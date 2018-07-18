Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134DDECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BC520850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/kBfia7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BC520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbeGRTtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbeGRTtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:49:45 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C2642084E;
        Wed, 18 Jul 2018 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531941028;
        bh=hN/6bz4hAADHcbTzDk4PJlKGV5XTYsxhqXXCkQWfw+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/kBfia7L27X2tXfQ0jC+csFshLGXYDls0pQRogQiyQ9nfbAWK8G6hmKbhSwTNkml
         l2SCQvWsC+G2VMKev8od/GzwjnjZ3dtkR0u9/zCad7pDGL8uz0FePd0/fxyoEJbZqw
         XAR90BBUiNxRmSpHW5RONXxE+24go5OjPSA2LMyc=
Date:   Wed, 18 Jul 2018 14:10:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Oza Pawandeep <poza@codeaurora.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 6/6] PCI/PORTDRV: Remove ERR_FATAL handling from
 pcie_portdrv_slot_reset()
Message-ID: <20180718191024.GE128988@bhelgaas-glaptop.roam.corp.google.com>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
 <1529661494-20936-7-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529661494-20936-7-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 05:58:14AM -0400, Oza Pawandeep wrote:
> We are handling ERR_FATAL by resetting the Link in software,skipping the
> driver pci_error_handlers callbacks, removing the devices from the PCI
> subsystem, and re-enumerating, because of, no need to handle
> pci_channel_io_frozen case anymore.
> 
> Besides the walk on the bus is happening on subordinates, inside
> broadcast_error_message(), which means that pcie_portdrv_slot_reset()
> is never called for RP, and now since the all the devices are removed under
> this downstream link, we can safely get rid of ERR_FATAL handling code
> in pcie_portdrv_slot_reset().

portdrv only binds to bridges, and it looks like
broadcast_error_message() only calls the pci_error_handlers callbacks
for subordinate devices, never for the bridge itself:

  broadcast_error_message
    if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
      pci_walk_bus(dev->subordinate, ...)

If that's the case, why do we need pcie_portdrv_err_handler at all?
We should remove it completely if we don't need it.

ISTR some arcane call path for pcie_portdrv_err_resume(), but I don't
remember the details.

> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 973f1b8..b970a6d 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -42,17 +42,6 @@ __setup("pcie_ports=", pcie_port_setup);
>  
>  /* global data */
>  
> -static int pcie_portdrv_restore_config(struct pci_dev *dev)
> -{
> -	int retval;
> -
> -	retval = pci_enable_device(dev);
> -	if (retval)
> -		return retval;
> -	pci_set_master(dev);
> -	return 0;
> -}
> -
>  #ifdef CONFIG_PM
>  static int pcie_port_runtime_suspend(struct device *dev)
>  {
> @@ -163,13 +152,6 @@ static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
>  static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
>  {
>  	/* If fatal, restore cfg space for possible link reset at upstream */
> -	if (dev->error_state == pci_channel_io_frozen) {
> -		dev->state_saved = true;
> -		pci_restore_state(dev);
> -		pcie_portdrv_restore_config(dev);
> -		pci_enable_pcie_error_reporting(dev);
> -	}
> -
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
>  
> -- 
> 2.7.4
> 
