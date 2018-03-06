Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750838AbeCFPZj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:25:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40102 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753792AbeCFPZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:25:37 -0500
Date: Tue, 6 Mar 2018 15:25:41 +0000
From: Will Deacon <will.deacon@arm.com>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Thomas Speier <tspeier@codeaurora.org>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Sean Campbell <scampbel@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH] arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP
 hardening
Message-ID: <20180306152540.GC18477@arm.com>
References: <1520027418-10646-1-git-send-email-shankerd@codeaurora.org>
 <20180305155614.GG6618@arm.com>
 <05c25982-4939-593f-ad30-bf496e879885@codeaurora.org>
 <20180305171529.GA12869@arm.com>
 <770bb422-7a53-06b9-a136-4e38a0a4bed2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770bb422-7a53-06b9-a136-4e38a0a4bed2@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 12:03:33PM -0600, Shanker Donthineni wrote:
> On 03/05/2018 11:15 AM, Will Deacon wrote:
> > On Mon, Mar 05, 2018 at 10:57:58AM -0600, Shanker Donthineni wrote:
> >> On 03/05/2018 09:56 AM, Will Deacon wrote:
> >>> On Fri, Mar 02, 2018 at 03:50:18PM -0600, Shanker Donthineni wrote:
> >>>> @@ -199,33 +208,15 @@ static int enable_smccc_arch_workaround_1(void *data)
> >>>>  		return 0;
> >>>>  	}
> >>>>  
> >>>> +	if (((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR) ||
> >>>> +	    ((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR_V1))
> >>>> +		cb = qcom_link_stack_sanitization;
> >>>
> >>> Is this just a performance thing? Do you actually see an advantage over
> >>> always making the firmware call? We've seen minimal impact in our testing.
> >>>
> >>
> >> Yes, we've couple of advantages using the standard SMCCC_ARCH_WOKAROUND_1 framework. 
> >>   - Improves the code readability.
> >>   - Avoid the unnecessary MIDR checks on each vCPU exit.
> >>   - Validates ID_AA64PFR0_CVS2 feature for Falkor chips.
> >>   - Avoids the 2nd link stack sanitization workaround in firmware.
> > 
> > What I mean is, can we drop qcom_link_stack_sanitization altogether and
> > use the SMCCC interface for everything?
> > 
> 
> No, We would like to keep it qcom_link_stack_sanitization for host kernel
> since it takes a few CPU cycles instead of heavyweight SMCCC call.

Is that something that you can actually measure in the workloads and
benchmarks that you care about? If so, fine, but that doesn't seem to be the
case for the Cortex cores we've looked at internally and it would be nice to
avoid having different workarounds in the kernel just because the SMCCC
interface wasn't baked in time, rather than because there's a meaningful
performance difference.

Will
