Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98966C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F0720693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F0720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935578AbeFRRyy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:54:54 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54312 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935347AbeFRRyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:54:52 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 418dyx0WQ1z1qymB;
        Mon, 18 Jun 2018 19:54:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 418dyw66lFz1qqlB;
        Mon, 18 Jun 2018 19:54:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id t-jXgtYc5GZs; Mon, 18 Jun 2018 19:54:48 +0200 (CEST)
X-Auth-Info: YJ9Xv45Ot+XN3njQQ+a1fJKCJDrzrQXP5VLkQtegbF0lFA4xbe7nHukbVjCk4Mcq
Received: from igel.home (ppp-188-174-155-192.dynamic.mnet-online.de [188.174.155.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 18 Jun 2018 19:54:48 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 884A82C10B2; Mon, 18 Jun 2018 19:54:47 +0200 (CEST)
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
        <m2tvq1672p.fsf@linux-m68k.org>
        <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com>
X-Yow:  Yow!  I'm out of work...I could go into shock absorbers...or SCUBA
 GEAR!!
Date:   Mon, 18 Jun 2018 19:54:47 +0200
In-Reply-To: <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com> (Eric Dumazet's
        message of "Sun, 17 Jun 2018 15:54:48 -0700")
Message-ID: <87o9g8geu0.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 17 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:

> Oh this is silly, please try :
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c642304f178ce0a4e1358d59e45032a39f76fb3f..54dd9c18ecad817812898d6f335e1794a07dabbe 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1845,10 +1845,9 @@ EXPORT_SYMBOL(___pskb_trim);
>  int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
>  {
>         if (skb->ip_summed == CHECKSUM_COMPLETE) {
> -               int delta = skb->len - len;
> +               __wsum csumdiff = skb_checksum(skb, len, skb->len - len, 0);
>  
> -               skb->csum = csum_sub(skb->csum,
> -                                    skb_checksum(skb, len, delta, 0));
> +               skb->csum = csum_block_sub(skb->csum, csumdiff, len);
>         }
>         return __pskb_trim(skb, len);
>  }

That doesn't help either.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
