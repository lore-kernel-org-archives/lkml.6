Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B895DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E13218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfBRBzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 20:55:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:57638 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfBRBzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 20:55:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2019 17:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,382,1544515200"; 
   d="scan'208";a="127243187"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga003.jf.intel.com with ESMTP; 17 Feb 2019 17:54:57 -0800
Message-ID: <5C6A119C.8080009@intel.com>
Date:   Mon, 18 Feb 2019 09:59:56 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v5 12/12] KVM/VMX/vPMU: support to report GLOBAL_STATUS_LBRS_FROZEN
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com> <1550135174-5423-13-git-send-email-wei.w.wang@intel.com> <20190214163147.GL16922@tassilo.jf.intel.com> <286AC319A985734F985F78AFA26841F73DF71ED6@shsmsx102.ccr.corp.intel.com> <20190215131014.GC16922@tassilo.jf.intel.com>
In-Reply-To: <20190215131014.GC16922@tassilo.jf.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/2019 09:10 PM, Andi Kleen wrote:
>
> OK. The freeze bits need to be cleared by IA32_PERF_GLOBAL_STATUS_RESET, which seems not supported by the perf code yet (thus guest won't clear them). Would handle_irq_v4 also need to be changed to support that?
> In Arch Perfmon v4 it is  cleared by the MSR_CORE_PERF_GLOBAL_OVF_CTRL write

Not very sure about this one. The spec 18.2.4.2 mentions
"IA32_PERF_GLOBAL_STATUS_RESET provides additional bit fields to clear 
the new indicators.."
IIUIC, the new freeze bits can only be cleared by RESET.


> But the guest KVM pmu doesn't support v4 so far, so the only way to clear it is through DEBUGCTL.
>
> STATUS_RESET would only be needed to set it from the guest, which is not necessary at least for now
> (and would be also v4)
>
> At some point the guest PMU should probably be updated for v4, but it can be done
> separately from this.
>

Agree. I think the guest perf won't work in v4 mode if the KVM vPMU 
exposes it is v3.
Probably we could also leave the freeze bits virtualization support to 
another series of vPMU v4 support?
We would also need to use the STATUS_SET in v4 to set the freeze bits of 
GLOBAL_STATUS when
entering the guest (instead of clearing the guest debugctl), so that we 
could achieve architectural emulation.

Best,
Wei

