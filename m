Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeEHGEN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 02:04:13 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43595 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752599AbeEHGEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 02:04:11 -0400
X-Google-Smtp-Source: AB8JxZr+gjH/pxQrP8Tz/nizLLXDJ8+konXbbvoERnjx/sM1CR3QIB9xBA44Z/7hv5ag7FUcO8w7aQ==
Subject: Re: BUG: spinlock bad magic in tun_do_read
To: Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+e8b902c3c3fadf0a9dba@syzkaller.appspotmail.com>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        peterpenkov96@gmail.com, Sabrina Dubroca <sd@queasysnail.net>,
        syzkaller-bugs@googlegroups.com
References: <0000000000003f06aa056bab0943@google.com>
 <CAM_iQpXVsMzKochN7SY-CdHeACtJi3cC4oCfgzYdpqDMbo8Lcw@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <997afbee-1e89-aa5b-5b15-cad5a073cc38@gmail.com>
Date: Mon, 7 May 2018 23:04:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpXVsMzKochN7SY-CdHeACtJi3cC4oCfgzYdpqDMbo8Lcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/07/2018 10:54 PM, Cong Wang wrote:
> On Mon, May 7, 2018 at 10:27 PM, syzbot
> <syzbot+e8b902c3c3fadf0a9dba@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    75bc37fefc44 Linux 4.17-rc4
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1162c697800000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=31f4b3733894ef79
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e8b902c3c3fadf0a9dba
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> userspace arch: i386
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=172e4c97800000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+e8b902c3c3fadf0a9dba@syzkaller.appspotmail.com
>>
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> IPVS: ftp: loaded support on port[0] = 21
>> BUG: spinlock bad magic on CPU#0, syz-executor0/4586
>>  lock: 0xffff8801ae8928c8, .magic: 00000000, .owner: <none>/-1, .owner_cpu:
>> 0
>> CPU: 0 PID: 4586 Comm: syz-executor0 Not tainted 4.17.0-rc4+ #62
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>>  spin_dump+0x160/0x169 kernel/locking/spinlock_debug.c:67
>>  spin_bug kernel/locking/spinlock_debug.c:75 [inline]
>>  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
>>  do_raw_spin_lock.cold.3+0x37/0x3c kernel/locking/spinlock_debug.c:112
>>  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
>>  _raw_spin_lock+0x32/0x40 kernel/locking/spinlock.c:144
>>  spin_lock include/linux/spinlock.h:310 [inline]
>>  ptr_ring_consume include/linux/ptr_ring.h:335 [inline]
>>  tun_ring_recv drivers/net/tun.c:2143 [inline]
> 
> Yeah, we should return early before hitting this uninitialized ptr ring...
> Something like:
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index ef33950a45d9..638c87a95247 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2128,6 +2128,9 @@ static void *tun_ring_recv(struct tun_file
> *tfile, int noblock, int *err)
>         void *ptr = NULL;
>         int error = 0;
> 
> +       if (!tfile->tx_ring.queue)
> +               goto out;
> +
> 
> Or, checking if tun is detached...
> 
>

tx_ring was properly initialized when first ptr_ring_consume() at line 2131 was attempted.

The bug happens later at line 2143 , after a schedule() call, line 2155

So a single check at function prologue wont solve the case the thread had to sleep,
then some uninit happened.
