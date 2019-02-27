Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC60C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DCE2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfB0OdB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:33:01 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:39750 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbfB0OdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:33:01 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id D630615632; Wed, 27 Feb 2019 14:32:58 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: set driver_info for SIM5218 and compatibles
References: <20190226170710.12709-1-mans@mansr.com>
        <20190227083342.GJ4747@localhost> <yw1xpnrdv3z7.fsf@mansr.com>
        <20190227131315.GO4747@localhost>
Date:   Wed, 27 Feb 2019 14:32:58 +0000
In-Reply-To: <20190227131315.GO4747@localhost> (Johan Hovold's message of
        "Wed, 27 Feb 2019 14:13:15 +0100")
Message-ID: <yw1xlg21uwrp.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> Adding Bjørn.
>
> On Wed, Feb 27, 2019 at 11:57:16AM +0000, Måns Rullgård wrote:
>> Johan Hovold <johan@kernel.org> writes:
>> 
>> > On Tue, Feb 26, 2019 at 05:07:10PM +0000, Mans Rullgard wrote:
>> >> The SIMCom SIM5218 and compatible devices have 5 USB interfaces, only 4
>> >> of which are serial ports.  The fifth is a network interface supported
>> >> by the qmi-wwan driver.  Furthermore, the serial ports do not support
>> >> modem control signals.  Add driver_info flags to reflect this.
>> >> 
>> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> >> ---
>> >>  drivers/usb/serial/option.c | 3 ++-
>> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
>> >> index fb544340888b..af4cbfecc3ff 100644
>> >> --- a/drivers/usb/serial/option.c
>> >> +++ b/drivers/usb/serial/option.c
>> >> @@ -1066,7 +1066,8 @@ static const struct usb_device_id option_ids[] = {
>> >>  	  .driver_info = RSVD(3) },
>> >>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x6613)}, /* Onda H600/ZTE MF330 */
>> >>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x0023)}, /* ONYX 3G device */
>> >> -	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x9000)}, /* SIMCom SIM5218 */
>> >> +	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x9000), /* SIMCom SIM5218 */
>> >> +	  .driver_info = NCTRL(0) | NCTRL(1) | NCTRL(2) | NCTRL(3) | RSVD(4) },
>> >>  	/* Quectel products using Qualcomm vendor ID */
>> >>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC15)},
>> >>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC20),
>> >
>> > Could you please provide the output of usb-devices (or lsusb -v) for
>> > this device?
>> 
>> lsusb -v:
>> [...]

> So the patch looks fine to me. The fifth interface is QMI, but hasn't
> been available for use until now then, and this seems to have been the
> vendors idea from the start:
>
> 	http://www.microchip.ua/simcom/WCDMA/APPNOTES/SIMCom_3G_Linux_driver_Application%20Note_V1.00.pdf

That document predates the qmi-wwan driver in the kernel.  Note that
this driver has an ID table entry for interface 4 of this device.  Right
now, whichever driver is probed first claims that interface.  I haven't
actually tried using the QMI interface, though.

> And you're seeing errors when opening ports 0-3 due to the DTR calls
> which I guess no one noticed or cared about before?

Right, some userspace tools complain about this.

> Before you sent me the lsusb I searched for it and came across the below
> thread where Bjørn's having a go at SIMCom. In it there's output from a
> second device using the same id but with entirely different descriptors.
>
> 	https://forum.openwrt.org/t/lte-wireless-module-support-by-openwrt-led-on-tplink/13586?page=3
>
> If this is a common theme with this vendor we may need to be extra
> careful when making changes.

Isn't this a common theme with most USB vendors, especially wireless things?

Regardless, setting the NCTRL flag should be harmless.

-- 
Måns Rullgård
