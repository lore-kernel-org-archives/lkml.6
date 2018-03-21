Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeCUToQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:44:16 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:53456 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752833AbeCUToN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:44:13 -0400
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
To: John Fastabend <john.fastabend@gmail.com>,
        Dave Taht <dave.taht@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
 <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
 <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
 <3a959e50-8656-5d9c-97b9-227d733948f8@theobroma-systems.com>
 <5aeb54ba-2d96-4ab5-53c4-2d3691be7acc@gmail.com>
 <340a6c54-6031-5522-98f5-eafdd3a37a38@theobroma-systems.com>
 <00cc2d41-6861-9a9c-603f-ba8013b2e2ce@theobroma-systems.com>
 <4e33aae4-9e87-22b4-7f09-008183ea553a@gmail.com>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <983427eb-2e25-f201-c953-4cff22569deb@theobroma-systems.com>
Date: Wed, 21 Mar 2018 20:44:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4e33aae4-9e87-22b4-7f09-008183ea553a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.18 19:43, John Fastabend wrote:
> Thats my theory at least. Are you able to test a patch if I generate
> one to fix this?

Yes, no problem.

I just tested with the flag change you suggested (see below, I had to 
keep TCQ_F_CPUSTATS to prevent a crash) and I have NOT seen OOO so far.

Thanks,
Jakob


diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 190570f21b20..51b68ef4977b 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -792,7 +792,7 @@ struct Qdisc_ops pfifo_fast_ops __read_mostly = {
         .dump           =       pfifo_fast_dump,
         .change_tx_queue_len =  pfifo_fast_change_tx_queue_len,
         .owner          =       THIS_MODULE,
-       .static_flags   =       TCQ_F_NOLOCK | TCQ_F_CPUSTATS,
+       .static_flags   =       TCQ_F_CPUSTATS,
  };
  EXPORT_SYMBOL(pfifo_fast_ops);
