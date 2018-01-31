Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeAaOLN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 09:11:13 -0500
Received: from foss.arm.com ([217.140.101.70]:38574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752172AbeAaOLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:11:12 -0500
Subject: Re: [PATCH v2 16/16] arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP
 hardening support
To: Hanjun Guo <guohanjun@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jon Masters <jcm@redhat.com>
References: <20180129174559.1866-1-marc.zyngier@arm.com>
 <20180129174559.1866-17-marc.zyngier@arm.com>
 <476d111e-6fb0-9bef-2448-a94d0cc03f45@huawei.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <49853e5e-f093-2e79-1cfb-182f51fcd6a0@arm.com>
Date: Wed, 31 Jan 2018 14:11:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <476d111e-6fb0-9bef-2448-a94d0cc03f45@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/18 13:56, Hanjun Guo wrote:
> Hi Marc,
> 
> On 2018/1/30 1:45, Marc Zyngier wrote:
>>  static int enable_psci_bp_hardening(void *data)
>>  {
>>  	const struct arm64_cpu_capabilities *entry = data;
>>  
>> -	if (psci_ops.get_version)
>> +	if (psci_ops.get_version) {
>> +		if (check_smccc_arch_workaround_1(entry))
>> +			return 0;
> 
> If I'm using the new version SMCCC, the firmware have the choice to decide
> whether this machine needs the workaround, even if the CPU is vulnerable
> for CVE-2017-5715, but..
> 
>> +
>>  		install_bp_hardening_cb(entry,
>>  				       (bp_hardening_cb_t)psci_ops.get_version,
>>  				       __psci_hyp_bp_inval_start,
>>  				       __psci_hyp_bp_inval_end);
> 
> ..the code above seems will enable get_psci_version() for CPU and will
> trap to trust firmware even the new version of firmware didn't say
> we need the workaround, did I understand it correctly?

Well, you only get there if we've established that your CPU is affected
(it has an entry matching its MIDR with the HARDEN_BRANCH_PREDICTOR
capability), and that entry points to enable_psci_bp_hardening. It is
not the firmware that decides whether we need hardening, but the kernel.
The firmware merely provides a facility to apply the hardening.

> I'm ask this because some platform will not expose to users to
> take advantage of CVE-2017-5715, and we can use different firmware
> to report we need such workaround or not, then use a single kernel
> image for both vulnerable platforms and no vulnerable ones.

You cannot have your cake and eat it. If you don't want to workaround
the issue, you can disable the hardening. But asking for the same kernel
to do both depending on what the firmware reports doesn't make much
sense to me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
