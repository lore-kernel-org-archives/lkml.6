Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C20C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB5F217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfAYCx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:53:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfAYCx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:53:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7ED6EC05FF7F;
        Fri, 25 Jan 2019 02:53:58 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 409667B534;
        Fri, 25 Jan 2019 02:53:49 +0000 (UTC)
Date:   Fri, 25 Jan 2019 10:53:46 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, bhe@redhat.com,
        kexec@lists.infradead.org, akpm@linux-foundation.org,
        robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org,
        fanc.fnst@cn.fujitsu.com, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/3] x86, kexec_file_load: Don't setup EFI info if EFI
 runtime is not enabled
Message-ID: <20190125025346.GA19241@dhcp-128-65.nay.redhat.com>
References: <20190118111310.29589-1-kasong@redhat.com>
 <20190118111310.29589-2-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118111310.29589-2-kasong@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 25 Jan 2019 02:53:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/18/19 at 07:13pm, Kairui Song wrote:
> Currently with "efi=noruntime" in kernel command line, calling
> kexec_file_load will raise below problem:
> 
> [   97.967067] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [   97.967894] #PF error: [normal kernel read fault]
> ...
> [   97.980456] Call Trace:
> [   97.980724]  efi_runtime_map_copy+0x28/0x30
> [   97.981267]  bzImage64_load+0x688/0x872
> [   97.981794]  arch_kexec_kernel_image_load+0x6d/0x70
> [   97.982441]  kimage_file_alloc_init+0x13e/0x220
> [   97.983035]  __x64_sys_kexec_file_load+0x144/0x290
> [   97.983586]  do_syscall_64+0x55/0x1a0
> [   97.983962]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> When efi runtime is not enabled, efi memmap is not mapped, so just skip
> EFI info setup.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 2c007abd3d40..097f52fb02e3 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -167,6 +167,9 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>  	struct efi_info *current_ei = &boot_params.efi_info;
>  	struct efi_info *ei = &params->efi_info;
>  
> +	if (!efi_enabled(EFI_RUNTIME_SERVICES))
> +		return 0;
> +
>  	if (!current_ei->efi_memmap_size)
>  		return 0;
>  
> -- 
> 2.20.1
> 

Patch 1/3 looks good to me, 2-3 should depend on Chao's early rsdp parsing according
to Boris.

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
