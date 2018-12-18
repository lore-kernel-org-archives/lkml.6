Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB28C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A57A21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+md+rzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeLRSPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:15:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55284 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeLRSPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:15:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so3616452wmh.4;
        Tue, 18 Dec 2018 10:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GVyWA65HXd1M/50UINW5Q7Np/vFk9ToXcmBqSOJROjM=;
        b=B+md+rzU36T1mdkqANC4ixQskiu5oxWyk1G6JzHiWmI2Zj13GvKusCO90KFvzJV1ZW
         SBS76yjmilRbsHbI0kLXl93VfUk4cuF0SA8oNS0zV/kt+nqBcarOIGOB2rNn8PRy3ivB
         /HnnGAq2zVLQoanjSyEB3OkYVuaAliXeKDB6znZWPH7af4NhpCv/l0mXjS7ldbmn1b5Q
         yYZ8pNxCLcjONsl9FY1XM7Ch31rCPh3T/Np60kDHrzUU43dSov3A1P1SfA+67QWlp2BX
         N4FHvn+sjZqxR2FxVD4VrS0lKHAhHe2z7ULfGwhhltuTHO7PIj6ykQbUp+cKGH9FNcCg
         AO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GVyWA65HXd1M/50UINW5Q7Np/vFk9ToXcmBqSOJROjM=;
        b=dMOikT1/mF5pujnejENLd05TV5oGE/NAmDoUctUn6dFctGvX7W0tIPqoRSXTZjqynn
         0H1zGfcoLz0pFtg/vpeOQ+EalNGx0AmfDujTfxiAoN6Yf69JSRaJnb0qjTu2gxqH7hwW
         7IGnKF83QPrEjMRYRVC7H7eZZO2cGunEv4FNvJc+BImqlamiwHSfkcVxNnpwarTL3s4j
         N3QKEfsppUE6ny8fCkpefJ5FJFo78WEUuqZCzVVJKh61ukHeJeeMNx5vC0jysSY2+1YQ
         XvRo7oNFC8FhpTTotBD4SSMb/GleTsxLsvqyIH/8zTTiSrl7nH65+Cs88c+kiNWaYOXw
         3Dzg==
X-Gm-Message-State: AA+aEWb33/oyIwX2pH8anihanehL1Q92PpBmXtGFJUtl5429NI1gTD1F
        Ajbt/JQFYEu8oG58FVSdt3MhPAjF
X-Google-Smtp-Source: AFSGD/U2Poiy0FpwCUMWPObxdZTxCPVXlCkVPQbQ/b1QYgCpjZ/r05UyIsKQoqM11ZjBTT6vENBdgg==
X-Received: by 2002:a1c:a58a:: with SMTP id o132mr4461044wme.6.1545156948350;
        Tue, 18 Dec 2018 10:15:48 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:d6b:eddb:42b0:da51? (p200300EA8BCFE3000D6BEDDB42B0DA51.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:d6b:eddb:42b0:da51])
        by smtp.googlemail.com with ESMTPSA id h13sm5105805wrp.61.2018.12.18.10.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:15:47 -0800 (PST)
Subject: Re: [PATCH net] net: phy: Fix the issue that netif always links up
 after resuming
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1545119824-30380-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <e8312559-2b67-eb3b-3f61-0503db90fa69@gmail.com>
Date:   Tue, 18 Dec 2018 19:15:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1545119824-30380-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.12.2018 08:57, Kunihiko Hayashi wrote:
> Even though the link is down before entering hibernation,
> there is an issue that the network interface always links up after resuming
> from hibernation.
> 
> If the link is still down before enabling the network interface,
> and after resuming from hibernation, the phydev->state is forcibly set
> to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
> 
> In suspend sequence, only if the PHY is attached, mdio_bus_phy_suspend()
> calls phy_stop_machine(), and mdio_bus_phy_resume() calls
> phy_start_machine().
> In resume sequence, it's enough to do the same as mdio_bus_phy_resume()
> because the state has been preserved.
> 
> This patch fixes the issue by calling phy_start_machine() in
> mdio_bus_phy_restore() in the same way as mdio_bus_phy_resume().
> 
The patch itself is fine and also that you tagged it as "net".
What's missing is a "Fixes:" line (before the Suggested-by:).
I think it should be:

Fixes: bc87922ff59d ("phy: Move PHY PM operations into phy_device")

This commit didn't actually introduce the issue, but moved it to today's
place.

> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/net/phy/phy_device.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> This patch is based on the RFC patch discussion [1].
> [1] https://www.spinics.net/lists/netdev/msg537326.html
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 7d5d698..3685be4 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -315,11 +315,8 @@ static int mdio_bus_phy_restore(struct device *dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* The PHY needs to renegotiate. */
> -	phydev->link = 0;
> -	phydev->state = PHY_UP;
> -
> -	phy_start_machine(phydev);
> +	if (phydev->attached_dev && phydev->adjust_link)
> +		phy_start_machine(phydev);
>  
>  	return 0;
>  }
> 

