Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933634AbeEICuo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 22:50:44 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:41022 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932579AbeEICum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 22:50:42 -0400
X-Google-Smtp-Source: AB8JxZpC2breDv08RdHTaCUaxFYllLQqOlHRdwkj0igPe9Kn7DoSr7YGcCMZB1ErXItxsWIO86KtzUpUjHtnF6QHFxU=
MIME-Version: 1.0
In-Reply-To: <997afbee-1e89-aa5b-5b15-cad5a073cc38@gmail.com>
References: <0000000000003f06aa056bab0943@google.com> <CAM_iQpXVsMzKochN7SY-CdHeACtJi3cC4oCfgzYdpqDMbo8Lcw@mail.gmail.com>
 <997afbee-1e89-aa5b-5b15-cad5a073cc38@gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 8 May 2018 19:50:21 -0700
Message-ID: <CAM_iQpW+vrecKuWTJ+zHt11ge7xPRWt=4GmZJxJ5Ffp_awV-ag@mail.gmail.com>
Subject: Re: BUG: spinlock bad magic in tun_do_read
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: syzbot <syzbot+e8b902c3c3fadf0a9dba@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Petar Penkov <peterpenkov96@gmail.com>,
        Sabrina Dubroca <sd@queasysnail.net>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 11:04 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 05/07/2018 10:54 PM, Cong Wang wrote:
>>
>> Yeah, we should return early before hitting this uninitialized ptr ring...
>> Something like:
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index ef33950a45d9..638c87a95247 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -2128,6 +2128,9 @@ static void *tun_ring_recv(struct tun_file
>> *tfile, int noblock, int *err)
>>         void *ptr = NULL;
>>         int error = 0;
>>
>> +       if (!tfile->tx_ring.queue)
>> +               goto out;
>> +
>>
>> Or, checking if tun is detached...
>>
>>
>
> tx_ring was properly initialized when first ptr_ring_consume() at line 2131 was attempted.
>
> The bug happens later at line 2143 , after a schedule() call, line 2155
>
> So a single check at function prologue wont solve the case the thread had to sleep,
> then some uninit happened.


Very good point. RTNL lock is supposed to protect cleanup path, but I don't
think we can acquire RTNL for tun_chr_read_iter() path...
