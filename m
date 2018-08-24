Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585DBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054582082B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q/1DMn8E";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Duen7Y2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054582082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeHXVKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:10:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46128 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXVKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:10:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F8EE6022B; Fri, 24 Aug 2018 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535132118;
        bh=ROiaCqo7tWwMPTxGo0KEd5ex8NllKOUXVHyuJQni6KM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Q/1DMn8Eg4LCGr7nIuBfC0xh4jYvB+N34LdQNZ9bMgT8l61XLgyPiNJzliCg0hMlJ
         CFPDU4fZIX2SiIIWtEX/1YqB93Rr+dsxZlC5e/bwahFvEuvvG4EV0pIrwUmjyUR3Ar
         wGHcSUwQZtpNRzQO0bV0dOBXNojKIncaanpPRg38=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B3E9604A6;
        Fri, 24 Aug 2018 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535132117;
        bh=ROiaCqo7tWwMPTxGo0KEd5ex8NllKOUXVHyuJQni6KM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Duen7Y2ht6KI0s5ybhMP5C7K3kb8Q3DnLcuYJJ20/3dg+zaGsFnkkxfBqprXPn6vK
         zTVhOgJ4Ddf3hxDP/kxByRXEhZLV/IkfMNoBx/YgGDTxQaBNax3Atei9uLdd8ZjVDC
         +GzECT1ziqmDtUPAMcrZU1XB9joj1Sxn8epvrUfI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B3E9604A6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wcn36xx: replace dma_alloc_coherent + memset with dma_zalloc_coherent
References: <20180824171410.22539-1-colin.king@canonical.com>
Date:   Fri, 24 Aug 2018 20:35:12 +0300
In-Reply-To: <20180824171410.22539-1-colin.king@canonical.com> (Colin King's
        message of "Fri, 24 Aug 2018 18:14:10 +0100")
Message-ID: <87bm9rhdm7.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> writes:

> From: Colin Ian King <colin.king@canonical.com>
>
> It is preferable to use dma_zalloc_coherent rather than dam_alloc_coherent
> and memset, so use it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/wireless/ath/wcn36xx/dxe.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
> index 06cfe8d311f3..e66ddaa39523 100644
> --- a/drivers/net/wireless/ath/wcn36xx/dxe.c
> +++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
> @@ -174,13 +174,11 @@ static int wcn36xx_dxe_init_descs(struct device *dev, struct wcn36xx_dxe_ch *wcn
>  	int i;
>  
>  	size = wcn_ch->desc_num * sizeof(struct wcn36xx_dxe_desc);
> -	wcn_ch->cpu_addr = dma_alloc_coherent(dev, size, &wcn_ch->dma_addr,
> -					      GFP_KERNEL);
> +	wcn_ch->cpu_addr = dma_zalloc_coherent(dev, size, &wcn_ch->dma_addr,
> +					       GFP_KERNEL);
>  	if (!wcn_ch->cpu_addr)
>  		return -ENOMEM;
>  
> -	memset(wcn_ch->cpu_addr, 0, size);
> -
>  	cur_dxe = (struct wcn36xx_dxe_desc *)wcn_ch->cpu_addr;
>  	cur_ctl = wcn_ch->head_blk_ctl;

Hehe, I think you are the third person submitting a similar patch :)
Anyway, I just applied this few hours ago:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=d410e28f3ae476e1572b8893c646ef44fae7bbbd

-- 
Kalle Valo
