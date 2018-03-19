Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeCSMci (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 08:32:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932490AbeCSMce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 08:32:34 -0400
Message-ID: <1521462750.3059.12.camel@redhat.com>
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
From: Paolo Abeni <pabeni@redhat.com>
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Dave Taht <dave.taht@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>
Date: Mon, 19 Mar 2018 13:32:30 +0100
In-Reply-To: <340a6c54-6031-5522-98f5-eafdd3a37a38@theobroma-systems.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
         <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
         <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
         <3a959e50-8656-5d9c-97b9-227d733948f8@theobroma-systems.com>
         <5aeb54ba-2d96-4ab5-53c4-2d3691be7acc@gmail.com>
         <340a6c54-6031-5522-98f5-eafdd3a37a38@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2018-03-16 at 11:26 +0100, Jakob Unterwurzacher wrote:
> On 15.03.18 23:30, John Fastabend wrote:
> > > I have reproduced it using two USB network cards connected to each other. The test tool sends UDP packets containing a counter and listens on the other interface, it is available at
> > > https://github.com/jakob-tsd/pfifo_stress/blob/master/pfifo_stress.py
> > > 
> > 
> > Great thanks, can you also run this with taskset to bind to
> > a single CPU,
> > 
> >   # taskset 0x1 ./pifof_stress.py
> > 
> > And let me know if you still see the OOO.
> 
> Interesting. Looks like it depends on which core it runs on. CPU0 is 
> clean, CPU1 is not.
> 
> Clean:	taskset --cpu-list 0 ./pfifo_stress.py
> 
> Broken:	taskset --cpu-list 1 ./pfifo_stress.py
> 
> Maybe related: CPU0 is where USB interrupts are handled:
> 
> > root@rk3399-q7:~# cat /proc/interrupts           
> >            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
> > 217:    2175353          0          0          0          0          0     GICv3 142 Level     xhci-hcd:usb5


Is not clear to me if you can reproduce the bug with the vanilla
kernel, or if  you need some out-of-tree nic driver. Can you please
clarify which NIC/driver are you using?

Thanks,

Paolo
