Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E0D208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHFVEWZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E0D208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeHQBMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 21:12:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35239 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeHQBMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 21:12:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so5691881wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 15:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CeyocFqr5RvyDdFZRocO2aCL6J/4HkqxBM/pzCh2ttY=;
        b=jHFVEWZN7aMHUU3DKsmMlojrXMDVySn0hkPhAF2TsoJZQz8jwDuECheWdTKYfTSs7y
         LfZWOWopDfUY7kx/+YYMaL0L7+W9SEbVV1d/FfkAiAwRIoanQGOfXxSFuHwjK6v0AJXG
         uv0E2UZLb7X2PLqpEDW2XdhMuf6kEI4UszkmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CeyocFqr5RvyDdFZRocO2aCL6J/4HkqxBM/pzCh2ttY=;
        b=SguMg/jE5k3AAqsUWnQC/Bsl9jhbMKRsZm6/0xVcQqh4xOk5HrLwi+Z1BkqDIehLjL
         y9P4w88NbnNeeXJ0Mx4G8gxdB+S3Dpbxvcv5zb/w/3PXEoaVMYeoNLsNWcfl36Jau4kM
         AYrup3QC/g802GOkXTvQpMa4jaggxoCBUaoWd22h13+4VyHvazhbbthhJhmS0pc/WAq1
         LAYB+cAPuxdJtqrr5kzNpiGX3UkBkS4ScxPcM+uoayjfSPjtz449CKaEIfOs6p0NEGxy
         4TMHpnAOrICnesjpe0o7YZ7VwgIx/wcVu3DwKi9erICBVpbp8eiDa0oBc2OLqF0pOu5F
         9Gtw==
X-Gm-Message-State: AOUpUlE5D4aDmyAzdUiiie3DJ/v+3WK/fiC0hRYxb8NJ3nEqelGpLJlV
        1rflSpz6ooVR/WcKKxEgvSp3uS3qQvROYVNxtGwZ8g==
X-Google-Smtp-Source: AA+uWPyja8Wws/impeUK9ZkGb7QAGN7OVdc7KxwlFpIfDYlr6qKanoL9TJwogUwPFeqmaT43kOZZsPzdsPHPSvIi8w8=
X-Received: by 2002:a1c:4182:: with SMTP id o124-v6mr16499493wma.101.1534457514032;
 Thu, 16 Aug 2018 15:11:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 15:11:53
 -0700 (PDT)
In-Reply-To: <CALAqxLWq-wgbc+aS0p45rvxmPj3KicsOV5ucCB-tcKWr74uqCQ@mail.gmail.com>
References: <CAPM=9txqtcX42eSYjkyJLL8mmzomXRRHi7iWmW=BYgk=CAagZg@mail.gmail.com>
 <CALAqxLXt3MOc=W_gnsR=D=Um5RPsK+6sTKDbSiqro_53ZbXfQQ@mail.gmail.com>
 <CAKMK7uFb0jXVm4gGr_TR07mhT924sTORGXZVNzx4rdTe3Pj94Q@mail.gmail.com> <CALAqxLWq-wgbc+aS0p45rvxmPj3KicsOV5ucCB-tcKWr74uqCQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 16 Aug 2018 15:11:53 -0700
Message-ID: <CALAqxLXX7zDRaYM0RTcXoF+hTzvUUbpEm44vQHABzNXGCn1H+w@mail.gmail.com>
Subject: Re: [git pull] drm for 4.19-rc1
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 1:38 PM, John Stultz <john.stultz@linaro.org> wrote:
>
> Unfortunately bumping the max width/height values to 4096 cause the
> system to hard hang as userspace starts up (and setting it to
> 2048/2160 does the same).
>
> So yea, I'm going to continue to dig at the hard-hang issue, and
> hopefully we can just  bump the max width/height, but if there are
> other suggestions, please let me know.

So still digging on the hard hang after bumping the max_height value.
It seems to trigger as the display is being initialized by userland,
so if I boot with the HDMI cable unplugged the kernel boots fine (as
userland error loops looking for a display). Then when I hotplug the
HDMI cable it will hang. Booting with drm_debug=0xe,  (and doing the
HDMI hotplug after bootup) I see:

[   63.172368] [drm:dsi_encoder_phy_mode_valid] OK!
[   63.185522] [drm:drm_calc_timestamping_constants] crtc 29: hwmode:
htotal 2200, vtotal 1125, vdisplay 1080
[   63.195213] [drm:drm_calc_timestamping_constants] crtc 29: clock
148500 kHz framedur 16666666 linedur 14814
[   63.205114] [drm:ade_ldi_set_mode.isra.9] set mode: 1920x1080
[   63.212529] [drm:ade_ldi_set_mode.isra.9] set mode: 1920x1080
[   63.218333] [drm:ade_plane_atomic_update] channel1: src:(0,
0)-1920x1080, crtc:(0, 0)-1920x1080
[   63.218346] [drm:ade_plane_atomic_update] rdma1: (y=0,
height=1080), stride=7680, paddr=0x77d00000
[   63.236111] [drm:ade_plane_atomic_update] addr=0x77d00000,
fb:1920x2160, pixel_format=2(XR24 little-endian (0x34325258))
[   63.238695] Mali<2>:
[   63.247032] [drm:ade_plane_atomic_update] clip1: clip_left=0, clip_right=0
[   63.247053] [drm:drm_vblank_enable] enabling vblank on crtc 0, ret: 0
[   63.249319] Session 0x74ACAE00 with pid 2249 was granted higher priority.
[   63.256253] [drm:ade_dump_regs] [rdma1]: reload(0)
[   63.273400] [drm:drm_handle_vblank] vblank event on 1, current 1
[   63.274362] [drm:ade_dump_regs] [rdma1]: reg_ctrl(0x00020000)
[   63.286201] [drm:ade_dump_regs] [rdma1]: reg_addr(0x77d00000)
[   63.286208] [drm:ade_dump_regs] [rdma1]: reg_size(0x04381e00)
[   63.286214] [drm:ade_dump_regs] [rdma1]: reg_stride(0x00001e00)
[   63.286221] [drm:ade_dump_regs] [rdma1]: reg_space(0x007e9000)
[   63.286227] [drm:ade_dump_regs] [rdma1]: reg_en(0x00000000)
[   63.286234] [drm:ade_dump_regs] [clip1]: reload(0)
[   63.286248] [drm:ade_dump_regs] [clip1]: reg_clip_disable(0x00000001)
[   63.326460] [drm:ade_dump_regs] [clip1]: reg_clip_size0(0x077f0437)
[   63.332786] [drm:ade_dump_regs] [clip1]: reg_clip_size1(0x00000000)
[   63.339102] [drm:ade_dump_regs] [overlay ch0]: reg_ch_xy0(0x00000000)
[   63.345596] [drm:ade_dump_regs] [overlay ch0]: reg_ch_xy1(0x077f0437)
[   63.350809] init: Received control message 'start' for 'bootanim'
from pid: 2249 (/system/bin/surfaceflinger)
[   63.352091] [drm:ade_dump_regs] [overlay ch0]: reg_ch_ctl(0x107f806c)
[   63.362726] init: starting service 'bootanim'...
[   63.368494] [drm:ade_dump_regs] [overlay2]: reload(0)
[   63.368506] [drm:ade_dump_regs] [overlay2]: reg_ctl(0x00000000)
[   63.384170] [drm:ade_dump_regs] ovly_ctl(0x00000002)
[   63.390826] [drm:dsi_encoder_enable] htot=2200, hfp=88, hbp=148, hsw=44
[   63.397502] [drm:dsi_encoder_enable] vtol=1125, vfp=4, vbp=36, vsw=5
[   63.403902] [drm:dsi_encoder_enable] hsa_time=33, hbp_time=111,
hline_time=1650
[   63.411250] [drm:dsi_encoder_enable] lanes=4, pixel_clk=144000 kHz,
bytes_freq=108000 kHz
[   63.428238] [drm:drm_mode_object_put] OBJ ID: 31 (5)
<hang>

Not always, but sometimes as it hangs I'll see:
 [drm:vblank_disable_fn] disabling vblank on crtc 0

And sometimes I'll also see:
Insufficient stack space to handle exception!

So I'm not sure if there's a screaming interrupt or what (nor am I
sure what from the problematic changes would cause that change
either).

thanks
-john
