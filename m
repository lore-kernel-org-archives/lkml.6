Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA43C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7FE25F77
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JBiFTIX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7FE25F77
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964874AbeFYRlO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:41:14 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41927 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934594AbeFYRlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=4ncWY3yoIqsTZRzrosMOkhlxCNbdz7udtVserh4e9v4=;
        b=JBiFTIX5qNZZpg0r1H0njY7t5YDxgjJ72O08If/8bCzVaxfUuhobMAAaMS6hbo74ln16UW9lnJwfm+4Tq3K4707NRNEN1/0TvcNyAqI3ciVhdv+cE/E9grBk8RuoYK8ASjrD/2TcLr3mg59Eqrp6tVJjuiHh6krO/+dHcWEapyI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fXVTU-0004ig-C1; Mon, 25 Jun 2018 19:40:24 +0200
Date:   Mon, 25 Jun 2018 19:40:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing
 at24_platform_data
Message-ID: <20180625174024.GB17417@lunn.ch>
References: <20180625155025.12567-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 05:50:11PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Since I took over maintainership of the at24 driver I've been working
> towards removing at24_platform_data in favor for device properties.
> 
> DaVinci is the only platform that's still using it - all other users
> have already been converted.
> 
> One of the obstacles in case of DaVinci is removing the setup() callback
> from the pdata struct, the only user of which are some davinci boards.

Hi Bartosz

Nice code.

I've got a platform i want to add sometime soon using the at24. I
noticed you doing the cleanup, so i avoided the setup() call. But
using it would of helped...

My platform is x86 based, so no device tree. I instantiate a number of
AT24 devices from a platform driver, and then add nvmem cells so i can
access data in these eeproms. This new code will make this simpler.

> The only board that's still using this callback is now mityomapl138.
> Unfortunately it stores more info in EEPROM than just the MAC address
> and will require some more work. Unfortunately I don't have access
> to this board so I can't test any actual solutions on a live hardware.

Depending on what i find in the EEPROM, i need to instantiate other
i2c devices. So i have the problem of knowing when the EEPROM has
actually probed and i can use the nvmem API to retrieve the contents.

What i have done so far, is registers a bus notifier on i2c_bus_type,
and look for BUS_NOTIFY_BOUND_DRIVER. I can then check if the i2c
client in the notifier is the at24 client. But when i then add more
i2c clients from inside the notifier i get lockdep splats. They are
false positives, but it does suggest it is not a good idea to do this.

So it would be good to have some sort of recommended alternative to
the setup() callback. Ideally it would be specific to a particular
at24, and safe to call other i2c functions from.

Do you have any ideas?

   Andrew
