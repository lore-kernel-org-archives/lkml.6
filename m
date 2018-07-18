Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40682ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F942075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d1hLQPbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F942075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeGRRnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:43:05 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38881 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeGRRnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Ce2jMyJ2HvLdxOv1JzTEhfe5lqUbffNf96beyj1w3eQ=;
        b=d1hLQPbuxrYSBigwOTkAiXhWePpz0zdySrJlAeUUovJ9Rc6oGhMDsU6nsuSk8/+d65DKXKfNaM7PieVCNHKk0SuKJvMt2ZoJzvJ2mBURyIpvqycQtjjUwYuPfAlMh5wCFo+70lWM3XzXC2UeMIAuTEic+v8OrUAsnlsQ9mDbljE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ffprk-0004ng-U0; Wed, 18 Jul 2018 19:03:52 +0200
Date:   Wed, 18 Jul 2018 19:03:52 +0200
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 5/5] net: add MTD support to
 eth_platform_get_mac_address()
Message-ID: <20180718170352.GF12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-6-brgl@bgdev.pl>
 <20180718164737.GE12477@lunn.ch>
 <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +#ifdef CONFIG_MTD
> >> +     /* NOTE: this should go away as soon as MTD gets nvmem support. */
> >> +     if (!addr) {
> >> +             struct mtd_info *mtd;
> >> +             int rv;
> >> +
> >> +             mtd = get_mtd_device_nm("MAC-Address");
> >
> > In order for this to go away, you need to keep backwards
> > compatibility. When using nvmem, you look for a cell called
> > "mac-address". Here you are looking for "MAC-Address". That is going
> > to make backwards compatibility harder. How do you plan to do it?
> >
> >    Andrew
> 
> I'm trying to adjust to already existing users. The only user of
> get_mtd_device_nm() who calls it to read the MAC address registers a
> partition called "MAC-Address". We can't change it since it's visible
> from user space. In the future we'd just have to have a list of
> supported string that we'd use to do the nvmem lookup.

Why not have the nvmem cell called "MAC-Address"? When you add nvmem
support to MTD, i assume you are going to map each MTD partition to an
nvmem cell?

    Andrew
