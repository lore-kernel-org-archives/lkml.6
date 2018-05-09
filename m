Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933695AbeEIDiU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 23:38:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932115AbeEIDiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 23:38:19 -0400
Subject: Re: BUG: spinlock bad magic in tun_do_read
To: Cong Wang <xiyou.wangcong@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc: syzbot <syzbot+e8b902c3c3fadf0a9dba@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Petar Penkov <peterpenkov96@gmail.com>,
        Sabrina Dubroca <sd@queasysnail.net>, syzkaller-bugs@googlegroups.com
References: <0000000000003f06aa056bab0943@google.com>
 <CAM_iQpXVsMzKochN7SY-CdHeACtJi3cC4oCfgzYdpqDMbo8Lcw@mail.gmail.com>
 <997afbee-1e89-aa5b-5b15-cad5a073cc38@gmail.com>
 <CAM_iQpW+vrecKuWTJ+zHt11ge7xPRWt=4GmZJxJ5Ffp_awV-ag@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9992abe5-57e6-4c2c-601d-fead7e441696@redhat.com>
Date: Wed, 9 May 2018 11:38:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpW+vrecKuWTJ+zHt11ge7xPRWt=4GmZJxJ5Ffp_awV-ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月09日 10:50, Cong Wang wrote:
> On Mon, May 7, 2018 at 11:04 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>> On 05/07/2018 10:54 PM, Cong Wang wrote:
>>> Yeah, we should return early before hitting this uninitialized ptr ring...
>>> Something like:
>>>
>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>> index ef33950a45d9..638c87a95247 100644
>>> --- a/drivers/net/tun.c
>>> +++ b/drivers/net/tun.c
>>> @@ -2128,6 +2128,9 @@ static void *tun_ring_recv(struct tun_file
>>> *tfile, int noblock, int *err)
>>>          void *ptr = NULL;
>>>          int error = 0;
>>>
>>> +       if (!tfile->tx_ring.queue)
>>> +               goto out;
>>> +
>>>
>>> Or, checking if tun is detached...
>>>
>>>
>> tx_ring was properly initialized when first ptr_ring_consume() at line 2131 was attempted.
>>
>> The bug happens later at line 2143 , after a schedule() call, line 2155
>>
>> So a single check at function prologue wont solve the case the thread had to sleep,
>> then some uninit happened.
>
> Very good point. RTNL lock is supposed to protect cleanup path, but I don't
> think we can acquire RTNL for tun_chr_read_iter() path...

I think the root cause is we try to initialize ptr ring during TUNSETIFF 
since the length depends on the dev->tx_queue_len and try to destroy it 
when device is gone. We can solve this by initializing a zero size 
ptr_ring during open() and resize if necessary. Then there no need for 
any workaround like memset and checking against NULL.

Let me try to cook a patch for this.

Thanks
