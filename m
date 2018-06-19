Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872CEC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369D420652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRYwb7NN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369D420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937575AbeFSV52 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935912AbeFSV5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:57:22 -0400
Received: from localhost (unknown [146.7.4.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620FD20652;
        Tue, 19 Jun 2018 21:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529445441;
        bh=ossF2oTZrZbdyDajO51VLUS0Ql9ra8K7kkbZ84lYVME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRYwb7NNRqoFUxrQzmJm5g7T4qqcKUrWB1sff795V6eEoQBjQkh0ktUMC0ifi/E/+
         mfUE87qw+4nbpBbrYg9cAKUpd6ZMT6/DX+iX5+1qABPP+weJIgIMHwkDTLSrIPdSBo
         /mcvHvG6PHjI7QI4IVJ7uIQUW9BmfGcu757r1djQ=
Date:   Tue, 19 Jun 2018 16:57:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Sinan Kaya <okaya@codeaurora.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>, bhelgaas@google.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Dongdong Liu <liudongdong3@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: DPC: Clear AER status bits before disabling port
 containment
Message-ID: <20180619215720.GE33049@bhelgaas-glaptop.roam.corp.google.com>
References: <20180516213306.27027-1-mr.nuke.me@gmail.com>
 <605540c0-b6c5-89a2-9d50-12a3005d9f88@codeaurora.org>
 <20180516231220.GA21659@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516231220.GA21659@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 05:12:21PM -0600, Keith Busch wrote:
> On Wed, May 16, 2018 at 06:44:22PM -0400, Sinan Kaya wrote:
> > On 5/16/2018 5:33 PM, Alexandru Gagniuc wrote:
> > > AER status bits are sticky, and they survive system resets. Downstream
> > > devices are usually taken care of after re-enumerating the downstream
> > > busses, as the AER bits are cleared during probe().
> > > 
> > > However, nothing clears the bits of the port which contained the
> > > error. These sticky bits may leave some BIOSes to think that something
> > > bad happened, and print ominous messages on next boot. To prevent this,
> > > tidy up the AER status bits before releasing containment.
> > > 
> > > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > > ---
> > >  drivers/pci/pcie/dpc.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > > index 8c57d607e603..bf82d6936556 100644
> > > --- a/drivers/pci/pcie/dpc.c
> > > +++ b/drivers/pci/pcie/dpc.c
> > > @@ -112,6 +112,10 @@ static void dpc_work(struct work_struct *work)
> > >  		dpc->rp_pio_status = 0;
> > >  	}
> > >  
> > > +	/* DPC event made a mess of our AER status bits. Clean them up. */
> > > +	pci_cleanup_aer_error_status_regs(pdev);
> > > +	/* TODO: Should we also use aer_print_error to log the event? */
> > > +
> > >  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
> > >  		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
> > >  
> > > 
> > 
> > I think Keith has a patch to fix this. It was under review at some point.
> 
> Right, I do intend to following up on this, but I've had some trouble
> finding time the last few weeks. Sorry about that, things will clear up
> for me shortly.

I'll drop this (Alexandru's) patch for now, waiting for your update, Keith.
