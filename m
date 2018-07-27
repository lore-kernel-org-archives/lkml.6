Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3E0C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C75120671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JIvNJCcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C75120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbeG0VAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:00:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46540 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389064AbeG0VAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:00:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id l16-v6so4256857lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mdqGObWYVfyyYmDkoVzA2CFPn8sf9vYZVTeu+piuB7o=;
        b=JIvNJCcsOdGDC4bms2WDbNzJtDO685gtlVAUCHc+7lHZlcgHqQ6QeJRSrC7I5IEJDW
         1mBdgs8Wz5+euB3Xr9+xG22Z/E/TnS45hIrZby6gy8viIJg5isOsQDD+xGNstIDr4hGq
         uVrMP0JaPIw8frG+SrrLXnlJ4w19g9Y7Xsf4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mdqGObWYVfyyYmDkoVzA2CFPn8sf9vYZVTeu+piuB7o=;
        b=S78KI+guK1UzLs3MvwNDebVDOCmkfWpeEiRho2aFs0cs2C4YiLnOwgSAWYxRzRj5pm
         xgiqsA9O+1oNI0uYq3eOHB8mEdjjhduOKxvDaCRkDukritkhPX56M31Eq20Zn8La9s9Z
         fVj6AQZZEmXkZvgRDgDmz7KhCrRV/AC70sVCip28ujvKX2cDBnrOdgDPnL2VuBg4KiG6
         wWMbiceMW4YrLEMaWhHjxICAaxGm1RHMtvgRl61gJZJT3Pc7lsBWjFroBvcYPITVbd/g
         EWF1yD/SZvgWLjtMFVaX38GDmm2e4GQSlzTMwyA7AmylBkBbNiwxL2mNCCwBhJCNKEmp
         XXGg==
X-Gm-Message-State: AOUpUlF0jN7OnSPslyY2ntQUD3mYCjjb2GO0Ul2XUc98EOW/Yn6xB7mA
        kagjUhv5tmpu9aXo9aLxYWuwbQ==
X-Google-Smtp-Source: AAOMgpfmol7d3PjYBoDxbEROyYJ13Ot3k2Lt7OXde6FAMmWswBLEYh24w+wjJ/TnJg50QjujAEcooQ==
X-Received: by 2002:a19:9345:: with SMTP id v66-v6mr4969879lfd.89.1532720205870;
        Fri, 27 Jul 2018 12:36:45 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id v136-v6sm644383lfa.10.2018.07.27.12.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 12:36:45 -0700 (PDT)
Date:   Fri, 27 Jul 2018 22:36:43 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: replace unnecessarily
 macroses on functions
Message-ID: <20180727193641.GA2619@khorivan>
Mail-Followup-To: Joe Perches <joe@perches.com>, grygorii.strashko@ti.com,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
 <98a6d1cd4d313512d66ced3fc25f438449b3c310.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <98a6d1cd4d313512d66ced3fc25f438449b3c310.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:21:07PM -0700, Joe Perches wrote:
>On Fri, 2018-07-27 at 22:13 +0300, Ivan Khoronzhuk wrote:
>> Replace ugly macroses on functions.
>
>Careful, see below.
>
>> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>[]
>> @@ -565,40 +565,40 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
>>  				(func)(slave++, ##arg);			\
>>  	} while (0)
>>
>> -#define cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb)		\
>> -	do {								\
>> -		if (!cpsw->data.dual_emac)				\
>> -			break;						\
>> -		if (CPDMA_RX_SOURCE_PORT(status) == 1) {		\
>> -			ndev = cpsw->slaves[0].ndev;			\
>> -			skb->dev = ndev;				\
>> -		} else if (CPDMA_RX_SOURCE_PORT(status) == 2) {		\
>> -			ndev = cpsw->slaves[1].ndev;			\
>> -			skb->dev = ndev;				\
>> -		}							\
>> -	} while (0)
>> -#define cpsw_add_mcast(cpsw, priv, addr)				\
>> -	do {								\
>> -		if (cpsw->data.dual_emac) {				\
>> -			struct cpsw_slave *slave = cpsw->slaves +	\
>> -						priv->emac_port;	\
>> -			int slave_port = cpsw_get_slave_port(		\
>> -						slave->slave_num);	\
>> -			cpsw_ale_add_mcast(cpsw->ale, addr,		\
>> -				1 << slave_port | ALE_PORT_HOST,	\
>> -				ALE_VLAN, slave->port_vlan, 0);		\
>> -		} else {						\
>> -			cpsw_ale_add_mcast(cpsw->ale, addr,		\
>> -				ALE_ALL_PORTS,				\
>> -				0, 0, 0);				\
>> -		}							\
>> -	} while (0)
>> -
>>  static inline int cpsw_get_slave_port(u32 slave_num)
>>  {
>>  	return slave_num + 1;
>>  }
>>
>> +static inline void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
>> +					struct sk_buff *skb)
>> +{
>> +	if (!cpsw->data.dual_emac)
>> +		return;
>> +
>> +	if (CPDMA_RX_SOURCE_PORT(status) == 1)
>> +		skb->dev = cpsw->slaves[0].ndev;
>> +	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
>> +		skb->dev = cpsw->slaves[1].ndev;
>> +}
>
>perhaps better as a switch/case
not better, it's shorter.

>
>> +
>> +static void cpsw_add_mcast(struct cpsw_priv *priv, u8 *addr)
>> +{
>> +	struct cpsw_common *cpsw = priv->cpsw;
>> +
>> +	if (cpsw->data.dual_emac) {
>> +		struct cpsw_slave *slave = cpsw->slaves + priv->emac_port;
>> +		int slave_port = cpsw_get_slave_port(slave->slave_num);
>> +
>> +		cpsw_ale_add_mcast(cpsw->ale, addr,
>> +				   1 << slave_port | ALE_PORT_HOST,
>> +				   ALE_VLAN, slave->port_vlan, 0);
>> +		return;
>> +	}
>> +
>> +	cpsw_ale_add_mcast(cpsw->ale, addr, ALE_ALL_PORTS, 0, 0, 0);
>> +}
>> +
>>  static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
>>  {
>>  	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
>> @@ -706,7 +706,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
>>
>>  		/* program multicast address list into ALE register */
>>  		netdev_for_each_mc_addr(ha, ndev) {
>> -			cpsw_add_mcast(cpsw, priv, (u8 *)ha->addr);
>> +			cpsw_add_mcast(priv, (u8 *)ha->addr);
>>  		}
>>  	}
>>  }
>> @@ -801,7 +801,8 @@ static void cpsw_rx_handler(void *token, int len, int status)
>>  	int			ret = 0;
>>  	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
>>
>> -	cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb);
>> +	cpsw_src_port_detect(cpsw, status, skb);
>> +	ndev = skb->dev;
>
>This is not the same code as the new function
>is not guaranteed to succeed or set skb->dev.
Guaranteed by above skb->dev is initialized already.
The function reflects previous macro.

Even more, seems that here is duplication of ndev=skb->dev;
It should be removed at init ), even if it 100% is optimized by complier.
So guaranteed a little more then needed ), will send v2 with removed
ndev = skb->dev at init if no objection.

>
>>  	if (unlikely(status < 0) || unlikely(!netif_running(ndev))) {
>>  		/* In dual emac mode check for all interfaces */

-- 
Regards,
Ivan Khoronzhuk
