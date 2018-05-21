Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeEUSPu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:15:50 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45396 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753255AbeEUSPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:15:44 -0400
X-Google-Smtp-Source: AB8JxZoEjTU2Edt+bxOJ4EwqgHzf6wJCUKWswmDZMMRyqJ9faf2MThWwL897K+4k4g4bYLkcI6Fneg==
Subject: Re: INFO: rcu detected stall in corrupted
To: Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        syzbot+f116bc1994efe725d51b@syzkaller.appspotmail.com
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, roopa@cumulusnetworks.com
References: <00000000000007eb20056cbb245f@google.com>
 <20180521.140924.2255125685012645769.davem@davemloft.net>
 <f8d0d282-1e75-d86a-8872-e32b57a6ec14@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <dada303b-bad2-212d-adb5-cfde28476a23@gmail.com>
Date: Mon, 21 May 2018 12:15:41 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f8d0d282-1e75-d86a-8872-e32b57a6ec14@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/18 12:13 PM, Eric Dumazet wrote:
> 
> 
> On 05/21/2018 11:09 AM, David Miller wrote:
>> From: syzbot <syzbot+f116bc1994efe725d51b@syzkaller.appspotmail.com>
>> Date: Mon, 21 May 2018 11:05:02 -0700
>>
>>>  find_match+0x244/0x13a0 net/ipv6/route.c:691
>>>  find_rr_leaf net/ipv6/route.c:729 [inline]
>>>  rt6_select net/ipv6/route.c:779 [inline]
>>
>> Hmmm, endless loop in find_rr_leaf or similar?
>>
> 
> 
> I do not think so, this really looks like SCTP specific 
> , we now have dozens of traces all sharing :
> 
>  sctp_transport_route+0xad/0x450 net/sctp/transport.c:293
>  sctp_packet_config+0xb89/0xfd0 net/sctp/output.c:123
>  sctp_outq_flush+0x79c/0x4370 net/sctp/outqueue.c:894
>  sctp_outq_uncork+0x6a/0x80 net/sctp/outqueue.c:776
>  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1820 [inline]
>  sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
>  sctp_do_sm+0x596/0x7160 net/sctp/sm_sideeffect.c:1191
>  sctp_generate_heartbeat_event+0x218/0x450 net/sctp/sm_sideeffect.c:406
>  call_timer_fn+0x230/0x940 kernel/time/timer.c:1326 
> 
> 
> Some kind of infinite loop.
> 
> When the hrtimer fires, it can point to any code that sits below but does not necessarily have a bug.
> 

Just so we are looking at the right tree, the original message shows:

> HEAD commit:    771c577c23ba Linux 4.17-rc6
> git tree:       upstream

I take that to mean this is Linus' tree.
