Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FE1C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4177120657
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4177120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeHIGow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 02:44:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728008AbeHIGow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 02:44:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E37E40216EC;
        Thu,  9 Aug 2018 04:22:01 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28E021DB4B;
        Thu,  9 Aug 2018 04:21:57 +0000 (UTC)
Date:   Thu, 9 Aug 2018 12:21:53 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
Message-ID: <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533737025.4936.3.camel@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 09 Aug 2018 04:22:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 09 Aug 2018 04:22:01 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Thanks for the patch!
On 08/08/18 at 04:03pm, Mike Galbraith wrote:
> When booting with efi=noruntime, we call efi_runtime_map_copy() while
> loading the kdump kernel, and trip over a NULL efi.memmap.map.  Avoid
> that and a useless allocation when the only mapping we can use (1:1)
> is not available.

At first glance, efi_get_runtime_map_size should return 0 in case
noruntime.

Also since we are here, would you mind to restructure the bzImage64_load
function, and try to move all efi related code to setup_efi_state()?


setup_boot_parameters(struct kimage *image, struct boot_params *params,
                      unsigned long params_load_addr,
                      unsigned int efi_map_offset, unsigned int efi_map_sz,
                      unsigned int efi_setup_data_offset)
{
[snip]

#ifdef CONFIG_EFI
        /* Setup EFI state */
        setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
                        efi_setup_data_offset);
#endif

[snip]
}

Currently bzImage64_load prepares the efi_map_offset, efi_map_sz,
 and efi_setup_data_offset and then pass it to setup_boot_parameters and
setup_efi_state.  It should be better to move those efi_* variables to
setup_efi_state().

So we can call setup_efi_state only when efi runtime is enabled.

> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  arch/x86/kernel/kexec-bzimage64.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -122,9 +122,6 @@ static int setup_efi_info_memmap(struct
>  	unsigned long efi_map_phys_addr = params_load_addr + efi_map_offset;
>  	struct efi_info *ei = &params->efi_info;
>  
> -	if (!efi_map_sz)
> -		return 0;
> -
>  	efi_runtime_map_copy(efi_map, efi_map_sz);
>  
>  	ei->efi_memmap = efi_map_phys_addr & 0xffffffff;
> @@ -176,7 +173,7 @@ setup_efi_state(struct boot_params *para
>  	 * acpi_rsdp=<addr> on kernel command line to make second kernel boot
>  	 * without efi.
>  	 */
> -	if (efi_enabled(EFI_OLD_MEMMAP))
> +	if (efi_enabled(EFI_OLD_MEMMAP) || !efi_enabled(EFI_MEMMAP))
>  		return 0;
>  
>  	ei->efi_loader_signature = current_ei->efi_loader_signature;
> @@ -338,7 +335,7 @@ static void *bzImage64_load(struct kimag
>  	struct kexec_entry64_regs regs64;
>  	void *stack;
>  	unsigned int setup_hdr_offset = offsetof(struct boot_params, hdr);
> -	unsigned int efi_map_offset, efi_map_sz, efi_setup_data_offset;
> +	unsigned int efi_map_offset = 0, efi_map_sz = 0, efi_setup_data_offset = 0;
>  	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
>  				  .top_down = true };
>  	struct kexec_buf pbuf = { .image = image, .buf_min = MIN_PURGATORY_ADDR,
> @@ -397,19 +394,22 @@ static void *bzImage64_load(struct kimag
>  	 * have to create separate segment for each. Keeps things
>  	 * little bit simple
>  	 */
> -	efi_map_sz = efi_get_runtime_map_size();
>  	params_cmdline_sz = sizeof(struct boot_params) + cmdline_len +
>  				MAX_ELFCOREHDR_STR_LEN;
>  	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
> -	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
> -				sizeof(struct setup_data) +
> -				sizeof(struct efi_setup_data);
> +	kbuf.bufsz = params_cmdline_sz + sizeof(struct setup_data);
> +
> +	/* Now add space for the efi stuff if we have a useable 1:1 mapping. */
> +	if (!efi_enabled(EFI_OLD_MEMMAP) && efi_enabled(EFI_MEMMAP)) {
> +		efi_map_sz = efi_get_runtime_map_size();
> +		kbuf.bufsz += ALIGN(efi_map_sz, 16) + sizeof(struct efi_setup_data);
> +		efi_map_offset = params_cmdline_sz;
> +		efi_setup_data_offset = efi_map_offset + ALIGN(efi_map_sz, 16);
> +	}
>  
>  	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
>  	if (!params)
>  		return ERR_PTR(-ENOMEM);
> -	efi_map_offset = params_cmdline_sz;
> -	efi_setup_data_offset = efi_map_offset + ALIGN(efi_map_sz, 16);
>  
>  	/* Copy setup header onto bootparams. Documentation/x86/boot.txt */
>  	setup_header_size = 0x0202 + kernel[0x0201] - setup_hdr_offset;

Thanks
Dave
