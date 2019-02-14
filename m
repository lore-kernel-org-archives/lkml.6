Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DD4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEE2222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407948AbfBNQbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:31:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:27965 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfBNQbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:31:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 08:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; 
   d="scan'208";a="116227432"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2019 08:31:48 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0386D301247; Thu, 14 Feb 2019 08:31:47 -0800 (PST)
Date:   Thu, 14 Feb 2019 08:31:47 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, peterz@infradead.org, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com, jmattson@google.com
Subject: Re: [PATCH v5 12/12] KVM/VMX/vPMU: support to report
 GLOBAL_STATUS_LBRS_FROZEN
Message-ID: <20190214163147.GL16922@tassilo.jf.intel.com>
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
 <1550135174-5423-13-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550135174-5423-13-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void intel_pmu_get_global_status(struct kvm_pmu *pmu,
> +					struct msr_data *msr_info)
> +{
> +	u64 guest_debugctl, freeze_lbr_bits = DEBUGCTLMSR_FREEZE_LBRS_ON_PMI |
> +					      DEBUGCTLMSR_LBR;
> +
> +	if (!pmu->global_status) {
> +		msr_info->data = 0;
> +		return;
> +	}
> +
> +	msr_info->data = pmu->global_status;
> +	if (pmu->version >= 4) {
> +		guest_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
> +		if ((guest_debugctl & freeze_lbr_bits) == freeze_lbr_bits)

It should only check for the freeze bit, the freeze bit can be set
even when LBRs are disabled.

Also you seem to set the bit unconditionally?
That doesn't seem right. It should only be set after an overflow.

So the PMI injection needs to set it.

-Andi
