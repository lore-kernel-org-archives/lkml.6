Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932573AbeCOWbN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:31:13 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:41689 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeCOWbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:31:11 -0400
X-Google-Smtp-Source: AG47ELvhUaLw2cHLUaWAjLtg8yqXgbJ9iw3jykODouDRTlB5OKcTg/c1oUmccOipfu/Ys6JWxLtLsw==
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Dave Taht <dave.taht@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
 <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
 <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
 <3a959e50-8656-5d9c-97b9-227d733948f8@theobroma-systems.com>
From: John Fastabend <john.fastabend@gmail.com>
Message-ID: <5aeb54ba-2d96-4ab5-53c4-2d3691be7acc@gmail.com>
Date: Thu, 15 Mar 2018 15:30:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3a959e50-8656-5d9c-97b9-227d733948f8@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 11:08 AM, Jakob Unterwurzacher wrote:
> On 14.03.18 05:03, John Fastabend wrote:
>> On 03/13/2018 11:35 AM, Dave Taht wrote:
>>> On Tue, Mar 13, 2018 at 11:24 AM, Jakob Unterwurzacher
>>> <jakob.unterwurzacher@theobroma-systems.com> wrote:
>>>> During stress-testing our "ucan" USB/CAN adapter SocketCAN driver on Linux
>>>> v4.16-rc4-383-ged58d66f60b3 we observed that a small fraction of packets are
>>>> delivered out-of-order.
>>>>
>>
>> Is the stress-testing tool available somewhere? What type of packets
>> are being sent?
> 
> 
> I have reproduced it using two USB network cards connected to each other. The test tool sends UDP packets containing a counter and listens on the other interface, it is available at
> https://github.com/jakob-tsd/pfifo_stress/blob/master/pfifo_stress.py
> 

Great thanks, can you also run this with taskset to bind to
a single CPU,

 # taskset 0x1 ./pifof_stress.py

And let me know if you still see the OOO.

> Here is what I get:
> 
> root@rk3399-q7:~# ./pfifo_stress.py
> [...]
> expected ctr 0xcdc, received 0xcdd
> expected ctr 0xcde, received 0xcdc
> expected ctr 0xcdd, received 0xcde
> expected ctr 0xe3c, received 0xe3d
> expected ctr 0xe3e, received 0xe3c
> expected ctr 0xe3d, received 0xe3e
> expected ctr 0x1097, received 0x1098
> expected ctr 0x1099, received 0x1097
> expected ctr 0x1098, received 0x1099
> expected ctr 0x17c0, received 0x17c1
> expected ctr 0x17c2, received 0x17c0
> [...]
> 
> Best regards,
> Jakob
