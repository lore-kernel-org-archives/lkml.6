Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC8EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E816D2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E816D2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alphalink.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeKJBOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:14:41 -0500
Received: from zimbra.alphalink.fr ([217.15.80.77]:46369 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeKJBOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:14:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id A92E12B52055;
        Fri,  9 Nov 2018 16:33:34 +0100 (CET)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Gl5HQgL6xXBH; Fri,  9 Nov 2018 16:33:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 16A8E2B5213B;
        Fri,  9 Nov 2018 16:33:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5hXsKFU8k1Wk; Fri,  9 Nov 2018 16:33:32 +0100 (CET)
Received: from c-dev-0.admin.alphalink.fr (94-84-15-217.reverse.alphalink.fr [217.15.84.94])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id DEA422B52055;
        Fri,  9 Nov 2018 16:33:32 +0100 (CET)
Received: by c-dev-0.admin.alphalink.fr (Postfix, from userid 1000)
        id C0C5260188; Fri,  9 Nov 2018 16:33:32 +0100 (CET)
Date:   Fri, 9 Nov 2018 16:33:32 +0100
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.4 063/114] l2tp: hold socket before dropping lock in
 l2tp_ip{, 6}_recv()
Message-ID: <20181109153332.GD1415@alphalink.fr>
References: <20181108215059.051093652@linuxfoundation.org>
 <20181108215106.791041209@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108215106.791041209@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:51:18PM -0800, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
This patch was partly wrong. Here is the followup fix:
94d7ee0baa8b ("l2tp: hold tunnel socket when handling control frames in l2tp_ip and l2tp_ip6")

Both a3c18422a4 ("l2tp: hold socket before dropping lock in l2tp_ip{, 6}_recv()")
and 94d7ee0baa8b ("l2tp: hold tunnel socket when handling control frames in l2tp_ip and l2tp_ip6")
should be applied/backported together.

> ------------------
> 
> [ Upstream commit a3c18422a4b4e108bcf6a2328f48867e1003fd95 ]
> 
> Socket must be held while under the protection of the l2tp lock; there
> is no guarantee that sk remains valid after the read_unlock_bh() call.
> 
> Same issue for l2tp_ip and l2tp_ip6.
> 
> Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/l2tp/l2tp_ip.c  | 11 ++++++-----
>  net/l2tp/l2tp_ip6.c | 11 ++++++-----
>  2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
> index 48ab93842322..c7e6098c924e 100644
> --- a/net/l2tp/l2tp_ip.c
> +++ b/net/l2tp/l2tp_ip.c
> @@ -184,14 +184,15 @@ pass_up:
>  
>  		read_lock_bh(&l2tp_ip_lock);
>  		sk = __l2tp_ip_bind_lookup(net, iph->daddr, 0, tunnel_id);
> +		if (!sk) {
> +			read_unlock_bh(&l2tp_ip_lock);
> +			goto discard;
> +		}
> +
> +		sock_hold(sk);
sock_hold(sk) is missing in the 'if' branch of this condition.

>  		read_unlock_bh(&l2tp_ip_lock);
>  	}
>  
> -	if (sk == NULL)
> -		goto discard;
> -
> -	sock_hold(sk);
> -
Original sock_hold(sk) covered both parts of the condition.

>  	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb))
>  		goto discard_put;
>  
> diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
> index bcdab1cba773..5fe0a6f6af3d 100644
> --- a/net/l2tp/l2tp_ip6.c
> +++ b/net/l2tp/l2tp_ip6.c
> @@ -196,14 +196,15 @@ pass_up:
>  		read_lock_bh(&l2tp_ip6_lock);
>  		sk = __l2tp_ip6_bind_lookup(&init_net, &iph->daddr,
>  					    0, tunnel_id);
> +		if (!sk) {
> +			read_unlock_bh(&l2tp_ip6_lock);
> +			goto discard;
> +		}
> +
> +		sock_hold(sk);
Same here.

>  		read_unlock_bh(&l2tp_ip6_lock);
>  	}
>  
> -	if (sk == NULL)
> -		goto discard;
> -
> -	sock_hold(sk);
> -
>  	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
>  		goto discard_put;
>  
> -- 
> 2.17.1
> 
