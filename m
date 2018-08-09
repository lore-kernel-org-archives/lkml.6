Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11024C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1DF21F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyTtyrc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1DF21F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeHIXmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbeHIXmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:42:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 517B021DEC;
        Thu,  9 Aug 2018 21:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533849344;
        bh=ed81Oj3ZuxmDVDxhz/9129BLm9Hs+9Tkl7+lVzkDImI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IyTtyrc9+sTJVWVxHTBlTXh8Ef3UkXUBfZTe0cK4q41B81oe4xWuyBJaUcrYiT6fg
         t3sT43VE+VfDEHOdd/9AetQGMB1NP3reaLtjlv4xfXZJRGgibygarLXdq+j6KHjcAv
         OZnDvN/RJv+MythONVoolBQa04b6xVz2d/1Isi/w=
Date:   Thu, 9 Aug 2018 16:15:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v8 1/4] PCI: Make specifying PCI devices in kernel
 parameters reusable
Message-ID: <20180809211541.GF113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180730161840.13733-1-logang@deltatee.com>
 <20180730161840.13733-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180730161840.13733-2-logang@deltatee.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:18:37AM -0600, Logan Gunthorpe wrote:
> Separate out the code to match a PCI device with a string (typically
> originating from a kernel parameter) from the
> pci_specified_resource_alignment() function into its own helper
> function.
> 
> While we are at it, this change fixes the kernel style of the function
> (fixing a number of long lines and extra parentheses).
> 
> Additionally, make the analogous change to the kernel parameter
> documentation: Separating the description of how to specify a PCI device
> into it's own section at the head of the pci= parameter.
> 
> This patch should have no functional alterations.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  28 ++++-
>  drivers/pci/pci.c                               | 157 ++++++++++++++++--------
>  2 files changed, 126 insertions(+), 59 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 533ff5c68970..5cc215870ee1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2994,7 +2994,26 @@
>  			See header of drivers/block/paride/pcd.c.
>  			See also Documentation/blockdev/paride.txt.
>  
> -	pci=option[,option...]	[PCI] various PCI subsystem options:
> +	pci=option[,option...]	[PCI] various PCI subsystem options.
> +
> +				Some options herein operate on a specific device
> +				or a set of devices (<pci_dev>). These are
> +				specified in one of the following formats:
> +
> +				[<domain>:]<bus>:<slot>.<func>
> +				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> +
> +				Note: the first format specifies a PCI
> +				bus/slot/function address which may change

Unless you object, I'm going to change "slot" references like this to
"device" so they match "BDF" and the language in the spec, which uses
"slot" to refer to a physical slot and "device" when referring to
geographical device addresses.  I can do this when I apply these, so
no need for you to repost them.

Bjorn
