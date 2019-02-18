Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F37C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22388214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfBRKdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:33:05 -0500
Received: from icebox.esperi.org.uk ([81.187.191.129]:49550 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBRKdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:33:05 -0500
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id x1IASFBg024635;
        Mon, 18 Feb 2019 10:28:15 GMT
From:   Nix <nix@esperi.org.uk>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 4.20.7: pl2303 not working (post-4.19 regression) (limited info so far, not yet bisected)
References: <87o97bu2bt.fsf@esperi.org.uk> <20190216194758.GA10756@kroah.com>
        <877edytehb.fsf@esperi.org.uk> <20190218075851.GA4072@localhost>
Emacs:  The Awakening
Date:   Mon, 18 Feb 2019 10:32:57 +0000
In-Reply-To: <20190218075851.GA4072@localhost> (Johan Hovold's message of
        "Mon, 18 Feb 2019 08:58:51 +0100")
Message-ID: <87sgwls7xi.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC-wuwien-Metrics: loom 1290; Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Feb 2019, Johan Hovold stated:

> On Sun, Feb 17, 2019 at 07:13:52PM +0000, Nix wrote:
>> I'm still fairly sure this is a regression -- my machines are often up
>> for a lot longer than that and I've never seen this before I upgraded to
>> 4.20.x -- but I don't think I'm going to identify it by mindless
>> bisection. I might have to actually *think* about it.
>
> I doubt it's a regression in usb-serial as essentially nothing changed
> with respect to pl2303 or core since 4.19.

Yeah, I came to that conclusion as well.

> The -ENOSPC you're seeing is returned by the host controller to
> indicate:
>
> 	This request would overcommit the usb bandwidth reserved for
> 	periodic transfers (interrupt, isochronous).

Side note: probably not related to *this* -ENOSPC, which I've been
seeing for a few releases now and which appears to break Chromium's U2F
negotiation when the USB bus has sufficiently weird devices on it (like,
uh, my wireless mouse):

<https://bugs.chromium.org/p/chromium/issues/detail?id=932699>

(I say "probably not related" because it's much older and long predates
the pl2303 trouble.)

> but if you're saying you can reproduce this on "every box" it may not be
> related to any particular host-controller driver (or USB topology).

They are all xhci, at least. The pl2303 is USB 2. One machine, a
two-year-old Broadwell server, says:

xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
xhci_hcd 0000:00:14.0: cache line size of 32 is not supported
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 15 ports detected
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpeed

00:14.0 USB controller: Intel Corporation C610/X99 series chipset USB xHCI Host Controller (rev 05) (prog-if 30 [XHCI])

The other, a 2012-era cheapish Ivy Bridge workstation:

xhci_hcd 0000:03:00.0: xHCI Host Controller
xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 3
xhci_hcd 0000:03:00.0: hcc params 0x014042cb hci version 0x96 quirks 0x0000000000000004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
xhci_hcd 0000:03:00.0: xHCI Host Controller
xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 4
xhci_hcd 0000:03:00.0: Host supports USB 3.0  SuperSpeed
usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
xhci_hcd 0000:04:00.0: xHCI Host Controller
xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 5
xhci_hcd 0000:04:00.0: hcc params 0x0200f180 hci version 0x96 quirks 0x0000000000080000
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
xhci_hcd 0000:04:00.0: xHCI Host Controller
xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 6
xhci_hcd 0000:04:00.0: Host supports USB 3.0  SuperSpeed
usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.

03:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
04:00.0 USB controller: ASMedia Technology Inc. ASM1042 SuperSpeed USB Host Controller (prog-if 30 [XHCI])

(I really don't know which of these is which. I suspect only one
actually has any visible ports on the outside of the case...)

So the quirks are all totally different, and the controllers are quite
different as well...
