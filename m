Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB053C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8295E21770
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEm9no0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8295E21770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbeHNA6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730921AbeHNA6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:58:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C3521763;
        Mon, 13 Aug 2018 22:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534198478;
        bh=LSTDG8ma7sxJcBiMoRKlBjYqKqjtZcspbUUuTO+Czl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEm9no0vcK6bcsK/IIMDlShGH4uQM/DOGKSERLcwP8k/00w5vhXv3VzBajGX2JMWW
         pepJ04/cusGIgDFgJ2eR1z0F68TAOwKW72W7IHWJCtEXkGBt6T4DgnfxEnJI9n9VtM
         kZQJGz56yjwUUaXLPvVMYviDe9H961hGv8oamWqg=
Date:   Mon, 13 Aug 2018 17:14:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 07/17] x86/pci: add Hygon PCI vendor and northbridge
 support
Message-ID: <20180813221436.GN113140@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1533989492.git.puwen@hygon.cn>
 <0b8f3a7c5ba8b4f496f8f790e3dafa8d612ffc81.1533989492.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8f3a7c5ba8b4f496f8f790e3dafa8d612ffc81.1533989492.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 09:27:42PM +0800, Pu Wen wrote:
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
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/Kconfig         |  2 +-
>  arch/x86/kernel/amd_nb.c | 51 ++++++++++++++++++++++++++++++++++++++++++------
>  arch/x86/pci/amd_bus.c   |  6 ++++--
>  include/linux/pci_ids.h  |  2 ++
>  4 files changed, 52 insertions(+), 9 deletions(-)

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 2950223..d0e98a9 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -511,6 +511,8 @@
>  #define PCI_DEVICE_ID_AMI_MEGARAID	0x9010
>  #define PCI_DEVICE_ID_AMI_MEGARAID2	0x9060
>  
> +#define PCI_VENDOR_ID_HYGON		0x1d94

Please add this entry so pci_ids.h remains sorted by Vendor ID, then Device
ID, as the comment at the top suggests.

With that changed,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h

>  #define PCI_VENDOR_ID_AMD		0x1022
>  #define PCI_DEVICE_ID_AMD_K8_NB		0x1100
>  #define PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP	0x1101
> -- 
> 2.7.4
> 
