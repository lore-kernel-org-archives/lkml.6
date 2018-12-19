Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04413C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8CD21841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbeLSOsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:48:07 -0500
Received: from zimbra.alphalink.fr ([217.15.80.77]:60184 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbeLSOsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:48:07 -0500
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2018 09:48:04 EST
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 8F1D82B52034;
        Wed, 19 Dec 2018 15:38:43 +0100 (CET)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6Y9L8_hzgLte; Wed, 19 Dec 2018 15:38:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id EF5B22B52058;
        Wed, 19 Dec 2018 15:38:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N8aZb0rzZc92; Wed, 19 Dec 2018 15:38:41 +0100 (CET)
Received: from c-dev-0.admin.alphalink.fr (94-84-15-217.reverse.alphalink.fr [217.15.84.94])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id AFF732B52034;
        Wed, 19 Dec 2018 15:38:41 +0100 (CET)
Received: by c-dev-0.admin.alphalink.fr (Postfix, from userid 1000)
        id 7EB636017C; Wed, 19 Dec 2018 15:38:41 +0100 (CET)
Date:   Wed, 19 Dec 2018 15:38:41 +0100
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppp: Move PFC decompression to PPP generic layer
Message-ID: <20181219143841.GC1338@alphalink.fr>
References: <20181219000808.28382-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219000808.28382-1-semen.protsenko@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:08:08AM +0200, Sam Protsenko wrote:
> Extract "Protocol" field decompression code from transport protocols to
> PPP generic layer, where it actually belongs. As a consequence, this
> patch fixes incorrect place of PFC decompression in L2TP driver (when
> it's not PPPOX_BOUND) and also enables this decompression for other
> protocols, like PPPoE.
> 
> Protocol field decompression also happens in PPP Multilink Protocol
> code and in PPP compression protocols implementations (bsd, deflate,
> mppe). It looks like there is no easy way to get rid of that, so it was
> decided to leave it as is, but provide those cases with appropriate
> comments instead.
> 
Yes, ideally we'd make PPP_PROTO() handle compressed protocol so that
we wouldn't need to decompress protocol field in place. But other parts
of the ppp code assume uncompressed protocol field in skb->data, so
let's stick with the current behaviour for now.

> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 500bc0027c1b..10c4c8eec995 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -1965,6 +1965,14 @@ ppp_do_recv(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
>  	ppp_recv_unlock(ppp);
>  }
>  
> +/* Decompress protocol field in PPP header if it's compressed */
> +static inline void
> +ppp_decompress_proto(struct sk_buff *skb)
> 
No need for inline keyword in .c files. Also, no need to split line
before function name. I know older function declarations of
ppp_generic.c do this, but let's stick to the general networking stack
style instead.

> +{
> +	if (skb->data[0] & 0x01)
> +		*(u8 *)skb_push(skb, 1) = 0x00;
> +}
> +
This assumes that we have at least 1 byte of head room and 1 byte of
linear data. Although that's what the original code did, I find that's
a bit dangerous. Maybe prefix the function name with '__' and add a
comment in the function description to warn the reader.

>  void
>  ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
>  {
> @@ -1986,6 +1994,7 @@ ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
>  		goto done;
>  	}
>  
> +	ppp_decompress_proto(skb);
> 
The pskb_may_pull(skb, 2) at the beginning of the functions is there
because we're going to read the protocol field. It doesn't make sense to
decompress it after this test (although technically that mostly works).

However, if we move ppp_decompress_proto() before pskb_may_pull(), then
callers must respect the requirements of ppp_decompress_proto().

>  	proto = PPP_PROTO(skb);
>  	if (!pch->ppp || proto >= 0xc000 || proto == PPP_CCPFRAG) {
>  		/* put it on the channel queue */
> @@ -2074,6 +2083,9 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
>  	if (ppp->flags & SC_MUST_COMP && ppp->rstate & SC_DC_FERROR)
>  		goto err;
>  
> +	/* At this point the "Protocol" field MUST be decompressed, either in
> +	 * ppp_decompress_frame() or in ppp_receive_mp_frame().
> +	 */
> 
Or ppp_input(). In the general case (no multilink header and no compression)
it's ppp_input() that'd decompress the protocol field.

> @@ -2290,9 +2305,11 @@ ppp_receive_mp_frame(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
>  
>  	/*
>  	 * Do protocol ID decompression on the first fragment of each packet.
> +	 * We can't wait for this to happen in ppp_input(), because
> +	 * ppp_receive_nonmp_frame() expects decompressed protocol field.
>  	 */
ppp_input() is not going to be called anyway. I think you can omit the
middle line entirely.
