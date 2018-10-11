Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26101C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14532085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWGEKN+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14532085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeJLDIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbeJLDIF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:08:05 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FDB92075C;
        Thu, 11 Oct 2018 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539286763;
        bh=uTL6c9UJIs3Rvij+Oxx7Sbm95QJgJQMBIT+qSpKmnWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWGEKN+Y0B2Gq4ZD5Xe07Gshw3quul5kJnqvOzuCU4tfLK0/DKS4HoOzCiwfjr8CA
         s0VmL9rZXFvLXT1q8jLT/yvj7J/6fEWezUruaLbJESPsLsRddmf4854clKlBC2r5k/
         KIiK0LiaQRRLngD/gUwIcIWpEAFry+FSZzmjP6lc=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 9D690142C5E; Thu, 11 Oct 2018 16:39:20 -0300 (-03)
Date:   Thu, 11 Oct 2018 16:39:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     jolsa@kernel.org, yao.jin@linux.intel.com, namhyung@kernel.org,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf report: don't crash on invalid inline debug
 information
Message-ID: <20181011193920.GA393@kernel.org>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
 <20180926135207.30263-3-milian.wolff@kdab.com>
 <20180927191037.GG25764@kernel.org>
 <1768601.Weh5pZyhPy@agathebauer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1768601.Weh5pZyhPy@agathebauer>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 11, 2018 at 08:23:31PM +0200, Milian Wolff escreveu:
> On Donnerstag, 27. September 2018 21:10:37 CEST Arnaldo Carvalho de Melo 
> wrote:
> > Em Wed, Sep 26, 2018 at 03:52:07PM +0200, Milian Wolff escreveu:
> > > When the function name for an inline frame is invalid, we must
> > > not try to demangle this symbol, otherwise we crash with:
> > > 
> > > #0  0x0000555555895c01 in bfd_demangle ()
> > > #1  0x0000555555823262 in demangle_sym (dso=0x555555d92b90, elf_name=0x0,
> > > kmodule=0) at util/symbol-elf.c:215 #2  dso__demangle_sym
> > > (dso=dso@entry=0x555555d92b90, kmodule=<optimized out>, kmodule@entry=0,
> > > elf_name=elf_name@entry=0x0) at util/symbol-elf.c:400 #3 
> > > 0x00005555557fef4b in new_inline_sym (funcname=0x0,
> > > base_sym=0x555555d92b90, dso=0x555555d92b90) at util/srcline.c:89 #4 
> > > inline_list__append_dso_a2l (dso=dso@entry=0x555555c7bb00,
> > > node=node@entry=0x555555e31810, sym=sym@entry=0x555555d92b90) at
> > > util/srcline.c:264 #5  0x00005555557ff27f in addr2line
> > > (dso_name=dso_name@entry=0x555555d92430
> > > "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce5/
> > > elf", addr=addr@entry=2888, file=file@entry=0x0,> 
> > >     line=line@entry=0x0, dso=dso@entry=0x555555c7bb00,
> > >     unwind_inlines=unwind_inlines@entry=true, node=0x555555e31810,
> > >     sym=0x555555d92b90) at util/srcline.c:313> 
> > > #6  0x00005555557ffe7c in addr2inlines (sym=0x555555d92b90,
> > > dso=0x555555c7bb00, addr=2888, dso_name=0x555555d92430
> > > "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce5/
> > > elf")> 
> > >     at util/srcline.c:358
> > > 
> > > So instead handle the case where we get invalid function names
> > > for inlined frames and use a fallback '??' function name instead.
> > > 
> > > While this crash was originally reported by Hadrien for rust code,
> > > I can now also reproduce it with trivial C++ code. Indeed, it seems
> > > like libbfd fails to interpret the debug information for the inline
> > > frame symbol name:
> > > 
> > > $ addr2line -e
> > > /home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce5/e
> > > lf -if b48 main
> > > /usr/include/c++/8.2.1/complex:610
> > > ??
> > > /usr/include/c++/8.2.1/complex:618
> > > ??
> > > /usr/include/c++/8.2.1/complex:675
> > > ??
> > > /usr/include/c++/8.2.1/complex:685
> > > main
> > > /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-inlining/mai
> > > n.cpp:39
> > > 
> > > I've reported this bug upstream and also attached a patch there
> > > which should fix this issue:
> > > https://sourceware.org/bugzilla/show_bug.cgi?id=23715
> > 
> > Millian, what about this one, which is the cset it is fixing?
> 
> Hey Arnaldo,
> 
> just noticed this email and that the corresponding patch hasn't landed in 
> perf/core yet. The patch set which introduced this is a64489c56c307 ("perf 
> report: Find the inline stack for a given address"). Note that the code was 
> introduced by this patch, but then subsequently touched and moved by follow up 
> patches. So, is this the patch you want to see referenced? Otherwise, the 
> latest patch which gets fixed is afaik: 7285cf3325b4a ("perf srcline: Show 
> correct function name for srcline of callchains").
> 
> Can you please pick either of these patches and amend the commit message of my 
> patch and push it to perf/urgent and perf/core?

I'll reread all this later or tomorrow and continue, going AFK now.

- Arnaldo
