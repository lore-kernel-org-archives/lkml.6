Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1564C20652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ia3MgcHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1564C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbeGRR0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:26:45 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38846 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbeGRR0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=RE8V0KcVKk5nvOfgE8iS5sHYMw5F9tbllbf5ZaROLsE=;
        b=Ia3MgcHFC86NwHznKPhpEGLX5gmhmaW7cF7hcDaYvMA6gqp7/mVdGJZNkCqlQCd+IN2WRMXKVtuxc5+cXJqmq62882pgdjoykBpwer/C8TTfqiplkKSvQzYtZnVIx93/DLXw6zccFOksDg4S6diBptctJxd6pCx9x7c2+tmwqRs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ffpc1-0004IB-9x; Wed, 18 Jul 2018 18:47:37 +0200
Date:   Wed, 18 Jul 2018 18:47:37 +0200
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
Subject: Re: [PATCH 5/5] net: add MTD support to
 eth_platform_get_mac_address()
Message-ID: <20180718164737.GE12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718161035.7005-6-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 06:10:35PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> MTD doesn't support nvmem yet. Some platforms use MTD to read the MAC
> address from SPI flash. If we want this function to generalize reading
> the MAC address, we need to separately try to use MTD.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  net/ethernet/eth.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index adf5bd03851f..f7dbd2cff7f9 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -55,6 +55,7 @@
>  #include <linux/of_net.h>
>  #include <linux/pci.h>
>  #include <linux/nvmem-consumer.h>
> +#include <linux/mtd/mtd.h>
>  #include <net/dst.h>
>  #include <net/arp.h>
>  #include <net/sock.h>
> @@ -573,6 +574,25 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  		}
>  	}
>  
> +#ifdef CONFIG_MTD
> +	/* NOTE: this should go away as soon as MTD gets nvmem support. */
> +	if (!addr) {
> +		struct mtd_info *mtd;
> +		int rv;
> +
> +		mtd = get_mtd_device_nm("MAC-Address");

In order for this to go away, you need to keep backwards
compatibility. When using nvmem, you look for a cell called
"mac-address". Here you are looking for "MAC-Address". That is going
to make backwards compatibility harder. How do you plan to do it?

   Andrew
