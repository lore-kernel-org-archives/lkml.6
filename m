Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907C8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3466A20857
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DFKvhNg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3466A20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbeGRRV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:21:26 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38825 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730897AbeGRRV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=+Bwwb0t8beQe43hJEUdWtX7lxnkLSP0zlUepbeC+z98=;
        b=DFKvhNg4d6tFI3HqC75eIffPVKI+puUKbDAUMl24puOSMSmIi3LmbNmuXdSxKAm7/j2alNXRw0zxwzlOGwQ4UAd9YTtzZ1HV+GSUbnrrni2eTRbPFsxdSiXJ470bu9YxOLo0PQcNneaYyiyR1s5IaYBUcExZG7vXZ7BnDdWJ09M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ffpWs-0004Ea-Id; Wed, 18 Jul 2018 18:42:18 +0200
Date:   Wed, 18 Jul 2018 18:42:18 +0200
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
Subject: Re: [PATCH 4/5] net: add support for nvmem to
 eth_platform_get_mac_address()
Message-ID: <20180718164218.GD12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718161035.7005-5-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		if (!IS_ERR(nvmem)) {
> +			addr = nvmem_cell_read(nvmem, &alen);
> +			if (!IS_ERR(addr)) {
> +				from = "nvmem";
> +				/* Don't use ether_addr_copy() in case we
> +				 * didn't get the right size.
> +				 */

Please verify the size. A short read can still give a valid MAC
address, so the is_valid_ether_addr(addr) is not sufficient.

> +				memcpy(addrbuf, addr, alen);

Another reason to check the length is that you appear to have a buffer
overflow here, if alen > 6.

	 Andrew

> +				kfree(addr);
> +				addr = addrbuf;
> +			}
> +
> +			nvmem_cell_put(nvmem);
> +		}
> +	}
> +
>  	if (!addr || !is_valid_ether_addr(addr))
>  		return -ENODEV;
>  
> -- 
> 2.17.1
> 
