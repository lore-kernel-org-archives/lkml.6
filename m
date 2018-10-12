Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5F4C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BB52086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BB52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeJMAEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:04:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:63989 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbeJMAEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:04:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 09:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="98890244"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga001.jf.intel.com with ESMTP; 12 Oct 2018 09:30:58 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8622E30054A; Fri, 12 Oct 2018 09:30:58 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:30:58 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, peterz@infradead.org, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com
Subject: Re: [PATCH v1] KVM/x86/vPMU: Guest PMI Optimization
Message-ID: <20181012163058.GN32651@tassilo.jf.intel.com>
References: <1539346817-8638-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539346817-8638-1-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 4. Results
>     - Without this optimization, the guest pmi handling time is
>       ~4500000 ns, and the max sampling rate is reduced to 250.
>     - With this optimization, the guest pmi handling time is ~9000 ns
>       (i.e. 1 / 500 of the non-optimization case), and the max sampling
>       rate remains at the original 100000.

Impressive performance improvement!

It's not clear to me why you're special casing PMIs here. The optimization
should work generically, right?

perf will enable/disable the PMU even outside PMIs, e.g. on context
switches, which is a very important path too.

> @@ -237,9 +267,23 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	default:
>  		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
>  		    (pmc = get_fixed_pmc(pmu, msr))) {
> -			if (!msr_info->host_initiated)
> -				data = (s64)(s32)data;
> -			pmc->counter += data - pmc_read_counter(pmc);
> +			if (pmu->in_pmi) {
> +				/*
> +				 * Since we are not re-allocating a perf event
> +				 * to reconfigure the sampling time when the
> +				 * guest pmu is in PMI, just set the value to
> +				 * the hardware perf counter. Counting will
> +				 * continue after the guest enables the
> +				 * counter bit in MSR_CORE_PERF_GLOBAL_CTRL.
> +				 */
> +				struct hw_perf_event *hwc =
> +						&pmc->perf_event->hw;
> +				wrmsrl(hwc->event_base, data);

Is that guaranteed to be always called on the right CPU that will run the vcpu?

AFAIK there's an ioctl to set MSRs in the guest from qemu, I'm pretty sure
it won't handle that.

May need to be delayed to entry time.

-Andi
