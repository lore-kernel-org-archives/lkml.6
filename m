Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFDCC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D6E20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+UT53J8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D6E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbeG0VQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:16:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38336 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389326AbeG0VQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:16:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so5385589ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3JvfByZvUV0ODKi6DgEyNGOlHS+Qvx52KigecwVaoI=;
        b=L+UT53J897pTwKg6LbkSLPcDoDORTwvcylqjllgUQS2EpzaAQK4w/a562jMmBu30QX
         XNQFluqxiK6mO8SB4xzhRnTeB3YEyZF+KjODC3KOuypAjIrNH1zgaCJ4zfIw89Yhadme
         PWdhA4aZdc/EcaE1kvYL6r175AcyQDh03o96U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3JvfByZvUV0ODKi6DgEyNGOlHS+Qvx52KigecwVaoI=;
        b=YtIS7VWDrjADV8PvsoiTwpIXUkQ86O2YXPZEnkYqczQlT4n/ew8W4rDgeduz+xNL3H
         DfN8+YX0s9TojmFDX0PzZd+Xu4L0CacvPoYvwHKBF5iHxzCexzkuASfGc+IruDINJl6a
         QPzRfL+Z8Iqemes0JttIEzlUNUBc40Es1Xqqr8V0iK5/Vksf69NNBHooIXU1t1pkNbqB
         NWTVa/NKVZnDilNbMD8DuAnfo3se+4LHekmyRN5zIe5r+qvMfSBvOc0BFrB+W1SxpUGW
         1adFXaDsKkv6oCveEEB8kgfHkMnV3OPzV4yxn8SGdlj1MQXosPhFcaBxZHHeX6l6Hh3G
         SrPw==
X-Gm-Message-State: AOUpUlFINkTLdv0/7nuGh3Wz7SOKI4U0fjgZu/EFM+ZHIIKwDkE0ylxn
        0n4TYlvuHHeLw2jOjl1mMxk0Vg==
X-Google-Smtp-Source: AAOMgpcywn95uBVbWA4YKj6llfpA/RAaGu6j3YrUzSyxW8D36bN6CVHrtCNlleyZwYr0If2eFoFkpQ==
X-Received: by 2002:a2e:96d8:: with SMTP id d24-v6mr6384304ljj.50.1532721178822;
        Fri, 27 Jul 2018 12:52:58 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id f129-v6sm647861lff.37.2018.07.27.12.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 12:52:58 -0700 (PDT)
Date:   Fri, 27 Jul 2018 22:52:56 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Joe Perches <joe@perches.com>, grygorii.strashko@ti.com,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: replace unnecessarily
 macroses on functions
Message-ID: <20180727195254.GB2619@khorivan>
Mail-Followup-To: Joe Perches <joe@perches.com>, grygorii.strashko@ti.com,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
 <98a6d1cd4d313512d66ced3fc25f438449b3c310.camel@perches.com>
 <20180727193641.GA2619@khorivan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180727193641.GA2619@khorivan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:36:43PM +0300, Ivan Khoronzhuk wrote:
>On Fri, Jul 27, 2018 at 12:21:07PM -0700, Joe Perches wrote:
>>On Fri, 2018-07-27 at 22:13 +0300, Ivan Khoronzhuk wrote:
>>>Replace ugly macroses on functions.
>>
>>Careful, see below.
>>
>>>diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>>[]
>>>@@ -565,40 +565,40 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
>>> 				(func)(slave++, ##arg);			\
>>> 	} while (0)
>>>
>>>-#define cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb)		\
>>>-	do {								\
>>>-		if (!cpsw->data.dual_emac)				\
>>>-			break;						\
>>>-		if (CPDMA_RX_SOURCE_PORT(status) == 1) {		\
>>>-			ndev = cpsw->slaves[0].ndev;			\
>>>-			skb->dev = ndev;				\
>>>-		} else if (CPDMA_RX_SOURCE_PORT(status) == 2) {		\
>>>-			ndev = cpsw->slaves[1].ndev;			\
>>>-			skb->dev = ndev;				\
>>>-		}							\
>>>-	} while (0)
>>>-#define cpsw_add_mcast(cpsw, priv, addr)				\
>>>-	do {								\
>>>-		if (cpsw->data.dual_emac) {				\
>>>-			struct cpsw_slave *slave = cpsw->slaves +	\
>>>-						priv->emac_port;	\
>>>-			int slave_port = cpsw_get_slave_port(		\
>>>-						slave->slave_num);	\
>>>-			cpsw_ale_add_mcast(cpsw->ale, addr,		\
>>>-				1 << slave_port | ALE_PORT_HOST,	\
>>>-				ALE_VLAN, slave->port_vlan, 0);		\
>>>-		} else {						\
>>>-			cpsw_ale_add_mcast(cpsw->ale, addr,		\
>>>-				ALE_ALL_PORTS,				\
>>>-				0, 0, 0);				\
>>>-		}							\
>>>-	} while (0)
>>>-
>>> static inline int cpsw_get_slave_port(u32 slave_num)
>>> {
>>> 	return slave_num + 1;
>>> }
>>>
>>>+static inline void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
>>>+					struct sk_buff *skb)
>>>+{
>>>+	if (!cpsw->data.dual_emac)
>>>+		return;
>>>+
>>>+	if (CPDMA_RX_SOURCE_PORT(status) == 1)
>>>+		skb->dev = cpsw->slaves[0].ndev;
>>>+	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
>>>+		skb->dev = cpsw->slaves[1].ndev;
>>>+}
>>
>>perhaps better as a switch/case
>not better, it's shorter.
>
>>
>>>+
>>>+static void cpsw_add_mcast(struct cpsw_priv *priv, u8 *addr)
>>>+{
>>>+	struct cpsw_common *cpsw = priv->cpsw;
>>>+
>>>+	if (cpsw->data.dual_emac) {
>>>+		struct cpsw_slave *slave = cpsw->slaves + priv->emac_port;
>>>+		int slave_port = cpsw_get_slave_port(slave->slave_num);
>>>+
>>>+		cpsw_ale_add_mcast(cpsw->ale, addr,
>>>+				   1 << slave_port | ALE_PORT_HOST,
>>>+				   ALE_VLAN, slave->port_vlan, 0);
>>>+		return;
>>>+	}
>>>+
>>>+	cpsw_ale_add_mcast(cpsw->ale, addr, ALE_ALL_PORTS, 0, 0, 0);
>>>+}
>>>+
>>> static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
>>> {
>>> 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
>>>@@ -706,7 +706,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
>>>
>>> 		/* program multicast address list into ALE register */
>>> 		netdev_for_each_mc_addr(ha, ndev) {
>>>-			cpsw_add_mcast(cpsw, priv, (u8 *)ha->addr);
>>>+			cpsw_add_mcast(priv, (u8 *)ha->addr);
>>> 		}
>>> 	}
>>> }
>>>@@ -801,7 +801,8 @@ static void cpsw_rx_handler(void *token, int len, int status)
>>> 	int			ret = 0;
>>> 	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
>>>
>>>-	cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb);
>>>+	cpsw_src_port_detect(cpsw, status, skb);
>>>+	ndev = skb->dev;
>>
>>This is not the same code as the new function
>>is not guaranteed to succeed or set skb->dev.
>Guaranteed by above skb->dev is initialized already.
>The function reflects previous macro.
>
>Even more, seems that here is duplication of ndev=skb->dev;
>It should be removed at init ), even if it 100% is optimized by complier.
>So guaranteed a little more then needed ), will send v2 with removed
>ndev = skb->dev at init if no objection.

But no, not duplicates.
It's used to get cpsw. So everyting is fine.
Patch should go as is.

>
>>
>>> 	if (unlikely(status < 0) || unlikely(!netif_running(ndev))) {
>>> 		/* In dual emac mode check for all interfaces */
>
>-- 
>Regards,
>Ivan Khoronzhuk

-- 
Regards,
Ivan Khoronzhuk
