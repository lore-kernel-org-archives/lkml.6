Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98879C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA6C2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="V/sZTabY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA6C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeLKNWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:22:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44480 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeLKNWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:22:38 -0500
Received: from zn.tnic (p200300EC2BCD2B00BD72DD1FE93D9839.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:bd72:dd1f:e93d:9839])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29F451EC0BAA;
        Tue, 11 Dec 2018 14:22:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544534557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ct4IPzTQP8nDSad1R3f+AYWTXQVO0j/2wKlVRxqaHgU=;
        b=V/sZTabYPqaViJ/3I/ESZ4sR0yA85PM3YUqioxIT3x2pEyfje/TWisOiHJ78MomM6OOLfz
        0cbQoLotIzxpEvMAR/JOeAMGReVObRpuV7hPhqy8YkSxdsDyTPn0ZUrz5RhpWtHyVaPtTm
        9qt7ARKuioG5+1kXN46snvUPB6s73Sw=
Date:   Tue, 11 Dec 2018 14:22:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Maran Wilson <maran.wilson@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, boris.ostrovsky@oracle.com,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com, bp@suse.de,
        thomas.lendacky@amd.com, luto@kernel.org,
        dave.hansen@linux.intel.com, roger.pau@citrix.com,
        rkrcmar@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH v9 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and
 CONFIG_XEN_PVH
Message-ID: <20181211132234.GE27375@zn.tnic>
References: <1544468734-32763-1-git-send-email-maran.wilson@oracle.com>
 <1544468848-496-1-git-send-email-maran.wilson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1544468848-496-1-git-send-email-maran.wilson@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:07:28AM -0800, Maran Wilson wrote:
> In order to pave the way for hypervisors other than Xen to use the PVH
> entry point for VMs, we need to factor the PVH entry code into Xen specific
> and hypervisor agnostic components. The first step in doing that, is to
> create a new config option for PVH entry that can be enabled
> independently from CONFIG_XEN.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/Kconfig          | 6 ++++++
>  arch/x86/kernel/head_64.S | 2 +-
>  arch/x86/xen/Kconfig      | 3 ++-
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8689e794a43c..c2a22a74abee 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -796,6 +796,12 @@ config KVM_GUEST
>  	  underlying device model, the host provides the guest with
>  	  timing infrastructure such as time of day, and system time
>  
> +config PVH
> +	bool "Support for running PVH guests"
> +	---help---
> +	  This option enables the PVH entry point for guest virtual machines
> +	  as specified in the x86/HVM direct boot ABI.
> +
>  config KVM_DEBUG_FS
>  	bool "Enable debug information for KVM Guests in debugfs"
>  	depends on KVM_GUEST && DEBUG_FS
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 747c758f67b7..d1dbe8e4eb82 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -386,7 +386,7 @@ NEXT_PAGE(early_dynamic_pgts)
>  
>  	.data
>  
> -#if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
> +#if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
>  NEXT_PGD_PAGE(init_top_pgt)
>  	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
>  	.org    init_top_pgt + L4_PAGE_OFFSET*8, 0
> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> index 1ef391aa184d..e07abefd3d26 100644
> --- a/arch/x86/xen/Kconfig
> +++ b/arch/x86/xen/Kconfig
> @@ -74,6 +74,7 @@ config XEN_DEBUG_FS
>  	  Enabling this option may incur a significant performance overhead.
>  
>  config XEN_PVH
> -	bool "Support for running as a PVH guest"
> +	bool "Support for running as a Xen PVH guest"
>  	depends on XEN && XEN_PVHVM && ACPI
> +	select PVH
>  	def_bool n
> -- 

LGTM:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
