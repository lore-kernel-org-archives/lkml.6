Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF99FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B887D2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfBRKLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:11:04 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:39257 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBRKLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:11:03 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1IAAnvL050085;
        Mon, 18 Feb 2019 19:10:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Mon, 18 Feb 2019 19:10:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1IAAeUM049878
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 19:10:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     dmitry.torokhov@gmail.com, rydberg@bitmath.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kay Sievers <kay@vrfy.org>,
        syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
Subject: [PATCH] input : avoid too late kobject_uevent(KOBJ_REMOVE) call
Date:   Mon, 18 Feb 2019 19:09:23 +0900
Message-Id: <1550484563-13217-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is hitting use-after-free bug in uinput module [1]. This is because
kobject_uevent(KOBJ_REMOVE) is called again due to commit 0f4dafc0563c6c49
("Kobject: auto-cleanup on final unref") after memory allocation fault
injection made kobject_uevent(KOBJ_REMOVE) from device_del() from
input_unregister_device() fail, while uinput_destroy_device() is expecting
that kobject_uevent(KOBJ_REMOVE) is not called after device_del() from
input_unregister_device() completed.

Fix this problem by pretending as if kobject_uevent(KOBJ_REMOVE) from
device_del() from input_unregister_device() did not fail.

[1] https://syzkaller.appspot.com/bug?id=8b17c134fe938bbddd75a45afaa9e68af43a362d

Reported-by: syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
Analyzed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kay Sievers <kay@vrfy.org>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/input/input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 3304aaaffe87..6df3c33ef3aa 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2032,6 +2032,19 @@ static void __input_unregister_device(struct input_dev *dev)
 	mutex_unlock(&input_mutex);
 
 	device_del(&dev->dev);
+	/*
+	 * Regarding input subsystem, we always take care of sending uevent at
+	 * "unregister" time, and we do not expect to have uevent sent out at
+	 * the final "put" time. Therefore, if we failed to send uevent at
+	 * "unregister" time (due to e.g. fault injection), complain it and
+	 * do not allow the final "put" time to send the remove uevent again.
+	 */
+	if (dev->dev.kobj.state_add_uevent_sent &&
+	    !dev->dev.kobj.state_remove_uevent_sent) {
+		dev->dev.kobj.state_remove_uevent_sent = 1;
+		pr_warn("Failed to send remove uevent for %s\n",
+			dev_name(&dev->dev));
+	}
 }
 
 static void devm_input_device_unregister(struct device *dev, void *res)
-- 
2.17.1
