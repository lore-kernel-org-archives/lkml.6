Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeEUO16 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:27:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41556 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752803AbeEUO1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:27:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 852A160314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tbaicar@codeaurora.org
Subject: Re: [PATCH v6 2/2] acpi: apei: Do not panic() on PCIe errors reported
 through GHES
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, bp@alien8.de
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-3-mr.nuke.me@gmail.com>
From: Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <737bea6a-2f0e-e573-754e-2e410c34013e@codeaurora.org>
Date: Mon, 21 May 2018 10:27:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521135003.32459-3-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/2018 9:49 AM, Alexandru Gagniuc wrote:
> +/* PCIe errors should not cause a panic. */
> +static int ghes_sec_pcie_severity(struct acpi_hest_generic_data *gdata)
> +{
> +	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
> +
> +	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> +	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO &&
> +	    IS_ENABLED(CONFIG_ACPI_APEI_PCIEAER))
> +		return GHES_SEV_RECOVERABLE;
> +
> +	return ghes_cper_severity(gdata->error_severity);
> +}
> +
> +/*
> + * The severity field in the status block is an unreliable metric for the
> + * severity. A more reliable way is to look at each subsection and see how safe
> + * it is to call the approproate error handler.
> + * We're not conerned with handling the error. We're concerned with being able
> + * to notify an error handler by crossing the NMI/IRQ boundary, being able to
> + * schedule_work, and so forth.
> + *   - SEC_PCIE: All PCIe errors can be handled by AER.
> + */
> +static int ghes_severity(struct ghes *ghes)
> +{
> +	int worst_sev, sec_sev;
> +	struct acpi_hest_generic_data *gdata;
> +	const guid_t *section_type;
> +	const struct acpi_hest_generic_status *estatus = ghes->estatus;
> +
> +	worst_sev = GHES_SEV_NO;
> +	apei_estatus_for_each_section(estatus, gdata) {
> +		section_type = (guid_t *)gdata->section_type;
> +		sec_sev = ghes_cper_severity(gdata->error_severity);
> +
> +		if (guid_equal(section_type, &CPER_SEC_PCIE))
> +			sec_sev = ghes_sec_pcie_severity(gdata);
> +
> +		worst_sev = max(worst_sev, sec_sev);
> +	}
> +
> +	return worst_sev;
> +}
> +
>   static void ghes_do_proc(struct ghes *ghes,
>   			 const struct acpi_hest_generic_status *estatus)
>   {
> @@ -944,7 +986,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>   			ret = NMI_HANDLED;
>   		}
>   
> -		sev = ghes_cper_severity(ghes->estatus->error_severity);
> +		sev = ghes_severity(ghes);
Hello Alex,

There is a compile warning if CONFIG_HAVE_ACPI_APEI_NMI is not selected.

   CC      drivers/acpi/apei/ghes.o
drivers/acpi/apei/ghes.c:483:12: warning: ‘ghes_severity’ defined but not used 
[-Wunused-function]
  static int ghes_severity(struct ghes *ghes)
             ^~~~~~~~~~~~~

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
