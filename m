Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88125C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E01920861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E01920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeIMP6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:58:15 -0400
Received: from foss.arm.com ([217.140.101.70]:45880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbeIMP6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:58:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3A9680D;
        Thu, 13 Sep 2018 03:49:20 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E5EF3F557;
        Thu, 13 Sep 2018 03:49:19 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:49:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dwc: fix scheduling while atomic issues
Message-ID: <20180913104914.GA2051@e107981-ln.cambridge.arm.com>
References: <20180829110408.556c3622@xhacker.debian>
 <20180910165722.38218779@xhacker.debian>
 <20180913091534.GB32721@e107981-ln.cambridge.arm.com>
 <20180913182926.365d155b@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913182926.365d155b@xhacker.debian>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 06:29:54PM +0800, Jisheng Zhang wrote:
> Hi Lorenzo,
> 
> On Thu, 13 Sep 2018 10:15:34 +0100 Lorenzo Pieralisi wrote:
> 
> > On Mon, Sep 10, 2018 at 04:57:22PM +0800, Jisheng Zhang wrote:
> > > Hi all,
> > > 
> > > On Wed, 29 Aug 2018 11:04:08 +0800 Jisheng Zhang wrote:
> > >   
> > > > When programming inbound/outbound atu, we call usleep_range() after
> > > > each checking PCIE_ATU_ENABLE bit. Unfortunately, the atu programming
> > > > can be called in atomic context:
> > > > 
> > > > inbound atu programming could be called through
> > > > pci_epc_write_header()  
> > > >   =>dw_pcie_ep_write_header()
> > > >     =>dw_pcie_prog_inbound_atu()    
> > > > 
> > > > outbound atu programming could be called through
> > > > pci_bus_read_config_dword()  
> > > >   =>dw_pcie_rd_conf()
> > > >     =>dw_pcie_prog_outbound_atu()    
> > > > 
> > > > Fix this issue by calling mdelay() instead.  
> > > 
> > > Any comments about this patch?
> > > 
> > > Thanks,
> > > Jisheng
> > >   
> > > > 
> > > > Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> > > > Fixes: d8bbeb39fbf3 ("PCI: designware: Wait for iATU enable")  
> > 
> > Can you split it into two patches and repost it please ? It will make
> > everyone's life easier to backport it if there is need, I will apply
> > then.
> 
> IIUC, the purpose of this split is to make the backport to stable easier. If
> so, I realise that the Fixes tags were not enough, we missed:
> 
> Fixes: edd45e396829 ("PCI: dwc: designware: Move _unroll configurations to a
> separate function")
> 
> I'm not sure how to handle this case. From another side, the issue to be
> fixed is the same: call sleep in atomic context in the same driver, is it
> better to use one patch?
> 
> As for stable tree, I could send out separate patches instead. What do you
> think?

OK, I will merge the patch as-is and we will handle the stable backports
when Greg sends the patches out.

Lorenzo
