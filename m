Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D526DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841B0214D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841B0214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389955AbeHPLTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:19:06 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:49810 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbeHPLTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:19:06 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:51177 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1fqDXq-0002Vz-Pw; Thu, 16 Aug 2018 10:22:14 +0200
Subject: Re: [git pull] drm for 4.19-rc1
To:     Daniel Vetter <daniel@ffwll.ch>,
        John Stultz <john.stultz@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <CAPM=9txqtcX42eSYjkyJLL8mmzomXRRHi7iWmW=BYgk=CAagZg@mail.gmail.com>
 <CALAqxLXt3MOc=W_gnsR=D=Um5RPsK+6sTKDbSiqro_53ZbXfQQ@mail.gmail.com>
 <CAKMK7uFb0jXVm4gGr_TR07mhT924sTORGXZVNzx4rdTe3Pj94Q@mail.gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <4b1d11a7-c6fd-c7ac-c910-ac84c2646f0f@tronnes.org>
Date:   Thu, 16 Aug 2018 10:22:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFb0jXVm4gGr_TR07mhT924sTORGXZVNzx4rdTe3Pj94Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 16.08.2018 09.16, skrev Daniel Vetter:
> On Thu, Aug 16, 2018 at 8:04 AM, John Stultz <john.stultz@linaro.org> wrote:
>> On Tue, Aug 14, 2018 at 7:53 PM, Dave Airlie <airlied@gmail.com> wrote:
>>> This is the main drm pull request for 4.19.
>>>
>>> Rob has some new hardware support for new qualcomm hw that I'll send along
>>> separately. This has the display part of it, the remaining pull is for the
>>> acceleration engine.
>>>
>>> This also contains a wound-wait/wait-die mutex rework, Peter has acked it
>>> for merging via my tree.
>>>
>>> Otherwise mostly the usual level of activity.
>> Hey Folks,
>>    Since this branch landed, I've been seeing the following panic on
>> bootup w/ the HiKey board (which uses the hisilicon/kirin drm driver):
>>
>> [    8.088388] Unable to handle kernel read from unreadable memory at
>> virtual address 0000000000000030
>> [    8.088393] Mem abort info:
>> [    8.088397]   ESR = 0x96000005
>> [    8.088402]   Exception class = DABT (current EL), IL = 32 bits
>> [    8.088406]   SET = 0, FnV = 0
>> [    8.088410]   EA = 0, S1PTW = 0
>> [    8.088413] Data abort info:
>> [    8.088417]   ISV = 0, ISS = 0x00000005
>> [    8.088421]   CM = 0, WnR = 0
>> [    8.088427] user pgtable: 4k pages, 39-bit VAs, pgdp = (____ptrval____)
>> [    8.088432] [0000000000000030] pgd=0000000000000000, pud=0000000000000000
>> [    8.088443] Internal error: Oops: 96000005 [#1] PREEMPT SMP
>> [    8.088453] CPU: 5 PID: 1414 Comm: kworker/5:2 Tainted: G        W
>>         4.18.0-07439-gbf1fba4 #633
>> [    8.088457] Hardware name: HiKey Development Board (DT)
>> [    8.088474] Workqueue: events adv7511_hpd_work
>> [    8.088482] pstate: 40400005 (nZcv daif +PAN -UAO)
>> [    8.088493] pc : drm_sysfs_hotplug_event+0x40/0x78
>> [    8.088499] lr : drm_sysfs_hotplug_event+0x40/0x78
>> [    8.088502] sp : ffffff800ba73d20
>> [    8.088506] x29: ffffff800ba73d20 x28: 0000000000000000
>> [    8.088514] x27: ffffff8009293cd8 x26: ffffffc074e55938
>> [    8.088522] x25: 0000000000000000 x24: ffffffc07ff85000
>> [    8.088530] x23: ffffffc0742c4a78 x22: ffffffc07ff86c00
>> [    8.088537] x21: ffffffc0750d0e00 x20: 0000000000000000
>> [    8.088545] x19: ffffff8009009a48 x18: 0000000000000000
>> [    8.088552] x17: 0000000000000000 x16: ffffffc074fbde80
>> [    8.088560] x15: 0000000000000000 x14: ffffffc005f96c00
>> [    8.088568] x13: 00000040770c9000 x12: 0000000034d5d91d
>> [    8.088575] x11: 0000000000000000 x10: 0000000000000990
>> [    8.088582] x9 : ffffff800ba739b0 x8 : ffffff800913e000
>> [    8.088589] x7 : 0000000000000000 x6 : ffffff8009009a48
>> [    8.088596] x5 : ffffff80090588d0 x4 : 0000000000000000
>> [    8.088602] x3 : ffffff8009009a48 x2 : 0000000000000000
>> [    8.088608] x1 : 18701cfc97cf1200 x0 : 0000000000000000
>> [    8.120775] Process kworker/5:2 (pid: 1414, stack limit = 0x(____ptrval____))
>> [    8.120778] Call trace:
>> [    8.120787]  drm_sysfs_hotplug_event+0x40/0x78
>> [    8.120794]  drm_kms_helper_hotplug_event+0x14/0x40
>> [    8.120800]  adv7511_hpd_work+0x64/0xe0
>> [    8.120807]  process_one_work+0x12c/0x320
>> [    8.120814]  worker_thread+0x48/0x458
>> [    8.126654]  kthread+0xf8/0x128
>> [    8.126661]  ret_from_fork+0x10/0x18
>> [    8.126672] Code: aa0003f4 52800020 a902ffa2 94006637 (f9401a80)
>> [    8.135638] ---[ end trace cf7120942e6f40fa ]---
>>
>> And earlier in boot we see:
>>
>> [    4.620909] kirin-drm f4100000.ade: bound f4107800.dsi (ops dsi_ops)
>> [    4.627304] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>> [    4.633935] [drm] No driver support for vblank timestamp query.
>> [    4.732910] kirin-drm f4100000.ade: [drm:drm_fb_helper_fbdev_setup]
>> *ERROR* Failed to set fbdev configuration
>> [    4.742948] [drm:kirin_drm_bind] *ERROR* failed to initialize fbdev.
>> [    4.749585] kirin-drm f4100000.ade: master bind failed: -22
>> [    4.755218] dw-dsi: probe of f4107800.dsi failed with error -22
>>
>> I've also seen similar trouble w/ the HiKey960 which uses a similar
>> but still out of tree driver that also utilizes the cma fbhelper code,
>> which makes me suspect it has to do with the drm/cma-helper changes
>> below:
>>
>>> Noralf Trønnes (15):
>>>        drm/file: Don't set master on in-kernel clients
>>>        drm: Make ioctls available for in-kernel clients
>>>        drm: Begin an API for in-kernel clients
>>>        drm/fb-helper: Add generic fbdev emulation .fb_probe function
>>>        drm/pl111: Set .gem_prime_vmap and .gem_prime_mmap
>>>        drm/cma-helper: Use the generic fbdev emulation
>>>        drm/debugfs: Add internal client debugfs file
>>>        drm/fb-helper: Finish the generic fbdev emulation
>>>        drm/tinydrm: Use drm_fbdev_generic_setup()
>>>        drm/cma-helper: Remove drm_fb_cma_fbdev_init_with_funcs()
>> Though I've not yet had time to bisect this down tonight.
>>
>> I'll spend some more time on this tomorrow, but wanted to give folks a
>> heads up in the meantime.
> Hm, not immediately seeing what's going boom here. Bisect would indeed
> be good, but maybe we need to chase the callchain to figure out where
> exactly that -EINVAL is coming from in the reworked code (and why
> hikey is the first to hit that, there's lots of cma based drivers
> after all).

Call chain deducted from the error messages:
kirin_drm_bind -> kirin_drm_kms_init -> drm_fbdev_cma_init ->
drm_fb_helper_fbdev_setup -> drm_fb_helper_initial_config

If this message turns up when enabling debug messages:

int drm_fb_helper_generic_probe(struct drm_fb_helper *fb_helper,
                 struct drm_fb_helper_surface_size *sizes)
{
...
     DRM_DEBUG_KMS("surface width(%d), height(%d) and bpp(%d)\n",
               sizes->surface_width, sizes->surface_height,
               sizes->surface_bpp);

     format = drm_mode_legacy_fb_format(sizes->surface_bpp, 
sizes->surface_depth);
     buffer = drm_client_framebuffer_create(client, sizes->surface_width,
                            sizes->surface_height, format);
     if (IS_ERR(buffer))
         return PTR_ERR(buffer);
...

then it's probably drm_client_framebuffer_create() that fails.
That function creates a dumb buffer and is a likely suspect.

Noralf.

