Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CC4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3D520893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OcHBK9DR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3D520893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeH1MDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:03:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39092 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeH1MDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B6fWduFSQCgqId81pfl7WtO6bKBuyx39MuqTrgl5G6s=; b=OcHBK9DRGgm4CpP10XwCTCJeh
        1VytTEEovJ/NGZSP8tnvA/CD8nG+TLvY0/uiSqMUlHEqhtd1ZqKeWsIEeoA8WAHF8D0lvaRMUeG9X
        tZIzOCr0ayizbche54kEtgjSjpMXSTHmiMbFy1MzsJUgPQVjHf4qB9tIMCk5qavu0CilK1qEcrx1w
        CVtgL6+RGeFgqebshK4xossLdIvkvBUXt3nKKHQb+YxOPjL3SbqN6d/+7ECt4EeK723MxlQuQu9aI
        CKVox7tCh/mpTN4rKfgNnX9xKhJSDx+PGt/CJW4HYCYSVIdYZcmuAkW6bU4HQrfM8ldME6BMbhj/9
        s7X3pXywA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuZ73-0007I7-Bz; Tue, 28 Aug 2018 08:12:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C99C2024D705; Tue, 28 Aug 2018 10:12:32 +0200 (CEST)
Date:   Tue, 28 Aug 2018 10:12:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf/x86/intel: Export mem events only if there's PEBs
 support
Message-ID: <20180828081232.GI24124@hirez.programming.kicks-ass.net>
References: <20180813154820.16991-1-jolsa@kernel.org>
 <20180827090624.GI24695@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827090624.GI24695@krava>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:06:24AM +0200, Jiri Olsa wrote:
> +static __init struct attribute **get_hsw_events_attrs(bool *alloc)
>  {
> +	if (boot_cpu_has(X86_FEATURE_RTM)) {
> +		*alloc = true;
> +		return merge_attr(hsw_events_attrs, hsw_tsx_events_attrs);
> +	}
> +	return hsw_events_attrs;
>  }



> @@ -4357,6 +4374,15 @@ __init int intel_pmu_init(void)
>  		WARN_ON(!x86_pmu.format_attrs);
>  	}
>  
> +	if (x86_pmu.pebs && mem_attr) {
> +		struct attribute **attr = x86_pmu.cpu_events;
> +
> +		x86_pmu.cpu_events = merge_attr(x86_pmu.cpu_events, mem_attr);
> +
> +		if (alloc_events)
> +			kfree(attr);
> +	}
> +
>  	if (x86_pmu.num_counters > INTEL_PMC_MAX_GENERIC) {
>  		WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
>  		     x86_pmu.num_counters, INTEL_PMC_MAX_GENERIC);


static __init struct attribute **
get_events_attrs(struct attribute **base,
		 struct attribute **mem,
		 struct attribute **tsx)
{
	struct attribute **attrs = base;
	struct attribute **old;

	if (mem) {
		old = attrs;
		attrs = merge_attrs(attrs, mem);
		if (old != base)
			kfree(old);
	}

	if (tsx && boot_cpu_has(X86_FEATURE_RTM)) {
		old = attrs;
		attrs = merge_attrs(attrs, tsx);
		if (old != base)
			kfree(old);
	}

	return attrs;
}

Would that not help to concentrate things a little more?
