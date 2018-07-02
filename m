Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87A2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F016242DF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F016242DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbeGBPp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:45:29 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38832 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1752216AbeGBPp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:45:27 -0400
Received: (qmail 3168 invoked by uid 2102); 2 Jul 2018 11:45:26 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Jul 2018 11:45:26 -0400
Date:   Mon, 2 Jul 2018 11:45:26 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] usb/host/pci-quirks: Only reset USB bus on NVIDIA devices
In-Reply-To: <20180701211607.7833-1-pmenzel@molgen.mpg.de>
Message-ID: <Pine.LNX.4.44L0.1807021135320.1574-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jul 2018, Paul Menzel wrote:

> Currently, on the AMD board Asus F2A85-M Pro there is a 100 ms delay as
> the USB bus of each of the two OHCI PCI devices is reset. As a 50 ms
> delay is done per the USB specification.
> 
> Commit c6187597 (OHCI: final fix for NVIDIA problems (I hope))
> unconditionally does the bus reset for
>  all chipsets, while it was only doen for NVIDIA chipsets before.

I don't follow this at all.  Prior to that commit, the bus reset (i.e.,

	writel(control & OHCI_CTRL_MASK, base + OHCI_CONTROL);

) was performed unconditionally for _all_ controllers.  (However, the
50-ms delay was used only for NVIDIA hardware.)  Following that commit,
the reset is performed for all controllers, but only if the HCFS
bitfield is nonzero.

> As it should not be needed for non-NVIDIA chipsets, only do the reset
> for Nvidia devices.

Therefore this reasoning is wrong.

> Tested on Asus F2A85-M PRO and ASRock E350M1. The USB keyboard works and
> the LUKS passphrase can be e
> ntered.

Unfortunately, there is a wide variety of OHCI controller hardware 
available.  Something that works on one or two controllers might not 
work on another.

Besides, doesn't it seem like a bad idea to reset the controller while 
leaving devices on the USB bus in whatever state they happened to be?

Alan Stern

> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  drivers/usb/host/pci-quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 3625a5c1a41b..f6b1a9bbe301 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -784,7 +784,7 @@ static void quirk_usb_handoff_ohci(struct pci_dev *pdev)
>  	writel((u32) ~0, base + OHCI_INTRDISABLE);
>  
>  	/* Reset the USB bus, if the controller isn't already in RESET */
> -	if (control & OHCI_HCFS) {
> +	if ((pdev->vendor == PCI_VENDOR_ID_NVIDIA) && (control & OHCI_HCFS)) {
>  		/* Go into RESET, preserving RWC (and possibly IR) */
>  		writel(control & OHCI_CTRL_MASK, base + OHCI_CONTROL);
>  		readl(base + OHCI_CONTROL);
> 

