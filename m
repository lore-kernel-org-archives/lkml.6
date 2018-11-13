Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE407C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E13C2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hp30EoBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E13C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeKNHJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:09:17 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:33813 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeKNHJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=/in2uaQwt9+tHrDZ/YCNyyyAmq0/RftYfmGY491HX+Q=;
        b=Hp30EoBUmi03+i8r5sJT0X+kmpvREhYJbU8UjD9kl+9DmomNsg99m3be/MbicBvrlZjZS0iv5R/13RJJQxgSIomvM3tj5N+5hfzKOI0Xfs34nTLVp2H8zXl8os7tIQB7JsrnDfP4BgudQ5RDXexQ9kRp3wQSIY0x8uHIohkvfBQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gMfvt-0002ng-RM; Tue, 13 Nov 2018 22:09:13 +0100
Date:   Tue, 13 Nov 2018 22:09:13 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH v1] tg3: optionally get mac address from devicetree
Message-ID: <20181113210913.GD9828@lunn.ch>
References: <20181113161508.7427-1-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113161508.7427-1-TheSven73@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int tg3_of_get_macaddr(struct tg3 *tp)
>  {
> -	struct net_device *dev = tp->dev;
> -	struct pci_dev *pdev = tp->pdev;
> -	struct device_node *dp = pci_device_to_OF_node(pdev);
> -	const unsigned char *addr;
> -	int len;
> +	struct device_node *np = pci_device_to_OF_node(tp->pdev);
> +	const void *mac;
>  
> -	addr = of_get_property(dp, "local-mac-address", &len);
> -	if (addr && len == ETH_ALEN) {
> -		memcpy(dev->dev_addr, addr, ETH_ALEN);
> -		return 0;
> -	}
> -	return -ENODEV;
> +	if (!np)
> +		return -ENODEV;
> +	mac = of_get_mac_address(np);
> +	if (!mac || !is_valid_ether_addr(mac))
> +		return -EINVAL;

Hi Sven

If i'm reading of_get_mac_address() correctly, there is no need to
call is_valid_ether_addr() afterwards. It does it already.

     Andrew
