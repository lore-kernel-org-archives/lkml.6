Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232C2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D506C20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D506C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbeGXOHW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:07:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60316 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeGXOHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:07:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B29D120884; Tue, 24 Jul 2018 15:00:56 +0200 (CEST)
Received: from dell-desktop.home (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 678E920731;
        Tue, 24 Jul 2018 15:00:46 +0200 (CEST)
Date:   Tue, 24 Jul 2018 15:00:46 +0200
From:   =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mylene.josserand@free-electrons.com,
        thomas.petazzoni@free-electrons.com,
        maxime.ripard@free-electrons.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Input: Add Cypress Gen5 Touchscreen driver
Message-ID: <20180724150046.7d70786c@dell-desktop.home>
In-Reply-To: <20180704162158.euiw2v3hyv3hzofn@penguin>
References: <20180703094309.18514-1-mylene.josserand@bootlin.com>
        <20180704162158.euiw2v3hyv3hzofn@penguin>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On Wed, 4 Jul 2018 16:21:58 +0000
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Mylène,
> 
> On Tue, Jul 03, 2018 at 11:43:07AM +0200, Mylène Josserand wrote:
> > Hello,
> > 
> > Here is a V6 series to add the driver of the touchscreen Cypress,
> > TrueTouch Generation 5.
> > Based on v4.18-rc3.
> > 
> > This patch series has already been posted in several iterations:
> >     - v1: Sent on 2017/05/29
> >     - v2: Sent on 2017/08/18
> >     - v3: Sent on 2017/09/27
> >     - v4: Sent on 2017/12/01
> >     - v5: Sent on 2017/12/20
> > 
> > I did not have any comments the last 4 versions.
> > And no reviews on my v5 during 6 months. Could I have any updates
> > or feedback on my series to know why it is not merged (to be able to
> > correct what is wrong)?  
> 
> Sorry, I must have missed the v5, sorry about that.
> 
> I probably asked this question before, but just to make sure - I see
> references to HID in the patch - the device is really not HID
> compatible? Is there any hope it could be made work with i2c-hid +
> hid-multitouch?
> 
> Thanks.
> 

I have checked and, for what I have seen, all the HID descriptor stuff
is HID compliant. We could definitely use i2c-hid and hid-multitouch
(there is the "hid-cypress" driver that exists also).

The only problem is that this touchscreen has two modes: a bootloader
mode and an application mode (which is the one where we can send
HID commands). After a power-on-reset, it is always in "bootloader"
mode so we need to send some commands (called "bootloader commands") to
switch to application mode. These commands are not HID-compliant as the
datasheet indicates:

"Bootloader commands are not HID-over-I2C compliant."

I think that if the touchscreen would start directly in "application"
mode, we could directly use i2c-hid and hid-cypress drivers.
Unfortunately, this is not the case.

In bootloader mode, the ProductID is 0xc101 and in application mode, it
is 0xc001 (already available in hid-ids.h:
USB_DEVICE_ID_CYPRESS_TRUETOUCH but not handled)

What would be the better approach here?
Should I add a new product ID to detect the bootloader mode in
hid-cypress driver and send non-HID commands to switch to
"application" mode in this driver?
Anyway, I guess that I will drop this cyttsp5 driver and update the
existing one, right?

Let me know what you think about it.

Thank you in advance,

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
