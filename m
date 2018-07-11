Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA4EC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C965208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C965208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbeGKLfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:35:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33966 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733028AbeGKLfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:35:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0133B80D;
        Wed, 11 Jul 2018 04:31:31 -0700 (PDT)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36CE63F589;
        Wed, 11 Jul 2018 04:31:29 -0700 (PDT)
Date:   Wed, 11 Jul 2018 12:33:23 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Xiaowei Song <songxiaowei@hisilicon.com>
Cc:     wangbinghui@hisilicon.com, bhelgaas@google.com, robh+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        suzhuangluan@hisilicon.com, andy.shevchenko@gmail.com,
        kongfei@hisilicon.com, chenyao11@huawei.com
Subject: Re: [PATCH v7 1/1] PCI: kirin: Add MSI support
Message-ID: <20180711113323.GA17546@red-moon>
References: <20180711080946.14942-1-songxiaowei@hisilicon.com>
 <20180711080946.14942-2-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711080946.14942-2-songxiaowei@hisilicon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:09:46PM +0800, Xiaowei Song wrote:
> Add support for MSI
> 
> Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
> Signed-off-by: Yao Chen <chenyao11@huawei.com>
> ---
>  drivers/pci/dwc/pcie-kirin.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Applied to pci/dwc for v4.19, thanks.

Lorenzo

> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
> index d2970a009eb5..5352e0c3be82 100644
> --- a/drivers/pci/dwc/pcie-kirin.c
> +++ b/drivers/pci/dwc/pcie-kirin.c
> @@ -430,6 +430,9 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
>  {
>  	kirin_pcie_establish_link(pp);
>  
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +
>  	return 0;
>  }
>  
> @@ -445,9 +448,34 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
>  	.host_init = kirin_pcie_host_init,
>  };
>  
> +static int kirin_pcie_add_msi(struct dw_pcie *pci,
> +				struct platform_device *pdev)
> +{
> +	int irq;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		irq = platform_get_irq(pdev, 0);
> +		if (irq < 0) {
> +			dev_err(&pdev->dev,
> +				"failed to get MSI IRQ (%d)\n", irq);
> +			return irq;
> +		}
> +
> +		pci->pp.msi_irq = irq;
> +	}
> +
> +	return 0;
> +}
> +
>  static int __init kirin_add_pcie_port(struct dw_pcie *pci,
>  				      struct platform_device *pdev)
>  {
> +	int ret;
> +
> +	ret = kirin_pcie_add_msi(pci, pdev);
> +	if (ret)
> +		return ret;
> +
>  	pci->pp.ops = &kirin_pcie_host_ops;
>  
>  	return dw_pcie_host_init(&pci->pp);
> -- 
> 2.11.GIT
> 
