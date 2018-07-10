Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F93AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133A3208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133A3208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934287AbeGJPi0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:38:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933475AbeGJPiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:38:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8BCC80D;
        Tue, 10 Jul 2018 08:38:24 -0700 (PDT)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A73823F589;
        Tue, 10 Jul 2018 08:38:23 -0700 (PDT)
Date:   Tue, 10 Jul 2018 16:40:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Songxiaowei (Kirin_DRV)" <songxiaowei@hisilicon.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenyao (F)" <chenyao11@huawei.com>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH v5 1/1] PCI: kirin:
 Add MSI support
Message-ID: <20180710154017.GA16825@red-moon>
References: <20180628124803.110315-1-songxiaowei@hisilicon.com>
 <20180628124803.110315-2-songxiaowei@hisilicon.com>
 <99B4C6BADD9E3241B25E52B02BA737C5412D2511@dggema525-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99B4C6BADD9E3241B25E52B02BA737C5412D2511@dggema525-mbx.china.huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:54:07AM +0000, Songxiaowei (Kirin_DRV) wrote:
> Hi Bjorn Helgaas,
> 
> Would you help to review this patch?
> 
> Best regards,
> 
> Xiaowei.
> 
> > -----邮件原件-----
> > 发件人: Songxiaowei (Kirin_DRV)
> > 发送时间: 2018年6月28日 20:48
> > 收件人: Wangbinghui <wangbinghui@hisilicon.com>; bhelgaas@google.com;
> > robh+dt@kernel.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > dimitrysh@google.com
> > 抄送: chenyao (F) <chenyao11@huawei.com>; Songxiaowei (Kirin_DRV)
> > <songxiaowei@hisilicon.com>
> > 主题: [PATCH v5 1/1] PCI: kirin: Add MSI support
> > 
> > Add support for MSI.
> > 
> > Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
> > ---
> >  drivers/pci/dwc/pcie-kirin.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c index
> > d2970a009eb5..6997276eb69c 100644
> > --- a/drivers/pci/dwc/pcie-kirin.c
> > +++ b/drivers/pci/dwc/pcie-kirin.c
> > @@ -430,6 +430,9 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
> > {
> >  	kirin_pcie_establish_link(pp);
> > 
> > +	if (IS_ENABLED(CONFIG_PCI_MSI))
> > +		dw_pcie_msi_init(pp);
> > +
> >  	return 0;
> >  }
> > 
> > @@ -445,9 +448,34 @@ static const struct dw_pcie_host_ops
> > kirin_pcie_host_ops = {
> >  	.host_init = kirin_pcie_host_init,
> >  };
> > 
> > +static int kirin_pcie_add_msi(struct dw_pcie *pci,
> > +				struct platform_device *pdev)
> > +{
> > +	int ret = 0;
> > +
> > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +		ret = platform_get_irq(pdev, 0);
> > +		if (ret < 0) {
> > +			dev_err(&pdev->dev,
> > +				"failed to get MSI IRQ (%d)\n", ret);
> > +			return ret;
> > +		}
> > +
> > +		pci->pp.msi_irq = ret;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> >  				      struct platform_device *pdev)  {
> > +	int ret;
> > +
> > +	ret = kirin_pcie_add_msi(pci, pdev);
> > +	if (ret)
> > +		return ret;

If kirin_pcie_add_msi() returns an IRQ number we return from
this function here, is that what you really want ?

Lorenzo

> > +
> >  	pci->pp.ops = &kirin_pcie_host_ops;
> > 
> >  	return dw_pcie_host_init(&pci->pp);
> > --
> > 2.11.GIT
> 
