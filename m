Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3228C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF77213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7Pmnlmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF77213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbeHPXjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:39:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52105 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeHPXjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:39:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so5651420wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EJgIAoXmKCdwb4nTwDIzuI4l2X84MJIGzZ5wtrwXTE8=;
        b=D7PmnlmbbRJpHPyjoUApduN7Uizp/XKl/0H2wPDvhT6fO7maUhh5bogoANQRprl4+E
         ffueY0vnA0lBcmmlCX7NY1hDa80+vHg7bs4VHbZMhqw2zVskP1g0PEVmb+TLJcmpbo3z
         ExTziJeQH80J/EaTjr6IXOd7ITR47E8+PgCTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EJgIAoXmKCdwb4nTwDIzuI4l2X84MJIGzZ5wtrwXTE8=;
        b=ndr6VVERgZTFRHBEb48hrq+x6QqmU1ynU3vqoxFPdlOaTgpM8Cs57doYTuSEzJJc4R
         yZ4uCIYArL95iomYz+lM0DYb9GG68ldaTmuILKKAfMMfPaAxrEQp8/KFOe2tdz+9zCC2
         Oey+9CpkH2utxGp5du3zGT9vcYRzcv2a98KtAvDanMg8MOLVIfNq/tRboXk+G0a1Y8MV
         dpZcseq+QWgHTHwgQ8eyEv+1hSfkQ2b9UgQ1nPRn5HysQVzLs/YtULejWVvqJd3POgw8
         /7iAkqJjSV7mki1CJpQRy5+tAY0pAYJ56++rJbinXzSxLRb58YGGQ9WPLv60hwoRWyxe
         FJqw==
X-Gm-Message-State: AOUpUlGlfWTV30V/FiwjsaEHyV7OrwmXj7vIqyxZfsJC2s/eP2YlAj1L
        76m87JleHeD29FVl5i3E+xJA+U94qlgjHJuE8gSMmSnTps0=
X-Google-Smtp-Source: AA+uWPxJVx0BUvNj6eUcuV0BLJUB2O5ueF+hIZbNEI6/RGfgAq6lRI/1rWlMCE62VlFHy9glXkfxzDm/H0rzAauAMLE=
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr18227299wma.41.1534451925707;
 Thu, 16 Aug 2018 13:38:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 13:38:45
 -0700 (PDT)
In-Reply-To: <CAKMK7uFb0jXVm4gGr_TR07mhT924sTORGXZVNzx4rdTe3Pj94Q@mail.gmail.com>
References: <CAPM=9txqtcX42eSYjkyJLL8mmzomXRRHi7iWmW=BYgk=CAagZg@mail.gmail.com>
 <CALAqxLXt3MOc=W_gnsR=D=Um5RPsK+6sTKDbSiqro_53ZbXfQQ@mail.gmail.com> <CAKMK7uFb0jXVm4gGr_TR07mhT924sTORGXZVNzx4rdTe3Pj94Q@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 16 Aug 2018 13:38:45 -0700
Message-ID: <CALAqxLWq-wgbc+aS0p45rvxmPj3KicsOV5ucCB-tcKWr74uqCQ@mail.gmail.com>
Subject: Re: [git pull] drm for 4.19-rc1
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:16 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Aug 16, 2018 at 8:04 AM, John Stultz <john.stultz@linaro.org> wro=
te:
>> On Tue, Aug 14, 2018 at 7:53 PM, Dave Airlie <airlied@gmail.com> wrote:
>>> This is the main drm pull request for 4.19.
>>>
>>> Rob has some new hardware support for new qualcomm hw that I'll send al=
ong
>>> separately. This has the display part of it, the remaining pull is for =
the
>>> acceleration engine.
>>>
>>> This also contains a wound-wait/wait-die mutex rework, Peter has acked =
it
>>> for merging via my tree.
>>>
>>> Otherwise mostly the usual level of activity.
>>
>> Hey Folks,
>>   Since this branch landed, I've been seeing the following panic on
>> bootup w/ the HiKey board (which uses the hisilicon/kirin drm driver):
>>
>> [    8.088388] Unable to handle kernel read from unreadable memory at
>> virtual address 0000000000000030
>> [    8.088393] Mem abort info:
>> [    8.088397]   ESR =3D 0x96000005
>> [    8.088402]   Exception class =3D DABT (current EL), IL =3D 32 bits
>> [    8.088406]   SET =3D 0, FnV =3D 0
>> [    8.088410]   EA =3D 0, S1PTW =3D 0
>> [    8.088413] Data abort info:
>> [    8.088417]   ISV =3D 0, ISS =3D 0x00000005
>> [    8.088421]   CM =3D 0, WnR =3D 0
>> [    8.088427] user pgtable: 4k pages, 39-bit VAs, pgdp =3D (____ptrval_=
___)
>> [    8.088432] [0000000000000030] pgd=3D0000000000000000, pud=3D00000000=
00000000
>> [    8.088443] Internal error: Oops: 96000005 [#1] PREEMPT SMP
>> [    8.088453] CPU: 5 PID: 1414 Comm: kworker/5:2 Tainted: G        W
>>        4.18.0-07439-gbf1fba4 #633
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
>> [    8.120775] Process kworker/5:2 (pid: 1414, stack limit =3D 0x(____pt=
rval____))
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
>> [    4.627304] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013=
).
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
>>> Noralf Tr=C3=B8nnes (15):
>>>       drm/file: Don't set master on in-kernel clients
>>>       drm: Make ioctls available for in-kernel clients
>>>       drm: Begin an API for in-kernel clients
>>>       drm/fb-helper: Add generic fbdev emulation .fb_probe function
>>>       drm/pl111: Set .gem_prime_vmap and .gem_prime_mmap
>>>       drm/cma-helper: Use the generic fbdev emulation
>>>       drm/debugfs: Add internal client debugfs file
>>>       drm/fb-helper: Finish the generic fbdev emulation
>>>       drm/tinydrm: Use drm_fbdev_generic_setup()
>>>       drm/cma-helper: Remove drm_fb_cma_fbdev_init_with_funcs()
>>
>> Though I've not yet had time to bisect this down tonight.
>>
>> I'll spend some more time on this tomorrow, but wanted to give folks a
>> heads up in the meantime.
>
> Hm, not immediately seeing what's going boom here. Bisect would indeed
> be good, but maybe we need to chase the callchain to figure out where
> exactly that -EINVAL is coming from in the reworked code (and why
> hikey is the first to hit that, there's lots of cma based drivers
> after all).

So I can confirm reverting:
85b5bafb86e6 ("drm/cma-helper: Remove drm_fb_cma_fbdev_init_with_funcs()")
and
894a677f4b3e ("drm/cma-helper: Use the generic fbdev emulation")

makes things work again.

Though without the reverts, I was digging to understand what was
failing, and it seems when we call into
drm_client_framebuffer_create(), as Noralf suggested, we're eventually
failing at drm_internal_framebuffer_create() when checking
config->max_height.  The kirin driver is somewhat limited w/ max
width/height values at 2048 each.

Though I'm on a 1920x1080 monitor (max resolution supported by the
board), it seems we're trying to allocate a 1920x2160 buffer? I know
Android tries to allocate 2x Y for page-flipping, but I'm not sure yet
why the old code didn't hit this problem.

Unfortunately bumping the max width/height values to 4096 cause the
system to hard hang as userspace starts up (and setting it to
2048/2160 does the same).

So yea, I'm going to continue to dig at the hard-hang issue, and
hopefully we can just  bump the max width/height, but if there are
other suggestions, please let me know.

thanks
-john
