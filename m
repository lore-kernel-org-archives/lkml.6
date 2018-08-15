Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23A8C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 04:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5E8215F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 04:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5E8215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeHOGtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 02:49:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728480AbeHOGtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 02:49:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD90B401D795;
        Wed, 15 Aug 2018 03:59:29 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-175.pek2.redhat.com [10.72.12.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87E8C112D168;
        Wed, 15 Aug 2018 03:59:26 +0000 (UTC)
Date:   Wed, 15 Aug 2018 11:59:21 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
Message-ID: <20180815035921.GA5865@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
 <20180810084501.GA11901@dhcp-128-65.nay.redhat.com>
 <20180810102846.GA31327@dhcp-128-65.nay.redhat.com>
 <1533922786.5083.7.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533922786.5083.7.camel@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 15 Aug 2018 03:59:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 15 Aug 2018 03:59:29 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologize for late reply, I'm occupied with something else.

On 08/10/18 at 07:39pm, Mike Galbraith wrote:
> On Fri, 2018-08-10 at 18:28 +0800, Dave Young wrote:
> > 
> > > @@ -250,8 +253,10 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
> > >  
> > >  #ifdef CONFIG_EFI
> > >  	/* Setup EFI state */
> > > -	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
> > > +	ret = setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
> > >  			efi_setup_data_offset);
> > > +	if (ret)
> > 
> > Here should check efi_enabled(EFI_BOOT) && ret
> 
> Patch with that works for me.
> 
> > In case efi boot we need the efi info set correctly,  or one need pass
> > acpi_rsdp= in kernel cmdline param.
> > 
> > Still not sure how to allow one to workaround it by using acpi_rsdp=
> > param with kexec_file_load..
> 
> Does this improve things, and plug the no boot hole?

Would you mind to tune my patch with some acpi_rsdp checking and add
some error message in case kexec load failure? Eg. suggest people to use
append acpi_rsdp for noefi booting etc.

I'm still not very satisfied with the code cleanup, ideally we should add a
separate kbuf for efi stuff, so that we can isolate the efi_map_sz
efi_setup_data_offset, and efi_map_offset initialization only when
necessary.  Anyway the cleanup can be a separate patch.

> 
> x86, kdump: cleanup efi setup data handling a bit
> 
> 1. Remove efi specific variables from bzImage64_load() other than the
> one it needs, efi_map_sz, passing it and params_cmdline_sz on to efi
> setup functions, giving them all they need without duplication.
> 
> 2. Only allocate space for efi setup data when a 1:1 mapping is available.
> Bail early with -ENODEV if not available, but is required to boot, and
> acpi_rsdp= was not passed on the command line. 
> 
> 3. Use the proper config dependency to isolate efi setup functions,
> adding a !EFI_RUNTIME_MAP stub for setup_efi_state().
> 
> 4. Change efi functions that cannot fail to void. 
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  arch/x86/kernel/kexec-bzimage64.c |   99 +++++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 54 deletions(-)
> 
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -112,35 +112,32 @@ static int setup_e820_entries(struct boo
>  	return 0;
>  }
>  
> -#ifdef CONFIG_EFI
> -static int setup_efi_info_memmap(struct boot_params *params,
> +#ifdef CONFIG_EFI_RUNTIME_MAP
> +static void setup_efi_info_memmap(struct boot_params *params,
>  				  unsigned long params_load_addr,
> -				  unsigned int efi_map_offset,
> +				  unsigned int params_cmdline_sz,
>  				  unsigned int efi_map_sz)
>  {
> -	void *efi_map = (void *)params + efi_map_offset;
> -	unsigned long efi_map_phys_addr = params_load_addr + efi_map_offset;
> +	void *efi_map = (void *)params + params_cmdline_sz;
> +	unsigned long efi_map_phys_addr = params_load_addr + params_cmdline_sz;
>  	struct efi_info *ei = &params->efi_info;
>  
> -	if (!efi_map_sz)
> -		return -EINVAL;
> -
>  	efi_runtime_map_copy(efi_map, efi_map_sz);
>  
>  	ei->efi_memmap = efi_map_phys_addr & 0xffffffff;
>  	ei->efi_memmap_hi = efi_map_phys_addr >> 32;
>  	ei->efi_memmap_size = efi_map_sz;
> -
> -	return 0;
>  }
>  
> -static int
> +static void
>  prepare_add_efi_setup_data(struct boot_params *params,
> -		       unsigned long params_load_addr,
> -		       unsigned int efi_setup_data_offset)
> +			   unsigned long params_load_addr,
> +			   unsigned int params_cmdline_sz,
> +			   unsigned int efi_map_sz)
>  {
> +	unsigned int data_offset = params_cmdline_sz + ALIGN(efi_map_sz, 16);
>  	unsigned long setup_data_phys;
> -	struct setup_data *sd = (void *)params + efi_setup_data_offset;
> +	struct setup_data *sd = (void *)params + data_offset;
>  	struct efi_setup_data *esd = (void *)sd + sizeof(struct setup_data);
>  
>  	esd->fw_vendor = efi.fw_vendor;
> @@ -152,33 +149,20 @@ prepare_add_efi_setup_data(struct boot_p
>  	sd->len = sizeof(struct efi_setup_data);
>  
>  	/* Add setup data */
> -	setup_data_phys = params_load_addr + efi_setup_data_offset;
> +	setup_data_phys = params_load_addr + data_offset;
>  	sd->next = params->hdr.setup_data;
>  	params->hdr.setup_data = setup_data_phys;
> -
> -	return 0;
>  }
>  
>  static int
>  setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
> -		unsigned int efi_map_offset, unsigned int efi_map_sz,
> -		unsigned int efi_setup_data_offset)
> +		unsigned int params_cmdline_sz, unsigned int efi_map_sz)
>  {
>  	struct efi_info *current_ei = &boot_params.efi_info;
>  	struct efi_info *ei = &params->efi_info;
> -	int ret;
> -
> -	if (!current_ei->efi_memmap_size)
> -		return -EINVAL;
>  
> -	/*
> -	 * If 1:1 mapping is not enabled, second kernel can not setup EFI
> -	 * and use EFI run time services. User space will have to pass
> -	 * acpi_rsdp=<addr> on kernel command line to make second kernel boot
> -	 * without efi.
> -	 */
> -	if (efi_enabled(EFI_OLD_MEMMAP) || !efi_enabled(EFI_RUNTIME_SERVICES))
> -		return -ENODEV;
> +	if (!efi_map_sz || !current_ei->efi_memmap_size)
> +		return efi_map_sz ? -EINVAL : 0;
>  
>  	ei->efi_loader_signature = current_ei->efi_loader_signature;
>  	ei->efi_systab = current_ei->efi_systab;
> @@ -187,21 +171,24 @@ setup_efi_state(struct boot_params *para
>  	ei->efi_memdesc_version = current_ei->efi_memdesc_version;
>  	ei->efi_memdesc_size = efi_get_runtime_map_desc_size();
>  
> -	ret = setup_efi_info_memmap(params, params_load_addr, efi_map_offset,
> +	setup_efi_info_memmap(params, params_load_addr, params_cmdline_sz,
>  			      efi_map_sz);
> -	if (ret)
> -		return ret;
> -	prepare_add_efi_setup_data(params, params_load_addr,
> -				   efi_setup_data_offset);
> +	prepare_add_efi_setup_data(params, params_load_addr, params_cmdline_sz,
> +				   efi_map_sz);
>  	return 0;
>  }
> -#endif /* CONFIG_EFI */
> +#else /* !CONFIG_EFI_RUNTIME_MAP */
> +static int
> +setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
> +		unsigned int params_cmdline_sz, unsigned int efi_map_sz)
> +{ return 0; }
> +#endif /* CONFIG_EFI_RUNTIME_MAP */
>  
>  static int
>  setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  		      unsigned long params_load_addr,
> -		      unsigned int efi_map_offset, unsigned int efi_map_sz,
> -		      unsigned int efi_setup_data_offset)
> +		      unsigned int params_cmdline_sz,
> +		      unsigned int efi_map_sz)
>  {
>  	unsigned int nr_e820_entries;
>  	unsigned long long mem_k, start, end;
> @@ -251,13 +238,9 @@ setup_boot_parameters(struct kimage *ima
>  		}
>  	}
>  
> -#ifdef CONFIG_EFI
> -	/* Setup EFI state */
> -	ret = setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
> -			efi_setup_data_offset);
> -	if (efi_enabled(EFI_BOOT) && ret)
> +	ret = setup_efi_state(params, params_load_addr, params_cmdline_sz, efi_map_sz);
> +	if (ret)
>  		return ret;
> -#endif
>  
>  	/* Setup EDD info */
>  	memcpy(params->eddbuf, boot_params.eddbuf,
> @@ -343,7 +326,7 @@ static void *bzImage64_load(struct kimag
>  	struct kexec_entry64_regs regs64;
>  	void *stack;
>  	unsigned int setup_hdr_offset = offsetof(struct boot_params, hdr);
> -	unsigned int efi_map_offset, efi_map_sz, efi_setup_data_offset;
> +	unsigned int efi_map_sz = 0;
>  	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
>  				  .top_down = true };
>  	struct kexec_buf pbuf = { .image = image, .buf_min = MIN_PURGATORY_ADDR,
> @@ -402,19 +385,28 @@ static void *bzImage64_load(struct kimag
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
> +	/*
> +	 * If a 1:1 mapping does not exist, the second kernel cannot setup
> +	 * and use EFI run time services, user space will have to pass
> +	 * acpi_rsdp=<addr> on the kernel command line to make the second
> +	 * kernel boot without efi.  Allocate space for efi setup data if
> +	 * this constraint is met, bail if not, but is required to boot,
> +	 * and acpi_rsdp=<addr> was not passed on the command line.
> +	 */
> +	if (efi_enabled(EFI_RUNTIME_SERVICES) && !efi_enabled(EFI_OLD_MEMMAP)) {
> +		efi_map_sz = efi_get_runtime_map_size();
> +		kbuf.bufsz += ALIGN(efi_map_sz, 16) + sizeof(struct efi_setup_data);
> +	} else if (efi_enabled(EFI_BOOT) && !strstr(cmdline, "acpi_rsdp="))
> +		return ERR_PTR(-ENODEV);
>  
>  	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
>  	if (!params)
>  		return ERR_PTR(-ENOMEM);
> -	efi_map_offset = params_cmdline_sz;
> -	efi_setup_data_offset = efi_map_offset + ALIGN(efi_map_sz, 16);
>  
>  	/* Copy setup header onto bootparams. Documentation/x86/boot.txt */
>  	setup_header_size = 0x0202 + kernel[0x0201] - setup_hdr_offset;
> @@ -494,8 +486,7 @@ static void *bzImage64_load(struct kimag
>  		goto out_free_params;
>  
>  	ret = setup_boot_parameters(image, params, bootparam_load_addr,
> -				    efi_map_offset, efi_map_sz,
> -				    efi_setup_data_offset);
> +				    params_cmdline_sz, efi_map_sz);
>  	if (ret)
>  		goto out_free_params;
>  
> 

Thanks
Dave
