Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6546FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E892171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWiyHEwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeLZSJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 13:09:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55080 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeLZSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 13:09:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so15063711wmh.4;
        Wed, 26 Dec 2018 10:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TdV2R8UgjUdDddm9RaGLRzcwrRIYU197K2hpHWkMBiE=;
        b=jWiyHEwlrBusGagCKmn2oONJiARWTaH0pzXDclwI2+3/yUvrAotSmNPBT7dWwnLlzt
         hXz/HrCkr9M7c+O54nHPjtZPKgDd/UsFNtqBtcw3SIuvGq6dU2aqrXpINockzNdqOVxv
         Yvey4lmn2GIa1BvjAzNeveODHQ6fMykf2Xhc1uyqhyRM7coPg1D5BjInAiY5iN3qOK+Y
         D64gbIyf1cAX4TwJJ9l2XrtBO+7B4HHB5g2FszBDWg7hdzfJqD5qalCzo3phQe6Vh1em
         OQBCjtP8YkfSf/nrKIMYYx3X+g1m7V1GS00ngnj9m6HWkI5be8Wm5GA3cKR/QlKCuN5k
         QInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TdV2R8UgjUdDddm9RaGLRzcwrRIYU197K2hpHWkMBiE=;
        b=HBybao+FkcbNpaEOEm3nUl4ZwRqlQ3kNUik1WiVmaMNnhLQ/16o+IjOlWHR3mIELYo
         phwPSmsf8+8GJA0pHlG1MyNy8u2FTcyJW1+xW5ffqR5e9A2HKJYe+tZasmOAQGtl0oD0
         t8V0H50m03aTiwq52kKHbrjCX8LuoIaFMoAM6yMaHmx4zAMi6GY20Q1P7Ug0fDTfOcsh
         lbPVxCMeordEngwgRdlRfcVsNbpKLjT5j8q2VZYCcBlgBNZmR4QunHaj+77KjRug0Tcf
         DqMZr68VMUTw2AmM5DRv0lnQ+gsTIvBKiNexTH0D6x+L0S6hKXj7BL03ZSTwnKSh3zIk
         i4iw==
X-Gm-Message-State: AJcUukc9AzovMXCYjj4uwPdb4bxI86RMW1z4IEyIz6Uli1/ufgjqTrVi
        +n4R/h6rAJtP2YpPR6U4jU19V/fO
X-Google-Smtp-Source: ALg8bN7p8BpgAFHQogH34Q95nv5GvdiL3eWjvXD6beMRvSusK3Ev+mwQHpkMy2Hka6ZsORfG2oUw6g==
X-Received: by 2002:a1c:9dc4:: with SMTP id g187mr9087721wme.152.1545847765026;
        Wed, 26 Dec 2018 10:09:25 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:6194:598:7f5e:b2e? (p200300EA8BCFE300619405987F5E0B2E.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:6194:598:7f5e:b2e])
        by smtp.googlemail.com with ESMTPSA id e18sm27643557wrv.88.2018.12.26.10.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 10:09:24 -0800 (PST)
Subject: Re: [PATCH v2] net: dsa: bcm_sf2: Propagate error value from
 mdio_write
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181226175001.76546-1-kjlu@umn.edu>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <e3d3b931-0d0d-af39-8b79-001ceb6942cf@gmail.com>
Date:   Wed, 26 Dec 2018 19:09:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181226175001.76546-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.12.2018 18:50, Kangjie Lu wrote:
> Both bcm_sf2_sw_indir_rw and mdiobus_write_nested could fail, so let's
> return their error codes upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/dsa/bcm_sf2.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
> index 2eb68769562c..73fbc16a1f86 100644
> --- a/drivers/net/dsa/bcm_sf2.c
> +++ b/drivers/net/dsa/bcm_sf2.c
> @@ -305,9 +305,8 @@ static int bcm_sf2_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
>  	if (addr == BRCM_PSEUDO_PHY_ADDR && priv->indir_phy_mask & BIT(addr))
>  		bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
>  	else
> -		mdiobus_write_nested(priv->master_mii_bus, addr, regnum, val);
> -
> -	return 0;
> +		return mdiobus_write_nested(priv->master_mii_bus,
> +				addr, regnum, val);
>  }
Did you try to compile this? The first branch of the if clause has no return
value any longer.
