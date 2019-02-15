Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5FEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21094218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437037AbfBONKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:10:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:2647 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbfBONKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:10:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 05:10:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="275317145"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2019 05:10:15 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id EF062300E42; Fri, 15 Feb 2019 05:10:14 -0800 (PST)
Date:   Fri, 15 Feb 2019 05:10:14 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
        "jmattson@google.com" <jmattson@google.com>
Subject: Re: [PATCH v5 12/12] KVM/VMX/vPMU: support to report
 GLOBAL_STATUS_LBRS_FROZEN
Message-ID: <20190215131014.GC16922@tassilo.jf.intel.com>
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
 <1550135174-5423-13-git-send-email-wei.w.wang@intel.com>
 <20190214163147.GL16922@tassilo.jf.intel.com>
 <286AC319A985734F985F78AFA26841F73DF71ED6@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73DF71ED6@shsmsx102.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 08:56:02AM +0000, Wang, Wei W wrote:
> On Friday, February 15, 2019 12:32 AM, Andi Kleen wrote:
> > 
> > > +static void intel_pmu_get_global_status(struct kvm_pmu *pmu,
> > > +					struct msr_data *msr_info)
> > > +{
> > > +	u64 guest_debugctl, freeze_lbr_bits =
> > DEBUGCTLMSR_FREEZE_LBRS_ON_PMI |
> > > +					      DEBUGCTLMSR_LBR;
> > > +
> > > +	if (!pmu->global_status) {
> > > +		msr_info->data = 0;
> > > +		return;
> > > +	}
> > > +
> > > +	msr_info->data = pmu->global_status;
> > > +	if (pmu->version >= 4) {
> > > +		guest_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
> > > +		if ((guest_debugctl & freeze_lbr_bits) == freeze_lbr_bits)
> > 
> > It should only check for the freeze bit, the freeze bit can be set even when
> > LBRs are disabled.
> > 
> > Also you seem to set the bit unconditionally?
> > That doesn't seem right. It should only be set after an overflow.
> > 
> > So the PMI injection needs to set it.
> 
> OK. The freeze bits need to be cleared by IA32_PERF_GLOBAL_STATUS_RESET, which seems not supported by the perf code yet (thus guest won't clear them). Would handle_irq_v4 also need to be changed to support that?

In Arch Perfmon v4 it is  cleared by the MSR_CORE_PERF_GLOBAL_OVF_CTRL write
But the guest KVM pmu doesn't support v4 so far, so the only way to clear it is through DEBUGCTL.

STATUS_RESET would only be needed to set it from the guest, which is not necessary at least for now
(and would be also v4)

At some point the guest PMU should probably be updated for v4, but it can be done
separately from this.

-Andi
