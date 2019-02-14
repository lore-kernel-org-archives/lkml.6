Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1FBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75517222D2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437795AbfBNJec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:34:32 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:57080 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388196AbfBNJec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:34:32 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 4BBAE480064;
        Thu, 14 Feb 2019 09:34:30 +0000 (UTC)
Received: from hgk-desktop.uk.solarflarecom.com (10.17.20.82) by
 ukex01.SolarFlarecom.com (10.17.10.4) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 09:34:24 +0000
Subject: Re: [PATCH 2/2] net: Replace dev_kfree_skb_any by dev_consume_skb_any
To:     Huang Zijiang <huang.zijiang@zte.com.cn>,
        <linux-net-drivers@solarflare.com>
CC:     <ecree@solarflare.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wang.yi59@zte.com.cn>
References: <1550126533-28462-1-git-send-email-huang.zijiang@zte.com.cn>
From:   Bert Kenward <bkenward@solarflare.com>
Message-ID: <f0f1b6ea-9568-c3e9-a92e-43fc87d253c4@solarflare.com>
Date:   Thu, 14 Feb 2019 09:34:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550126533-28462-1-git-send-email-huang.zijiang@zte.com.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.82]
X-ClientProxiedBy: ocex03.SolarFlarecom.com (10.20.40.36) To
 ukex01.SolarFlarecom.com (10.17.10.4)
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24428.003
X-TM-AS-Result: No-9.497300-8.000000-10
X-TMASE-MatchedRID: pBwXUM+nCwu4FBGXUfhfYia1MaKuob8PC/ExpXrHizwlC3U/r0iv84aR
        iUQlb8ekYoZZSMRmp2KTh3oFoyKmrLBAQLqGlKiv4pdq9sdj8LVudYzMeKOrpJsoi2XrUn/JyeM
        tMD9QOgChMIDkR/KfwBMQLQ/0+9hG3QfwsVk0UbvWxQsAIHSpEgMv90UHEXNDF3ujjkAkFB8Tf9
        VK/bVaw4wOgVtaJ/BAgxsKo5BsMSKUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.497300-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24428.003
X-MDID: 1550136871-rl2QF-d0rIhh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2019 06:42, Huang Zijiang wrote:
> The skb should be freed by dev_consume_skb_any() efx_tx_tso_fallback()
> when skb is still used. The skb is be replaced by segments, so the
> original skb should be consumed(not drop).
> 
> Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>

Sergei's commit message fixups look good, but apart from that:

Acked-by: Bert Kenward <bkenward@solarflare.com>

> ---
>  drivers/net/ethernet/sfc/tx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/tx.c b/drivers/net/ethernet/sfc/tx.c
> index c3ad564..ed551f0 100644
> --- a/drivers/net/ethernet/sfc/tx.c
> +++ b/drivers/net/ethernet/sfc/tx.c
> @@ -471,7 +471,7 @@ static int efx_tx_tso_fallback(struct efx_tx_queue *tx_queue,
>  	if (IS_ERR(segments))
>  		return PTR_ERR(segments);
>  
> -	dev_kfree_skb_any(skb);
> +	dev_consume_skb_any(skb);
>  	skb = segments;
>  
>  	while (skb) {
> 
