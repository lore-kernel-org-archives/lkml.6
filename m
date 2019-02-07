Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C78C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1CC218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfBGERi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:17:38 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40430 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfBGERh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:17:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1449B1411B0B5;
        Wed,  6 Feb 2019 20:17:37 -0800 (PST)
Date:   Wed, 06 Feb 2019 20:17:36 -0800 (PST)
Message-Id: <20190206.201736.1146228626076916564.davem@davemloft.net>
To:     yzhai003@ucr.edu
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, maxime.ripard@free-electrons.com,
        wens@csie.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190205221559.17545-1-yzhai003@ucr.edu>
References: <20190205221559.17545-1-yzhai003@ucr.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Feb 2019 20:17:37 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yizhuo <yzhai003@ucr.edu>
Date: Tue,  5 Feb 2019 14:15:59 -0800

> @@ -639,9 +639,14 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
>  	struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
>  	struct device_node *node = priv->device->of_node;
>  	int ret;
> -	u32 reg, val;
> +	u32 reg, val = 0;
> +
> +	ret = regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
> +	if (ret) {
> +		dev_err(priv->device, "Fail to read SYSCON_EMAC_REG.\n");
> +		return ret;
> +	}

I agree with the other reviewer that since you check 'ret' the initialization of
'val' is no longer needed.
