Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeCIW2a (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 17:28:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932520AbeCIW2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 17:28:25 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E41956076C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anjiandi@codeaurora.org
Subject: Re: [PATCH] ipmi: Remove ACPI SPMI probing from the SSIF (I2C) driver
To: minyard@acm.org
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
References: <1520543298-18163-1-git-send-email-minyard@acm.org>
From: Jiandi An <anjiandi@codeaurora.org>
Message-ID: <ea095e0f-023b-dca2-90da-cc95782a6fb0@codeaurora.org>
Date: Fri, 9 Mar 2018 16:28:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1520543298-18163-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/08/2018 03:08 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> The IPMI spec states:
> 
>    The purpose of the SPMI Table is to provide a mechanism that can
>    be used by the OSPM (an ACPI term for “OS Operating System-directed
>    configuration and Power Management” essentially meaning an ACPI-aware
>    OS or OS loader) very early in the boot process, e.g., before the
>    ability to execute ACPI control methods in the OS is available.
> 
> When we are probing IPMI in Linux, ACPI control methods are available,
> so we shouldn't be probing using SPMI.  It could cause some confusion
> during the probing process.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Jiandi An <anjiandi@codeaurora.org>
> ---
> 
> Jiandi, this just yanks out the SPMI code.  Your platform
> should have an ACPI control method in it's namespace specifying the
> IPMI interface.  If it doesn't, that's a bug in your platform and
> really needs to be fixed.  Finding IPMI devices with SMBIOS tables
> is kind of risky since there is no real way to know which I2C bus
> has the IPMI device if your system has more than one I2C bus.  With
> an ACPI control method, the IPMI control method will be inside the
> I2C bus control method, so it will be unambiguous.

Thanks Corey.  I tested this patch.  It works for us through the ACPI
control method.  By the way, FYI the ipmi_si driver is also having the
SPMI probe code.

[   17.370835] ipmi_si: probing via SPMI

Thanks
- Jiandi

> 
>   drivers/char/ipmi/ipmi_ssif.c | 105 ------------------------------------------
>   1 file changed, 105 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 4cff4cd..206257b 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1994,108 +1994,6 @@ static const struct acpi_device_id ssif_acpi_match[] = {
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(acpi, ssif_acpi_match);
> -
> -/*
> - * Once we get an ACPI failure, we don't try any more, because we go
> - * through the tables sequentially.  Once we don't find a table, there
> - * are no more.
> - */
> -static int acpi_failure;
> -
> -/*
> - * Defined in the IPMI 2.0 spec.
> - */
> -struct SPMITable {
> -	s8	Signature[4];
> -	u32	Length;
> -	u8	Revision;
> -	u8	Checksum;
> -	s8	OEMID[6];
> -	s8	OEMTableID[8];
> -	s8	OEMRevision[4];
> -	s8	CreatorID[4];
> -	s8	CreatorRevision[4];
> -	u8	InterfaceType;
> -	u8	IPMIlegacy;
> -	s16	SpecificationRevision;
> -
> -	/*
> -	 * Bit 0 - SCI interrupt supported
> -	 * Bit 1 - I/O APIC/SAPIC
> -	 */
> -	u8	InterruptType;
> -
> -	/*
> -	 * If bit 0 of InterruptType is set, then this is the SCI
> -	 * interrupt in the GPEx_STS register.
> -	 */
> -	u8	GPE;
> -
> -	s16	Reserved;
> -
> -	/*
> -	 * If bit 1 of InterruptType is set, then this is the I/O
> -	 * APIC/SAPIC interrupt.
> -	 */
> -	u32	GlobalSystemInterrupt;
> -
> -	/* The actual register address. */
> -	struct acpi_generic_address addr;
> -
> -	u8	UID[4];
> -
> -	s8      spmi_id[1]; /* A '\0' terminated array starts here. */
> -};
> -
> -static int try_init_spmi(struct SPMITable *spmi)
> -{
> -	unsigned short myaddr;
> -
> -	if (num_addrs >= MAX_SSIF_BMCS)
> -		return -1;
> -
> -	if (spmi->IPMIlegacy != 1) {
> -		pr_warn("IPMI: Bad SPMI legacy: %d\n", spmi->IPMIlegacy);
> -		return -ENODEV;
> -	}
> -
> -	if (spmi->InterfaceType != 4)
> -		return -ENODEV;
> -
> -	if (spmi->addr.space_id != ACPI_ADR_SPACE_SMBUS) {
> -		pr_warn(PFX "Invalid ACPI SSIF I/O Address type: %d\n",
> -			spmi->addr.space_id);
> -		return -EIO;
> -	}
> -
> -	myaddr = spmi->addr.address & 0x7f;
> -
> -	return new_ssif_client(myaddr, NULL, 0, 0, SI_SPMI, NULL);
> -}
> -
> -static void spmi_find_bmc(void)
> -{
> -	acpi_status      status;
> -	struct SPMITable *spmi;
> -	int              i;
> -
> -	if (acpi_disabled)
> -		return;
> -
> -	if (acpi_failure)
> -		return;
> -
> -	for (i = 0; ; i++) {
> -		status = acpi_get_table(ACPI_SIG_SPMI, i+1,
> -					(struct acpi_table_header **)&spmi);
> -		if (status != AE_OK)
> -			return;
> -
> -		try_init_spmi(spmi);
> -	}
> -}
> -#else
> -static void spmi_find_bmc(void) { }
>   #endif
>   
>   #ifdef CONFIG_DMI
> @@ -2200,9 +2098,6 @@ static int init_ipmi_ssif(void)
>   		ssif_i2c_driver.driver.acpi_match_table	=
>   			ACPI_PTR(ssif_acpi_match);
>   
> -	if (ssif_tryacpi)
> -		spmi_find_bmc();
> -
>   	if (ssif_trydmi) {
>   		rv = platform_driver_register(&ipmi_driver);
>   		if (rv)
> 

-- 
Jiandi An
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
