Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C7EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C75F2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C75F2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeH3M56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:57:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbeH3M55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:57:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94CB4804BAAC;
        Thu, 30 Aug 2018 08:56:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5CB162166B41;
        Thu, 30 Aug 2018 08:56:49 +0000 (UTC)
Date:   Thu, 30 Aug 2018 10:56:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 04/10] perf, tools, script: Allow sym and dso without
 ip, addr
Message-ID: <20180830085648.GC16691@krava>
References: <20180829171834.6590-1-andi@firstfloor.org>
 <20180829171834.6590-5-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829171834.6590-5-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 08:56:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 08:56:50 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:18:28AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Currently sym and dso require printing ip and addr because
> the print function is tied to those outputs. With callindent
> it makes sense to print the symbol or dso without numerical
> IP or ADDR. So change the dependency check to only check the
> underlying attribute.
> 
> This allows to remove a lot of noise in callindent output by
> dropping the numerical addresses, which are not all that useful.
> 
> Before
> 
> % perf script --itrace=cr -F +callindent
>          swapper     0 [000] 156546.354971:          1   branches: pt_config                                       0 [unknown] ([unknown]) => ffffffff81010486 pt_config ([kernel.kallsyms])
>          swapper     0 [000] 156546.354971:          1   branches:     pt_config                    ffffffff81010499 pt_config ([kernel.kallsyms]) => ffffffff8101063e pt_event_add ([kernel.kallsyms])
>          swapper     0 [000] 156546.354971:          1   branches:     pt_event_add                 ffffffff81010635 pt_event_add ([kernel.kallsyms]) => ffffffff8115e687 event_sched_in.isra.107 ([kernel.kallsyms])
>          swapper     0 [000] 156546.354971:          1   branches:     perf_pmu_enable              ffffffff8115e726 event_sched_in.isra.107 ([kernel.kallsyms]) => ffffffff811579b0 perf_pmu_enable ([kernel.kallsyms])
>          swapper     0 [000] 156546.354971:          1   branches:     perf_pmu_nop_void            ffffffff81151730 perf_pmu_nop_void ([kernel.kallsyms]) => ffffffff8115e72b event_sched_in.isra.107 ([kernel.kallsyms])
>          swapper     0 [000] 156546.354971:          1   branches:     event_sched_in.isra.107      ffffffff8115e737 event_sched_in.isra.107 ([kernel.kallsyms]) => ffffffff8115e7a5 group_sched_in ([kernel.kallsyms])
>          swapper     0 [000] 156546.354971:          1   branches:     __x86_indirect_thunk_rax     ffffffff8115e7f6 group_sched_in ([kernel.kallsyms]) => ffffffff81a03000 __x86_indirect_thunk_rax ([kernel.kallsyms])
> 
> After
> 
> % perf script --itrace=cr -F +callindent,-ip,-sym
>        swapper     0 [000] 156546.354971:          1   branches:  pt_config
>          swapper     0 [000] 156546.354971:          1   branches:      pt_config
>          swapper     0 [000] 156546.354971:          1   branches:      pt_event_add
>          swapper     0 [000] 156546.354971:          1   branches:       perf_pmu_enable
>          swapper     0 [000] 156546.354971:          1   branches:       perf_pmu_nop_void
>          swapper     0 [000] 156546.354971:          1   branches:       event_sched_in.isra.107
>          swapper     0 [000] 156546.354971:          1   branches:       __x86_indirect_thunk_rax
>          swapper     0 [000] 156546.354971:          1   branches:       perf_pmu_nop_int
>          swapper     0 [000] 156546.354971:          1   branches:       group_sched_in
>          swapper     0 [000] 156546.354971:          1   branches:       event_filter_match
>          swapper     0 [000] 156546.354971:          1   branches:       event_filter_match
>          swapper     0 [000] 156546.354971:          1   branches:       group_sched_in

[jolsa@krava perf]$ ./perf script --itrace=cr -F +callindent,-ip,-sym
Display of offsets requested but symbol is notselected.

jirka
