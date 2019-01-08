Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921D5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508472087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jQkOVpPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfAHIh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:37:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39176 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfAHIh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:37:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so3349552edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 00:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aJqDdLnQHsKFL0WPPIBBPF3nQ2EqP4XrCwEVMe0Y+Dw=;
        b=jQkOVpPz4Nu587nJaDBLKRdgLnagw+kBSMKU000KyTi3LVvtIGJpzLFj2gf7UMriNq
         sOe+Ob900gQW3a+D+CHLqqW99sP6GvkV+hNNtxJXpTGWmf6sjQyXM1BSdGZPR1Ks4Lfb
         qJ+VlHRoz9jl0Q2TyDG6Hz3z9yop0R8uG1YyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=aJqDdLnQHsKFL0WPPIBBPF3nQ2EqP4XrCwEVMe0Y+Dw=;
        b=KuHikLLlL8j1kw+Eu+YCq5vhfmR/JLbdww/ftRES6CINkv0hJYKlTsiLCiqyNwSRrk
         IMGqqPnSUrGk+8xM3krHahHWcBVe6GuPkWJIeTMJvyO/q7yLtaV+KEHlIN6sCPp3c8ey
         Dd6BiRxKRQ5ba9XK5qw0SVpozbMWgd311zh7V4Kz9GJu/Yb3VwJ2QdQhxmPbw+Il3SZK
         sBejZgJGnCbip5TZhg14sSK02GWGCaM4e8uf8aYoFKr2RlXDLT98640TcRARKvRWIMjU
         Sb7uhCxpnAm1qfUNQjQtg7kQAHMmjmeJbT1tXGOV1Uwcgp40KcK61/W3ylgzD8dxKgPy
         mDeA==
X-Gm-Message-State: AJcUukevuRsMZeK9pg7sl4oI+ZQnwoErpofMkcPW6A6/5/dM5BG2tx7l
        Zv24S/yLFmIc0fBuVeVo5wSlaA==
X-Google-Smtp-Source: ALg8bN7XYGss+u0mNwwcW28KF2o4Xx59M31cConO36Vdg5mQZS7ppBzEJOFprFz1rdsQhPSXU/Cg2g==
X-Received: by 2002:a50:b0e5:: with SMTP id j92mr1119435edd.188.1546936645425;
        Tue, 08 Jan 2019 00:37:25 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w10sm31593992eda.77.2019.01.08.00.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 00:37:24 -0800 (PST)
Date:   Tue, 8 Jan 2019 09:37:22 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190108083722.GQ21184@phenom.ffwll.local>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20190108111230.2dd3abd9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108111230.2dd3abd9@canb.auug.org.au>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 11:12:41AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'amdgpu_dm_mode_config_init':
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1695:30: error: passing argument 1 of 'drm_atomic_private_obj_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   drm_atomic_private_obj_init(&adev->dm.atomic_obj,
>                               ^~~~~~~~~~~~~~~~~~~~
> In file included from include/drm/drm_dp_mst_helper.h:27,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h:46,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu.h:57,
>                  from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:34:
> include/drm/drm_atomic.h:437:53: note: expected 'struct drm_device *' but argument is of type 'struct drm_private_obj *'
>  void drm_atomic_private_obj_init(struct drm_device *dev,
>                                   ~~~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1696:9: error: passing argument 2 of 'drm_atomic_private_obj_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
>          &state->base,
>          ^~~~~~~~~~~~
> In file included from include/drm/drm_dp_mst_helper.h:27,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h:46,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu.h:57,
>                  from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:34:
> include/drm/drm_atomic.h:438:30: note: expected 'struct drm_private_obj *' but argument is of type 'struct drm_private_state *'
>       struct drm_private_obj *obj,
>       ~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1697:9: error: passing argument 3 of 'drm_atomic_private_obj_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
>          &dm_atomic_state_funcs);
>          ^~~~~~~~~~~~~~~~~~~~~~
> In file included from include/drm/drm_dp_mst_helper.h:27,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h:46,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu.h:57,
>                  from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:34:
> include/drm/drm_atomic.h:439:32: note: expected 'struct drm_private_state *' but argument is of type 'struct drm_private_state_funcs *'
>       struct drm_private_state *state,
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1695:2: error: too few arguments to function 'drm_atomic_private_obj_init'
>   drm_atomic_private_obj_init(&adev->dm.atomic_obj,
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/drm/drm_dp_mst_helper.h:27,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h:46,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu.h:57,
>                  from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:34:
> include/drm/drm_atomic.h:437:6: note: declared here
>  void drm_atomic_private_obj_init(struct drm_device *dev,
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   b962a12050a3 ("drm/atomic: integrate modeset lock with private objects")
> 
> interacting with commit
> 
>   eb3dc8978596 ("drm/amd/display: Use private obj helpers for dm_atomic_state")
> 
> from Linus' tree (merged during the merge window).
> 
> Its not obvious how to fix this up, so I have used the drm-misc tree
> from next-20190107 for today.

https://cgit.freedesktop.org/drm-tip/tree/fixups/drm-misc-next.patch?h=rerere-cache

is the fixup you want. Should get baked into drm-next any moment, since
the first drm-misc-next pull is already out.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
