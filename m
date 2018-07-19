Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9947ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCEF20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TPuhdqAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCEF20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbeGSQGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:06:30 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40198 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731369AbeGSQG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=YCaJxcZSU5hdv4YnUh3DQ1JUXLcIOJU8T1V161rc0R4=;
        b=TPuhdqAyZmdEaoDgJaJ1bFuL9nv1n7RPn8AQh0xnn1EIrV8PcoNos0NlRcB3wb/1A9WMAmJxnXq8cZMSiqgzQ9MNObRTARJWnHpq0GL5Qht21KGgojj1ygPo4sl7jUVycckSpDUwMlKr6QdncbXgV5hCZy6xpIVkpTksY1EilNQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fgAl4-0002ln-J8; Thu, 19 Jul 2018 17:22:22 +0200
Date:   Thu, 19 Jul 2018 17:22:22 +0200
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
Message-ID: <20180719152222.GD9119@lunn.ch>
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

On Wed, Jul 18, 2018 at 06:10:34PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Many non-DT platforms read the MAC address from EEPROM. Usually it's
> either done with callbacks defined in board files or from SoC-specific
> ethernet drivers.
> 
> In order to generalize this, try to read the MAC from nvmem in
> eth_platform_get_mac_address() using a standard lookup name:
> "mac-address".
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  net/ethernet/eth.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index 6b64586fd2af..adf5bd03851f 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -54,6 +54,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/of_net.h>
>  #include <linux/pci.h>
> +#include <linux/nvmem-consumer.h>
>  #include <net/dst.h>
>  #include <net/arp.h>
>  #include <net/sock.h>
> @@ -530,7 +531,10 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  	struct device_node *dp = dev_is_pci(dev) ?
>  			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
>  	const unsigned char *addr = NULL;
> +	unsigned char addrbuf[ETH_ALEN];
> +	struct nvmem_cell *nvmem;
>  	const char *from = NULL;
> +	size_t alen;
>  
>  	if (dp) {
>  		addr = of_get_mac_address(dp);
> @@ -544,6 +548,31 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  			from = "arch callback";
>  	}
>  
> +	if (!addr) {
> +		nvmem = nvmem_cell_get(dev, "mac-address");
> +		if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)

How does EPROBE_DEFER work here? You say the use case is
Non-DT. Without having DT, how do you know the cell should exist, but
does not yet exist? I might be looking at old code, but i only see
-EPROBE_DEFER inside the if (np) case.

> +			/* We may have a lookup registered for MAC address but
> +			 * the corresponding nvmem provider hasn't been
> +			 * registered yet.
> +			 */
> +			return -EPROBE_DEFER;

You really should return real errors. If i'm reading
__nvmem_device_get() right, it will return a NULL pointer when the
cell does not exist. NULL is not an error, so IS_ERR() will return
false. So you should return all errors from nvmem_cell_get().

       Andrew
