Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61923ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159102147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xkDc7jNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159102147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbeITWIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:08:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39120 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbeITWIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aiVv8H0RRgbNo+YW6tyz47IwYmBIyrMZHycD8Ttvbwg=; b=xkDc7jNXMg413H986Y/N+eQc8
        tcBJNwuW3TDIQtccQiSiJUhF9ZpZeEZkxm2XqlNKZAwa7jFrp/30MMpWZclvy39uieivFmbuPlwqj
        70BwkUm2/0yEaexUkeU2mV5jobaJ0Roo/zSm14yHAF0mucGP7C98+tE1WkHMnvhV59qKjYbtfAIPZ
        RQl0VN0FVZ+WO3xapvAnwe1gkBPgVgLb/bcdRzCmwrHXRK+xx93hPKG+1EsNe5USBO1Jxji+y/KDx
        EQbRPpdPTWl23DzQzw1I1Z/gLB71XTGuyjMDIQSU1iytlBHy/PF6iBPooEeMbE/6+gGPqHTuqLEuf
        r/XoAyg8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g31kP-0003q9-MX; Thu, 20 Sep 2018 16:24:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B4812024E44A; Thu, 20 Sep 2018 18:24:07 +0200 (CEST)
Date:   Thu, 20 Sep 2018 18:24:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, pbonzini@redhat.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v3 4/5] KVM/x86/vPMU: Add APIs to support host
 save/restore the guest lbr stack
Message-ID: <20180920162407.GA24124@hirez.programming.kicks-ass.net>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
 <1537437959-8751-5-git-send-email-wei.w.wang@intel.com>
 <20180920153035.GB10360@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920153035.GB10360@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 08:30:35AM -0700, Andi Kleen wrote:
> > +int intel_pmu_enable_save_guest_lbr(struct kvm_vcpu *vcpu)
> > +{
> > +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> > +	struct perf_event *event;
> > +	struct perf_event_attr attr = {
> > +		.type = PERF_TYPE_RAW,
> > +		.size = sizeof(attr),
> > +		.pinned = true,
> > +		.exclude_host = true,
> > +		.sample_type = PERF_SAMPLE_BRANCH_STACK,
> > +		.branch_sample_type = PERF_SAMPLE_BRANCH_CALL_STACK |
> > +				      PERF_SAMPLE_BRANCH_USER |
> > +				      PERF_SAMPLE_BRANCH_KERNEL,
> 
> I think that will allocate an extra perfmon counter, right? 

I throught the same too, but I think the exclude_host/guest, whichever
is the right one makes that work for regular counters too.

That code is a wee bit magical and I didn't take the time to reverse
engineer that. It most certainly needs a comment.
