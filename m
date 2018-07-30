Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EB9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD693208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKKbgFlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD693208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbeG3XHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbeG3XHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:07:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74C820857;
        Mon, 30 Jul 2018 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532986230;
        bh=yh8r5Jub8C1LdVDBCGDB3HIdAT6QN3bGDxiHnLyXjhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKKbgFlhcP18k1yXL16AaFLjfdkCZ/QPmrtooA1SzSpAg8dhn6Y6hVYyf8U3Ekmbq
         U2OucGGt7RIpiHUmcrnh4MpRVpiv/HPt48mhZQiEO0MgOpuw1ChdN6ZeH0G1/zr2WG
         xsMbfHTXR+TSoETSSCR0UD+fBpAoDzU53PHm0Z44=
Date:   Mon, 30 Jul 2018 16:30:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
Message-ID: <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Thomas, Christoph, LKML]

On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
> If we have a threaded interrupt with the handler being NULL, then
> request_threaded_irq() -> __setup_irq() will complain and bail out
> if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
> being NULL and set IRQF_ONESHOT in this case.
> 
> This change is needed to migrate the mei_me driver to
> pci_alloc_irq_vectors() and pci_request_irq().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
usage isn't mentioned in the request_threaded_irq() function doc or
Documentation/

> ---
>  drivers/pci/irq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
> index 2a808e10..a1de501a 100644
> --- a/drivers/pci/irq.c
> +++ b/drivers/pci/irq.c
> @@ -86,13 +86,17 @@ int pci_request_irq(struct pci_dev *dev, unsigned int nr, irq_handler_t handler,
>  	va_list ap;
>  	int ret;
>  	char *devname;
> +	unsigned long irqflags = IRQF_SHARED;
> +
> +	if (!handler)
> +		irqflags |= IRQF_ONESHOT;
>  
>  	va_start(ap, fmt);
>  	devname = kvasprintf(GFP_KERNEL, fmt, ap);
>  	va_end(ap);
>  
>  	ret = request_threaded_irq(pci_irq_vector(dev, nr), handler, thread_fn,
> -			IRQF_SHARED, devname, dev_id);
> +				   irqflags, devname, dev_id);
>  	if (ret)
>  		kfree(devname);
>  	return ret;
> -- 
> 2.18.0
> 
