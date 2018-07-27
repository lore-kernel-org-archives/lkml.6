Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C050C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430E120842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430E120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbeG1AzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:55:06 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:49165 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388652AbeG1AzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:55:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DB283100E86C0;
        Fri, 27 Jul 2018 23:30:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: turn12_253205b3ad10f
X-Filterd-Recvd-Size: 2000
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Jul 2018 23:30:55 +0000 (UTC)
Message-ID: <c2b3f36b8e7e1a2799580e76f19a267351da5491.camel@perches.com>
Subject: Re: [PATCH v3 net-next] net: ethernet: ti: cpsw: replace
 unnecessarily macroses on functions
From:   Joe Perches <joe@perches.com>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch
Date:   Fri, 27 Jul 2018 16:30:54 -0700
In-Reply-To: <20180727225725.3843-1-ivan.khoronzhuk@linaro.org>
References: <20180727225725.3843-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-28 at 01:57 +0300, Ivan Khoronzhuk wrote:
> Replace ugly macroses on functions.

trivia:

As cpsw_src_port_detect is only used once, and is a
very small function, it might make the code more
intelligible to just directly code it where it's used.

> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
[]
> @@ -565,40 +565,40 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
[]
> +static void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
> +				 struct sk_buff *skb)
> +{
> +	if (!cpsw->data.dual_emac)
> +		return;
> +
> +	if (CPDMA_RX_SOURCE_PORT(status) == 1)
> +		skb->dev = cpsw->slaves[0].ndev;
> +	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
> +		skb->dev = cpsw->slaves[1].ndev;
> +}
[]
> @@ -801,7 +801,8 @@ static void cpsw_rx_handler(void *token, int len, int status)
>  	int			ret = 0;
>  	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
>  
> -	cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb);
> +	cpsw_src_port_detect(cpsw, status, skb);

here

> +	ndev = skb->dev;
