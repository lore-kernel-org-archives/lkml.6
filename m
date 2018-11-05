Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E036AC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE06C208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLMlyPdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE06C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387757AbeKFDRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730047AbeKFDRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:17:33 -0500
Received: from jouet.infradead.org (unknown [189.40.101.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3DA2086A;
        Mon,  5 Nov 2018 17:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541440602;
        bh=YqOGo1ih9WJpsyVJtaTP5HYXxXZodJmzJeXFPTZS8Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLMlyPdqeYAvQQL6orsQZTTYwD7EnyRadjDvuA5wVQdzxKp463OfUv/dQniK6NPxh
         91WM5SlnvB/HmsDEE6pwDO5NisW8V1lWuPcUHe3tL1INt/tRo9KLVi03cCQpu55LRU
         24NN/YCdeP0VJWWcZFlaFIYeEAIW2B0SmeqIDpgY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 3356B142D18; Mon,  5 Nov 2018 14:11:40 -0300 (-03)
Date:   Mon, 5 Nov 2018 14:11:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 19/28] perf beauty: Wire up the mmap flags table
 generator to the Makefile
Message-ID: <20181105171140.GD11147@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-20-acme@kernel.org>
 <20181105154433.GA11115@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105154433.GA11115@roeck-us.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 05, 2018 at 07:44:33AM -0800, Guenter Roeck escreveu:
> On Wed, Oct 31, 2018 at 01:44:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Now when we run 'make -C tools/perf O=/tmp/build/perf' we end up with:
> > 
> >   $ cat /tmp/build/perf/trace/beauty/generated/mmap_flags_array.c
> >   static const char *mmap_flags[] = {
> > 	[ilog2(0x40) + 1] = "32BIT",
> > 	[ilog2(0x01) + 1] = "SHARED",
> > 	[ilog2(0x02) + 1] = "PRIVATE",
> > 	[ilog2(0x10) + 1] = "FIXED",
> > 	[ilog2(0x20) + 1] = "ANONYMOUS",
> > 	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
> > 	[ilog2(0x0100) + 1] = "GROWSDOWN",
> > 	[ilog2(0x0800) + 1] = "DENYWRITE",
> > 	[ilog2(0x1000) + 1] = "EXECUTABLE",
> > 	[ilog2(0x2000) + 1] = "LOCKED",
> > 	[ilog2(0x4000) + 1] = "NORESERVE",
> > 	[ilog2(0x8000) + 1] = "POPULATE",
> > 	[ilog2(0x10000) + 1] = "NONBLOCK",
> > 	[ilog2(0x20000) + 1] = "STACK",
> > 	[ilog2(0x40000) + 1] = "HUGETLB",
> > 	[ilog2(0x80000) + 1] = "SYNC",
> >   };
> >   $
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: David Ahern <dsahern@gmail.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Wang Nan <wangnan0@huawei.com>
> > Link: https://lkml.kernel.org/n/tip-t3fn7u3tjsupio6e6vkufx9m@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/Makefile.perf | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index a31c5c29d53a..3ccb4f0bf088 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1,4 +1,5 @@
> >  include ../scripts/Makefile.include
> > +include ../scripts/Makefile.arch
> >  
> >  # The default target of this Makefile is...
> >  all:
> > @@ -385,6 +386,8 @@ export INSTALL SHELL_PATH
> >  SHELL = $(SHELL_PATH)
> >  
> >  linux_uapi_dir := $(srctree)/tools/include/uapi/linux
> > +asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
> > +arch_asm_uapi_dir := $(srctree)/tools/arch/$(ARCH)/include/uapi/asm/
> >  
> 
> This doesn't work for me. With v4.20-rc1:
> 
> $ make ARCH=x86_64 defconfig
> *** Default configuration is based on 'x86_64_defconfig'

I'll fix this, its the ARCH that needs to be normalized to x86 before
building the path...

- Arnaldo

> #
> # configuration written to .config
> #
> groeck@server:~/src/linux-staging$ make ARCH=x86_64 -j30 tools/perf
> scripts/kconfig/conf  --syncconfig Kconfig
>   BUILD:   Doing 'make -j16' parallel build
>   HOSTCC   /home/groeck/src/linux-staging/tools/perf/fixdep.o
>   HOSTLD   /home/groeck/src/linux-staging/tools/perf/fixdep-in.o
>   LINK     /home/groeck/src/linux-staging/tools/perf/fixdep
> Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
> diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
> diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
> Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/ioctls.h' differs from latest version at 'include/uapi/asm-generic/ioctls.h'
> diff -u tools/include/uapi/asm-generic/ioctls.h include/uapi/asm-generic/ioctls.h
> Makefile.config:814: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> Makefile.config:851: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> make[4]: *** No rule to make target '/home/groeck/src/linux-staging/tools/arch/x86_64/include/uapi/asm//mman.h', needed by '/home/groeck/src/linux-staging/tools/perf/trace/beauty/generated/mmap_flags_array.c'.  Stop.
> make[4]: *** Waiting for unfinished jobs....
>   PERF_VERSION = 4.20.rc1.g6510223
> Makefile.perf:206: recipe for target 'sub-make' failed
> make[3]: *** [sub-make] Error 2
> Makefile:69: recipe for target 'all' failed
> make[2]: *** [all] Error 2
> Makefile:77: recipe for target 'perf' failed
> make[1]: *** [perf] Error 2
> Makefile:1688: recipe for target 'tools/perf' failed
> make: *** [tools/perf] Error 2
> groeck@server:~/src/linux-staging$ ls tools/arch
> alpha  arc  arm  arm64	h8300  hexagon	ia64  microblaze  mips	parisc	powerpc  s390  sh  sparc  x86  xtensa
