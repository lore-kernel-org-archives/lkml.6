Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F7FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E934020850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jb7ZlkD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E934020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbeGRRID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:08:03 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38742 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731144AbeGRRID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=S2WGeck9CJvob22V0WW66HsQ1t/Ma+gKswxmVDcvHsQ=;
        b=jb7ZlkD9K6wZ3jUgBkjzZ721+VIbAUQnQdJ973RWRsb4n7++VoNLTs//Hz1avqecyvePOTAxavPapRepgV5YIEI0CBXSBfqG75oa9iU1dihL4NzlOXXEGV7d+c8eDInAukyWPRmnssjb65guvH06FZUZSZbfel9mOS/2I84eIKk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ffpJp-000410-Si; Wed, 18 Jul 2018 18:28:49 +0200
Date:   Wed, 18 Jul 2018 18:28:49 +0200
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
Subject: Re: [PATCH 1/5] net: visually shrink eth_platform_get_mac_address()
Message-ID: <20180718162849.GA12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718161035.7005-2-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 06:10:31PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Initialize the variables with proper values so that we save a few
> lines of code before we extend this function in the follow-up patches.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  net/ethernet/eth.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index ee28440f57c5..da8530879e1e 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -527,15 +527,10 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>  
>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  {
> -	const unsigned char *addr;
> -	struct device_node *dp;
> +	struct device_node *dp = dev_is_pci(dev) ?
> +			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
> +	const unsigned char *addr = NULL;

Hi Bartosz

You are now in the net subsystem, which has its own set of additional
coding styles. One of them is reverse Christmas tree.

You might want to read Documentation/networking/netdev-FAQ.txt.

    Andrew
