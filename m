Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LoDDN/6kGVuLfgAAmS7hNA
	; Thu, 07 Jun 2018 21:34:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C5D316089E; Thu,  7 Jun 2018 21:34:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3kWqkog"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 41FC5601C3;
	Thu,  7 Jun 2018 21:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41FC5601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeFGVew (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751641AbeFGVeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:34:50 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C0B2088F;
        Thu,  7 Jun 2018 21:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528407290;
        bh=tXZ/fSSuXRG51JQpHHmW/7oPaQtBiRD1t+jtkgPsm4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3kWqkogtCbTRtixdzZOwa8d9nMcQDmVMW6AUKvjv9kSsCSU3e7/A+IpjbWw/P/eG
         bqmMVaprkvrIvSrjY4V/V+a2LEQlScT5J2T8+39k2Lw/FjWNOy02Xm+x2bz1C5Xh0G
         Ay7lX/hseQaU8uIn0ye2pk1ZW5wcujYxyx99UalE=
Date: Thu, 7 Jun 2018 16:34:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH NEXT 6/6] PCI/PORTDRV: Remove ERR_FATAL handling from
 pcie_portdrv_slot_reset()
Message-ID: <20180607213448.GB37077@bhelgaas-glaptop.roam.corp.google.com>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
 <1528351234-26914-6-git-send-email-poza@codeaurora.org>
 <94661add3e71e3694aa22c2a9cabf503@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94661add3e71e3694aa22c2a9cabf503@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 07:18:03PM +0530, poza@codeaurora.org wrote:
> On 2018-06-07 11:30, Oza Pawandeep wrote:
> > We are handling ERR_FATAL by resetting the Link in software,skipping the
> > driver pci_error_handlers callbacks, removing the devices from the PCI
> > subsystem, and re-enumerating, as a result of that, no more calling
> > pcie_portdrv_slot_reset in ERR_FATAL case.
> > 
> > Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> > 
> > diff --git a/drivers/pci/pcie/portdrv_pci.c
> > b/drivers/pci/pcie/portdrv_pci.c
> > index 973f1b8..92f5d330 100644
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -42,17 +42,6 @@ __setup("pcie_ports=", pcie_port_setup);
> > 
> >  /* global data */
> > 
> > -static int pcie_portdrv_restore_config(struct pci_dev *dev)
> > -{
> > -	int retval;
> > -
> > -	retval = pci_enable_device(dev);
> > -	if (retval)
> > -		return retval;
> > -	pci_set_master(dev);
> > -	return 0;
> > -}
> > -
> >  #ifdef CONFIG_PM
> >  static int pcie_port_runtime_suspend(struct device *dev)
> >  {
> > @@ -162,14 +151,6 @@ static pci_ers_result_t
> > pcie_portdrv_mmio_enabled(struct pci_dev *dev)
> > 
> >  static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
> >  {
> > -	/* If fatal, restore cfg space for possible link reset at upstream */
> > -	if (dev->error_state == pci_channel_io_frozen) {
> > -		dev->state_saved = true;
> > -		pci_restore_state(dev);
> > -		pcie_portdrv_restore_config(dev);
> > -		pci_enable_pcie_error_reporting(dev);
> > -	}
> > -
> >  	return PCI_ERS_RESULT_RECOVERED;
> >  }
> 
> 
> Hi Bjorn,
> 
> the above patch removes ERR_FATAL handling from pcie_portdrv_slot_reset()
> because now we are handling ERR_FATAL differently than before.
> 
> I tried to dig into pcie_portdrv_slot_reset() handling for ERR_FATAL case
> where it
> restores the config space, enable device, set master and enable error
> reporting....
> and as far as I understand this is being done for upstream link (bridges
> etc..)
> 
> why was it done at the first point (I checked the commit description, but
> could not really get it)
> and do we need to handle the same thing in ERR_FATAL now ?

You mean 4bf3392e0bf5 ("PCI-Express AER implemetation: pcie_portdrv
error handler"), which added pcie_portdrv_slot_reset()?  I agree, that
commit log has no useful information.  I don't know any of the history
behind it.
