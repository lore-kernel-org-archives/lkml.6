Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757361AbeDKThz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:37:55 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45019 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756124AbeDKThu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:37:50 -0400
X-Google-Smtp-Source: AIpwx49YyZse/ylcv7P+3TqP1Du9v3TNShx4mkV0+7F8/tZrkiqSzFms2+pEMTbbFgjHKcs6r1TRSg==
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Gustavo Pimentel'" <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
Cc: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com> <5181f7ffbb9d2889974c49d84e72042251adf8b6.1523266508.git.gustavo.pimentel@synopsys.com> <003001d3d128$39f3eaa0$addbbfe0$@gmail.com> <c295bc5b-e67a-290c-3316-56a1cc001538@synopsys.com>
In-Reply-To: <c295bc5b-e67a-290c-3316-56a1cc001538@synopsys.com>
Subject: Re: [PATCH v2 8/9] PCI: dwc: Small computation improvement
Date: Wed, 11 Apr 2018 15:37:46 -0400
Message-ID: <000001d3d1cc$92706790$b75136b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQEaRjwvEF5/h3QMrbPVq+Y0x5xNJwIXxkZLAdaBFooA9hP2Z6VH6TYw
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 11, 2018 3:40 AM, Gustavo Pimentel wrote:
> 
> Hi Jingoo,
> 
> On 11/04/2018 01:01, Jingoo Han wrote:
> > On Monday, April 9, 2018 5:41 AM, Gustavo Pimentel wrote:
> >>
> >> Replaces a simple division by 2 to a right shift rotation of 1 bit.
> >
> > It looks good. However, would you add a simple reason to the commit
> > message?
> 
> Sure.
> 
> Can be this one?
> 
> Probably any recent and decent compiler does this kind of substitution
> in order to improve code performance. Nevertheless it's a coding good
> practice whenever there is a division / multiplication by multiple of 2
> to replace it by the equivalent operation in this case, the shift
> rotation.

Yes, that's what I wanted. The most platforms using 'dwc' are based on
ARM CPUs. So, the shift rotation can be better.
Thank you.

Best regards,
Jingoo Han

> 
> >
> > Best regards,
> > Jingoo Han
> >
> >>
> >> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> >> ---
> >> Change v1->v2:
> >> - Nothing changed, just to follow the patch set version.
> >>
> >>  drivers/pci/dwc/pcie-designware-host.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/pci/dwc/pcie-designware-host.c
> >> b/drivers/pci/dwc/pcie-designware-host.c
> >> index 03e9b82..8e6fed4 100644
> >> --- a/drivers/pci/dwc/pcie-designware-host.c
> >> +++ b/drivers/pci/dwc/pcie-designware-host.c
> >> @@ -332,8 +332,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >>
> >>  	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> >> "config");
> >>  	if (cfg_res) {
> >> -		pp->cfg0_size = resource_size(cfg_res) / 2;
> >> -		pp->cfg1_size = resource_size(cfg_res) / 2;
> >> +		pp->cfg0_size = resource_size(cfg_res) >> 1;
> >> +		pp->cfg1_size = resource_size(cfg_res) >> 1;
> >>  		pp->cfg0_base = cfg_res->start;
> >>  		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
> >>  	} else if (!pp->va_cfg0_base) {
> >> @@ -377,8 +377,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >>  			break;
> >>  		case 0:
> >>  			pp->cfg = win->res;
> >> -			pp->cfg0_size = resource_size(pp->cfg) / 2;
> >> -			pp->cfg1_size = resource_size(pp->cfg) / 2;
> >> +			pp->cfg0_size = resource_size(pp->cfg) >> 1;
> >> +			pp->cfg1_size = resource_size(pp->cfg) >> 1;
> >>  			pp->cfg0_base = pp->cfg->start;
> >>  			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
> >>  			break;
> >> --
> >> 2.7.4
> >>
> >
> >
> 
> Regards,
> Gustavo
