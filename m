Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D8C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2195820892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2195820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbeKHB6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:58:31 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:47698 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731373AbeKHB6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:58:31 -0500
Received: (qmail 3451 invoked by uid 2102); 7 Nov 2018 11:27:26 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Nov 2018 11:27:26 -0500
Date:   Wed, 7 Nov 2018 11:27:26 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Al Cooper <al.cooper@broadcom.com>
cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        <linux-kernel@vger.kernel.org>, Alban Bedel <albeu@free.fr>,
        Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        <devicetree@vger.kernel.org>, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, <linux-usb@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH V3 4/6] usb: ohci-platform: Add support for Broadcom STB
 SoC's
In-Reply-To: <e4f2a868-c265-58c8-7b7b-91de91f2cf0b@broadcom.com>
Message-ID: <Pine.LNX.4.44L0.1811071124260.1542-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018, Al Cooper wrote:

> On 11/7/18 10:23 AM, Alan Stern wrote:
> > On Tue, 6 Nov 2018, Florian Fainelli wrote:
> > 
> >> On 11/6/18 1:40 PM, Al Cooper wrote:
> >>> On 11/6/18 11:08 AM, Alan Stern wrote:
> >>>> On Mon, 5 Nov 2018, Al Cooper wrote:
> >>>>
> >>>>> Add support for Broadcom STB SoC's to the ohci platform driver.
> >>>>>
> >>>>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> >>>>> ---
> >>>>
> >>>>> @@ -177,6 +189,8 @@ static int ohci_platform_probe(struct
> >>>>> platform_device *dev)
> >>>>>            ohci->flags |= OHCI_QUIRK_FRAME_NO;
> >>>>>        if (pdata->num_ports)
> >>>>>            ohci->num_ports = pdata->num_ports;
> >>>>> +    if (pdata->suspend_without_phy_exit)
> >>>>> +        hcd->suspend_without_phy_exit = 1;
> >>>>
> >>>> Sorry if I missed this in the earlier discussions...  Is there any
> >>>> possibility of adding a DT binding that could express this requirement,
> >>>> instead of putting it in the platform data?
> >>>>
> >>>> Alan Stern
> >>>>
> >>>
> >>> Alan,
> >>>
> >>> That was my original approach but internal review suggested that I use
> >>> pdata instead. Below is my original patch for:
> >>
> >> And the reason for that suggestion was really because it was percevied
> >> as encoding a driver behavior as a Device Tree property as opposed to
> >> describing something that was inherently and strictly a hardware
> >> behavior (therefore suitable for Device Tree).
> > 
> > Right.  The best way to approach this problem is to identify and
> > characterize the hardware behavior which makes this override necessary.
> > Then _that_ can be added to DT, since it will be a property of the
> > hardware rather than of the driver.
> > 
> >>> Add the ability to skip calling the PHY's exit routine on suspend
> >>> and the PHY's init routine on resume. This is to handle a USB PHY
> >>> that should have it's power_off function called on suspend but cannot
> >>> have it's exit function called because on exit it will disable the
> >>> PHY to the point where register accesses to the Host Controllers
> >>> using the PHY will be disabled and the host drivers will crash.
> > 
> > What's special about this PHY?  Why does the exit function mess the PHY
> > up?  Or to put it another way, why doesn't the exit function mess up
> > other PHYs in the same way?
> > 
> > For that matter, can we change the code so that suspend doesn't call
> > the exit function for _any_ PHY?  Will just calling the power_off
> > function be good enough?  If not, then why not?
> > 
> > Alan Stern
> > 
> 
> In our USB hardware the USB PHY supplies a clock for the EHCI/OHCI and 
> XHCI host controllers and if the PHY is totally shut down the EHCI, OHCI 
> and XHCI registers will cause an exception if accessed and cause the 
> EHCI, OHCI and XHCI drivers to crash. There is always talk of fixing 
> this in the hardware by adding an aux clock that will takeover when the 
> PHY clock is shut down, but this hasn't happened yet. It seems like 
> "exit on suspend" still makes sense on systems that don't have this 
> problem (additional power savings?) so removing the exit on suspend for 
> all systems is not a good idea.

Then in theory you should be able to add a Device Tree property which
says that the PHY provides a clock for the USB host controller.  That
is strictly a property of the hardware; it has nothing to do with the
driver.  Therefore it is appropriate for DT.

Wouldn't this solve your issue?

Alan Stern

