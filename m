Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1A8C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FFE2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FFE2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeJVSjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:39:42 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:22657 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729246AbeJVSjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:39:39 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9MAM2N8088781;
        Mon, 22 Oct 2018 18:22:02 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 22 Oct 2018
 18:20:26 +0800
Date:   Mon, 22 Oct 2018 18:20:27 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Greentime Ying-Han =?utf-8?B?SHUo6IOh6Iux5ryiKQ==?= 
        <greentime@andestech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        Zong Zong-Xian =?utf-8?B?TGko5p2O5a6X5oayKQ==?= 
        <zong@andestech.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>
Subject: Re: [PATCH 4/5] nds32: Fix perf multiple events map to same counter.
Message-ID: <20181022102027.GC24110@andestech.com>
References: <cover.1539745993.git.nickhu@andestech.com>
 <a683ef0bac252d0a0982643e9095dc0fc46a1305.1539745993.git.nickhu@andestech.com>
 <20181018142905.bn73t7rvtdjr2tbf@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181018142905.bn73t7rvtdjr2tbf@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9MAM2N8088781
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Oct 18, 2018 at 10:29:05PM +0800, Mark Rutland wrote:
> On Thu, Oct 18, 2018 at 04:43:16PM +0800, Nickhu wrote:
> > When there are multiple events map to the same counter, the counter
> > counts inaccurately. This is because each counter only counts one event
> > in the same time.
> > So when there are multiple events map to same counter, they have to take
> > turns in each context.
> > 
> > There are two solution:
> > 1. Print the error message when multiple events map to the same counter.
> > But print the error message would let the program hang in loop. The ltp
> > (linux test program) would be failed when the program hang in loop.
> > 
> > 2. Don't print the error message, the ltp would pass. But the user need to
> > have the knowledge that don't count the events which map to the same
> > counter, or the user will get the inaccurate results.
> > 
> > We choose method 2 for the solution
> 
> This is the correct solution. Perf exposes the active/enabled time in
> the perf event, so the user can determine that the event wasn't enabled
> all of the time.
> 
> This should be folded into the commit adding perf support.
> 
> Thanks,
> Mark.
> 
> > 
> > Signed-off-by: Nickhu <nickhu@andestech.com>
> > ---
> >  arch/nds32/include/asm/pmu.h       |  1 +
> >  arch/nds32/kernel/perf_event_cpu.c | 30 ++++++++++++++++++++----------
> >  2 files changed, 21 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/nds32/include/asm/pmu.h b/arch/nds32/include/asm/pmu.h
> > index 3fbbe97c2d42..e75ec34af5f6 100644
> > --- a/arch/nds32/include/asm/pmu.h
> > +++ b/arch/nds32/include/asm/pmu.h
> > @@ -55,6 +55,7 @@ enum { PFMC0, PFMC1, PFMC2, MAX_COUNTERS };
> >   */
> >  #define NDS32_IDX_CYCLE_COUNTER			0
> >  #define NDS32_IDX_COUNTER0			1
> > +#define NDS32_IDX_COUNTER1			2
> >  #define NDS32_IDX_COUNTER_LAST(cpu_pmu) \
> >  	(NDS32_IDX_CYCLE_COUNTER + (cpu_pmu)->num_events - 1)
> >  
> > diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_event_cpu.c
> > index 7bb4ebb87b5c..e9a0d8bb2bc1 100644
> > --- a/arch/nds32/kernel/perf_event_cpu.c
> > +++ b/arch/nds32/kernel/perf_event_cpu.c
> > @@ -566,16 +566,26 @@ static int nds32_pmu_get_event_idx(struct pmu_hw_events *cpuc,
> >  	/*
> >  	 * Try to get the counter for correpsonding event
> >  	 */
> > -	if (!test_and_set_bit(idx, cpuc->used_mask))
> > -		return idx;
> > -
> > -	/*
> > -	 * The counter is in use.
> > -	 * The system will hang in the loop.
> > -	 */
> > -	pr_err
> > -	("Multiple events map to one counter, the behavior is undefined.\n");
> > -	return -EPERM;
> > +	if (evtype == SPAV3_0_SEL_TOTAL_CYCLES) {
> > +		if (!test_and_set_bit(idx, cpuc->used_mask))
> > +			return idx;
> > +		if (!test_and_set_bit(NDS32_IDX_COUNTER0, cpuc->used_mask))
> > +			return NDS32_IDX_COUNTER0;
> > +		if (!test_and_set_bit(NDS32_IDX_COUNTER1, cpuc->used_mask))
> > +			return NDS32_IDX_COUNTER1;
> > +	} else if (evtype == SPAV3_1_SEL_COMPLETED_INSTRUCTION) {
> > +		if (!test_and_set_bit(idx, cpuc->used_mask))
> > +			return idx;
> > +		else if (!test_and_set_bit(NDS32_IDX_COUNTER1, cpuc->used_mask))
> > +			return NDS32_IDX_COUNTER1;
> > +		else if (!test_and_set_bit
> > +			 (NDS32_IDX_CYCLE_COUNTER, cpuc->used_mask))
> > +			return NDS32_IDX_CYCLE_COUNTER;
> > +	} else {
> > +		if (!test_and_set_bit(idx, cpuc->used_mask))
> > +			return idx;
> > +	}
> > +	return -EAGAIN;
> >  }
> >  
> >  static void nds32_pmu_start(struct nds32_pmu *cpu_pmu)
> > -- 
> > 2.17.0
> > 
Thanks for the comment.
I will folded it into the commit adding perf support.
