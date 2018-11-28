Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A4DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB5320832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB5BerpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB5320832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeK2AGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:06:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbeK2AGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:06:18 -0500
Received: from quaco.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E5F120989;
        Wed, 28 Nov 2018 13:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543410281;
        bh=m3PADt0gPFrfO0yETRYfCyFILkO/y6dF3MyibXkERLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SB5BerpCGZH3ql0l0KWc2V4WfNOem6eT4g9Ye8qEcF3+tnM1Dagypz2CAqOblKy+p
         ytL0Hvau6iIzNktlkFaubl1BwDG8bHp57jf57E7KpDgB2PeT0z9PFbXeJj1Hn+MGvu
         b7KrmM3Jur7vR6OklzstOpFhZm0Y4cP+gnfBrBqQ=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id EEC2A40341; Wed, 28 Nov 2018 10:04:38 -0300 (-03)
Date:   Wed, 28 Nov 2018 10:04:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ivan Babrou <ibobrik@gmail.com>
Cc:     arnaldo.melo@gmail.com, linux-perf-users@vger.kernel.org,
        daniel@iogearbox.net, ast@kernel.org, davem@davemloft.net,
        dsahern@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: eBPF program symbols in perf top
Message-ID: <20181128130438.GB31608@kernel.org>
References: <CANWdNRAD2XBnztZN760mOX+LfXY_uAvsRqEnkTJnqwrZCBK92w@mail.gmail.com>
 <20181127133054.GE15747@kernel.org>
 <CANWdNRDdSMeQ1RHpHMoG7-aRVjufG79jyrZqYqho2_3gX3hrfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANWdNRDdSMeQ1RHpHMoG7-aRVjufG79jyrZqYqho2_3gX3hrfw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 27, 2018 at 11:41:19PM -0800, Ivan Babrou escreveu:
> Hey Arnaldo,
> 
> Thanks for the quick response. I've tried your patch and it works as
> expected with perf top.

Ok, I'll add the patch to my perf/core branch with your Reported-by and
Tested-by, is that ok with you?
 
> What are the reasons for not giving kallsyms precedence at this moment?

The use of vmlinux for these things predates having many of the code
modifications that are performed in a live kernel these days, also
pre-dates eBPF, etc, etc, so using vmlinux, when found, was better
because ELF symtabs are more expressive, kallsyms have just the start of
a symbol, for instance, etc.

Having that said, with the advent of things like Intel PT, etc using
/proc/kcore + /proc/kallsyms became a requirement, there is even code to
stash copies of those in ~/.debug/ for post processing (off-site using
'perf archive' even, etc).

I _think_ that switch to using /proc/kallsyms as default now is becoming
a requirement, just haven't thought thru all possible implications of
doing that.

I don't recall if there is a way to set kallsyms precedence in
~/.perfconfig, have to look at that.

- Arnaldo

> On Tue, Nov 27, 2018 at 5:30 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Mon, Nov 26, 2018 at 04:21:15PM -0800, Ivan Babrou escreveu:
> > > It's possible to see eBPF programs in "perf report" and "perf script"
> > > started with "--kallsyms=/proc/kallsyms", if net.core.bpf_jit_kallsyms
> > > sysctl is set to 1. However, it's not possible to pass "--kallsyms" to
> > > "perf top".
> >
> >
> > So, the first step, I think, is to check if having 'perf top
> > --kallsyms=..." would help, i.e. to check the patch that introduced
> > '--kallsyms' to 'perf report' and see if that would be difficult to have
> > the same functionality in 'perf top', the cset where it is introduced
> > is:
> >
> >   b226a5a72901b ("perf report: Allow user to specify path to kallsyms file"
> >
> > Below is the resulting patch, can you please check if with that you get
> > the result you want? We can then go from there to some simplification,
> > perhaps give precedence to kallsyms.
> >
> > diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> > index 808b664343c9..44d89fb9c788 100644
> > --- a/tools/perf/Documentation/perf-top.txt
> > +++ b/tools/perf/Documentation/perf-top.txt
> > @@ -70,6 +70,9 @@ Default is to monitor all CPUS.
> >  --ignore-vmlinux::
> >         Ignore vmlinux files.
> >
> > +--kallsyms=<file>::
> > +       kallsyms pathname
> > +
> >  -m <pages>::
> >  --mmap-pages=<pages>::
> >         Number of mmap data pages (must be a power of two) or size
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index aa0c73e57924..1252d1759064 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1289,6 +1289,8 @@ int cmd_top(int argc, const char **argv)
> >                    "file", "vmlinux pathname"),
> >         OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
> >                     "don't load vmlinux even if found"),
> > +       OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
> > +                  "file", "kallsyms pathname"),
> >         OPT_BOOLEAN('K', "hide_kernel_symbols", &top.hide_kernel_symbols,
> >                     "hide kernel symbols"),
> >         OPT_CALLBACK('m', "mmap-pages", &opts->mmap_pages, "pages",

-- 

- Arnaldo
