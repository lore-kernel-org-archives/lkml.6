Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D53C5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 02:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BC120850
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 02:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfASClj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 21:41:39 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58797 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729963AbfASClj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 21:41:39 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0J2fP8t084793;
        Sat, 19 Jan 2019 11:41:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Sat, 19 Jan 2019 11:41:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0J2fLuE084605
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 19 Jan 2019 11:41:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] workqueue: Try to catch flush_work() without INIT_WORK().
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1547831098-7930-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190118194853.pgdkz2ugwrob3zun@ca-dmjordan1.us.oracle.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <90c831b3-0d09-3cf7-5a2c-2fa7afaa003e@i-love.sakura.ne.jp>
Date:   Sat, 19 Jan 2019 11:41:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118194853.pgdkz2ugwrob3zun@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/19 4:48, Daniel Jordan wrote:
> On Sat, Jan 19, 2019 at 02:04:58AM +0900, Tetsuo Handa wrote:
>> syzbot found a flush_work() caller who forgot to call INIT_WORK()
>> because that work_struct was allocated by kzalloc(). But the message
>>
>>   INFO: trying to register non-static key.
>>   the code is fine but needs lockdep annotation.
>>   turning off the locking correctness validator.
>>
>> by lock_map_acquire() is failing to tell that INIT_WORK() is missing.
>>
>> Since flush_work() without INIT_WORK() is a bug, and INIT_WORK() should
>> set ->func field to non-zero, let's warn if ->func field is zero.
> 
> Agree that it's a good idea to catch this.  So the caller did flush_work
> without queueing it beforehand?  Out of curiosity, what situation leads to
> this?  Link to the report might be helpful.

I quoted the patch below.

> 
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 392be4b..a503ad9 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -2908,6 +2908,9 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
>>  	if (WARN_ON(!wq_online))
>>  		return false;
>>  
>> +	if (WARN_ON(!work->func))
>> +		return false;
>> +
> 
> __queue_work has a sanity check already for work, but using list_empty.  Seems
> slightly better to be consistent?
> 

list_empty() won't work, for "struct work_struct" is embedded into a struct
which is allocated by kzalloc().



From 1bbf8d9c7aaef78d7f483d2131261162485c6f72 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 19 Jan 2019 01:38:53 +0900
Subject: [PATCH] drm/vkms: Fix flush_work() without INIT_WORK().

syzbot is hitting a lockdep warning [1] because flush_work() is called
without INIT_WORK() after kzalloc() at vkms_atomic_crtc_reset().

Commit 6c234fe37c57627a ("drm/vkms: Implement CRC debugfs API") added
INIT_WORK() to only vkms_atomic_crtc_duplicate_state() side. Assuming
that lifecycle of crc_work is appropriately managed, fix this problem
by adding INIT_WORK() to vkms_atomic_crtc_reset() side.

[1] https://syzkaller.appspot.com/bug?id=a5954455fcfa51c29ca2ab55b203076337e1c770

Reported-and-tested-by: syzbot <syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 177bbcb..3c37d8c 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -104,6 +104,7 @@ static void vkms_atomic_crtc_reset(struct drm_crtc *crtc)
 	vkms_state = kzalloc(sizeof(*vkms_state), GFP_KERNEL);
 	if (!vkms_state)
 		return;
+	INIT_WORK(&vkms_state->crc_work, vkms_crc_work_handle);
 
 	crtc->state = &vkms_state->base;
 	crtc->state->crtc = crtc;
-- 
1.8.3.1

