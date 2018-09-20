Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FAEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4F020867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ivfXClov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4F020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbeITSPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:15:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387570AbeITSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QZuZa1meuIZaNWQp6dF92m665G4UHHN63rowi+t00Ss=; b=ivfXClovRNRbB2W9BfgT8S602
        uNwk0lTwDZAExKiei+pvya496++V7EGSZTtrR0n8OiRc5i8P41EWej31nerH20uC3f1A7MmX0t0ri
        +8JfcnJ4/t5u6rZDu3vVy2O8J56ncSN5nCCI9qlBwLWzib+Bct4h+A1W3bWfqMWzn5L+Nrzp4n8Ly
        yRhYlOccXqSs8aDIZXFO4/XZI3xyuBHymY3jc+0KoHXxSQsYslkayyhzrLDJH4CR/YjbW87xhykvh
        +ro6dyE48TgSTf7yVejDnqVBGAiAzYSLq4RkbmpPPgyhPCHOjJCst5F2VeLl65HcCOYY+6zMkyXqj
        UHUR65DQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2y88-0001h9-QD; Thu, 20 Sep 2018 12:32:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 547852015F391; Thu, 20 Sep 2018 14:32:23 +0200 (CEST)
Date:   Thu, 20 Sep 2018 14:32:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v3 4/5] KVM/x86/vPMU: Add APIs to support host
 save/restore the guest lbr stack
Message-ID: <20180920123223.GS24124@hirez.programming.kicks-ass.net>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
 <1537437959-8751-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537437959-8751-5-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 06:05:58PM +0800, Wei Wang wrote:

> diff --git a/arch/x86/kvm/pmu_intel.c b/arch/x86/kvm/pmu_intel.c
> index 5ab4a36..97a29d7 100644
> --- a/arch/x86/kvm/pmu_intel.c
> +++ b/arch/x86/kvm/pmu_intel.c
> @@ -342,6 +342,47 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
>  		pmu->global_ovf_ctrl = 0;
>  }
>  
> +int intel_pmu_enable_save_guest_lbr(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	struct perf_event *event;
> +	struct perf_event_attr attr = {
> +		.type = PERF_TYPE_RAW,
> +		.size = sizeof(attr),

Bit yuck to imply .config = 0, like that.

> +		.pinned = true,

Note that this can still result in failing to schedule the event, you
create a pinned task event, but a pinned cpu event takes precedence and
can claim the LBR.

How do you deal with that situation, where the LBR is in use by a host
event?

> +		.exclude_host = true,

Didn't you mean to use .exclude_guest ? You don't want this thing to run
when the guest is running, right?

But I still don't like this hack much, what happens if userspace sets
that bit? You seems to have forgotten to combine it with PF_VCPU or
whatever is the appropriate bit to check.

Similarly, how does the existing exclude_{gues,host} crud work?

> +		.sample_type = PERF_SAMPLE_BRANCH_STACK,

What's the point of setting .sample_type if !.sample_period ?

> +		.branch_sample_type = PERF_SAMPLE_BRANCH_CALL_STACK |
> +				      PERF_SAMPLE_BRANCH_USER |
> +				      PERF_SAMPLE_BRANCH_KERNEL,
> +	};

I think this function wants a comment to explain wth its doing and why,
because if someone stumbles over this code in a few months nobody will
remember those things.

> +
> +	if (pmu->guest_lbr_event)
> +		return 0;
> +
> +	event = perf_event_create_kernel_counter(&attr, -1, current, NULL,
> +						 NULL);
> +	if (IS_ERR(event)) {
> +		pr_err("%s: failed %ld\n", __func__, PTR_ERR(event));
> +		return -ENOENT;
> +	}
> +	pmu->guest_lbr_event = event;
> +
> +	return 0;
> +}
