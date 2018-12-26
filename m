Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DEDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA535214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCdaRM4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeLZTNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:13:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36062 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeLZTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:13:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so16391582wrp.3;
        Wed, 26 Dec 2018 11:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l1drhdPBTUeFwUaO4N7OO6ZAkAHU4ztB+12Yr2qImeA=;
        b=uCdaRM4iIVoHBWNn5OGH+9i+YkRP1yMy8UEpw/Oiu1orXWzMIFBn+fsKfHgExKpApj
         hIh8SJECkx6MxWfQ2HVt8Edp4cQDTXMbMmVrhN8R3VWiDR2EMfiX/VfOdfbcn9Bm4y1I
         tpACuFrklKb0D0oMtCeHhrqiASVEBjS6TNZbo6W7s10Km+p/NkSQJGFi7U+/vSjZa0OQ
         Cdm5tgw8/dKbBCUM8xWO4pTbqbSYj1jIoTM+HkEbPjwcbjvR8LvQCAo1yd39V1Jzmqkg
         LYoIwUgzp/nVDO2ZWl0U/z34GpavfnC4dvq39/JU50p51HhimLYD6ougdUDBOuhIofV8
         tL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l1drhdPBTUeFwUaO4N7OO6ZAkAHU4ztB+12Yr2qImeA=;
        b=epdXbxal/7uxoHCQYUIH10iXHj6BJ0J4EMWWJUzVXQnuDKpfvs9u3bg3NSKNnyG4RM
         B4vUl2/RtSELZUG9L7M1Ax5oBNgN5SmS+FT3EfsWdhqPkZXIkCNm6DfbEfjbw3efbOKk
         TDX5Dd++UIhSrYpvUYNKPewrMUI9N7QcXBcruv3X3Zk/6jwkwacEgWA/YVs8BpGldDfs
         zGDuw0GTlfuGTzYus/mVY9thez0tR5DcoUWF9ngSSjAloehQe+8XlyHd/tQJBEAJOQvZ
         smnomofhT4A9UTYlSNS7VFCrPPRHFga05a94Pa8W/ymm+bVZpSTPe9He9ExWSU7AO0dK
         6+7g==
X-Gm-Message-State: AJcUukc3oyczR3nK5k56dHq6wrc8AXZIUPa7YJ8fMOt2a4gpXJ4q0rP3
        fC1TgcRo/QnogTmPNQD6H+h7hc8A
X-Google-Smtp-Source: ALg8bN4gpyS6L5fTMS59W6y+gyjUWeIaFAe37ATRAuhax9XPCbH18XSqS04NseKdr2t2ns1CJxwQHA==
X-Received: by 2002:a5d:4202:: with SMTP id n2mr19500539wrq.260.1545851598949;
        Wed, 26 Dec 2018 11:13:18 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:6194:598:7f5e:b2e? (p200300EA8BCFE300619405987F5E0B2E.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:6194:598:7f5e:b2e])
        by smtp.googlemail.com with ESMTPSA id w18sm4208320wmi.12.2018.12.26.11.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 11:13:18 -0800 (PST)
Subject: Re: [PATCH] net: dsa: bcm_sf2: Propagate error value from mdio_write
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181226182132.76798-1-kjlu@umn.edu>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <4f6199de-51c4-4446-3ad3-6b036a09a63c@gmail.com>
Date:   Wed, 26 Dec 2018 20:13:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181226182132.76798-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.12.2018 19:21, Kangjie Lu wrote:
> Both bcm_sf2_sw_indir_rw and mdiobus_write_nested could fail, so let's
> return their error codes upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/dsa/bcm_sf2.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
> index 2eb68769562c..236815700fba 100644
> --- a/drivers/net/dsa/bcm_sf2.c
> +++ b/drivers/net/dsa/bcm_sf2.c
> @@ -303,11 +303,10 @@ static int bcm_sf2_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
>  	 * send them to our master MDIO bus controller
>  	 */
>  	if (addr == BRCM_PSEUDO_PHY_ADDR && priv->indir_phy_mask & BIT(addr))
> -		bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
> +		return bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
This is wrong. Please get familiar with what the function does.
And test changes before submitting them!

>  	else
> -		mdiobus_write_nested(priv->master_mii_bus, addr, regnum, val);
> -
> -	return 0;
> +		return mdiobus_write_nested(priv->master_mii_bus,
> +				addr, regnum, val);
>  }
>  
>  static irqreturn_t bcm_sf2_switch_0_isr(int irq, void *dev_id)
> 

