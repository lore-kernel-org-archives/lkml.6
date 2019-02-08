Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8E3C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B852206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfBHK0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:26:16 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:50976 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHK0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:26:15 -0500
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x18AQ1Qd043931;
        Fri, 8 Feb 2019 19:26:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Fri, 08 Feb 2019 19:26:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x18APtPW043792
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 8 Feb 2019 19:26:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: [PATCH (resend)] Input: uinput - Set name/phys to NULL before
 kfree().
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     dmitry.torokhov@gmail.com, rydberg@bitmath.org
Cc:     syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000009ce64e0574fe896e@google.com>
 <47d5fdbe-120e-cf42-106f-b0cc0f2feb49@I-love.SAKURA.ne.jp>
Message-ID: <b937b59c-22b8-9113-229f-056738819467@I-love.SAKURA.ne.jp>
Date:   Fri, 8 Feb 2019 19:25:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <47d5fdbe-120e-cf42-106f-b0cc0f2feb49@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is hitting use-after-free bug in uinput module [1]. This is because
uinput_destroy_device() sometimes kfree()s dev->name and dev->phys at
uinput_destroy_device() before dev_uevent() is triggered by dropping the
refcount to 0. Since the timing of triggering last input_put_device() is
uncontrollable, this patch prepares for such race by setting dev->name and
dev->phys to NULL before doing operations which might drop the refcount
to 0.

[1] https://syzkaller.appspot.com/bug?id=8b17c134fe938bbddd75a45afaa9e68af43a362d

Reported-by: syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/input/misc/uinput.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 8ec483e8688b..131591b5babd 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -300,7 +300,9 @@ static void uinput_destroy_device(struct uinput_device *udev)
 
 	if (dev) {
 		name = dev->name;
+		dev->name = NULL;
 		phys = dev->phys;
+		dev->phys = NULL;
 		if (old_state == UIST_CREATED) {
 			uinput_flush_requests(udev);
 			input_unregister_device(dev);
-- 
2.17.1

