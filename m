Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeERTwB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751197AbeERTv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:51:57 -0400
Date: Fri, 18 May 2018 14:51:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Cc: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, bhelgaas@google.com,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        ryder.lee@mediatek.com, hongkun.cao@mediatek.com,
        youlin.pei@mediatek.com, yong.wu@mediatek.com, yt.shen@mediatek.com,
        sean.wang@mediatek.com, xinping.qian@mediatek.com
Subject: Re: [PATCH v7 2/2] PCI: mediatek: Using chained IRQ to setup IRQ
 handle
Message-ID: <20180518195154.GB41790@bhelgaas-glaptop.roam.corp.google.com>
References: <1525412853-24367-1-git-send-email-honghui.zhang@mediatek.com>
 <1525412853-24367-3-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525412853-24367-3-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:47:33PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Using irq_chip solution to setup IRQs in order to consist
> with IRQ framework.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/host/pcie-mediatek.c | 206 ++++++++++++++++++++++-----------------
>  1 file changed, 115 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index c3dc549..dabf1086 100644
> --- a/drivers/pci/host/pcie-mediatek.c
> +++ b/drivers/pci/host/pcie-mediatek.c
> ...

> -static int mtk_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> -			    irq_hw_number_t hwirq)
> +static struct msi_domain_info mtk_msi_domain_info = {

I think this patch should be amended to include this:

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 0d0177ce436c..368b70d9371b 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -193,7 +193,7 @@ config PCIE_MEDIATEK
 	bool "MediaTek PCIe controller"
 	depends on (ARM || ARM64) && (ARCH_MEDIATEK || COMPILE_TEST)
 	depends on OF
-	depends on PCI
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	help
 	  Say Y here if you want to enable PCIe controller support on


Lorenzo, if you want to fold that in and update your branch, I can pull it.
If not, I can add a patch on top, which should only break compile-testing
bisection.
