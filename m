Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A27C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2386B2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvN6yGjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2386B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbeKFEH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:07:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeKFEH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:07:29 -0500
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27E7420869;
        Mon,  5 Nov 2018 18:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541443585;
        bh=d4RQtZ82g0SGcjtPgXw16iJIqqOLZvoyQrtjJdWHPKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LvN6yGjhvhhEVs2Gv2uQvuiKxONjOzhxZ9AdAxCKO1oafsSy7tRH0YpJGjYb58YWo
         RzDdt2dhX0HJOP6SP9w9kaQUXvk47nnd8ALaktuKKqE6r5mp8MClPuXED6vsw/ZrYA
         T1noNRzbYtwwhMdjRjCHLTeyv6PvAkywFDlL8gfQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 592A8142D18; Mon,  5 Nov 2018 15:46:12 -0300 (-03)
Date:   Mon, 5 Nov 2018 15:46:12 -0300
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
Message-ID: <20181105184612.GD7077@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-20-acme@kernel.org>
 <20181105154433.GA11115@roeck-us.net>
 <20181105171140.GD11147@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105171140.GD11147@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 05, 2018 at 02:11:40PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 05, 2018 at 07:44:33AM -0800, Guenter Roeck escreveu:
> > On Wed, Oct 31, 2018 at 01:44:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>

> > > Now when we run 'make -C tools/perf O=/tmp/build/perf' we end up with:

> > >   $ cat /tmp/build/perf/trace/beauty/generated/mmap_flags_array.c
> > >   static const char *mmap_flags[] = {
> > > 	[ilog2(0x40) + 1] = "32BIT",
<SNIP>
> > > +include ../scripts/Makefile.arch

> > >  # The default target of this Makefile is...
> > >  all:
> > > @@ -385,6 +386,8 @@ export INSTALL SHELL_PATH
> > >  SHELL = $(SHELL_PATH)

> > >  linux_uapi_dir := $(srctree)/tools/include/uapi/linux
> > > +asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
> > > +arch_asm_uapi_dir := $(srctree)/tools/arch/$(ARCH)/include/uapi/asm/

> > This doesn't work for me. With v4.20-rc1:

> > $ make ARCH=x86_64 defconfig
> > *** Default configuration is based on 'x86_64_defconfig'
 
> I'll fix this, its the ARCH that needs to be normalized to x86 before
> building the path...

Can you try with the following patch?

Thanks,

- Arnaldo

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
