Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD258C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F7820862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F7820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeICUdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:33:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:25562 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbeICUdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:33:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 09:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,325,1531810800"; 
   d="scan'208";a="67221895"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga007.fm.intel.com with ESMTP; 03 Sep 2018 09:12:30 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 64192301B65; Mon,  3 Sep 2018 09:12:30 -0700 (PDT)
Date:   Mon, 3 Sep 2018 09:12:30 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] perf, tools, script: Allow sym and dso without
 ip, addr
Message-ID: <20180903161230.GH27886@tassilo.jf.intel.com>
References: <20180831220206.28351-1-andi@firstfloor.org>
 <20180831220206.28351-5-andi@firstfloor.org>
 <20180903071510.GA24575@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903071510.GA24575@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 09:15:10AM +0200, Jiri Olsa wrote:
> On Fri, Aug 31, 2018 at 03:02:00PM -0700, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > Currently sym and dso require printing ip and addr because
> > the print function is tied to those outputs. With callindent
> > it makes sense to print the symbol or dso without numerical
> > IP or ADDR. So change the dependency check to only check the
> > underlying attribute.
> > 
> > This allows to remove a lot of noise in callindent output by
> > dropping the numerical addresses, which are not all that useful.
> > 
> > Before
> > 
> > % perf script --itrace=cr -F +callindent
> >          swapper     0 [000] 156546.354971:          1   branches: pt_config                                       0 [unknown] ([unknown]) => ffffffff81010486 pt_config ([kernel.kallsyms])
> >          swapper     0 [000] 156546.354971:          1   branches:     pt_config                    ffffffff81010499 pt_config ([kernel.kallsyms]) => ffffffff8101063e pt_event_add ([kernel.kallsyms])
> >          swapper     0 [000] 156546.354971:          1   branches:     pt_event_add                 ffffffff81010635 pt_event_add ([kernel.kallsyms]) => ffffffff8115e687 event_sched_in.isra.107 ([kernel.kallsyms])
> >          swapper     0 [000] 156546.354971:          1   branches:     perf_pmu_enable              ffffffff8115e726 event_sched_in.isra.107 ([kernel.kallsyms]) => ffffffff811579b0 perf_pmu_enable ([kernel.kallsyms])
> >          swapper     0 [000] 156546.354971:          1   branches:     perf_pmu_nop_void            ffffffff81151730 perf_pmu_nop_void ([kernel.kallsyms]) => ffffffff8115e72b event_sched_in.isra.107 ([kernel.kallsyms])
> >          swapper     0 [000] 156546.354971:          1   branches:     event_sched_in.isra.107      ffffffff8115e737 event_sched_in.isra.107 ([kernel.kallsyms]) => ffffffff8115e7a5 group_sched_in ([kernel.kallsyms])
> >          swapper     0 [000] 156546.354971:          1   branches:     __x86_indirect_thunk_rax     ffffffff8115e7f6 group_sched_in ([kernel.kallsyms]) => ffffffff81a03000 __x86_indirect_thunk_rax ([kernel.kallsyms])
> > 
> > After
> > 
> > % perf script --itrace=cr -F +callindent,-ip,-sym,-symoff
> >        swapper     0 [000] 156546.354971:          1   branches:  pt_config
> >          swapper     0 [000] 156546.354971:          1   branches:      pt_config
> >          swapper     0 [000] 156546.354971:          1   branches:      pt_event_add
> >          swapper     0 [000] 156546.354971:          1   branches:       perf_pmu_enable
> >          swapper     0 [000] 156546.354971:          1   branches:       perf_pmu_nop_void
> >          swapper     0 [000] 156546.354971:          1   branches:       event_sched_in.isra.107
> >          swapper     0 [000] 156546.354971:          1   branches:       __x86_indirect_thunk_rax
> >          swapper     0 [000] 156546.354971:          1   branches:       perf_pmu_nop_int
> >          swapper     0 [000] 156546.354971:          1   branches:       group_sched_in
> >          swapper     0 [000] 156546.354971:          1   branches:       event_filter_match
> >          swapper     0 [000] 156546.354971:          1   branches:       event_filter_match
> >          swapper     0 [000] 156546.354971:          1   branches:       group_sched_in
> 
> I'm getting different output than advertised
> 
> [jolsa@krava perf]$ ./perf script --itrace=cr -F +callindent,-ip,-sym,-symoff | head -3
>               ls  1926 [000] 55509.544711:          1 branches:uhH: _start                           =>     7f9722fa0f60 (/usr/lib64/ld-2.27.so)
>               ls  1926 [000] 55509.544711:          1 branches:uhH: _start                           =>                0 ([unknown])
>               ls  1926 [000] 55509.544716:          1 branches:uhH: _start                           =>     7f9722fa0f60 (/usr/lib64/ld-2.27.so)

Yes it needs the next patch too. There's no good way to show the effect independently.

I will merge them into one.

-Andi
