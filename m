Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890EAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6A72147A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfBRKKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:10:49 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:39176 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBRKKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:10:48 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1IAAXEm049673;
        Mon, 18 Feb 2019 19:10:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Mon, 18 Feb 2019 19:10:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1IAAN3U049606
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 18 Feb 2019 19:10:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH (resend)] Input: uinput - Set name/phys to NULL before
 kfree().
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     rydberg@bitmath.org,
        syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000009ce64e0574fe896e@google.com>
 <47d5fdbe-120e-cf42-106f-b0cc0f2feb49@I-love.SAKURA.ne.jp>
 <b937b59c-22b8-9113-229f-056738819467@I-love.SAKURA.ne.jp>
 <20190217210713.GA145509@dtor-ws>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <722c14a1-78cd-14b6-59ef-ba0d6fc82cb1@i-love.sakura.ne.jp>
Date:   Mon, 18 Feb 2019 19:10:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190217210713.GA145509@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for responding.

On 2019/02/18 6:07, Dmitry Torokhov wrote:
> The commit tries to send final uevent for objects for which "add" uevent
> has been sent, but not "remove" event. However in uinput (and general
> input case) we always take care of sending uevent at unregister, and do
> not expect to have uevent sent out at the final "put" time.

Then, we want to keep dev->name and dev->phys when calling "unregister" time.

> 
> I believe the real fix is to have kobj->state_remove_uevent_sent be set
> to true as soon as we enter kobject_uevent(kobj, KOBJ_REMOVE) so that
> it is being set even if memory allocation fails. Doing anything else may
> violate expectations of subsystem owning the kobject.

If we want to keep dev->name and dev->phys when calling "unregister" time,
we could do something like below. Does calling kobject_uevent(KOBJ_REMOVE)
without dev->name and dev->phys (to some degree) help (compared to not
triggering kobject_uevent(KOBJ_REMOVE) at all) ?

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 3304aaa..da39a23 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1587,6 +1587,7 @@ static int input_dev_uevent(struct device *device, struct kobj_uevent_env *env)
 {
 	struct input_dev *dev = to_input_dev(device);
 
+	rcu_read_lock();
 	INPUT_ADD_HOTPLUG_VAR("PRODUCT=%x/%x/%x/%x",
 				dev->id.bustype, dev->id.vendor,
 				dev->id.product, dev->id.version);
@@ -1618,6 +1619,7 @@ static int input_dev_uevent(struct device *device, struct kobj_uevent_env *env)
 		INPUT_ADD_HOTPLUG_BM_VAR("SW=", dev->swbit, SW_MAX);
 
 	INPUT_ADD_HOTPLUG_MODALIAS_VAR(dev);
+	rcu_read_unlock();
 
 	return 0;
 }
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 26ec603f..6689312 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -308,9 +308,12 @@ static void uinput_destroy_device(struct uinput_device *udev)
 		} else {
 			input_free_device(dev);
 		}
+		dev->name = NULL;
+		dev->phys = NULL;
+		udev->dev = NULL;
+		synchronize_rcu();
 		kfree(name);
 		kfree(phys);
-		udev->dev = NULL;
 	}
 }
 

