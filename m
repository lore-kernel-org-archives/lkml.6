Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472ADC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085B820867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085B820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeIDTSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:18:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47902 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbeIDTSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:18:40 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lag7W8aBTt8Z; Tue,  4 Sep 2018 16:52:55 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC9A500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:a500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4550E1EC060B;
        Tue,  4 Sep 2018 16:52:55 +0200 (CEST)
Date:   Tue, 4 Sep 2018 16:52:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 07/16] x86/pci: add Hygon PCI vendor and northbridge
 support
Message-ID: <20180904145255.GI32615@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <ecd62b5b5e8f406598f2354892929caa87cf7deb.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecd62b5b5e8f406598f2354892929caa87cf7deb.1535459013.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:44:18PM +0800, Pu Wen wrote:
> As Hygon register its PCI Vendor ID as a new one "0x1d94", so add a new
> definition PCI_VENDOR_ID_HYGON in include/linux/pci_ids.h.
> 
> Also Hygon PCI Device ID(0x1450/0x1463/0x1464) for Host bridge is added
> to amd_nb.c. And it need to define new arrays for Hygon:
> hygon_root_ids[], hygon_nb_misc_ids[], hygon_nb_link_ids[].
> 
> To enable Hygon north bridge support, add new variable root_ids, and
> assign its value based on whether CPU vendor is AMD or Hygon. Modify
> the CONFIG_AMD_NB to depends on either AMD or Hygon.
> 
> Add Hygon support in amd_postcore_init(), early_root_info_init().

This whole commit message needs to not say *what* the patch does.

> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/Kconfig         |  2 +-
>  arch/x86/kernel/amd_nb.c | 51 ++++++++++++++++++++++++++++++++++++++++++------
>  arch/x86/pci/amd_bus.c   |  6 ++++--
>  include/linux/pci_ids.h  |  2 ++
>  4 files changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c5ff296..733f1ec 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2818,7 +2818,7 @@ endif # X86_32
>  
>  config AMD_NB
>  	def_bool y
> -	depends on CPU_SUP_AMD && PCI
> +	depends on (CPU_SUP_AMD || CPU_SUP_HYGON) && PCI
>  
>  source "drivers/pcmcia/Kconfig"
>  
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index b481b95..d9867b2 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -20,6 +20,10 @@
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  
> +#define PCI_DEVICE_ID_HYGON_18H_ROOT     0x1450
> +#define PCI_DEVICE_ID_HYGON_18H_DF_F3    0x1463
> +#define PCI_DEVICE_ID_HYGON_18H_DF_F4    0x1464

Why are you adding those if you can use the AMD f17h ones? They're the same.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
