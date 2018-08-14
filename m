Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBE3C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A024121733
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A024121733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbeHNNBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:01:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60298 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732055AbeHNNBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:01:09 -0400
Received: from 79.184.254.66.ipv4.supernova.orange.pl (79.184.254.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 1903da7fc614f69d; Tue, 14 Aug 2018 12:14:38 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 15/17] driver/cpufreq: enable Hygon support to cpufreq driver
Date:   Tue, 14 Aug 2018 12:12:29 +0200
Message-ID: <4011042.yx3xh8JzSX@aspire.rjw.lan>
In-Reply-To: <36b1edf4bd9e203f8e14fa5b90a5a197fdf13898.1533989493.git.puwen@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn> <36b1edf4bd9e203f8e14fa5b90a5a197fdf13898.1533989493.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 11, 2018 3:29:52 PM CEST Pu Wen wrote:
> Enable ACPI cpufreq driver support for Hygon by adding family ID check
> along with AMD.
> 
> As Hygon platforms have SMBus device(PCI device ID 0x790b), enable Hygon
> support to function amd_freq_sensitivity_init().
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  drivers/cpufreq/acpi-cpufreq.c         | 5 +++++
>  drivers/cpufreq/amd_freq_sensitivity.c | 9 +++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index b61f4ec..d62fd37 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -61,6 +61,7 @@ enum {
>  
>  #define INTEL_MSR_RANGE		(0xffff)
>  #define AMD_MSR_RANGE		(0x7)
> +#define HYGON_MSR_RANGE		(0x7)
>  
>  #define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
>  
> @@ -95,6 +96,7 @@ static bool boost_state(unsigned int cpu)
>  		rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
>  		msr = lo | ((u64)hi << 32);
>  		return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> +	case X86_VENDOR_HYGON:
>  	case X86_VENDOR_AMD:
>  		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
>  		msr = lo | ((u64)hi << 32);
> @@ -113,6 +115,7 @@ static int boost_set_msr(bool enable)
>  		msr_addr = MSR_IA32_MISC_ENABLE;
>  		msr_mask = MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
>  		break;
> +	case X86_VENDOR_HYGON:
>  	case X86_VENDOR_AMD:
>  		msr_addr = MSR_K7_HWCR;
>  		msr_mask = MSR_K7_HWCR_CPB_DIS;
> @@ -225,6 +228,8 @@ static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
>  
>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>  		msr &= AMD_MSR_RANGE;
> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +		msr &= HYGON_MSR_RANGE;
>  	else
>  		msr &= INTEL_MSR_RANGE;
>  
> diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
> index be926d9..4ac7c3c 100644
> --- a/drivers/cpufreq/amd_freq_sensitivity.c
> +++ b/drivers/cpufreq/amd_freq_sensitivity.c
> @@ -111,11 +111,16 @@ static int __init amd_freq_sensitivity_init(void)
>  {
>  	u64 val;
>  	struct pci_dev *pcidev;
> +	unsigned int pci_vendor;
>  
> -	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		pci_vendor = PCI_VENDOR_ID_AMD;
> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +		pci_vendor = PCI_VENDOR_ID_HYGON;
> +	else
>  		return -ENODEV;
>  
> -	pcidev = pci_get_device(PCI_VENDOR_ID_AMD,
> +	pcidev = pci_get_device(pci_vendor,
>  			PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
>  
>  	if (!pcidev) {
> 

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


