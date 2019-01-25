Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421A0C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081A1218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ad1+QzPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfAYO5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:57:16 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55715 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfAYO5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JnYZe81m8mRJ5RfUEA8Um5lzxmgxWGE0ky+A7rSf9uA=; b=ad1+QzPia0EJgCcCaEbpXCUvQc
        zuFsdQbmHa6DdLScnS6Hln9tqtKk9llhW0X81jR08UjsqLMpFL4FlqP2Xnwy90GuLaZm4LlgVeA9B
        exiLAfRT4VDrBGuMyJzwrzfmUiG86wOMrlCmCZ2oM9wYkFvpLOdrM5VbpYJWNpGiHuiw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gn2ut-0004QH-2Z; Fri, 25 Jan 2019 15:57:11 +0100
Date:   Fri, 25 Jan 2019 15:57:11 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: Load MAC address from device tree if present
Message-ID: <20190125145711.GF12962@lunn.ch>
References: <20190125101814.6262-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125101814.6262-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:18:14AM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> If the system was booted using a device tree and if the device tree
> contains a MAC address, use it instead of reading one from the EEPROM.
> This is useful in situations where the EEPROM isn't properly programmed
> or where the firmware wants to override the existing MAC address.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Based on net-next.
> 
>  drivers/net/ethernet/realtek/r8169.c | 35 +++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index f574b6b557f9..fd9edd643ca5 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -6957,6 +6957,21 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
>  }
>  
> +static void rtl_read_mac_address(struct rtl8169_private *tp,
> +				 u8 mac_addr[ETH_ALEN])
> +{
> +	/* Get MAC address */
> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
> +	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
> +		*(u32 *)&mac_addr[0] = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
> +		*(u16 *)&mac_addr[4] = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  DECLARE_RTL_COND(rtl_link_list_ready_cond)
>  {
>  	return RTL_R8(tp, MCU) & LINK_LIST_RDY;
> @@ -7148,6 +7163,7 @@ static int rtl_get_ether_clk(struct rtl8169_private *tp)
>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
> +	u8 mac_addr[ETH_ALEN] __aligned(4);

Hi Thierry

Maybe now would be a good time to cleanup this __aligned(4), pointer
aliasing, etc?

> +	/* get MAC address */
> +	if (eth_platform_get_mac_address(&pdev->dev, mac_addr))
> +		rtl_read_mac_address(tp, mac_addr);
> +

Maybe that could be made more readable with:

      err = eth_platform_get_mac_address(&pdev->dev, mac_addr);
      if (err)
      	 	rtl_read_mac_address(tp, mac_addr);

Thanks
	Andrew
