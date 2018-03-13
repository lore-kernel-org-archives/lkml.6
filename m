Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeCMSfu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:35:50 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40813 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeCMSfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:35:47 -0400
X-Google-Smtp-Source: AG47ELs4U3Nj8XPUMICd+enSDgufzvv/xabtkw0FQg2mHomDxPxJU+usYiVL3xrAQxhSsSJLPgvknAcGBrwlnrBRknU=
MIME-Version: 1.0
In-Reply-To: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Tue, 13 Mar 2018 11:35:46 -0700
Message-ID: <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2DIZtj1005949

On Tue, Mar 13, 2018 at 11:24 AM, Jakob Unterwurzacher
<jakob.unterwurzacher@theobroma-systems.com> wrote:
> During stress-testing our "ucan" USB/CAN adapter SocketCAN driver on Linux
> v4.16-rc4-383-ged58d66f60b3 we observed that a small fraction of packets are
> delivered out-of-order.
>
> We have tracked the problem down to the driver interface level, and it seems
> that the driver's net_device_ops.ndo_start_xmit() function gets the packets
> handed over in the wrong order.
>
> This behavior was not observed on Linux v4.15 and I have bisected the
> problem down to this patch:
>
>> commit c5ad119fb6c09b0297446be05bd66602fa564758
>> Author: John Fastabend <john.fastabend@gmail.com>
>> Date:   Thu Dec 7 09:58:19 2017 -0800
>>
>>    net: sched: pfifo_fast use skb_array
>>
>>    This converts the pfifo_fast qdisc to use the skb_array data structure
>>    and set the lockless qdisc bit. pfifo_fast is the first qdisc to
>> support
>>    the lockless bit that can be a child of a qdisc requiring locking. So
>>    we add logic to clear the lock bit on initialization in these cases
>> when
>>    the qdisc graft operation occurs.
>>
>>    This also removes the logic used to pick the next band to dequeue from
>>    and instead just checks a per priority array for packets from top
>> priority
>>    to lowest. This might need to be a bit more clever but seems to work
>>    for now.
>>
>>    Signed-off-by: John Fastabend <john.fastabend@gmail.com>
>>    Signed-off-by: David S. Miller <davem@davemloft.net>
>
>
> The patch does not revert cleanly, but moving to one commit earlier makes
> the problem go away.
>
> Selecting the "fq" scheduler instead of "pfifo_fast" makes the problem go
> away as well.

I am of course, a fan of obsoleting pfifo_fast. There's no good reason
for it anymore.

>
> Is this an unintended side-effect of the patch or is there something the
> driver has to do to request in-order delivery?
>
> Thanks,
> Jakob



-- 

Dave Täht
CEO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-669-226-2619
