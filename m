Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3966EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0104220855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547737140;
	bh=ZUkUj11T3jfQheJDtdUqq8TzjzB6/YEfE3O8Vl1jsTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1VU8sYRomDigVnQP6ebWW8B7MciejiIeJkapjaG7ZAS2Lwg8TBGngWjtQN4B71UP/
	 0KgAj0NvcCDdvJ4nmoHVPPAMOg5IhPG3j8fgJ2lUaZC13Fg/dCsExxx3zC4ZoEnprF
	 W4NpIEvnU8dyOR41W33X7977TsG1wQnMynU0mZXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfAQO66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:58:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfAQO66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:58:58 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1655520851;
        Thu, 17 Jan 2019 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547737137;
        bh=ZUkUj11T3jfQheJDtdUqq8TzjzB6/YEfE3O8Vl1jsTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/K/q+XGt+BkVw7R2yfC2iXsa3QcJd6B/VH74QoO4dnffTXpy2QZRqMMpCfCHdDcx
         rzAe/kd2ntyQCZUCBEvG4U9p02XybqUr5vjOdAKHUcQCijFLDP/dZeETzP+/3CAV4k
         SC1USyy4egWi4b2ckVjgwbwDENlX2esePMZ4CRXs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9EDAB41AB5; Thu, 17 Jan 2019 11:58:54 -0300 (-03)
Date:   Thu, 17 Jan 2019 11:58:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        David Ahern <dsahern@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v10 perf, bpf-next 1/9] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Message-ID: <20190117145854.GD5823@kernel.org>
References: <20190116162931.1542429-1-songliubraving@fb.com>
 <20190116162931.1542429-2-songliubraving@fb.com>
 <20190117125653.GF10486@hirez.programming.kicks-ass.net>
 <A411D89E-0B62-4DE7-9D70-CD57672FD20A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A411D89E-0B62-4DE7-9D70-CD57672FD20A@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 17, 2019 at 02:49:10PM +0000, Song Liu escreveu:
> 
> 
> > On Jan 17, 2019, at 4:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Jan 16, 2019 at 08:29:23AM -0800, Song Liu wrote:
> >> For better performance analysis of dynamically JITed and loaded kernel
> >> functions, such as BPF programs, this patch introduces
> >> PERF_RECORD_KSYMBOL, a new perf_event_type that exposes kernel symbol
> >> register/unregister information to user space.
> >> 
> >> The following data structure is used for PERF_RECORD_KSYMBOL.
> >> 
> >>    /*
> >>     * struct {
> >>     *      struct perf_event_header        header;
> >>     *      u64                             addr;
> >>     *      u32                             len;
> >>     *      u16                             ksym_type;
> >>     *      u16                             flags;
> >>     *      char                            name[];
> >>     *      struct sample_id                sample_id;
> >>     * };
> >>     */
> > 
> > So I've cobbled together the attached patches to see how it would work
> > out..
> > 
> > I didn't convert ftrace trampolines; because ftrace code has this
> > uncanny ability to make my head hurt. But I don't think it should be
> > hard, once one figures out the right structure to stick that
> > kallsym_node thing in (ftrace_ops ?!).
> > 
> > It is compiled only, so no testing what so ever (also, no changelogs).
> > 
> > I didn't wire up the KSYM_TYPE thing; I'm wondering if we really need
> > that, OTOH it really doesn't hurt having it either.
> > 
> > One weird thing I noticed, wth does bpf_prog_kallsyms_add() check
> > CAP_ADMIN ?! Surely even a non-priv JIT'ed program generates symbols,
> > why hide those?
> > 
> > Anyway; with the one nit about the get_names() thing sorted:
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > (thanks for sticking with this)
> > <peterz-latch-next.patch><peterz-kallsym.patch><peterz-kallsym-bpf.patch>
> 
> Aha, now I get the point on perf_event_ksymbol(). Yeah this approach is 
> definitely better. 
> 
> While I run more tests with these patches, could we get current in 
> perf/core? This will enable the development of user space tools like
> bcc. 
> 
> Also, I current base this set on bpf-next tree, as tip/perf/core is 
> 4 week old. Shall I rebase the set on Linus' tree? Or shall I wait for
> tip/perf/core?

So, can you post one last set, this time with PeterZ's Acked-by,
assuming you're sorting out the get_names() thing, and I can try merging
this into my perf/core branch, then pushing it out to Ingo, my perf/core
starts from tip/perf/urgent, so should be new enough.

I'd then right after testing it send a pull request to Ingo, synching
everything.

- Arnaldo
