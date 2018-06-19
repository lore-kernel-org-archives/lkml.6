Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB101C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856B02075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkSp13l7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856B02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967292AbeFSVnw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935985AbeFSVns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:43:48 -0400
Received: from localhost (unknown [146.7.4.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733F920661;
        Tue, 19 Jun 2018 21:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529444627;
        bh=w7JhPxNuvlm0YHk4+rOraMWT9Y+at4ZTQH6Kqz91RE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkSp13l70Ucbl4dtKsCLyfLrwrcjPWIBkB2xzJpmL9n03NtRCJxEiCXwyy2Sf/v2S
         FIyAxHYAdtbu8Ip9q9MG7mFzGVjxT6UU2CCzOO4iZDfc2aHehzUPwda/Ad/jowzUk5
         VhEpnmj1IWaF+OH4gtiep+qG2KdIdq9cvAbY3rM4=
Date:   Tue, 19 Jun 2018 16:43:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, sulrich@codeaurora.org,
        timur@codeaurora.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
Message-ID: <20180619214346.GD33049@bhelgaas-glaptop.roam.corp.google.com>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 03:56:23PM -0400, Sinan Kaya wrote:
> The infiniband adapter might be connected to a PCI hotplug slot. Performing
> secondary bus reset on a hotplug slot causes PCI link up/down interrupts.
> 
> Hotplug driver removes the device from system when a link down interrupt
> is observed and performs re-enumeration when link up interrupt is observed.
> 
> This conflicts with what this code is trying to do. Try secondary bus reset
> only if pci_reset_slot() fails/unsupported.

Hi Sinan,

We had a bunch of discussion here but not sure we ever reached a
consensus.  It did seem like we'd like to avoid putting hotplug
knowledge in drivers, though.  What do you think the path forward is?

> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/infiniband/hw/hfi1/pcie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
> index 83d66e8..75f49e3 100644
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -908,7 +908,8 @@ static int trigger_sbr(struct hfi1_devdata *dd)
>  	 * delay after a reset is required.  Per spec requirements,
>  	 * the link is either working or not after that point.
>  	 */
> -	pci_reset_bridge_secondary_bus(dev->bus->self);
> +	if (pci_reset_slot(dev->slot))
> +		pci_reset_bridge_secondary_bus(dev->bus->self);
>  
>  	return 0;
>  }
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
