Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7977C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE5420844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTogsUDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfA2S4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:56:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42367 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfA2S4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:56:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so9752369plp.9;
        Tue, 29 Jan 2019 10:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6QwWpnJgv1GjxiMMzkx3rfy8vyFIphyZ17dynepjQE4=;
        b=TTogsUDSia1/idd3GeITuoQQBgU8LeycUtrM2B5gZ2f89QgFebjeweazVdNrvndOPN
         c2jbVLolQjMXZFYDOvBt5yuqsiPMHdhHdd2mtm4X7mjPZ+BIjKArgm6fWjCxu9fTDSIW
         pV0IoWWkSbU+hai9a8516IniV6pNkO43d0z9f9XePac07Yg3BCk+PV1LHB4ZQRZ3YCVA
         u0pOZyzKxGh9DSIkgY1tPmt+AfwtVS9f9YAaLgoPvG5IwQynaYi5uCSjy5806HzEl3Dj
         TsIFdOnEPjtQufrsEqJmTZVUBVy4mY/78ajG+T6Ozj5wR8JJ2SHEeVOTHw1bvdb+e8Dz
         YIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6QwWpnJgv1GjxiMMzkx3rfy8vyFIphyZ17dynepjQE4=;
        b=XnuE9tJtIvXCa8vd+JMuvkCgkb+fcOU+95jWv+OidAutevKVm2AbD60PUR6zyAi4AE
         KZLr0IZd/Sv9YAykbKOii01SGtR09IhN0aWFhANGuPG992P5HR2dFc6usL0wTYLR6mNJ
         UDrHplVtBloakF7vsvK6RdyQdYvGTa9uSMx6TnnDGtlH+BkHBi2tAIJe8Q0ZAGzgS67l
         4dkSJfWOQw2nwUFFg/c/EkAZ6EOCGXj6IHL/ap0YRQQgk8bZVI+jtMKGPFau9r/5Cfkq
         NHlbymEhU72KkP1W87ix3TZzA7P48b6dG9gZHmtAZLQoO2krBAo738jFKmu+5ngKvMc6
         niTA==
X-Gm-Message-State: AJcUukfZVYrPXzfRBKrBF7TS3dDFcnQZCeAv6adqs+z6WnbfZVsA7Yxn
        uTCR/79YObmXD4z5oG1yhm3/3ASF
X-Google-Smtp-Source: ALg8bN69ysuxa2wXFsQb5eBbwcl6HQ4tBJSAXrcPdyjTX0x/lsR7vzHa0PHVF0l5Q5PAa7OGrQo08A==
X-Received: by 2002:a17:902:292b:: with SMTP id g40mr27434840plb.82.1548788163405;
        Tue, 29 Jan 2019 10:56:03 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a4sm39500514pgv.70.2019.01.29.10.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:56:02 -0800 (PST)
Date:   Tue, 29 Jan 2019 10:56:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>, "S@google.com" <S@google.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Daenzer, Michel" <Michel.Daenzer@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>,
        Matthias Kaehlcke <mka@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        James Y Knight <jyknight@google.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amd/display: add -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines
Message-ID: <20190129185601.GA17525@roeck-us.net>
References: <20190125005304.183322-1-ndesaulniers@google.com>
 <04bc6844-2a3b-2de8-60a7-a027149709fd@amd.com>
 <CADnq5_OuSD7Bmeg3CP0Y6JTo9Xso2FTZ3tKk-u1C+-B32eUGmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_OuSD7Bmeg3CP0Y6JTo9Xso2FTZ3tKk-u1C+-B32eUGmQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:30:31AM -0500, Alex Deucher wrote:
> On Fri, Jan 25, 2019 at 10:29 AM Wentland, Harry <Harry.Wentland@amd.com> wrote:
> >
> > On 2019-01-24 7:52 p.m., ndesaulniers@google.com wrote:
> > > arch/x86/Makefile disables SSE and SSE2 for the whole kernel.  The
> > > AMDGPU drivers modified in this patch re-enable SSE but not SSE2.  Turn
> > > on SSE2 to support emitting double precision floating point instructions
> > > rather than calls to non-existent (usually available from gcc_s or
> > > compiler_rt) floating point helper routines.
> > >
> > > Link: https://gcc.gnu.org/onlinedocs/gccint/Soft-float-library-routines.html
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/327
> > > Cc: stable@vger.kernel.org # 4.19
> > > Reported-by: S, Shirish <Shirish.S@amd.com>
> > > Reported-by: Matthias Kaehlcke <mka@google.com>
> > > Suggested-by: James Y Knight <jyknight@google.com>
> > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Tested-by: Guenter Roeck <linux@roeck-us.net>
> >
> > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >
> > and applied.
> >
> 
> This patch causes a segfault:
> https://bugs.freedesktop.org/show_bug.cgi?id=109487
> 
> Any ideas?
> 

Set -msse2 only for clang ? I suspect, though, that this might only
solve the compile problem. If I understand correctly, the first
warning in the log is due to BREAK_TO_DEBUGGER(), suggesting that
something is seriously wrong. Maybe enabling sse2 results in different
results from floating point operations.

Unfortunately I don't have a system with the affected GPU,
so I can't run any tests on real hardware. Unless someone can test
with real hardware, I think we have no choice but to revert the
patch.

Guenter

> Alex
> 
> > Harry
> >
> > > ---
> > >  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 2 +-
> > >  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> > > index 95f332ee3e7e..dc85a3c088af 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> > > +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> > > @@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
> > >       cc_stack_align := -mstack-alignment=16
> > >  endif
> > >
> > > -calcs_ccflags := -mhard-float -msse $(cc_stack_align)
> > > +calcs_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
> > >
> > >  CFLAGS_dcn_calcs.o := $(calcs_ccflags)
> > >  CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > > index d97ca6528f9d..33c7d7588712 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > > +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > > @@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
> > >       cc_stack_align := -mstack-alignment=16
> > >  endif
> > >
> > > -dml_ccflags := -mhard-float -msse $(cc_stack_align)
> > > +dml_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
> > >
> > >  CFLAGS_display_mode_lib.o := $(dml_ccflags)
> > >  CFLAGS_display_pipe_clocks.o := $(dml_ccflags)
> > >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
