Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeEGGzN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:55:13 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:32426 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeEGGzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:55:10 -0400
From: "Reizer, Eyal" <eyalr@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: Eyal Reizer <eyalreizer@gmail.com>,
        "bcousson@baylibre.com" <bcousson@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Loewy, Chen" <c-loewy@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH] arm: dts: am437x-sk-evm: add wilink8
 support
Thread-Topic: [EXTERNAL] Re: [PATCH] arm: dts: am437x-sk-evm: add wilink8
 support
Thread-Index: AQHT4umNrIAS1VNvUkK07yas+IZ4paQiVQFAgADvToCAAJCfoA==
Date: Mon, 7 May 2018 06:55:03 +0000
Message-ID: <a4dd3009f0f5492d8756f42c11590423@ti.com>
References: <1525159453-32489-1-git-send-email-eyalr@ti.com>
 <20180502145100.GK98604@atomide.com>
 <5cc906da15da45ab96e06957f878b65b@ti.com>
 <20180503141759.GP98604@atomide.com>
 <f0ea5260b3e2413aab4780b203ff24a4@ti.com>
 <20180506165621.GL98604@atomide.com>
In-Reply-To: <20180506165621.GL98604@atomide.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.167.25.139]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w476tIcL001466

Hi Tony,

> 
> Yeah my guess is that the reason for the separate GPIO interrupt was
> that on omap3 we did not have SDIO interrupt working for years. This was
> because of the issues related to padconf interrupts for off mode.
> 
> We now have Linux generic wakeirq support working with SDIO and it has
> been confirmed to work also for off mode with mwifiex at least. So
> there should be no reason to not also use the SDIO interrupt.
> 

There is more to this than just the padconf.
Using in-band interrupt instead of the out of band one requires
Supporting a feature called "Asynchronous interrupts in 4Bit mode"
Which is part of SDIO 3.0 spec:
https://www.sdcard.org/downloads/pls/pdf/index.php?p=PartE1_SDIO_Simplified_Specification_Ver3.00.jpg&f=PartE1_SDIO_Simplified_Specification_Ver3.00.pdf&e=EN_SSE1

Take a look at page 41 at the bottom part of the table.
Wilink8 supports this feature but AFAIK this support is still not part of the 
mmc/sdio core in the Linux kernel.
If we want wilink8 to trigger a host wakeup using the in-band interrupt instead 
Of the wlan_irq pin we would need to enable/use this feature.

I did use it internally in the past and was able to patch the Ubuntu kernel 
(3.5.0 at that time) to use wilink8 in a standard SD Card slot of an Ubuntu Laptop 
while removing the use of wlan_irq pin completely.
However this was an experimental patch set written by a third party 
that was not up-steamtable at that time.
I do have this patch set somewhere...

It is similar to the following patch which is not  upstream as well for some reason:
https://gitlab.com/k2wl/g2_kernel/commit/5c4970fdaa50422d7ea7220efa20fb35148a4bca
It is not the only patch needed, there are a couple of additional patches needed 
for fully using it from driver.
I did check latest Linux-next and don't see this support there. Not sure why.

Best Regards,
Eyal
