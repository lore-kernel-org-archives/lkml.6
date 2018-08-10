Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A4CC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0961223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0961223F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeHJLOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:14:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbeHJLOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:14:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6BCC40241C9;
        Fri, 10 Aug 2018 08:45:14 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFF7A2166BA2;
        Fri, 10 Aug 2018 08:45:08 +0000 (UTC)
Date:   Fri, 10 Aug 2018 16:45:01 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
Message-ID: <20180810084501.GA11901@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533737025.4936.3.camel@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 10 Aug 2018 08:45:14 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 10 Aug 2018 08:45:14 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/18 at 04:03pm, Mike Galbraith wrote:
> When booting with efi=noruntime, we call efi_runtime_map_copy() while
> loading the kdump kernel, and trip over a NULL efi.memmap.map.  Avoid
> that and a useless allocation when the only mapping we can use (1:1)
> is not available.
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

BTW, this patch only fix the kexec load phase problem,  even if kexec
load successfully with the fix, the 2nd kernel can not boot because efi
memmap info is not correct and usable.

So we should go with some fix similar to below, and do the cleanup we
mentioned with a separate patch later.

Also user space kexec-tools need a similar patch to error out in case
no runtime maps.  It would be good to fix both userspace and kernel
load.

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7326078eaa7a..e34ba2f53cfb 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -123,7 +123,7 @@ static int setup_efi_info_memmap(struct boot_params *params,
 	struct efi_info *ei = &params->efi_info;
 
 	if (!efi_map_sz)
-		return 0;
+		return -EINVAL;
 
 	efi_runtime_map_copy(efi_map, efi_map_sz);
 
@@ -166,9 +166,10 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 {
 	struct efi_info *current_ei = &boot_params.efi_info;
 	struct efi_info *ei = &params->efi_info;
+	int ret;
 
 	if (!current_ei->efi_memmap_size)
-		return 0;
+		return -EINVAL;
 
 	/*
 	 * If 1:1 mapping is not enabled, second kernel can not setup EFI
@@ -176,8 +177,8 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	 * acpi_rsdp=<addr> on kernel command line to make second kernel boot
 	 * without efi.
 	 */
-	if (efi_enabled(EFI_OLD_MEMMAP))
-		return 0;
+	if (efi_enabled(EFI_OLD_MEMMAP) || !efi_enabled(EFI_RUNTIME_SERVICES))
+		return -ENODEV;
 
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
@@ -186,8 +187,10 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	ei->efi_memdesc_version = current_ei->efi_memdesc_version;
 	ei->efi_memdesc_size = efi_get_runtime_map_desc_size();
 
-	setup_efi_info_memmap(params, params_load_addr, efi_map_offset,
+	ret = setup_efi_info_memmap(params, params_load_addr, efi_map_offset,
 			      efi_map_sz);
+	if (ret)
+		return ret;
 	prepare_add_efi_setup_data(params, params_load_addr,
 				   efi_setup_data_offset);
 	return 0;
@@ -250,8 +253,10 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 
 #ifdef CONFIG_EFI
 	/* Setup EFI state */
-	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
+	ret = setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
 			efi_setup_data_offset);
+	if (ret)
+		return ret;
 #endif
 
 	/* Setup EDD info */
