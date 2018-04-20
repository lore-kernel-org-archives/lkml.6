Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755180AbeDTOVj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:21:39 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:43258 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755031AbeDTOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:21:37 -0400
X-Google-Smtp-Source: AIpwx4+cUCvCkXehg1MRUnrDHbrwoSRrLnqdUaeT1o3Zyyta3yAVPmRRv8VO1GIlYqX6aoWDsVYPlg==
Subject: Re: [PATCH net] tcp: don't read out-of-bounds opsize
To: Jann Horn <jannh@google.com>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180420135730.44921-1-jannh@google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <552d49b6-1b6e-c320-b56a-a119e360f1d7@gmail.com>
Date: Fri, 20 Apr 2018 07:21:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180420135730.44921-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/20/2018 06:57 AM, Jann Horn wrote:
> The old code reads the "opsize" variable from out-of-bounds memory (first
> byte behind the segment) if a broken TCP segment ends directly after an
> opcode that is neither EOL nor NOP.
> 
> The result of the read isn't used for anything, so the worst thing that
> could theoretically happen is a pagefault; and since the physmap is usually
> mostly contiguous, even that seems pretty unlikely.
>

No page fault possible, because tcp headers are in skb->head

And we have 'struct skb_shared_info'  at the end of skb->head anyway.

But, yes, reading some extra bytes with random content is possible.
