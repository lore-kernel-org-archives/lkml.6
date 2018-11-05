Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27232C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E490D20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yG2zSNhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E490D20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbeKFEfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387841AbeKFEfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:35:20 -0500
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 703182086A;
        Mon,  5 Nov 2018 19:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541445248;
        bh=GCT2JXFvdH1s4I6/mrxBz+A3CRkfU/ndn+tv7gKD+Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yG2zSNhbilkBFbxgAxZoeX+hywMLL3yVMq+2zYQ8+mRlHHzzB503wnumcx7LjnWix
         /BO7RG8go70PikRjD5UJiueveh9EUEH2wc2PFmiJLjRBIob0KOvkaAuhB0VLWJX1iL
         4NvxvV8Ni7/S++E0hLmh6OZnfeQK3ocaUJR1cvdU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 42373142D18; Mon,  5 Nov 2018 16:13:56 -0300 (-03)
Date:   Mon, 5 Nov 2018 16:13:56 -0300
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
Message-ID: <20181105191356.GF7077@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-20-acme@kernel.org>
 <20181105154433.GA11115@roeck-us.net>
 <20181105171140.GD11147@kernel.org>
 <20181105184612.GD7077@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105184612.GD7077@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 05, 2018 at 03:46:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 05, 2018 at 02:11:40PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Nov 05, 2018 at 07:44:33AM -0800, Guenter Roeck escreveu:
> > > On Wed, Oct 31, 2018 at 01:44:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> > > > Now when we run 'make -C tools/perf O=/tmp/build/perf' we end up with:
> 
> > > >   $ cat /tmp/build/perf/trace/beauty/generated/mmap_flags_array.c
> > > >   static const char *mmap_flags[] = {
> > > > 	[ilog2(0x40) + 1] = "32BIT",
> <SNIP>
> > > > +include ../scripts/Makefile.arch
> 
> > > >  # The default target of this Makefile is...
> > > >  all:
> > > > @@ -385,6 +386,8 @@ export INSTALL SHELL_PATH
> > > >  SHELL = $(SHELL_PATH)
> 
> > > >  linux_uapi_dir := $(srctree)/tools/include/uapi/linux
> > > > +asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
> > > > +arch_asm_uapi_dir := $(srctree)/tools/arch/$(ARCH)/include/uapi/asm/
> 
> > > This doesn't work for me. With v4.20-rc1:
> 
> > > $ make ARCH=x86_64 defconfig
> > > *** Default configuration is based on 'x86_64_defconfig'
>  
> > I'll fix this, its the ARCH that needs to be normalized to x86 before
> > building the path...
> 
> Can you try with the following patch?

I did the tests and it seems to work, its the same method used by the
kernel sources, so I have this in place now:

commit e2c39f36c354a06c6e9d32d4fdf8660b41803d82
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Nov 5 15:46:51 2018 -0300

    perf beauty: Use SRCARCH, ARCH=x86_64 must map to "x86" to find the headers
    
    Guenter reported that using ARCH=x86_64 to build perf has regressed:
    
      $ make -C tools/perf O=/tmp/build/perf ARCH=x86_64
      make: Entering directory '/home/acme/git/perf/tools/perf'
        BUILD:   Doing 'make -j4' parallel build
        HOSTCC   /tmp/build/perf/fixdep.o
        HOSTLD   /tmp/build/perf/fixdep-in.o
        LINK     /tmp/build/perf/fixdep
    
      Auto-detecting system features:
      ...                         dwarf: [ on  ]
      <SNIP>
      ...                           bpf: [ on  ]
    
        GEN      /tmp/build/perf/common-cmds.h
      make[2]: *** No rule to make target '/home/acme/git/perf/tools/arch/x86_64/include/uapi/asm//mman.h', needed by '/tmp/build/perf/trace/beauty/generated/mmap_flags_array.c'.  Stop.
      make[2]: *** Waiting for unfinished jobs....
        PERF_VERSION = 4.19.gf6c23e3
      make[1]: *** [Makefile.perf:207: sub-make] Error 2
      make: *** [Makefile:70: all] Error 2
      make: Leaving directory '/home/acme/git/perf/tools/perf'
      $
    
    This is because we must use $(SRCARCH) where we were using $(ARCH), so
    that, just like the top level Makefile, we get this done:
    
      # Additional ARCH settings for x86
      ifeq ($(ARCH),i386)
              SRCARCH := x86
      endif
      ifeq ($(ARCH),x86_64)
              SRCARCH := x86
      endif
    
    Which is done in tools/scripts/Makefile.arch, so switch to use
    $(SRCARCH).
    
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Clark Williams <williams@redhat.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Wang Nan <wangnan0@huawei.com>
    Fixes: fbd7458db757 ("perf beauty: Wire up the mmap flags table generator to the Makefile")
    Link: https://lkml.kernel.org/r/20181105184612.GD7077@kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3ccb4f0bf088..d95655489f7e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -387,7 +387,7 @@ SHELL = $(SHELL_PATH)
 
 linux_uapi_dir := $(srctree)/tools/include/uapi/linux
 asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
-arch_asm_uapi_dir := $(srctree)/tools/arch/$(ARCH)/include/uapi/asm/
+arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
 
 beauty_outdir := $(OUTPUT)trace/beauty/generated
 beauty_ioctl_outdir := $(beauty_outdir)/ioctl
