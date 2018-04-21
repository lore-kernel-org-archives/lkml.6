Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeDUQzM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 12:55:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34354 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbeDUQzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 12:55:10 -0400
X-Google-Smtp-Source: AIpwx494IPqCTqauD0h1Cmapjb27rb0TX3Zp5A17MGovk9+my8GG07iSK/vHI5MMRVFXPXbMm/oVMQ==
Subject: Re: [PATCH net-next 0/4] mm,tcp: provide mmap_hook to solve lockdep
 issue
To: Christoph Hellwig <hch@infradead.org>,
        Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20180420155542.122183-1-edumazet@google.com>
 <20180421090722.GA11998@infradead.org>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <f9d07a33-4fad-62a8-898a-ebf6ed47a721@gmail.com>
Date: Sat, 21 Apr 2018 09:55:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180421090722.GA11998@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/21/2018 02:07 AM, Christoph Hellwig wrote:
> On Fri, Apr 20, 2018 at 08:55:38AM -0700, Eric Dumazet wrote:
>> This patch series provide a new mmap_hook to fs willing to grab
>> a mutex before mm->mmap_sem is taken, to ensure lockdep sanity.
>>
>> This hook allows us to shorten tcp_mmap() execution time (while mmap_sem
>> is held), and improve multi-threading scalability. 
> 
> Missing CC to linu-fsdevel and linux-mm that will have to decide.
> 
> We've rejected this approach multiple times before, so you better
> make a really good argument for it.
> 

Well, tcp code needs to hold socket lock before mm->mmap_sem, so current
mmap hook can not fit. Or we need to revisit all code doing copyin/copyout while
holding a socket lock. (Not feasible really)


> introducing a multiplexer that overloads a single method certainly
> doesn't help making that case.

Well, if you refer to multiple hooks instead of a single one, I basically
thought that since only TCP needs this hook at the moment,
it was not worth adding extra 8-bytes loads for all other mmap() users.

I have no issue adding more hooks and more memory pressure if this is the blocking factor.

We need two actions at this moment, (to lock the socket or release it)
and a third one would allow us to build the array of pages
before grabbing mmap_sem (as I mentioned in the last patch changelog)
