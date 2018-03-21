Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeCUDEV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 23:04:21 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8464 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751531AbeCUDEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 23:04:20 -0400
X-UUID: 3bd3df6c9a924b668f10efc313b38da6-20180321
Message-ID: <1521601453.3717.117.camel@mhfsdcap03>
Subject: Re: [PATCH -next] phy: phy-mtk-tphy: fix missing
 clk_disable_unprepare() on error in mtk_phy_init()
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Wei Yongjun <weiyongjun1@huawei.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Date: Wed, 21 Mar 2018 11:04:13 +0800
In-Reply-To: <1521551999-154546-1-git-send-email-weiyongjun1@huawei.com>
References: <1521551999-154546-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-20 at 13:19 +0000, Wei Yongjun wrote:
> Fix the missing clk_disable_unprepare() before return
> from mtk_phy_init() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/phy/mediatek/phy-mtk-tphy.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
> index 38c281b..3ff9020 100644
> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> @@ -841,7 +841,7 @@ static int mtk_phy_init(struct phy *phy)
>  	ret = clk_prepare_enable(instance->ref_clk);
>  	if (ret) {
>  		dev_err(tphy->dev, "failed to enable ref_clk\n");
> -		return ret;
> +		goto disable_u3phya_ref;
@u3phya_ref and @ref_clk clocks are mutually exclusive, that means one
of them must be NULL; so if failed to enable @ref_clk, then @u3phya_ref
should be NULL, and no need to disable it in fact.
But it's also no problem to disable it.
>  	}


>  
>  	switch (instance->type) {
> @@ -859,10 +859,17 @@ static int mtk_phy_init(struct phy *phy)
>  		break;
>  	default:
>  		dev_err(tphy->dev, "incompatible PHY type\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto disable_ref_clk;
mtk_phy_xlate() has already checked supported type,so usually doesn't
comes here, otherwise there will be a serious problem about system.

Anyway, it's better to disable these clocks when fail.
>  	}
>  
>  	return 0;
> +
> +disable_ref_clk:
> +	clk_disable_unprepare(instance->ref_clk);
> +disable_u3phya_ref:
> +	clk_disable_unprepare(tphy->u3phya_ref);
> +	return ret;
>  }
>  
>  static int mtk_phy_power_on(struct phy *phy)
> 
Tested-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks a lot
> 
> 
