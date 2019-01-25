Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE170C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4BF2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g4IPKrM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfAYBDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 20:03:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36577 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfAYBDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 20:03:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so3459456pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 17:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CKn20MR+rPx8T8NZ4z+z2YPrVyWk46gwhbT67qOgJLU=;
        b=g4IPKrM3ErPySZax0pvWfEJHj9MqI94Kn/j55sQzLNDdKdsmpM9FleIdConOguyph2
         C2rXNzDVD0L8n5qPNspuT0Nbd2V+K5oa+N4OqBCK1zeBkfxmTb6n8H+7fPU506SVIbNO
         wXR3OMrWlQpCWl16dp0ZShmZsJpk/HF0VjcU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CKn20MR+rPx8T8NZ4z+z2YPrVyWk46gwhbT67qOgJLU=;
        b=H8hJa6+iLWoQogFPZB5wt2y7qMWouEmT0FstOKIFY/HqAkexv7eSu/dtotTtsbFDk9
         QNeyoVxwjS8l8cVeYTTe7dMKWMOzCULbnyijODB2avALaoCLZiazfKH/yppBFlcT0M8z
         EDt7FPQ5zMRpzqtOCQrjzj8R/OZN6nwnrQnjBcuOv8Kb754iJG8J7xYx6k8FOXnLH8zA
         bB3uzAQDVD/f+Uwhd0k5+POXsy/r5TomDaA5SiWoFCKSKqwQrAJaORYzdKlsgyKrgddN
         4Uv5W8pbtzVuBX1z5JTvuHX/O7Xm+AnQccYrNWrkk6jgOizTKPjO3mnAsDXU/jrC+Dy5
         VomQ==
X-Gm-Message-State: AJcUukeJxDfKTN9fv4hmpzWh9zJt6+xGPZhPMyUyG4kZSVNcjzPDZk5j
        S97WeMIXPmMd6dg+hFSfTL1oHQ==
X-Google-Smtp-Source: ALg8bN5ZvYoOGlXVyMMwFrsTZOZGrMJ+74WNth43TKCOn8EJOj7yUejvVc0CtErFrAXYK86vCuDjYw==
X-Received: by 2002:a63:5252:: with SMTP id s18mr8012581pgl.326.1548378228405;
        Thu, 24 Jan 2019 17:03:48 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u137sm41901719pfc.140.2019.01.24.17.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 17:03:47 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
X-Google-Original-From: Matthias Kaehlcke <mka@google.com>
Date:   Thu, 24 Jan 2019 17:03:47 -0800
To:     ndesaulniers@google.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, stable@vger.kernel.org,
        S@google.com, Shirish <Shirish.S@amd.com>,
        James Y Knight <jyknight@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: add -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines
Message-ID: <20190125010347.GD81583@google.com>
References: <20190125005304.183322-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190125005304.183322-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 04:52:59PM -0800, ndesaulniers@google.com wrote:
> arch/x86/Makefile disables SSE and SSE2 for the whole kernel.  The
> AMDGPU drivers modified in this patch re-enable SSE but not SSE2.  Turn
> on SSE2 to support emitting double precision floating point instructions
> rather than calls to non-existent (usually available from gcc_s or
> compiler_rt) floating point helper routines.
> 
> Link: https://gcc.gnu.org/onlinedocs/gccint/Soft-float-library-routines.html
> Link: https://github.com/ClangBuiltLinux/linux/issues/327
> Cc: stable@vger.kernel.org # 4.19
> Reported-by: S, Shirish <Shirish.S@amd.com>
> Reported-by: Matthias Kaehlcke <mka@google.com>
> Suggested-by: James Y Knight <jyknight@google.com>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 2 +-
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> index 95f332ee3e7e..dc85a3c088af 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> @@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
>  	cc_stack_align := -mstack-alignment=16
>  endif
>  
> -calcs_ccflags := -mhard-float -msse $(cc_stack_align)
> +calcs_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
>  
>  CFLAGS_dcn_calcs.o := $(calcs_ccflags)
>  CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index d97ca6528f9d..33c7d7588712 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
>  	cc_stack_align := -mstack-alignment=16
>  endif
>  
> -dml_ccflags := -mhard-float -msse $(cc_stack_align)
> +dml_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
>  
>  CFLAGS_display_mode_lib.o := $(dml_ccflags)
>  CFLAGS_display_pipe_clocks.o := $(dml_ccflags)

Tested-by:  Matthias Kaehlcke <mka@chromium.org>
