Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968199AbeEYUKx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:10:53 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44950 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967879AbeEYUKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:10:52 -0400
X-Google-Smtp-Source: ADUXVKLExWNe8y/Z2DTRxh9lZiaX2TTn7sS6hJk1VHU6qJ3Y2j2rU8LtOVTx5gpxFefU+9EO8JigaiQ2QdeSeXrR7ks=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
 <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
 <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
 <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com> <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de>
From: Song Liu <liu.song.a23@gmail.com>
Date: Fri, 25 May 2018 13:10:50 -0700
Message-ID: <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tariq Toukan <tariqt@mellanox.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are seeing something probably related.

We run ethtool on a system with Broadcom NIC to increase number of
combined queues.


    [root@ ~]# ethtool -l eth0
    Channel parameters for eth0:
    Pre-set maximums:
    RX:             9
    TX:             8
    Other:          0
    Combined:       17
    Current hardware settings:
    RX:             0
    TX:             0
    Other:          0
    Combined:       8

    [root@ ~]# ethtool -L eth0 combined 16

The last command PANIC the kernel easily (5 out of 5 in my tests).

I haven't got luck to catch much console output, the only line I got is:

    [ 504.727865] WARNING: CPU: 10 PID: 0 at kernel/irq/matrix.c:371
irq_matrix_free+0x32/0xd0

The NIC we have is

    Broadcom Limited BCM57302 NetXtreme-C 10Gb/25Gb Ethernet Controller

Thanks,
Song

On Wed, May 23, 2018 at 1:49 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 23 May 2018, Tariq Toukan wrote:
>> On 19/05/2018 2:20 PM, Thomas Gleixner wrote:
>> > On Fri, 18 May 2018, Dmitry Safonov wrote:
>> > > I'm not entirely sure that it's the same fault, but at least backtrace
>> > > looks resembling.
>> >
>> > Yes, it's similar, but not the same issue. I'll stare are the code ...
>> >
>> > Thanks,
>> >
>> >     tglx
>> >
>>
>> We still see the issue in our daily regression runs.
>> I have your patch merged into my internal branch, it prints the following:
>>
>> [ 4898.226258] Trying to clear prev_vector: 0
>> [ 4898.226439] Trying to clear prev_vector: 0
>>
>> i.e. vector(0) is lower than FIRST_EXTERNAL_VECTOR.
>
> Could you please enable the vector and irq matrix trace points and capture
> the trace when this happens?
>
> Thanks,
>
>         tglx
>
