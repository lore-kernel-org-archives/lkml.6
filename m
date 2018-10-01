Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83F0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4BF2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4BF2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbeJAQ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:26:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51433 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728960AbeJAQ0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:26:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 425D8208F4; Mon,  1 Oct 2018 11:49:09 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 155AD2039F;
        Mon,  1 Oct 2018 11:48:59 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:49:00 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net] net: mscc: fix the frame extraction into the skb
Message-ID: <20181001094900.GB2967@piout.net>
References: <20180920100854.19044-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180920100854.19044-1-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2018 12:08:54+0200, Antoine Ténart wrote:
> When extracting frames from the Ocelot switch, the frame check sequence
> (FCS) is present at the end of the data extracted. The FCS was put into
> the sk buffer which introduced some issues (as length related ones), as
> the FCS shouldn't be part of an Rx sk buffer.
> 
> This patch fixes the Ocelot switch extraction behaviour by discarding
> the FCS.
> 
> Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> 
> Hi all,
> 
> Once this patch will be accepted and net merged into net-next, I'll
> probably send another patch to fill skb->csum with the FCS based on
> NETIF_F_RXFCS.
> 
> Thanks!
> Antoine
> 
>  drivers/net/ethernet/mscc/ocelot_board.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
> index 26bb3b18f3be..3cdf63e35b53 100644
> --- a/drivers/net/ethernet/mscc/ocelot_board.c
> +++ b/drivers/net/ethernet/mscc/ocelot_board.c
> @@ -91,7 +91,7 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
>  		struct sk_buff *skb;
>  		struct net_device *dev;
>  		u32 *buf;
> -		int sz, len;
> +		int sz, len, buf_len;
>  		u32 ifh[4];
>  		u32 val;
>  		struct frame_info info;
> @@ -116,14 +116,20 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
>  			err = -ENOMEM;
>  			break;
>  		}
> -		buf = (u32 *)skb_put(skb, info.len);
> +		buf_len = info.len - ETH_FCS_LEN;
> +		buf = (u32 *)skb_put(skb, buf_len);
>  
>  		len = 0;
>  		do {
>  			sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
>  			*buf++ = val;
>  			len += sz;
> -		} while ((sz == 4) && (len < info.len));
> +		} while (len < buf_len);
> +
> +		/* Read the FCS and discard it */
> +		sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
> +		/* Update the statistics if part of the FCS was read before */
> +		len -= ETH_FCS_LEN - sz;
>  
>  		if (sz < 0) {
>  			err = sz;
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
