Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6651BC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCC721486
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9dDrTQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCC721486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeINAzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbeINAzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:55:41 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A3EF20853;
        Thu, 13 Sep 2018 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536867884;
        bh=Cyeha3oztEh3UQHl06+1gaWXogkIxn1BpA1c2ayDM08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9dDrTQUzghtZlHePtvTyD+ZI7SNjbsDuYRTv1gAFjX/tFtS2ExT0p76vRQB5Qt1I
         VyhQwox9Ug4V+v2JZiw+Waqrkjk0dDqer3m+mURma+DWtSE8QbpolocBTdGfhDST9r
         2LPdzZkDYCagFUARWvi/VD8B8IVTB3Lil2wT7u5c=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 693BC140260; Thu, 13 Sep 2018 16:44:41 -0300 (-03)
Date:   Thu, 13 Sep 2018 16:44:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>
Subject: Re: [RFC/fix] Re: libbpf build broken on musl libc (Alpine Linux)
Message-ID: <20180913194441.GG30969@kernel.org>
References: <20180910172903.GB15516@kernel.org>
 <20180911122218.0d2eb3f9@cakuba>
 <20180911121543.GB22689@kernel.org>
 <20180911212451.hvnyfwyvcs4yojqy@ast-mbp>
 <20180913183240.GF30969@kernel.org>
 <20180913185629.su22fnimluoezntg@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913185629.su22fnimluoezntg@ast-mbp>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 13, 2018 at 11:56:31AM -0700, Alexei Starovoitov escreveu:
> On Thu, Sep 13, 2018 at 03:32:40PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Sep 11, 2018 at 02:24:53PM -0700, Alexei Starovoitov escreveu:
> > > On Tue, Sep 11, 2018 at 09:15:43AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, Sep 11, 2018 at 12:22:18PM +0200, Jakub Kicinski escreveu:
> > > > > On Mon, 10 Sep 2018 14:29:03 -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > After lunch I'll work on a patch to fix this, 
> > > > > Any luck?
> > 
> > > > Well, we need to apply the patch below and make tools/lib/str_error_r.c
> > > > live in a library that libbpf and perf is linked to.
> >  
> > > do you want us to take the patch or you're applying it yourself?
> > 
> > Please do some testing with my perf/libbpf+str_error_r branch, it has
> > two patches to get this fixed, the one I sent and a prep one making
> > libbpf link against libapi.
> > 
> > [acme@jouet perf]$ git log --oneline -2
> > a7ab924b7fec (HEAD -> perf/urgent, acme.korg/perf/libbpf+str_error_r) tools lib bpf: Use str_error_r() to fix the build in Alpine Linux
> > fb4a79e04c2b tools lib bpf: Build and link to tools/lib/api/
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/libbpf%2bstr_error_r&id=fb4a79e04c2b37ee873a3b31a3250925cf466fff
> we cannot do this.
> lib/api is GPL we cannot use it in LGPL library.

Humm, I wrote tools/lib/str_error_r.c, so I can possibly relicense it as
LGPL and then link just that one, as I did in one of my local patches.

The only line that is not from me in tha file is from Josh Poinboeuf,
which I CCed here.

- Arnaldo
