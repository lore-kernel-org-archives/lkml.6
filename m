Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0FCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C0721476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKtzI2hV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C0721476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeJQBlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbeJQBlA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:41:00 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CAB320645;
        Tue, 16 Oct 2018 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539712165;
        bh=GIqKxFZjgGb+FT/9F3ATzhSqfijWdV8PY/gkSCKIYTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKtzI2hVlZGyu9Lv1okMQj8myVn3XJ3AWsjoRr1GLP1O5M/MD13BwRYi0Z4fwFZIU
         zdFcX+S9KwFSuhqoHNpT0ECeCHFFUc3nGc7m6dYX0UwLDuH59mIOq7OXXpcQ3OSa/z
         Eu+eOJS/rWpF5hYpVgSF/zbHhJm00VtxWoOYLq+k=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 16550142C5E; Tue, 16 Oct 2018 14:49:23 -0300 (-03)
Date:   Tue, 16 Oct 2018 14:49:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH 3/3] perf report: don't crash on invalid inline debug
 information
Message-ID: <20181016174923.GE3849@kernel.org>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
 <1768601.Weh5pZyhPy@agathebauer>
 <20181011193920.GA393@kernel.org>
 <4772069.7eSvdiorvC@agathebauer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4772069.7eSvdiorvC@agathebauer>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 15, 2018 at 10:51:36PM +0200, Milian Wolff escreveu:
> On Donnerstag, 11. Oktober 2018 21:39:20 CEST Arnaldo Carvalho de Melo wrote:
> > Em Thu, Oct 11, 2018 at 08:23:31PM +0200, Milian Wolff escreveu:
> > > On Donnerstag, 27. September 2018 21:10:37 CEST Arnaldo Carvalho de Melo
> > > 
> > > wrote:
> > > > Em Wed, Sep 26, 2018 at 03:52:07PM +0200, Milian Wolff escreveu:
> > > > > When the function name for an inline frame is invalid, we must
> > > > > not try to demangle this symbol, otherwise we crash with:
> > > > > 
> > > > > #0  0x0000555555895c01 in bfd_demangle ()
> > > > > #1  0x0000555555823262 in demangle_sym (dso=0x555555d92b90,
> > > > > elf_name=0x0,
> > > > > kmodule=0) at util/symbol-elf.c:215 #2  dso__demangle_sym
> > > > > (dso=dso@entry=0x555555d92b90, kmodule=<optimized out>,
> > > > > kmodule@entry=0,
> > > > > elf_name=elf_name@entry=0x0) at util/symbol-elf.c:400 #3
> > > > > 0x00005555557fef4b in new_inline_sym (funcname=0x0,
> > > > > base_sym=0x555555d92b90, dso=0x555555d92b90) at util/srcline.c:89 #4
> > > > > inline_list__append_dso_a2l (dso=dso@entry=0x555555c7bb00,
> > > > > node=node@entry=0x555555e31810, sym=sym@entry=0x555555d92b90) at
> > > > > util/srcline.c:264 #5  0x00005555557ff27f in addr2line
> > > > > (dso_name=dso_name@entry=0x555555d92430
> > > > > "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fc
> > > > > e5/
> > > > > elf", addr=addr@entry=2888, file=file@entry=0x0,>
> > > > > 
> > > > >     line=line@entry=0x0, dso=dso@entry=0x555555c7bb00,
> > > > >     unwind_inlines=unwind_inlines@entry=true, node=0x555555e31810,
> > > > >     sym=0x555555d92b90) at util/srcline.c:313>
> > > > > 
> > > > > #6  0x00005555557ffe7c in addr2inlines (sym=0x555555d92b90,
> > > > > dso=0x555555c7bb00, addr=2888, dso_name=0x555555d92430
> > > > > "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fc
> > > > > e5/
> > > > > elf")>
> > > > > 
> > > > >     at util/srcline.c:358
> > > > > 
> > > > > So instead handle the case where we get invalid function names
> > > > > for inlined frames and use a fallback '??' function name instead.
> > > > > 
> > > > > While this crash was originally reported by Hadrien for rust code,
> > > > > I can now also reproduce it with trivial C++ code. Indeed, it seems
> > > > > like libbfd fails to interpret the debug information for the inline
> > > > > frame symbol name:
> > > > > 
> > > > > $ addr2line -e
> > > > > /home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce
> > > > > 5/e
> > > > > lf -if b48 main
> > > > > /usr/include/c++/8.2.1/complex:610
> > > > > ??
> > > > > /usr/include/c++/8.2.1/complex:618
> > > > > ??
> > > > > /usr/include/c++/8.2.1/complex:675
> > > > > ??
> > > > > /usr/include/c++/8.2.1/complex:685
> > > > > main
> > > > > /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-inlining
> > > > > /mai
> > > > > n.cpp:39
> > > > > 
> > > > > I've reported this bug upstream and also attached a patch there
> > > > > which should fix this issue:
> > > > > https://sourceware.org/bugzilla/show_bug.cgi?id=23715
> > > > 
> > > > Millian, what about this one, which is the cset it is fixing?
> > > 
> > > Hey Arnaldo,
> > > 
> > > just noticed this email and that the corresponding patch hasn't landed in
> > > perf/core yet. The patch set which introduced this is a64489c56c307 ("perf
> > > report: Find the inline stack for a given address"). Note that the code
> > > was
> > > introduced by this patch, but then subsequently touched and moved by
> > > follow up patches. So, is this the patch you want to see referenced?
> > > Otherwise, the latest patch which gets fixed is afaik: 7285cf3325b4a
> > > ("perf srcline: Show correct function name for srcline of callchains").
> > > 
> > > Can you please pick either of these patches and amend the commit message
> > > of my patch and push it to perf/urgent and perf/core?
> > 
> > I'll reread all this later or tomorrow and continue, going AFK now.
> 
> Ping?

Applied, seems simple enough, makes this code a bit more robust.

With regards to the cset where the problem originally was introduced,
i.e. not checking if a2l->funcname was NULL before either passing it to
strdup() or all the way to bfd_demangle(), that would cause the crash in
either place, I think this is the cset:

  commit a64489c56c307bf0955f0489158c5ecf6aa10fe2
  Author: Jin Yao <yao.jin@linux.intel.com>
  Date:   Sun Mar 26 04:34:26 2017 +0800

      perf report: Find the inline stack for a given address

Agreed?

- Arnaldo
