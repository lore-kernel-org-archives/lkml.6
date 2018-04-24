Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932623AbeDXLmK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:42:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46302 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeDXLmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:42:06 -0400
X-Google-Smtp-Source: AIpwx4/64/tcZ0N4yAr//hpugEHns8YOqyqU0qALVCyD+/+z2zx5Pvx04QENdZ/TvVGnv5wnWMmDMA==
Subject: Re: [PATCH net-next] net: init sk_cookie for inet socket
To: Yafang Shao <laoar.shao@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc: David Miller <davem@davemloft.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1524405004-10960-1-git-send-email-laoar.shao@gmail.com>
 <20180423.115821.640630949143585629.davem@davemloft.net>
 <788ce3f1-6534-5c2e-1870-5ebd8ea4ae7f@gmail.com>
 <CALOAHbDpgOckQhW7_Ysi-F2HCoZW4RKSdUuvTquELJZsaMj6Lg@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <67a158d9-cd33-8c28-39c3-9cead4107205@gmail.com>
Date: Tue, 24 Apr 2018 04:41:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALOAHbDpgOckQhW7_Ysi-F2HCoZW4RKSdUuvTquELJZsaMj6Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/23/2018 09:39 PM, Yafang Shao wrote:
> On Tue, Apr 24, 2018 at 12:09 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>
>> On 04/23/2018 08:58 AM, David Miller wrote:
>>> From: Yafang Shao <laoar.shao@gmail.com>
>>> Date: Sun, 22 Apr 2018 21:50:04 +0800
>>>
>>>> With sk_cookie we can identify a socket, that is very helpful for
>>>> traceing and statistic, i.e. tcp tracepiont and ebpf.
>>>> So we'd better init it by default for inet socket.
>>>> When using it, we just need call atomic64_read(&sk->sk_cookie).
>>>>
>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>>
>>> Applied, thank you.
>>>
>>
>> This is adding yet another atomic_inc on a global cache line.
>>
> 
> That's a trade-off.
> 
>> Most applications do not need the cookie being ever set.
>>
>> The existing mechanism was fine. Set it on demand.
> 
> There are some drawback in the existing mechanism.
> - we have to set the net->cookie_gen and then sk->sk_cookie when we
> want to get the sk_cookie, that's a little expensive as well.

Same cost.

>   After that change, sock_gen_cookie() could be replaced by
> atomic64_read(&sk->sk_cookie) in most places.

Same cost than the helper.

> 
> - If the application want to get the sk_cookie, it must set it first.
>    What if the application don't have the permision to write?
>    Furthermore, maybe it is a security concern ?


Maybe ? Please elaborate.

Your patch destroys SYNFLOOD behavior.

I have spent months of work solving the SYNFLOOD behavior, your patch crushes it.

I am not that happy.

Please revert this patch.

Thank you.
