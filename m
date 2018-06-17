Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B260C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 10:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4922C20693
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 10:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4922C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933624AbeFQK2D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 06:28:03 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:47633 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932679AbeFQK2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 06:28:01 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 417r5r2sQpz1qvyc;
        Sun, 17 Jun 2018 12:28:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 417r5r25ffz1qqkM;
        Sun, 17 Jun 2018 12:28:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id QOWN7psJjp1o; Sun, 17 Jun 2018 12:27:59 +0200 (CEST)
X-Auth-Info: rWtJt8g99fRXG+cudho5R53XTVIJCOvQrU4HAnAYPlrxoleNmkzc+GXF9QR4BW4f
Received: from linux.local (ppp-188-174-159-255.dynamic.mnet-online.de [188.174.159.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 17 Jun 2018 12:27:59 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
        id 916831E5885; Sun, 17 Jun 2018 12:27:58 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        Meelis Roos <mroos@linux.ee>, netdev@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends"
References: <20180615185645.8921-1-malat@debian.org>
        <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
        <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
        <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com>
X-Yow:  -- I can do ANYTHING ... I can even ... SHOPLIFT!!
Date:   Sun, 17 Jun 2018 12:27:58 +0200
In-Reply-To: <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com> (Eric Dumazet's
        message of "Sat, 16 Jun 2018 05:45:42 -0700")
Message-ID: <m2tvq1672p.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:

> I would try something like :
>
> Basically do not bother using CHECKSUM_COMPLETE for small frames that might have been padded.
>
> Since we need to bring one cache line in eth_type_trans() and further header processing,
> computing the checksum in software will be almost free anyway.
>
> diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
> index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..071039f211a8a33153e888bd4014314ba5e686a4 100644
> --- a/drivers/net/ethernet/sun/sungem.c
> +++ b/drivers/net/ethernet/sun/sungem.c
> @@ -855,9 +855,11 @@ static int gem_rx(struct gem *gp, int work_to_do)
>                         skb = copy_skb;
>                 }
>  
> -               csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
> -               skb->csum = csum_unfold(csum);
> -               skb->ip_summed = CHECKSUM_COMPLETE;
> +               if (len > ETH_ZLEN) {
> +                       csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
> +                       skb->csum = csum_unfold(csum);
> +                       skb->ip_summed = CHECKSUM_COMPLETE;
> +               }
>                 skb->protocol = eth_type_trans(skb, gp->dev);
>  
>                 napi_gro_receive(&gp->napi, skb);

That doesn't change anything.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
