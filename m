Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3DAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 19:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD223217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 19:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pbGyShBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbeLWTOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 14:14:33 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:18928 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbeLWTOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 14:14:32 -0500
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Dec 2018 14:14:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1545592470;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=E8sMHdpZ56bdbaNqESoFKn20Q1s8hoTdAcM2MB+qsRo=;
        b=pbGyShBEluBSCnavpXuHnB6h+XQhfX4k5LWb3gzzS/L9cgVvQmmatR0KJeHLWRQAZy
        LJ4Xzn+1C0NKBIlh6xg58+zBisd02XgMynKrIrx8J+VZND6p3aTSTTi1BX7QKovirkM4
        WoeKe6+zxtUhJLNahvI4lQCm+dLQKxdjvnVk+8gSuaMd//9eldJdQTyAjedNoor7OKY9
        cbtUgENskSft7BFxOCDKeArITS7tG47O8tVBVRYvU/G+IzsyIX1jtpAhuNcrGayFckgX
        hi5g9SOweBuCvh9/nw/zwSIS2EaPLoAcgsy9ne7Yam0f9f+z7giQ39lh6biRp71qeY9t
        zEQg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3DbdV+MXxxxQl9RzJU="
X-RZG-CLASS-ID: mo00
Received: from [172.20.10.3]
        by smtp.strato.de (RZmta 44.8 DYNA|AUTH)
        with ESMTPSA id L0b8b9uBNJ2PHSq
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 23 Dec 2018 20:02:25 +0100 (CET)
Subject: Re: [PATCH] can: af_can: Fix Spectre v1 vulnerability
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181221212229.GA32635@embeddedor>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <f0c42e0b-7d10-be7e-4b52-82567cf747eb@hartkopp.net>
Date:   Sun, 23 Dec 2018 20:02:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181221212229.GA32635@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After *trying* to follow the discussion on ...

https://marc.info/?l=linux-kernel&m=154554485324143&w=2
[PATCH] net: core: Fix Spectre v1 vulnerability

... I'm still not sure whether af_can.c needs this enhancement or not.

Just waiting for the end of the discussion :-)

Thanks to the experts!

Oliver

On 12/21/18 10:22 PM, Gustavo A. R. Silva wrote:
> protocol is indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> net/can/af_can.c:115 can_get_proto() warn: potential spectre issue 'proto_tab' [w]
> 
> Fix this by sanitizing protocol before using it to index proto_tab.
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   net/can/af_can.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 1684ba5b51eb..cade7250c6d4 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -59,6 +59,7 @@
>   #include <linux/can/core.h>
>   #include <linux/can/skb.h>
>   #include <linux/ratelimit.h>
> +#include <linux/nospec.h>
>   #include <net/net_namespace.h>
>   #include <net/sock.h>
>   
> @@ -136,6 +137,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
>   
>   	if (protocol < 0 || protocol >= CAN_NPROTO)
>   		return -EINVAL;
> +	protocol = array_index_nospec(protocol, CAN_NPROTO);
>   
>   	cp = can_get_proto(protocol);
>   
> 
