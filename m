Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE16C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BAE2184E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2IRDZ/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfBZPL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:11:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36220 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfBZPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:11:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so6388381pfa.3;
        Tue, 26 Feb 2019 07:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bgBZNX6iyrEXkdOumTSBJNu0SZhygdEAjgAqZKxgZew=;
        b=X2IRDZ/ibMad3gRqT2+30Rbja18WP3XTgvttZTFkTR91eh6QATeM2HRznssUBqgCYl
         y8FdswbRsORowptHMACaSr6uvPibOcbzGWr0dV4cKQzmJTdh7hglslwT6JKxJKZ7gN3W
         2Zj/Pj6UzwJzN/PwIOZkWboh79WzYHJss74pQMkUDJxIzSI0IX8bE59XUl0jsHEcAQLZ
         M3nDGQljvgdh023pTBpCOq357V36y94FE0uU64xcmHSurOSNiNVgNHSJYrbMnt//BSUH
         enqo6sonF5uf6pJEYLFNx6Cd78eUNkszo48YyXxxHi9BgsSEEPCpfsuA/hUsZq76A3o+
         DfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bgBZNX6iyrEXkdOumTSBJNu0SZhygdEAjgAqZKxgZew=;
        b=RkLpkgSEF73OeX+CgHdUEDUTwJUxYZuLTl95EqwIrHsjLnJLyBQa/ek4AafZ8Jn8wk
         OXTX4qphoZC4BidtXXpgvUEcRXUo7o2GF2HpozVZ5y8rY/0+B/YHTbhYI3Pg112aGtG2
         IM7tS+sd/vwmQi/j8cDJWj6QeZ5qnntmY6AtnBtKaNEEIZMnkyVUTZXgH4a3i6yZaUgY
         9iZ02t19q7d45QFgZpr59oMiqBXZ/s0QxmniDjec+Xul3Li3CIfkPVUpzAZtR/3Eablm
         7DidxUSOLOsBi040CgVBwn/Ukrb9crTNt8d12/HoDqcvL/HVXLQF8Y176M+yDrjmGC26
         mlIA==
X-Gm-Message-State: AHQUAub72ZabQ9Q39H7Szw59D/sj+PbAR5CUFDArwMKa8sVFSAImyUMV
        cctqJ4R6cI84iuJxuIOeYUnpHzqs
X-Google-Smtp-Source: AHgI3IaS/oKz5PvMfWF+ZzXXUQp2/EVSTAQ1wyOHfZSjZm5tOtlIp6vrWbuCUMThpJm9ECUDLuxUfw==
X-Received: by 2002:aa7:9289:: with SMTP id j9mr26722540pfa.130.1551193915576;
        Tue, 26 Feb 2019 07:11:55 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id k18sm6837115pfj.92.2019.02.26.07.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 07:11:53 -0800 (PST)
Subject: Re: [PATCH] tcp: fix __tcp_transmit_skb's comment text
To:     Geliang Tang <geliangtang@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5599b6d78fa7f5a05d40123d43f955174c2c5baa.1551169935.git.geliangtang@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <353dd5fd-7364-4454-6d75-342ebce7c1c5@gmail.com>
Date:   Tue, 26 Feb 2019 07:11:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5599b6d78fa7f5a05d40123d43f955174c2c5baa.1551169935.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/26/2019 12:41 AM, Geliang Tang wrote:
> The function name tcp_do_sendmsg has been renamed. But it still
> appears in __tcp_transmit_skb's comment text. This patch changes
> it to tcp_sendmsg_locked.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index e72aa0ff5785..67a43b966b8a 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1003,7 +1003,7 @@ static void tcp_update_skb_after_send(struct sock *sk, struct sk_buff *skb,
>  }
>  
>  /* This routine actually transmits TCP packets queued in by
> - * tcp_do_sendmsg().  This is used by both the initial
> + * tcp_sendmsg_locked().  This is used by both the initial
>   * transmission and possible later retransmissions.
>   * All SKB's seen here are completely headerless.  It is our
>   * job to build the TCP header, and pass the packet down to
> 

Not sure your patch helps, packets can also be put in write queue
by many different functions, including tcp_sendmsg_locked().



