Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3F1C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2962082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2962082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeJ2CDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:03:48 -0400
Received: from netrider.rowland.org ([192.131.102.5]:50487 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727785AbeJ2CDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:03:48 -0400
Received: (qmail 24232 invoked by uid 500); 28 Oct 2018 13:18:33 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Oct 2018 13:18:33 -0400
Date:   Sun, 28 Oct 2018 13:18:33 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Cherian, George" <George.Cherian@cavium.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>
Subject: Re: [PATCH] xhci: Add quirk to workaround the errata seen on Cavium
 Thunder-X2 Soc
In-Reply-To: <1540661892-189850-1-git-send-email-george.cherian@cavium.com>
Message-ID: <Pine.LNX.4.44L0.1810281305140.23762-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2018, Cherian, George wrote:

> Implement workaround for ThunderX2 Errata-129 (documented in
> CN99XX Known Issues" available at Cavium support site).
> As per ThunderX2errata-129, USB-2.0 device may come up as USB-1.0
> If a connection to a USB-1.0 device is followed by another connection
> to a USB-2.0 device, the link will come up as USB-1.0 for the USB-2.0
> device.
> 
> Resolution: Reset the PHY after the USB1.0 device is disconnected.
> The PHY reset sequence is done using private registers in XHCI register
> space. After the PHY is reset we check for the PLL lock status and retry
> the operation if it fails. From our tests, retrying 4 times is sufficient.
> 
> Add a new quirk flag XHCI_RESET_PLL_ON_DISCONNECT to invoke the workaround
> in handle_xhci_port_status().

Minor nitpick (for both the patch description and the code comments):

USB 1.0 was never widely adopted and is not used any more.  The
earliest vesion of USB currently used in supported devices is USB 1.1.  
Likewise, there are a few devices around that support USB 2.1, not
USB 2.0, but they are presumably also subject to the problem described
above.

I suggest you change the description and the comments to refer to USB 1 
and USB 2 instead of USB 1.0 and USB 2.0, as the latter are too 
restrictive and misleading.

Alan Stern

