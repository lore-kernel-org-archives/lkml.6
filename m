Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C763ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F4E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F4E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeGTKBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:01:13 -0400
Received: from foss.arm.com ([217.140.101.70]:59976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbeGTKBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:01:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67F3580D;
        Fri, 20 Jul 2018 02:13:54 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 119A03F5B3;
        Fri, 20 Jul 2018 02:13:52 -0700 (PDT)
Date:   Fri, 20 Jul 2018 10:15:53 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Evan Wang <xswang@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: linux-next: manual merge of the pci tree with Linus' tree
Message-ID: <20180720091553.GA23214@red-moon>
References: <20180720110310.6d07e86e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720110310.6d07e86e@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 11:03:10AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the pci tree got a conflict in:
> 
>   drivers/pci/controller/pci-aardvark.c
> 
> between commit:
> 
>   1df3e5b3feeb ("PCI: aardvark: Fix I/O space page leak")
> 
> from Linus' tree and commit:
> 
>   6df6ba974a55 ("PCI: aardvark: Remove PCIe outbound window configuration")
> 
> from the pci tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/pci/controller/pci-aardvark.c
> index 0fae816fba39,d5030cd06197..000000000000
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@@ -843,13 -809,7 +809,7 @@@ static int advk_pcie_parse_request_of_p
>   
>   		switch (resource_type(res)) {
>   		case IORESOURCE_IO:
> - 			advk_pcie_set_ob_win(pcie, 1,
> - 					     upper_32_bits(res->start),
> - 					     lower_32_bits(res->start),
> - 					     0,	0xF8000000, 0,
> - 					     lower_32_bits(res->start),
> - 					     OB_PCIE_IO);
>  -			err = pci_remap_iospace(res, iobase);
>  +			err = devm_pci_remap_iospace(dev, res, iobase);
>   			if (err) {
>   				dev_warn(dev, "error %d: failed to map resource %pR\n",
>   					 err, res);

Hi Stephen,

thanks for fixing this up, the fix looks fine to me (Thomas please
confirm), if it is I would ask Bjorn please to send it upstream when the
time for the PCI pull request comes.

Thanks,
Lorenzo
