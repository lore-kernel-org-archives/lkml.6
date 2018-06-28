Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D48C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251452728F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UChyC++l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251452728F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965390AbeF1Mlc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:41:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56288 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeF1Mla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:41:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180628124128euoutp02eeaf179104e46aa63f443742c57ef81a~8U2oClWLx2253322533euoutp02Z
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:41:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180628124128euoutp02eeaf179104e46aa63f443742c57ef81a~8U2oClWLx2253322533euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530189688;
        bh=QN+gT6/tc1tSFycP44qMCjpAP0PzIVrL7Mc0x+83oR4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UChyC++l7hrL3D8IEYyAHsm24qwLKTrLMM77IGbBDpvLOrBgDpSY6M2+xFA3uQxX5
         ANp2NJfIN8rwj4GYOEX27lShkDqVM7fDf46kwU116raUWHUJR1F7+gtMhfGc7tN1uQ
         jnzmH+ZiI9OJ50uDzOhC0Qod4dSMbR52yV/6obck=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180628124127eucas1p2f5de713eed17ae49981fd964de106630~8U2nb6_Ct3134831348eucas1p2L;
        Thu, 28 Jun 2018 12:41:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F6.88.05700.677D43B5; Thu, 28
        Jun 2018 13:41:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180628124126eucas1p1396d8b111c6aee82ff979ee2106479c2~8U2mRg4Q11877318773eucas1p1k;
        Thu, 28 Jun 2018 12:41:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180628124126eusmtrp131587acbabffe0aa029fa0d18af44e24~8U2mDPg2c2971729717eusmtrp1Z;
        Thu, 28 Jun 2018 12:41:26 +0000 (GMT)
X-AuditID: cbfec7f2-5ffe19c000011644-ab-5b34d776a69c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 06.8E.04183.577D43B5; Thu, 28
        Jun 2018 13:41:25 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180628124125eusmtip275226b57c5ad768aa6291713dff3af3f~8U2lxJ4vL1223812238eusmtip2N;
        Thu, 28 Jun 2018 12:41:25 +0000 (GMT)
Subject: Re: [PATCH v2] drm/vc4: Make DSI call into the bridge after the DSI
 link is enabled.
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Thu, 28 Jun 2018 14:41:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621231759.29604-1-eric@anholt.net>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzned2y6ybRBqsPmlpc+fqezeJA42VG
        i8u75rA5MHs0vT/G5nG/+ziTx+dNcgHMUVw2Kak5mWWpRfp2CVwZL2ZGFTyQqmj8coepgfG9
        SBcjB4eEgInE+9s5XYxcHEICKxgl7lzawQ7hfGGUuLHxCRuE85lR4vSaacwwHUs/ckPElzNK
        /NlwihHCecso0bLuAWsXIyeHsEC8xMrGzWwgtoiAk8THDfuYQGxmAQWJX/c2gdWwCWhK/N18
        kw1kKIuAqsTsXnaQsKhAhMTGCZ+YQWxeAUGJkzOfsIDYnAKmEnd/nmWEGCMv0bx1NjOELS5x
        68l8sPESAs3sEn2zjSF6yyTOrT8FFXeRuPRhEjuELSzx6vgWKFtG4vTkHhYIu16iaeYVZpBf
        JAQ6GCVOLF7OBpGwljh8/CIryJ3MQDev36UPEXaU6Pk4hxUSJnwSN94KQpzDJzFp23RoUPFK
        dLQJQVQrStw/u5UZwhaXWHrhK9sERqVZSJ6cheSxWUgem4WwdwEjyypG8dTS4tz01GLDvNRy
        veLE3OLSvHS95PzcTYzA9HH63/FPOxi/Xko6xCjAwajEw3viikm0EGtiWXFl7iFGCQ5mJRHe
        T3uBQrwpiZVVqUX58UWlOanFhxilOViUxHnjNOqihATSE0tSs1NTC1KLYLJMHJxSDYxbFsi1
        7TH+ntCXqqD8ct5rIZcT79O8qk5G6Pp8FTitqpvykYlf5fx3ifbKGzI5Vxel71+mkzt52tH5
        UpfLJAr1PkjdeWB+g9vst10T75LQF/OZ8hfHHTiZU5R957BC8s0p076WJ1j9DUlya2TnMQ5R
        mmdaf13f9lvRSe15zz08E2Ifh626tlaJpTgj0VCLuag4EQAFr3BeGwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7ql102iDTads7S48vU9m8WBxsuM
        Fpd3zWFzYPZoen+MzeN+93Emj8+b5AKYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
        zWOtjEyV9O1sUlJzMstSi/TtEvQyXsyMKnggVdH45Q5TA+N7kS5GDg4JAROJpR+5uxi5OIQE
        ljJK9O66y9TFyAkUF5fYPf8tM4QtLPHnWhcbiC0k8JpRYsdrbRBbWCBeYmXjZrC4iICTxMcN
        +8B6mQUUJH7d28QKUd/BKNGxWxXEZhPQlPi7+SZYPa+AncS2jT/YQW5gEVCVmN3LDhIWFYiQ
        aJq3hh2iRFDi5MwnLCA2p4CpxN2fZxkhxqtL/Jl3iRnClpdo3jobyhaXuPVkPtMERqFZSNpn
        IWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIjZtuxn1t2MHa9Cz7EKMDB
        qMTDe+KKSbQQa2JZcWXuIUYJDmYlEd5Pe4FCvCmJlVWpRfnxRaU5qcWHGE2BfpvILCWanA+M
        5rySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2ampBalFMH1MHJxSDYyZJxc2HbqyO93V
        ysHPUtLo0+VXzpfXmLp/0ShMNzo5JY/567M0z2K/a3aZ9z0ZLh/YuSXqVfnN/2ZPAv0aWhZa
        PFeKXdGjfvfp0jwZq+v3PWy/FCaysN1bnHO/Sk5496uL78Nva6wNtr7ZdNlbUkxfemKA8e3z
        gYcnut05nr2eXz11QdajiAglluKMREMt5qLiRADX31yBrgIAAA==
Message-Id: <20180628124126eucas1p1396d8b111c6aee82ff979ee2106479c2~8U2mRg4Q11877318773eucas1p1k@eucas1p1.samsung.com>
X-CMS-MailID: 20180628124126eucas1p1396d8b111c6aee82ff979ee2106479c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180621231851epcas5p2a1c539dbc839c7c47f32e91460ad8e47
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180621231851epcas5p2a1c539dbc839c7c47f32e91460ad8e47
References: <CGME20180621231851epcas5p2a1c539dbc839c7c47f32e91460ad8e47@epcas5p2.samsung.com>
        <20180621231759.29604-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.2018 01:17, Eric Anholt wrote:
> This allows panels or bridges that need to send DSI commands during
> pre_enable() to successfully send them.  We delay DISP0 (aka the
> actual display) enabling until after pre_enable so that pixels aren't
> streaming before then.
>
> v2: Just clear out the encoder->bridge value to disable the midlayer
>     calls (idea by Andrzej Hajda).
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> ---
>  drivers/gpu/drm/vc4/vc4_dsi.c | 42 ++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 8aa897835118..9c8e89372d1c 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -814,7 +814,9 @@ static void vc4_dsi_encoder_disable(struct drm_encoder *encoder)
>  	struct vc4_dsi *dsi = vc4_encoder->dsi;
>  	struct device *dev = &dsi->pdev->dev;
>  
> +	drm_bridge_disable(dsi->bridge);
>  	vc4_dsi_ulps(dsi, true);
> +	drm_bridge_post_disable(dsi->bridge);
>  
>  	clk_disable_unprepare(dsi->pll_phy_clock);
>  	clk_disable_unprepare(dsi->escape_clock);
> @@ -1089,21 +1091,6 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
>  	/* Display reset sequence timeout */
>  	DSI_PORT_WRITE(PR_TO_CNT, 100000);
>  
> -	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> -		DSI_PORT_WRITE(DISP0_CTRL,
> -			       VC4_SET_FIELD(dsi->divider,
> -					     DSI_DISP0_PIX_CLK_DIV) |
> -			       VC4_SET_FIELD(dsi->format, DSI_DISP0_PFORMAT) |
> -			       VC4_SET_FIELD(DSI_DISP0_LP_STOP_PERFRAME,
> -					     DSI_DISP0_LP_STOP_CTRL) |
> -			       DSI_DISP0_ST_END |
> -			       DSI_DISP0_ENABLE);
> -	} else {
> -		DSI_PORT_WRITE(DISP0_CTRL,
> -			       DSI_DISP0_COMMAND_MODE |
> -			       DSI_DISP0_ENABLE);
> -	}
> -
>  	/* Set up DISP1 for transferring long command payloads through
>  	 * the pixfifo.
>  	 */
> @@ -1128,6 +1115,25 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
>  
>  	vc4_dsi_ulps(dsi, false);
>  
> +	drm_bridge_pre_enable(dsi->bridge);
> +
> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> +		DSI_PORT_WRITE(DISP0_CTRL,
> +			       VC4_SET_FIELD(dsi->divider,
> +					     DSI_DISP0_PIX_CLK_DIV) |
> +			       VC4_SET_FIELD(dsi->format, DSI_DISP0_PFORMAT) |
> +			       VC4_SET_FIELD(DSI_DISP0_LP_STOP_PERFRAME,
> +					     DSI_DISP0_LP_STOP_CTRL) |
> +			       DSI_DISP0_ST_END |
> +			       DSI_DISP0_ENABLE);
> +	} else {
> +		DSI_PORT_WRITE(DISP0_CTRL,
> +			       DSI_DISP0_COMMAND_MODE |
> +			       DSI_DISP0_ENABLE);
> +	}
> +
> +	drm_bridge_enable(dsi->bridge);
> +
>  	if (debug_dump_regs) {
>  		DRM_INFO("DSI regs after:\n");
>  		vc4_dsi_dump_regs(dsi);
> @@ -1639,6 +1645,12 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
>  		dev_err(dev, "bridge attach failed: %d\n", ret);
>  		return ret;
>  	}
> +	/* Disable the atomic helper calls into the bridge.  We
> +	 * manually call the bridge pre_enable / enable / etc. calls
> +	 * from our driver, since we need to sequence them within the
> +	 * encoder's enable/disable paths.
> +	 */
> +	dsi->encoder->bridge = NULL;
>  
>  	pm_runtime_enable(dev);
>  


