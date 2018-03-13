Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbeCMSYx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:24:53 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:55586 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752196AbeCMSYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:24:51 -0400
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: [bug, bisected] pfifo_fast causes packet reordering
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>
Message-ID: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
Date: Tue, 13 Mar 2018 19:24:44 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During stress-testing our "ucan" USB/CAN adapter SocketCAN driver on 
Linux v4.16-rc4-383-ged58d66f60b3 we observed that a small fraction of 
packets are delivered out-of-order.

We have tracked the problem down to the driver interface level, and it 
seems that the driver's net_device_ops.ndo_start_xmit() function gets 
the packets handed over in the wrong order.

This behavior was not observed on Linux v4.15 and I have bisected the 
problem down to this patch:

> commit c5ad119fb6c09b0297446be05bd66602fa564758
> Author: John Fastabend <john.fastabend@gmail.com>
> Date:   Thu Dec 7 09:58:19 2017 -0800
> 
>    net: sched: pfifo_fast use skb_array
> 
>    This converts the pfifo_fast qdisc to use the skb_array data structure
>    and set the lockless qdisc bit. pfifo_fast is the first qdisc to support
>    the lockless bit that can be a child of a qdisc requiring locking. So
>    we add logic to clear the lock bit on initialization in these cases when
>    the qdisc graft operation occurs.
> 
>    This also removes the logic used to pick the next band to dequeue from
>    and instead just checks a per priority array for packets from top priority
>    to lowest. This might need to be a bit more clever but seems to work
>    for now.
> 
>    Signed-off-by: John Fastabend <john.fastabend@gmail.com>
>    Signed-off-by: David S. Miller <davem@davemloft.net>

The patch does not revert cleanly, but moving to one commit earlier 
makes the problem go away.

Selecting the "fq" scheduler instead of "pfifo_fast" makes the problem 
go away as well.

Is this an unintended side-effect of the patch or is there something the 
driver has to do to request in-order delivery?

Thanks,
Jakob
