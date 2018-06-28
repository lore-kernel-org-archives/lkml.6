Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B5CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F95625982
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F95625982
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbeF1BMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:12:15 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:54041 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751272AbeF1BMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:12:13 -0400
X-UUID: 00570ab034cf4081a656ec8d55ad862b-20180628
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1573740479; Thu, 28 Jun 2018 09:12:09 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Thu, 28 Jun
 2018 09:12:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 28 Jun 2018 09:12:07 +0800
Message-ID: <1530148327.28284.1.camel@mhfsdcap03>
Subject: Re: [PATCH 1/4] PCI: mediatek: fixup mtk_pcie_find_port logical
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>, <sean.wang@mediatek.com>
Date:   Thu, 28 Jun 2018 09:12:07 +0800
In-Reply-To: <CAHp75Ve2N_Bt8FvX8xCx3JtQ+ozZE=isfsKp9swY+86Cg-78XQ@mail.gmail.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
         <1530091298-28120-2-git-send-email-honghui.zhang@mediatek.com>
         <CAHp75Ve2N_Bt8FvX8xCx3JtQ+ozZE=isfsKp9swY+86Cg-78XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 19:35 +0300, Andy Shevchenko wrote:
> On Wed, Jun 27, 2018 at 12:21 PM,  <honghui.zhang@mediatek.com> wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> >
> > Mediatek's host controller have two slots, each have it's own control
> > registers. The host driver need to identify which slot was connected
> > in order to access the device's configuration space. There's problem
> > for current host driver to find out which slot was connected to for
> > a given EP device.
> >
> > Assuming each slot have connect with one EP device as below:
> >
> >                 host bridge
> >   bus 0 --> __________|_______
> >            |                  |
> >            |                  |
> >          slot 0             slot 1
> >   bus 1 -->|        bus 2 --> |
> >            |                  |
> >          EP 0               EP 1
> >
> > While PCI emulation, system software will scan all the PCI device
> > starting from devfn 0. So it will get the proper port for slot0 and
> > slot1 device when using PCI_SLOT(devfn) for match. But it will get
> > the wrong slot for EP1: The devfn will be start from 0 when scanning
> > EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
> > for port0's slot value. So the host driver should not using EP's devfn
> > but the slot's devfn(the slot which EP was connected to) for match.
> >
> > This patch fix the mtk_pcie_find_port's logical by using the slot's
> > devfn for match.
> 
> 
> > +       list_for_each_entry(port, &pcie->ports, list) {
> > +               if (bus->number == 0 && port->slot == PCI_SLOT(devfn)) {
> >                         return port;
> > +               } else if (bus->number != 0) {
> 
> You can do it like (no need 'else')
> 
> if (...)
>  return ...;
> if (bus->number) {
>  ...
> }
> 
> > +                       pbus = bus;
> > +                       do {
> > +                               dev = pbus->self;
> > +                               if (port->slot == PCI_SLOT(dev->devfn))
> > +                                       return port;
> > +
> > +                               pbus = dev->bus;
> > +                       } while (dev->bus->number != 0);
> 
> This can be rewritten like
> 
> pbus = bus;
> while (pbus->number) {
>  dev = ...;
>  ...
>  pbus = dev->bus;
> }
> 
> and no need for if (bus->number) anymore.
> 

Hi, Andy, thanks very much for your advise, I will change it in the next
version.

thanks.
> > +               }
> > +       }
> >
> >         return NULL;
> >  }
> > --
> > 2.6.4
> >
> 
> 
> 


