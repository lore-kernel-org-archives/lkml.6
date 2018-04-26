Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755861AbeDZVlE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:41:04 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40872 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeDZVlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:41:02 -0400
X-Google-Smtp-Source: AB8JxZpkoiX0QFuvF+7H3Je9LqlJ7cBdd7jMjAPHqenuzyEr4itNvQ0s2oH8Qz4Uq/YAZIUy8G8aJg==
Subject: Re: [PATCH v2 net-next 0/2] tcp: mmap: rework zerocopy receive
To: Andy Lutomirski <luto@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20180425214307.159264-1-edumazet@google.com>
 <CACSApvZF8CJqcRx7FGkMGitBiC6m0=_FT9XRZ=VV07U62wGM3Q@mail.gmail.com>
 <a2c405e1-0ebc-dd33-fb0d-575bf06a1ff6@gmail.com>
 <CALCETrVBQD1tPUzc_t7HmoPfApTdFW+x-0DqL8+XHjrmEpYMXQ@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <2a8ea6bd-02dd-14dd-c797-2d8cba626f79@gmail.com>
Date: Thu, 26 Apr 2018 14:40:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVBQD1tPUzc_t7HmoPfApTdFW+x-0DqL8+XHjrmEpYMXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/26/2018 02:16 PM, Andy Lutomirski wrote:
> At the risk of further muddying the waters, there's another minor tweak
> that could improve performance on certain workloads.  Currently you mmap()
> a range for a given socket and then getsockopt() to receive.  If you made
> it so you could mmap() something once for any number of sockets (by
> mmapping /dev/misc/tcp_zero_receive or whatever), then the performance of
> the getsockopt() bit would be identical, but you could release the mapping
> for many sockets at once with only a single flush.  For some use cases,
> this could be a big win.
> 
> You could also add this later easily enough, too.
> 

I believe I implemented what you just described.

The getsockopt() call checks that the VMA was created by a mmap() to one TCP socket.

It does not check that the vma was created by mmap() on the same socket,
because we do not need this extra check really.

So you presumably could use mmap() to grab 1GB of virtual space, then split it
as you wish for different sockets.

Thanks.
