Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AA3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87AF26B36
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ruGx6At5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87AF26B36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935727AbeFZNWa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:22:30 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43144 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934072AbeFZNW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=1RtGiqngBGFkwxljYphBnqkSXn1iaUIRFutUlyri9vw=;
        b=ruGx6At5gZYdlwIEvdnumxcXqNfLBaU1S0FPbbAVL+XH81uo1NTjs2+uFFdZOgoWE1iAX6cVyBnRHkMtsDOGTUdxjIvYa0ZD1J0eUvkFaFXFHiSs89z8oMCRGsAAlKq3XPzNLrdtmTD3DUzMUtSBlQWKIg7Z57SADgHnGVf1hl0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fXnus-0001P5-2H; Tue, 26 Jun 2018 15:21:54 +0200
Date:   Tue, 26 Jun 2018 15:21:54 +0200
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
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing
 at24_platform_data
Message-ID: <20180626132154.GA5064@lunn.ch>
References: <20180625155025.12567-1-brgl@bgdev.pl>
 <20180625174024.GB17417@lunn.ch>
 <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com>
 <20180625180237.GC17417@lunn.ch>
 <CAMRc=MejDn=t6EPbKOfhMfRAb_O-5hxtWRyjAWH1mb5BUySrDA@mail.gmail.com>
 <20180626083823.GA28068@lunn.ch>
 <CAMRc=Mdvh+1enpD3qDoamhPfaBPin2v3amneQELApgoC0bS2FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mdvh+1enpD3qDoamhPfaBPin2v3amneQELApgoC0bS2FQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I see. I see it this way: the setup callback comes from the time when
> we didn't have nvmem and should go away. I will protest loud whenever
> someone will try to use it again and will work towards removing it as
> soon as possible.

The setup() callback could be moved into the nvmem framework, rather
than in the at24 driver. Make the call when the cells have been
connected to the backing store.

> I will give your problem a thought and will try to get back with some
> proposals - maybe we should, as you suggested, extend nvmem even
> further to allow to remove nvmem info entries etc.

That does not help me too much. I have the same problem with i2c and
MDIO. So i actually prefer to keep this the same as all others.

	Andrew
