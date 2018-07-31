Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6512C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53026208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY92Mm0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53026208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbeGaC1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:27:06 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38078 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbeGaC1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:27:06 -0400
Received: by mail-io0-f194.google.com with SMTP id v26-v6so11516174iog.5;
        Mon, 30 Jul 2018 17:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TqnAdbkQDuh+Ktioemj6ij3zWXgjk6n72gJxc8WN4vI=;
        b=QY92Mm0U4VX9r3Va57V+UOYpdulFGMRNfA+W640IX/+C5s+gZ1CAYRZUMNet5Y84hJ
         gn46y6eXcgltMlRKB7S+6sgAFDCQ6HffP/80cLPMv2vlU/VOlsiRDbJHmr3hMWiQAMnQ
         lXYybSYfM9gEdXVWWRn3nni99hf4UvlNCs6OZEF0+9ByAcxESHcs0MC9znNmAd3RXZtr
         lG/kJ9DGbc3QNJJSbgznXv+jAQeYst1OPXbrXPtTKLYkITiQOhA0wvP94CufOEQLbTH/
         q2Y2u/2zwb8eE7BY51xQ89aR58AW0Z1p5Ss7Tfcd+dIWeYGiRA59Fz0q3LYzUykqITPP
         bDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TqnAdbkQDuh+Ktioemj6ij3zWXgjk6n72gJxc8WN4vI=;
        b=rZa/lySapM+IKDC4hA14odsaT5MbkfOQpiZh/W+LNrt1qqhgmU9K9WkDIEM1m8MakI
         4RArMXuAbmJcd2MVeD2mJQ7FmbpzAtG1irjoh3xpeZF+8Wb99aNSr4POx89NFs44jwSp
         RtDTeh5/G0cpLJPoij32Z5ZnLf4c/nkANn9lICSjo9jFMjhPy/L9nB5u07zMwEVQCZyu
         xWIyDFYifmuXZ0xSVT3TC5sTfVC1zdNO/ept7t/AeZG6xtwZFg88b3UCQxko8U94RGpL
         E6MZNgY1pVAhLzGutkBllmBUqWYNsLQGvKCQYrh//2DA1fhHrSS4X0EJaLJId9vxPFZr
         DmCA==
X-Gm-Message-State: AOUpUlGChTeBdMB7jDhUPdG3Ah023WYCJRNPw9vJv67cOKtEiQVuZBEY
        /tdNCY3rHAij/IBUHJdoe44J14b4Dij+8CRW3Ug=
X-Google-Smtp-Source: AAOMgpe6ala4jwKWw+kW7h48oKl/Lf4MmuwX9+gmDB2Q5SmcSi9crkeQXeYH/gwz2MMtaodjx3SfmwV8B2DlVKFeG2E=
X-Received: by 2002:a6b:c8c8:: with SMTP id y191-v6mr15365437iof.295.1532998170089;
 Mon, 30 Jul 2018 17:49:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 17:48:49
 -0700 (PDT)
In-Reply-To: <CANn89iK4KLHww-R2JmNr-tYVcUWevq6ceFQW0qE2mJCsq6eL-g@mail.gmail.com>
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
 <CANn89iJ=Ad7sVWr3zBmXNSyePJJZaxgnMymN8S7x6fCSvG2jTQ@mail.gmail.com>
 <CALOAHbC4Rs7w1RwZRBsw_fjGSDvuHV37=nguzJNZzkreR5f4Dw@mail.gmail.com>
 <CANn89iKXPu=RKkLop4NJWZLixE__qYV2S=PngSj6ienuvWWL8g@mail.gmail.com>
 <CALOAHbAjtNf1LOhWEJMKNEEHSxjfEKiVV22KPUK88CTzt-eW0w@mail.gmail.com>
 <CANn89i+12HvAsvk9crDcqGh=v-DvLjuGQCOzVTPVDTUhHgeDiw@mail.gmail.com>
 <CALOAHbBFuASgsQK+iiAE+ebPOg5zjtzauYaN_Xtmfc9_wjTFgw@mail.gmail.com>
 <CANn89i+0peAq_BS3Ge-h2_MENHQAHtf8D_M0gzgchK6CxU8D+Q@mail.gmail.com>
 <CALOAHbBy6wEwDcVaWx9PG35jknwkhM-Y-TVyis3TpVQYr5K-Jw@mail.gmail.com> <CANn89iK4KLHww-R2JmNr-tYVcUWevq6ceFQW0qE2mJCsq6eL-g@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 31 Jul 2018 08:48:49 +0800
Message-ID: <CALOAHbCcK5OoGn1Zc_CDYwM9FXKgi0wk8zq8xB1wHyH4iZTxZA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: call tcp_drop() in tcp collapse
To:     Eric Dumazet <edumazet@google.com>
Cc:     Brendan Gregg <bgregg@netflix.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:56 PM, Eric Dumazet <edumazet@google.com> wrote:
> On Sun, Jul 29, 2018 at 10:40 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
>> Should we put NET_INC_STATS(sock_net(sk),  mib_idx) into the funtion
>> tcp_drop() ?
>> Then we could easily relate the sk_drops with the SNMP counters.
>>
>> Something like that,
>>
>>     static void tcp_drop(struct sock *sk, struct sk_buff *skb, int mib_idx)
>>     {
>>         int segs = max_t(u16, 1, skb_shinfo(skb)->gso_segs);
>>
>>         atomic_add(segs, &sk->sk_drops);
>>         NET_ADD_STATS(sock_net(sk), mib_idx, segs);
>>         __kfree_skb(skb);
>>     }
>
> We had a discussion during netconf, and Brendan Gregg was working on
> an idea like that,
> so that distinct events could be traced/reported.
>

Oh yes, introducing a new tracepoint for it should be better.
trace_tcp_probe(sk, skb, mib_idx);

> I prefer letting Brendan submit his patch, which not only refactors
> things, but add new functionality.
>

OK.
