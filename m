Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31A1ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3023821523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iBLegTX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3023821523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389804AbeIUTsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:48:35 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54280 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbeIUTse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5uaSylfbfLi6kI0jHSRGFH9EWLBbXQcBFY+uD4X453Q=; b=iBLegTX2NS/pqE3tyUZ/nv2Bb
        VmYMPYJzbcUzxTXB6TJ0oGIv/tXWpe7xKF+AeZQ6VSaXC7ux4dGKZx2/uqVTxIXqR2lpPQQZ9ILnJ
        xz9EYTnL4+x/dzNdoUuEayW0cB8XnAHS37niXvkxtLuIabIiRU8J0Q2620ZIYnFELz7+U=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:49226)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g3Lxq-0001Bm-PT; Fri, 21 Sep 2018 14:59:22 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g3Lxl-0001SX-KI; Fri, 21 Sep 2018 14:59:18 +0100
Date:   Fri, 21 Sep 2018 14:59:14 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] ARM: add serial.h and set BASE_BAUD to 0
Message-ID: <20180921135913.GM30658@n2100.armlinux.org.uk>
References: <20180920201357.16426-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180920201357.16426-1-zajec5@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:13:57PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> For years arm has been using serial.h from asm-generic which sets
> BASE_BAUD value to the (1843200 / 16). This is incorrect as:
> 1) This value obviously isn't correct for all devices
> 2) There are no device specific serial.h with CONFIG_ARCH_MULTIPLATFORM

This goes back a long way.  The BASE_BAUD definition is the base baud
for 8250 compatible UARTs _only_, no others.

However, as of 182ead3e418a ("earlycon: Remove hardcoded port->uartclk
initialization in of_setup_earlycon"), port->uartclk is no longer
initialised using BASE_BAUD.  As acknowledged in 814453adea7d
("earlycon: Initialize port->uartclk based on clock-frequency property")
the initialisation using BASE_BAUD was bogus, and there is now the
clock-frequency DT property which should be present to set this up.

Now, setting BASE_BAUD to zero as per your patch will break the
8250 serial driver - this relies on BASE_BAUD being set to the
current value, and yes, ARM hardware that uses this will break.  So
this is not a solution.

The only solution is that BASE_BAUD must not be abused - it must not
be used by non-8250 hardware, and thankfully there are already
solutions in the kernel (such as clock-frequency) to allow the clock
rate to be specified.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
