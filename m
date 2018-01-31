Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753594AbeAaN5a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 08:57:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53513 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752296AbeAaN52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 08:57:28 -0500
Subject: Re: [PATCH v2 16/16] arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP
 hardening support
To: Marc Zyngier <marc.zyngier@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
CC: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Christoffer Dall" <christoffer.dall@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jon Masters <jcm@redhat.com>
References: <20180129174559.1866-1-marc.zyngier@arm.com>
 <20180129174559.1866-17-marc.zyngier@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <476d111e-6fb0-9bef-2448-a94d0cc03f45@huawei.com>
Date: Wed, 31 Jan 2018 21:56:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180129174559.1866-17-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2018/1/30 1:45, Marc Zyngier wrote:
>  static int enable_psci_bp_hardening(void *data)
>  {
>  	const struct arm64_cpu_capabilities *entry = data;
>  
> -	if (psci_ops.get_version)
> +	if (psci_ops.get_version) {
> +		if (check_smccc_arch_workaround_1(entry))
> +			return 0;

If I'm using the new version SMCCC, the firmware have the choice to decide
whether this machine needs the workaround, even if the CPU is vulnerable
for CVE-2017-5715, but..

> +
>  		install_bp_hardening_cb(entry,
>  				       (bp_hardening_cb_t)psci_ops.get_version,
>  				       __psci_hyp_bp_inval_start,
>  				       __psci_hyp_bp_inval_end);

..the code above seems will enable get_psci_version() for CPU and will
trap to trust firmware even the new version of firmware didn't say
we need the workaround, did I understand it correctly?

I'm ask this because some platform will not expose to users to
take advantage of CVE-2017-5715, and we can use different firmware
to report we need such workaround or not, then use a single kernel
image for both vulnerable platforms and no vulnerable ones.

Thanks
Hanjun
