Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0F2ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAC021532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAC021532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390634AbeIUVFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:05:47 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:57664 "EHLO
        5.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390361AbeIUVFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:05:46 -0400
X-Greylist: delayed 1810 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2018 17:05:46 EDT
Received: from player798.ha.ovh.net (unknown [10.109.160.12])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 13DEDCB0D8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 16:37:14 +0200 (CEST)
Received: from RCM-web3.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player798.ha.ovh.net (Postfix) with ESMTPSA id 441275400CB;
        Fri, 21 Sep 2018 16:36:51 +0200 (CEST)
Received: from ip-194-187-74-233.konfederacka.maverick.com.pl
 ([194.187.74.233])
 via ip-194-187-74-233.konfederacka.maverick.com.pl
 ([194.187.74.233])
 by mail.ovh.net
 with HTTP (HTTP/1.1 POST); Fri, 21 Sep 2018 16:36:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 21 Sep 2018 16:36:51 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] ARM: add serial.h and set BASE_BAUD to 0
In-Reply-To: <20180921135913.GM30658@n2100.armlinux.org.uk>
References: <20180920201357.16426-1-zajec5@gmail.com>
 <20180921135913.GM30658@n2100.armlinux.org.uk>
Message-ID: <45c1302d81faf4e77555c3710b793d36@milecki.pl>
X-Sender: rafal@milecki.pl
User-Agent: Roundcube Webmail/1.3.7
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
X-Ovh-Tracer-Id: 151433538525236868
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrledvgdekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-21 15:59, Russell King - ARM Linux wrote:
> On Thu, Sep 20, 2018 at 10:13:57PM +0200, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>> 
>> For years arm has been using serial.h from asm-generic which sets
>> BASE_BAUD value to the (1843200 / 16). This is incorrect as:
>> 1) This value obviously isn't correct for all devices
>> 2) There are no device specific serial.h with 
>> CONFIG_ARCH_MULTIPLATFORM
> 
> This goes back a long way.  The BASE_BAUD definition is the base baud
> for 8250 compatible UARTs _only_, no others.
> 
> However, as of 182ead3e418a ("earlycon: Remove hardcoded port->uartclk
> initialization in of_setup_earlycon"), port->uartclk is no longer
> initialised using BASE_BAUD.  As acknowledged in 814453adea7d
> ("earlycon: Initialize port->uartclk based on clock-frequency 
> property")
> the initialisation using BASE_BAUD was bogus, and there is now the
> clock-frequency DT property which should be present to set this up.

Thanks a lot for looking at that. I was not aware of the commit
182ead3e418a ("earlycon: Remove hardcoded port->uartclk initialization
in of_setup_earlycon"), too bad it wasn't marked for stable.

I simply assumed that
port->uartclk = BASE_BAUD * 16;
is correct and that has poisoned all my further reasoning.

I've just confirmed that backporting 182ead3e418a to the 4.14 fixes the
problem for me (it results in the same 8250_early.c behavior as setting
BASE_BAUD to 0).

I'm planning to backport both:
182ead3e418a ("earlycon: Remove hardcoded port->uartclk initialization 
in of_setup_earlycon")
814453adea7d ("earlycon: Initialize port->uartclk based on 
clock-frequency property")
to 4.14+ as they fix regression triggered (not to say "caused") by the
commit 31cb9a8575ca0 ("earlycon: initialise baud field of earlycon
device structure").

Please DROP my serial.h patch and thanks again.


> Now, setting BASE_BAUD to zero as per your patch will break the
> 8250 serial driver - this relies on BASE_BAUD being set to the
> current value, and yes, ARM hardware that uses this will break.  So
> this is not a solution.
> 
> The only solution is that BASE_BAUD must not be abused - it must not
> be used by non-8250 hardware, and thankfully there are already
> solutions in the kernel (such as clock-frequency) to allow the clock
> rate to be specified.

Somehow my serial console kept working with BASE_BAUD set to 0. I'm not
sure why.
