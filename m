Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeEKIbO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:31:14 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:35785 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750852AbeEKIbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:31:12 -0400
From: "chenyao (F)" <chenyao11@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: songxiaowei <songxiaowei@hisilicon.com>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>,
        "dimitrysh@google.com" <dimitrysh@google.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Tejun Heo <tj@kernel.org>
Subject: RE: [PATCH v2 1/2] PCI: kirin: Add MSI support
Thread-Topic: [PATCH v2 1/2] PCI: kirin: Add MSI support
Thread-Index: AQHT526WA9UdXFlyM0ODTWQlj6GhcaQoeqiAgAG23kA=
Date: Fri, 11 May 2018 08:30:59 +0000
Message-ID: <1F615B5A909C3342A3B7B4843796B9151C35E2A4@dggemi502-mbs.china.huawei.com>
References: <1525854012-24228-1-git-send-email-chenyao11@huawei.com>
 <1525854012-24228-2-git-send-email-chenyao11@huawei.com>
 <20180510140431.GJ173327@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180510140431.GJ173327@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.151.30.91]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

> 
> [+cc Tejun, Wolfram]
> 
> On Wed, May 09, 2018 at 04:20:11PM +0800, Yao Chen wrote:
> > Add support for MSI.
> > ...
> 
> > @@ -448,6 +467,26 @@ static int kirin_pcie_host_init(struct pcie_port
> > *pp)  static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> >  				      struct platform_device *pdev)  {
> > +	int ret;
> > +
> > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +		pci->pp.msi_irq = platform_get_irq(pdev, 0);
> > +		if (!pci->pp.msi_irq) {
> 
> I think this test is incorrect.  platform_get_irq() returns a negative errno
> value when it fails.  Most calls test "irq < 0" to check for failure.
> 
> There's a lot of duplicated code like this, so maybe we should consider
> putting that check into devm_request_irq(), similar to what
> devm_ioremap_resource() does, so the driver code could look like this:
> 
>   pci->pp.msi_irq = platform_get_irq(pdev, 0);
>   ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq, ...);
>   if (ret) {
>     dev_err(&pdev->dev, "failed to request MSI IRQ\n");
>     return ret;
>   }
> 
> The basic devm_ioremap_resource() motivation is here: 72f8c0bfa0de ("lib:
> devres: add convenience function to remap a resource") and the same
> considerations seem to apply here.
> 
> But that's more than you need to do for *this* series.  So for now, I would
> simply fix the test to check for "irq < 0" and update the messages as I
> mention below.

Thank you for pointing out my mistake.  I'll fix it.

> 
> > +			dev_err(&pdev->dev, "failed to get msi irq[%d]\n",
> > +				pci->pp.msi_irq);
> > +			return -ENODEV;
> > +		}
> > +		ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
> > +				       kirin_pcie_msi_irq_handler,
> > +				       IRQF_SHARED | IRQF_NO_THREAD,
> > +				       "kirin_pcie_msi", &pci->pp);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "failed to request msi
> irq[%d]\n",
> 
> s/msi irq/MSI IRQ/ in both dev_err() messages above.  This is because the
> message is English text (not code), and the convention is that non-words like
> these initialisms written in all caps.
> 
> I would style the first one as "failed to get MSI IRQ (%d)" because the %d
> there is a return code, probably -ENXIO.
> 
> The second one should be "failed to request MSI IRQ %d" because here
> the %d is the actual IRQ.
> 

I'll fix it. Thanks again.

> > +				pci->pp.msi_irq);
> > +			return ret;
> > +		}
> > +	}
> > +
> >  	pci->pp.ops = &kirin_pcie_host_ops;
> >
> >  	return dw_pcie_host_init(&pci->pp);
> > --
> > 1.9.1
> >

Best regards,
Yao
