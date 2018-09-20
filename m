Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34396ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8E721529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8E721529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbeITVP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:15:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:54579 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbeITVP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:15:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 08:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="71571741"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2018 08:30:35 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 455C7301A71; Thu, 20 Sep 2018 08:30:35 -0700 (PDT)
Date:   Thu, 20 Sep 2018 08:30:35 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, kan.liang@intel.com, peterz@infradead.org,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v3 4/5] KVM/x86/vPMU: Add APIs to support host
 save/restore the guest lbr stack
Message-ID: <20180920153035.GB10360@tassilo.jf.intel.com>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
 <1537437959-8751-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537437959-8751-5-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int intel_pmu_enable_save_guest_lbr(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	struct perf_event *event;
> +	struct perf_event_attr attr = {
> +		.type = PERF_TYPE_RAW,
> +		.size = sizeof(attr),
> +		.pinned = true,
> +		.exclude_host = true,
> +		.sample_type = PERF_SAMPLE_BRANCH_STACK,
> +		.branch_sample_type = PERF_SAMPLE_BRANCH_CALL_STACK |
> +				      PERF_SAMPLE_BRANCH_USER |
> +				      PERF_SAMPLE_BRANCH_KERNEL,

I think that will allocate an extra perfmon counter, right? 

So if the guest wants to use all perfmon counters we would start to 
multiplex, which would be bad

Would need to fix perf core to not allocate a perfmon counter in
this case, if no period and no event count is requested.

-Andi
