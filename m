Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A6DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25503206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbeLPQiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:38:09 -0500
Received: from zimbra.alphalink.fr ([217.15.80.77]:58952 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbeLPQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 11:38:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 485712B5202D;
        Sun, 16 Dec 2018 17:29:22 +0100 (CET)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aVyryvOCQWW6; Sun, 16 Dec 2018 17:29:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id A500F2B52035;
        Sun, 16 Dec 2018 17:29:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qT-yJbMPiA3c; Sun, 16 Dec 2018 17:29:20 +0100 (CET)
Received: from localhost (unknown [82.120.188.200])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTPSA id 565292B5202D;
        Sun, 16 Dec 2018 17:29:20 +0100 (CET)
Date:   Sun, 16 Dec 2018 17:29:57 +0100
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] l2tp: Add protocol field decompression
Message-ID: <20181216162605.qn2jjbyb2bgcbxgq@kdev>
References: <20181214175921.6859-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214175921.6859-1-semen.protsenko@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 07:59:21PM +0200, Sam Protsenko wrote:
> When Protocol Field Compression (PFC) is enabled, the "Protocol" field
> in PPP packet will be received without leading 0x00. See section 6.5 in
> RFC 1661 for details. So let's decompress protocol field if needed, the
> same way it's done in drivers/net/ppp/pptp.c.
> 
> In case when "nopcomp" pppd option is not enabled, PFC (pcomp) can be
> negotiated during LCP handshake, and L2TP driver in kernel will receive
> PPP packets with compressed Protocol field, which in turn leads to next
> error:
> 
>     Protocol Rejected (unsupported protocol 0x2145)
> 
> because instead of Protocol=0x0021 in PPP packet there will be
> Protocol=0x21. This patch unwraps it back to 0x0021, which fixes the
> issue.
> 
> Sending the compressed Protocol field will be implemented in subsequent
> patch, this one is self-sufficient.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  net/l2tp/l2tp_ppp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 04d9946dcdba..c03c6461f236 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -236,6 +236,10 @@ static void pppol2tp_recv(struct l2tp_session *session, struct sk_buff *skb, int
>  	    skb->data[1] == PPP_UI)
>  		skb_pull(skb, 2);
>  
> +	/* Decompress protocol field if PFC is enabled */
> +	if ((*skb->data) & 0x1)
> +		*(u8 *)skb_push(skb, 1) = 0;
> +
Sorry, but PFC is PPP stuff. It's absolutely independent from the
transport layer. Therefore, it belongs to ppp_generic.c and L2TP has
nothing do with it.

I know some other transports got it wrong, but let's stop
re-implementing PPP features in every lower layer. Teaching ppp_input()
about PFC is all that is needed to get the feature work correctly on
all transports. As a bonus, it'd bring PFC support to PPPoE and would
let us drop the duplicated code from pptp.c, ppp_async.c and
ppp_synctty.c.

As an example of the problems caused by mixing the PPP and L2TP
layers, consider the case of L2TP sockets that aren't PPPOX_BOUND.
They're supposed to receive the original PPP frames. Now with your
patch if the protocol was compressed, the L2TP socket receives a fake
header. User space didn't ask for that and has no way to figure out
what was the original packet. To make things worse, that behaviour now
changes depending on the kernel version.

If you all agree, can we please revert this patch and properly
implement PFC in ppp_generic.c?
