Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753754AbeDJTls (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:41:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753720AbeDJTlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:41:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3794921745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Tue, 10 Apr 2018 14:41:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, sulrich@codeaurora.org,
        timur@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: quirk HT1100 & HT2000 and one HT2100 Root Ports for
 Extended Tags
Message-ID: <20180410194144.GD54986@bhelgaas-glaptop.roam.corp.google.com>
References: <1522882209-9743-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522882209-9743-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 06:50:09PM -0400, Sinan Kaya wrote:
> Per PCIe r3.1, sec 2.2.6.2 and 7.8.4, a Requester may not use 8-bit Tags
> unless its Extended Tag Field Enable is set, but all Receivers/Completers
> must handle 8-bit Tags correctly regardless of their Extended Tag Field
> Enable.
> 
> Some devices do not handle 8-bit Tags as Completers, so add a quirk for
> them.  If we find such a device, we disable Extended Tags for the entire
> hierarchy to make peer-to-peer DMA possible.
> 
> The Broadcom HT1100/HT2000/HT2100 seems to have issues with handling 8-bit
> tags.  Mark it as broken.
> 
> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=196197
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied to pci/enumeration for v4.18, thanks!

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 8b14bd3..f012742 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4813,9 +4813,13 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
>  
>  	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
>  }
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0142, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144, quirk_no_ext_tags);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
>  
>  #ifdef CONFIG_PCI_ATS
>  /*
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
