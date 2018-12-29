Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F779C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7E7217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeL2FK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:10:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40098 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeL2FK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:10:57 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E71461451513B;
        Fri, 28 Dec 2018 21:10:55 -0800 (PST)
Date:   Fri, 28 Dec 2018 21:10:53 -0800 (PST)
Message-Id: <20181228.211053.848330303302862567.davem@davemloft.net>
To:     peng.hao2@zte.com.cn
Cc:     qiang.zhao@nxp.com, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, wen.yang99@zte.com.cn,
        julia.lawall@lip6.fr, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1545812789-77690-1-git-send-email-peng.hao2@zte.com.cn>
References: <1545812789-77690-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Dec 2018 21:10:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 26 Dec 2018 16:26:29 +0800

> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 839fa77..8ce4921f 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -1057,6 +1057,27 @@ static const struct net_device_ops uhdlc_ops = {
>  	.ndo_tx_timeout	= uhdlc_tx_timeout,
>  };
>  
> +static int ucc_get_resource_by_nodename(char *name, struct resource *res)
> +{
 ...
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	return 0;

This assignment to 'res' doesn't do what you think it does.  The caller never
sees the value you compute.

