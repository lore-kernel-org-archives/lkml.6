Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AE6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4D920C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfBTNis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:38:48 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:14500 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTNir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:38:47 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1KDcY0P073576;
        Wed, 20 Feb 2019 22:38:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Wed, 20 Feb 2019 22:38:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1KDcTlO073517
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Feb 2019 22:38:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kay Sievers <kay@vrfy.org>,
        syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
Subject: [PATCH] kobject: Don't trigger kobject_uevent(KOBJ_REMOVE) twice.
Date:   Wed, 20 Feb 2019 22:38:34 +0900
Message-Id: <1550669914-10704-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
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
input_unregister_device() completed. Fix this problem by marking "remove"
event done regardless of result.

[1] https://syzkaller.appspot.com/bug?id=8b17c134fe938bbddd75a45afaa9e68af43a362d

Reported-by: syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
Analyzed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kay Sievers <kay@vrfy.org>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 lib/kobject_uevent.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index f058026..7ec4165 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -466,6 +466,13 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	int i = 0;
 	int retval = 0;
 
+	/*
+	 * Mark "remove" event done regardless of result, for some subsystems
+	 * do not want to re-trigger "remove" event via automatic cleanup.
+	 */
+	if (action == KOBJ_REMOVE && kobj->state_add_uevent_sent)
+		kobj->state_remove_uevent_sent = 1;
+
 	pr_debug("kobject: '%s' (%p): %s\n",
 		 kobject_name(kobj), kobj, __func__);
 
@@ -567,10 +574,6 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 		kobj->state_add_uevent_sent = 1;
 		break;
 
-	case KOBJ_REMOVE:
-		kobj->state_remove_uevent_sent = 1;
-		break;
-
 	case KOBJ_UNBIND:
 		zap_modalias_env(env);
 		break;
-- 
1.8.3.1

