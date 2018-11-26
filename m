Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08128C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B9220664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OnMduiRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B9220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeK0DV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:21:29 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34237 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeK0DV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:21:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so17171288ljd.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tpctfI38pW3V8sLhZ1hY2ZEepMiZk3cvEKfiZ6FaiQM=;
        b=OnMduiRt7YPzaXrleCeUMikwrthn801Abc/Zsgbd9JRvX79hvwqDwK0cXpWmTsJ2GD
         hkFg2oDyqvNWWp9VBmyRQUXwSBg4TUxQ+uesT1MzFOCkxuaJqoJynaDiLGb0AVCoP/nP
         CJ4mWiAyyKpHJ1WjUFEhz7SkEVvw85p/cxt5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=tpctfI38pW3V8sLhZ1hY2ZEepMiZk3cvEKfiZ6FaiQM=;
        b=tsRI6MGDrBoIQgIbAIBZT8YpQG0BidNXxangRWZzvr7sqHRXYhXhj0xggKToPqDexC
         WQqZ+konmKTAoM8+QbqrfU92o2dbfqpbFB+w7Xiy7aRMIIRcbga1lvf7CtDFFYGE9ZdS
         M4Ja+6lMUhbjuPDVFDK6Luk6TH5+mBbSjqdH9nO3qY1PG+ZA1WJiHcGfAZBKd/13eo9z
         lyo4j4m2Iwhx58KybBE5AB7uEPmH/NkUeaFwQc9JTlIItqMxoL9B9v1Zpgz3wSHt6Gz6
         PCKCItt4n4QEE0RCqPMeOdFXYSxXBs0FgyeqLHRlwsyP68JFLbwXowg5TYlIXfUk8JID
         aZAw==
X-Gm-Message-State: AA+aEWa3AXOnlxdthUlcruyk70KeuZq2zIj+63oZ9Q8GcFdD4G0MMGc2
        ZU3a9y4zMYVDK1+vV5QIHVuf0jRtJ+akRg==
X-Google-Smtp-Source: AFSGD/VHaiaexSG3R1Nys/tZ1jRgjBD1DNNBUiowEOVQ6tLMM3GXpsGOVQt0wTF01waC65azo228Mw==
X-Received: by 2002:a2e:9256:: with SMTP id v22-v6mr19105499ljg.178.1543249611046;
        Mon, 26 Nov 2018 08:26:51 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id f29sm123655lfa.46.2018.11.26.08.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 08:26:49 -0800 (PST)
Date:   Mon, 26 Nov 2018 18:26:47 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0
 configuration in dual_mac modey
Message-ID: <20181126162644.GA23230@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20181125234626.28474-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181125234626.28474-1-grygorii.strashko@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 05:46:26PM -0600, Grygorii Strashko wrote:
>In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
>dual mac mode wich are used to configure pvids for each external ports.
>But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
>ext. ports. As result, it's imposible to use priority tagged packets in
>dual mac mode.
>
>Hence, drop vid0 configuration in dual mac mode as it's not required for dual
>mac mode functionality and, this way, make it possible to use priority
>tagged packet in dual mac mode.
So, now it's enabled to be added via regular ndo.
I have similar change in mind, but was going to send it after
mcast/ucast, and - enabling same vlans patch...

2 things stopped me to add this:

1) Moving it to be enabled via regular call is Ok, but in dual mac mode
it causes overlaps, at least while vid deletion. So decided to wait till
same vlans series is applied.

2) Wanted implement somehow similar handling for single port boards
in one patch, not only for dual mac mode. This part was not clear and
not verified completely...

So, if it's needed now, maybe better at this moment only remove
untag field? and remove vlan0 later, once other vlan changes applied.

Say:

cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
		  ALE_ALL_PORTS, 0, ALE_ALL_PORTS, 0);

instead of:
cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
		  ALE_ALL_PORTS, ALE_ALL_PORTS, 0, 0);

>
>Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>---
> drivers/net/ethernet/ti/cpsw.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>index 15d563c..4f3a159 100644
>--- a/drivers/net/ethernet/ti/cpsw.c
>+++ b/drivers/net/ethernet/ti/cpsw.c
>@@ -2036,9 +2036,6 @@ static int cpsw_ndo_open(struct net_device *ndev)
> 	/* Add default VLAN */
> 	if (!cpsw->data.dual_emac)
> 		cpsw_add_default_vlan(priv);
>-	else
>-		cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
>-				  ALE_ALL_PORTS, ALE_ALL_PORTS, 0, 0);
>
> 	/* initialize shared resources for every ndev */
> 	if (!cpsw->usage_count) {
>@@ -2490,7 +2487,7 @@ static int cpsw_ndo_vlan_rx_add_vid(struct net_device *ndev,
> 	struct cpsw_common *cpsw = priv->cpsw;
> 	int ret;
>
>-	if (vid == cpsw->data.default_vlan)
>+	if (!cpsw->data.dual_emac && vid == cpsw->data.default_vlan)
> 		return 0;
>
> 	ret = pm_runtime_get_sync(cpsw->dev);
>@@ -2528,7 +2525,7 @@ static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
> 	struct cpsw_common *cpsw = priv->cpsw;
> 	int ret;
>
>-	if (vid == cpsw->data.default_vlan)
>+	if (!cpsw->data.dual_emac && vid == cpsw->data.default_vlan)
> 		return 0;
>
> 	ret = pm_runtime_get_sync(cpsw->dev);
>-- 
>2.10.5
>

-- 
Regards,
Ivan Khoronzhuk
