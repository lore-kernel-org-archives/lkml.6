Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C88C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD3D20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="b6fUueQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfAKJRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:17:35 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33467 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbfAKJRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:17:35 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so11682280ioi.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qus/CM+i0lx1DfSah/ThfGlpCxXR+SXhj7oSq7rg2Yo=;
        b=b6fUueQtNQ67rscGC1Dz3EgE0az4NDg0LbmRDZ3t2AH0cCyNUaJq85kSwsfMZNhpyr
         F8r1/S6czuVounQRoHKQJWJQgxBx0843OWvCDIcp2l5oB5B0A3ut4XPKdxLj/zWktlf0
         OsCyjfDJ4WwgJ5gh6wZDFqUrP29NGBk51jE5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qus/CM+i0lx1DfSah/ThfGlpCxXR+SXhj7oSq7rg2Yo=;
        b=l6sQ78rsZxWrFyL8VJoA5q9uBSP+1GffN8CLhU7xAu9luXCr00OQSVsUXZKkWDDBfv
         xImUcLNe/SBUmJDyvy65q7xYBjOsb86QezHkDz0u2bSJuXhll0KgfCqsoY+6R80Dr4Ge
         Uis89vi5KCerWWmN6tU/Dgy8HDynesnOzdbPrOG7ePSEMg0wjVk7eC2A/I8vARDr0Jm1
         ErQGI3xCBeQBZEp6n6urgjhJLSZHtE9hHV8IwPLLs2uMNseMfSrl5nMBAfzW0DWjZtCd
         hdY1lObuYHqXUpPyslX0mkyk6eWuanN9mLMjFJxRieDJHYC7/okAsFQ1jhSo+HRyLpy3
         NB4A==
X-Gm-Message-State: AJcUukfJfG6tiYbXhJjSWsybbWY7GqNzeO9XH974l1Pb/mdMIy8h0XNN
        82XzatN5G6GLNW7kp3I3iPeW1SWAqJ6f6+K6ub9dBX++2F0=
X-Google-Smtp-Source: ALg8bN50/qSEHfIaA6NPLmygQH9P+K6Ssmc0djBEZ3RlXs3R+mW51fhnThOipLoscEQe9beYX1GhYYt2ddc1TM3U08s=
X-Received: by 2002:a5d:959a:: with SMTP id a26mr9199258ioo.278.1547198253854;
 Fri, 11 Jan 2019 01:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20190108072353.28078-3-mironov.ivan@gmail.com>
 <20190109155254.AA160206B6@mail.kernel.org> <1688637327c088be458662a86d384cc0f0d51f55.camel@gmail.com>
In-Reply-To: <1688637327c088be458662a86d384cc0f0d51f55.camel@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 11 Jan 2019 10:17:22 +0100
Message-ID: <CAKMK7uEm=MyT+Ty5EQWtQCMVTqS4w13yMeEbsXw9hE=f5OpCNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 9:19 AM Ivan Mironov <mironov.ivan@gmail.com> wrote:
>
> On Wed, 2019-01-09 at 15:52 +0000, Sasha Levin wrote:
> > Hi,
> >
> > [This is an automated email]
> >
> > This commit has been processed because it contains a "Fixes:" tag,
> > fixing commit: 79e539453b34 DRM: i915: add mode setting support.
> >
> > The bot has tested the following trees: v4.20.0, v4.19.13, v4.14.91, v4.9.148, v4.4.169, v3.18.131.
> >
> > v4.20.0: Failed to apply! Possible dependencies:
> >     042bf753842d ("drm/fourcc: Add char_per_block, block_w and block_h in drm_format_info")
> >     9c71a6686bfa ("drm: fourcc: Convert drm_format_info kerneldoc to in-line member documentation")
> >
> > v4.19.13: Failed to apply! Possible dependencies:
> >     042bf753842d ("drm/fourcc: Add char_per_block, block_w and block_h in drm_format_info")
> >     9c71a6686bfa ("drm: fourcc: Convert drm_format_info kerneldoc to in-line member documentation")
> >     c76abab59b3c ("drm: Use horizontal and vertical chroma subsampling factor while calculating offsets in the physical address of framebuffer")
> >
> > v4.14.91: Failed to apply! Possible dependencies:
> >     042bf753842d ("drm/fourcc: Add char_per_block, block_w and block_h in drm_format_info")
> >     4cc4e1b40f3f ("drm/fourcc: Add a alpha field to drm_format_info")
> >     9c71a6686bfa ("drm: fourcc: Convert drm_format_info kerneldoc to in-line member documentation")
> >     c76abab59b3c ("drm: Use horizontal and vertical chroma subsampling factor while calculating offsets in the physical address of framebuffer")
> >     ce2d54619a10 ("drm/fourcc: Add is_yuv field to drm_format_info to denote if the format is yuv")
> >
> > v4.9.148: Failed to apply! Possible dependencies:
> >     042bf753842d ("drm/fourcc: Add char_per_block, block_w and block_h in drm_format_info")
> >     05fc03217e08 ("drm/mm: Some doc polish")
> >     06df8ac682e6 ("drm: kselftest for drm_mm_debug()")
> >     14d7f96f90fb ("drm/fb_cma_helper: Add drm_fb_cma_prepare_fb() helper")
> >     2bd966d106e3 ("drm: kselftest for drm_mm_replace_node()")
> >     2fba0de0a9ec ("drm: kselftest for drm_mm_insert_node_in_range()")
> >     393b50f30566 ("drm: kselftest for drm_mm_init()")
> >     4636ce93d5b2 ("drm/fb-cma-helper: Add drm_fb_cma_get_gem_addr()")
> >     50f0033d1a0f ("drm: Add some kselftests for the DRM range manager (struct drm_mm)")
> >     5628648df755 ("drm/fb-cma-helper: Use drm_gem_framebuffer_helper")
> >     5705670d0463 ("drm: Track drm_mm allocators and show leaks on shutdown")
> >     6259a56ba0e1 ("drm: Add asserts to catch overflow in drm_mm_init() and drm_mm_init_scan()")
> >     62a0d98a188c ("drm: allow to use mmuless SoC")
> >     72a93e8dd52c ("drm: Take ownership of the dmabuf->obj when exporting")
> >     7886692a5804 ("drm: kselftest for drm_mm_insert_node()")
> >     900537dc3889 ("drm: kselftest for drm_mm_reserve_node()")
> >     940eba2d58a7 ("drm/gem|prime|mm: Use recommened kerneldoc for struct member refs")
> >     9a71e277888b ("drm: Extract struct drm_mm_scan from struct drm_mm")
> >     9b26f2ed29f8 ("drm: kselftest for drm_mm and alignment")
> >     b112481bb327 ("drm/cma-helper: simplify setup for drivers with ->dirty callbacks")
> >     b3ee963fe41d ("drm: Compile time enabling for asserts in drm_mm")
> >     ba004e39b199 ("drm: Fix kerneldoc for drm_mm_scan_remove_block()")
> >     c76abab59b3c ("drm: Use horizontal and vertical chroma subsampling factor while calculating offsets in the physical address of framebuffer")
> >     e6b62714e87c ("drm: Introduce drm_gem_object_{get,put}()")
> >
> > v4.4.169: Failed to apply! Possible dependencies:
> >     042bf753842d ("drm/fourcc: Add char_per_block, block_w and block_h in drm_format_info")
> >     14d7f96f90fb ("drm/fb_cma_helper: Add drm_fb_cma_prepare_fb() helper")
> >     199c77179c87 ("drm/fb-cma-helper: Add fb_deferred_io support")
> >     1eb83451ba55 ("drm: Pass the user drm_mode_fb_cmd2 as const to .fb_create()")
> >     4636ce93d5b2 ("drm/fb-cma-helper: Add drm_fb_cma_get_gem_addr()")
> >     5628648df755 ("drm/fb-cma-helper: Use drm_gem_framebuffer_helper")
> >     70c0616d5a84 ("drm/fb_cma_helper: remove duplicate const from drm_fb_cma_alloc")
> >     b112481bb327 ("drm/cma-helper: simplify setup for drivers with ->dirty callbacks")
> >     c76abab59b3c ("drm: Use horizontal and vertical chroma subsampling factor while calculating offsets in the physical address of framebuffer")
> >     ce0c57576810 ("drm/fb_cma_helper: Implement fb_mmap callback")
> >     fdce184609ee ("drm/fb-cma-helper: Use const for drm_framebuffer_funcs argument")
> >
> > v3.18.131: Failed to apply! Possible dependencies:
> >     042bf753842d ("drm/fourcc: Add char_per_block, block_w and block_h in drm_format_info")
> >     14d7f96f90fb ("drm/fb_cma_helper: Add drm_fb_cma_prepare_fb() helper")
> >     199c77179c87 ("drm/fb-cma-helper: Add fb_deferred_io support")
> >     1a396789f65a ("drm: add Atmel HLCDC Display Controller support")
> >     1eb83451ba55 ("drm: Pass the user drm_mode_fb_cmd2 as const to .fb_create()")
> >     2a8cb4894540 ("drm/exynos: merge exynos_drm_buf.c to exynos_drm_gem.c")
> >     2b8376c803c4 ("drm/exynos: remove struct exynos_drm_encoder layer")
> >     39a839f2e651 ("drm/exynos: s/exynos_gem_obj/obj in exynos_drm_fbdev.c")
> >     421ee18d4e04 ("drm/exynos: fix null pointer dereference issue")
> >     4636ce93d5b2 ("drm/fb-cma-helper: Add drm_fb_cma_get_gem_addr()")
> >     4846e4520849 ("drm/exynos: clean up machine compatible string check")
> >     5628648df755 ("drm/fb-cma-helper: Use drm_gem_framebuffer_helper")
> >     5cbb37df378d ("drm/exynos: resolve infinite loop issue on multi-platform")
> >     70c0616d5a84 ("drm/fb_cma_helper: remove duplicate const from drm_fb_cma_alloc")
> >     7239067795dc ("drm/exynos: remove ifdeferry from initialization code")
> >     7ded85885d49 ("drm/exynos: remove superfluous error messages")
> >     813fd67b57ff ("drm/exynos: cleanup name of gem object for exynos_drm")
> >     820687befec4 ("drm/exynos: move Exynos platform drivers registration to init")
> >     94e30d93f936 ("drm/exynos: remove exynos_drm_fb_set_buf_cnt()")
> >     96976c3d9aff ("drm/exynos: Add DECON driver")
> >     b74ea6a97e82 ("drm/exynos: remove DRM_EXYNOS_DMABUF config")
> >     c76abab59b3c ("drm: Use horizontal and vertical chroma subsampling factor while calculating offsets in the physical address of framebuffer")
> >     ce0c57576810 ("drm/fb_cma_helper: Implement fb_mmap callback")
> >     cf67cc9a29ac ("drm/exynos: remove struct exynos_drm_display")
> >     d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> >     d56125afcbdf ("drm/exynos: update exynos_drm_framebuffer_init() for multiple buffers")
> >     e9fbdcb45a36 ("drm/exynos: fix possible infinite loop issue")
> >
> >
> > How should we proceed with this patch?
> >
> > --
> > Thanks,
> > Sasha
>
> Hi,
>
> I'm new to kernel development, so: what exactly I'm supposed to do in
> such case? Rebase my patch on top of older versions and then resend
> patches somewhere?
>
> Just checked the v3.18.131. Apparently code in question was not changed
> since then, so manual rebase would be trivial.

If you want to do that work of backporting to older kernels, then:
- grab latest point release of each such kernel you care about.
- cherry-pick the upstream commit with git cherry-pick -x (the -x is
required by stable kernel release rules)
- add a note at the bottom that this is the manual backport for $kernel_release
- submit to stable team

https://www.kernel.org/doc/html/v4.14/process/stable-kernel-rules.html#option-3

Cheers, Daniel

>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
