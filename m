Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D486C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B80208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B80208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbeK1F6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:58:38 -0500
Received: from foss.arm.com ([217.140.101.70]:45760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbeK1F6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:58:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 172632ED2;
        Tue, 27 Nov 2018 10:59:47 -0800 (PST)
Received: from [192.168.100.243] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62EA3F575;
        Tue, 27 Nov 2018 10:59:46 -0800 (PST)
Subject: Re: [PATCH 5/5] efi: permit calling efi_mem_reserve_persistent from
 atomic context
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
 <20181114175544.12860-6-ard.biesheuvel@linaro.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <a8346212-70cb-0bbb-9e29-e21fa2ee5040@arm.com>
Date:   Tue, 27 Nov 2018 12:59:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181114175544.12860-6-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,


On 11/14/2018 11:55 AM, Ard Biesheuvel wrote:
> Currently, efi_mem_reserve_persistent() may not be called from atomic
> context, since both the kmalloc() call and the memremap() call may
> sleep.
> 
> The kmalloc() call is easy enough to fix, but the memremap() call
> needs to be moved into an init hook since we cannot control the
> memory allocation behavior of memremap() at the call site.

So, at first glance this looks correct until I noticed that 
its_cpu_init_lpis() is being called before the early_initcalls are run.

This results in the WARN_ON triggering with the following backtrace:

[    0.000000]  its_cpu_init_lpis+0x1d4/0x2e0
[    0.000000]  its_cpu_init+0x78/0x1b4
[    0.000000]  gic_init_bases+0x2c4/0x2e0
[    0.000000]  gic_acpi_init+0x158/0x270
[    0.000000]  acpi_match_madt+0x4c/0x84
[    0.000000]  acpi_table_parse_entries_array+0x140/0x218
[    0.000000]  acpi_table_parse_entries+0x70/0x98
[    0.000000]  acpi_table_parse_madt+0x40/0x50
[    0.000000]  __acpi_probe_device_table+0x88/0xe0
[    0.000000]  irqchip_init+0x38/0x40
[    0.000000]  init_IRQ+0xfc/0x130
[    0.000000]  start_kernel+0x344/0x4cc

due to the efi_memreserve_root not yet being set.



> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>   drivers/firmware/efi/efi.c | 31 +++++++++++++++++++------------
>   1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 72a4da76d274..fad7c62cfc0e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -967,36 +967,43 @@ bool efi_is_table_address(unsigned long phys_addr)
>   }
>   
>   static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
> +static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
>   
>   int efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>   {
> -	struct linux_efi_memreserve *rsv, *parent;
> +	struct linux_efi_memreserve *rsv;
>   
> -	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
> +	if (!efi_memreserve_root)
>   		return -ENODEV;
>   
> -	rsv = kmalloc(sizeof(*rsv), GFP_KERNEL);
> +	rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
>   	if (!rsv)
>   		return -ENOMEM;
>   
> -	parent = memremap(efi.mem_reserve, sizeof(*rsv), MEMREMAP_WB);
> -	if (!parent) {
> -		kfree(rsv);
> -		return -ENOMEM;
> -	}
> -
>   	rsv->base = addr;
>   	rsv->size = size;
>   
>   	spin_lock(&efi_mem_reserve_persistent_lock);
> -	rsv->next = parent->next;
> -	parent->next = __pa(rsv);
> +	rsv->next = efi_memreserve_root->next;
> +	efi_memreserve_root->next = __pa(rsv);
>   	spin_unlock(&efi_mem_reserve_persistent_lock);
>   
> -	memunmap(parent);
> +	return 0;
> +}
>   
> +static int __init efi_memreserve_root_init(void)
> +{
> +	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
> +		return -ENODEV;
> +
> +	efi_memreserve_root = memremap(efi.mem_reserve,
> +				       sizeof(*efi_memreserve_root),
> +				       MEMREMAP_WB);
> +	if (!efi_memreserve_root)
> +		return -ENOMEM;
>   	return 0;
>   }
> +early_initcall(efi_memreserve_root_init);
>   
>   #ifdef CONFIG_KEXEC
>   static int update_efi_random_seed(struct notifier_block *nb,
> 

