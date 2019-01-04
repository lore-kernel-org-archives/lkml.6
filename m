Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B056C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC2B21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfADKER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:04:17 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:29085 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfADKEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:04:16 -0500
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x04A4EZv050012;
        Fri, 4 Jan 2019 19:04:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Fri, 04 Jan 2019 19:04:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x04A49G2049992
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 4 Jan 2019 19:04:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: WARNING: lock held when returning to user space in
 set_property_atomic
To:     Dmitry Vyukov <dvyukov@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     syzbot <syzbot+6ea337c427f5083ebdf2@syzkaller.appspotmail.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, maxime.ripard@bootlin.com,
        sean@poorly.run, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000f56975057e374c46@google.com>
 <fea9b565-06e4-fbb5-7e92-efd133a7028c@linux.intel.com>
 <CACT4Y+bKqXknE--kTngznowLaY1b9h5oGWdWBR8w=nHv8F90AQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <c56f9fb5-0ee4-edfe-0d82-943f11cc78bc@I-love.SAKURA.ne.jp>
Date:   Fri, 4 Jan 2019 19:04:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bKqXknE--kTngznowLaY1b9h5oGWdWBR8w=nHv8F90AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/03 18:04, Dmitry Vyukov wrote:
> On Thu, Jan 3, 2019 at 9:55 AM Maarten Lankhorst <maarten.lankhorst@linux.intel.com> wrote:
>> Just guessing..
>>
>> Does this help?

Yes it will. And while at it, let's fix another one together.

From 291e42211e3cc6d85c915772717dd08d40fb5fed Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 4 Jan 2019 15:23:47 +0900
Subject: [PATCH] gpu/drm: Fix lock held when returning to user space.

We need to call drm_modeset_acquire_fini() when drm_atomic_state_alloc()
failed or call drm_modeset_acquire_init() after drm_atomic_state_alloc()
succeeded.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+6ea337c427f5083ebdf2@syzkaller.appspotmail.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 3 +--
 drivers/gpu/drm/drm_mode_object.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index c408898..9a1f41a 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1296,12 +1296,11 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 			(arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
 		return -EINVAL;
 
-	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
-
 	state = drm_atomic_state_alloc(dev);
 	if (!state)
 		return -ENOMEM;
 
+	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
 	state->acquire_ctx = &ctx;
 	state->allow_modeset = !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET);
 
diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index cd9bc0c..004191d 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -459,11 +459,11 @@ static int set_property_atomic(struct drm_mode_object *obj,
 	struct drm_modeset_acquire_ctx ctx;
 	int ret;
 
-	drm_modeset_acquire_init(&ctx, 0);
-
 	state = drm_atomic_state_alloc(dev);
 	if (!state)
 		return -ENOMEM;
+
+	drm_modeset_acquire_init(&ctx, 0);
 	state->acquire_ctx = &ctx;
 retry:
 	if (prop == state->dev->mode_config.dpms_property) {
-- 
1.8.3.1
