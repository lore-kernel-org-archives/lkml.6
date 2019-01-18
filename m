Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A67C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23432086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfARLNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:13:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbfARLNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:13:12 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3517BCBEE9193D40F4E7;
        Fri, 18 Jan 2019 19:13:10 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Fri, 18 Jan 2019
 19:13:02 +0800
Date:   Fri, 18 Jan 2019 11:12:51 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCHv4 00/13] Heterogeneuos memory node attributes
Message-ID: <20190118111251.00006582@huawei.com>
In-Reply-To: <20190117194751.GE31543@localhost.localdomain>
References: <20190116175804.30196-1-keith.busch@intel.com>
        <20190117181835.000034ab@huawei.com>
        <20190117194751.GE31543@localhost.localdomain>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 12:47:51 -0700
Keith Busch <keith.busch@intel.com> wrote:

> On Thu, Jan 17, 2019 at 10:18:35AM -0800, Jonathan Cameron wrote:
> > I've been having a play with various hand constructed HMAT tables to allow
> > me to try breaking them in all sorts of ways.
> > 
> > Mostly working as expected.
> > 
> > Two places I am so far unsure on...
> > 
> > 1. Concept of 'best' is not implemented in a consistent fashion.
> > 
> > I don't agree with the logic to match on 'best' because it can give some counter
> > intuitive sets of target nodes.
> > 
> > For my simple test case we have both the latency and bandwidth specified (using
> > access as I'm lazy and it saves typing).
> > 
> > Rather that matching when both are the best value, we match when _any_ of the
> > measurements is the 'best' for the type of measurement.
> > 
> > A simple system with a high bandwidth interconnect between two SoCs
> > might well have identical bandwidths to memory connected to each node, but
> > much worse latency to the remote one.  Another simple case would be DDR and
> > SCM on roughly the same memory controller.  Bandwidths likely to be equal,
> > latencies very different.
> > 
> > Right now we get both nodes in the list of 'best' ones because the bandwidths
> > are equal which is far from ideal.  It also means we are presenting one value
> > for both latency and bandwidth, misrepresenting the ones where it doesn't apply.
> > 
> > If we aren't going to specify that both must be "best", then I think we should
> > separate the bandwidth and latency classes, requiring userspace to check
> > both if they want the best combination of latency and bandwidth. I'm also
> > happy enough (having not thought about it much) to have one class where the 'best'
> > is the value sorted first on best latency and then on best bandwidth.  
> 
> Okay, I see what you mean. I must admit my test environment doesn't have
> nodes with the same bandwith but different latency, so we may get the
> wrong information with the HMAT parsing in this series. I'll look into
> fixing that and consider your sugggestions.

Great.

>  
> > 2. Handling of memory only nodes - that might have a device attached - _PXM
> > 
> > This is a common situation in CCIX for example where you have an accelerator
> > with coherent memory homed at it. Looks like a pci device in a domain with
> > the memory.   Right now you can't actually do this as _PXM is processed
> > for pci devices, but we'll get that fixed (broken threadripper firmwares
> > meant it got reverted last cycle).
> > 
> > In my case I have 4 nodes with cpu and memory (0,1,2,3) and 2 memory only (4,5)
> > Memory only are longer latency and lower bandwidth.
> > 
> > Now
> > ls /sys/bus/nodes/devices/node0/class0/
> > ...
> > 
> > initiator0
> > target0
> > target4
> > target5
> > 
> > read_bandwidth = 15000
> > read_latency = 10000
> > 
> > These two values (and their paired write values) are correct for initiator0 to target0
> > but completely wrong for initiator0 to target4 or target5.  
> 
> Hm, this wasn't intended to tell us performance for the initiator's
> targets. The performance data here is when you access node0's memory
> target from a node in its initiator_list, or one of the simlinked
> initiatorX's.

> 
> If you want to see the performance attributes for accessing
> initiator0->target4, you can check:
> 
>   /sys/devices/system/node/node0/class0/target4/class0/read_bandwidth

Ah.  That makes sense, but does raise the question of whether this interface
is rather unintuitive and that the example given in the docs for the PCI device
doesn't always work.  Perhaps it is that documentation that needs refining.

Having values that don't apply to particular combinations of entries
in the initiator_list and target_list based on which directory we are
in doesn't seem great to me.

So the presence of a target directory in a node indicates the memory
in the target is 'best' accessed from this node, but is unrelated to the
values provided in this node.

One thought is we are trying to combine two unrelated questions and that
is what is leading to the confusion.

1) I have a process (or similar) in this node, which is the 'best' memory
   to use and what are it's characteristics.

2) I have data in this memory, which processor node should I schedule my
   processing on.

Ideally we want to avoid searching all the nodes.
To test this I disabled the memory on one of my nodes to make it even more
pathological (this is valid on the real hardware as the cpus don't have to
have memory attached to them).  So same as before but now node 3 is initiator only.

Using bandwidth as a proxy for all the other measurements..

For question 1 (what memory)

Initiator in node 0

Need to check
node0/class0/target0/class0/read_bandwidth (can shortcut this one obviously)
node0/class0/target4/class0/read_bandwidth
node0/class0/target5/class0/read_bandwidth

and discover that it's smaller for node0/class0/target0

Initiator in node 3 (initiator only)
node3/class0/initiator_nodelist is empty so no useful information available.

Initiator in node 4 (pci card for example) can assume node 4 as no
other information and it has memory (which incidentally might have long
latencies compared to memory over the interconnect.).

For question 2 (what processor)

We are on better grounds

node0/class0/initiator0
node1/class0/initiator1
node2/class0/initiator2
node3 doesn't make sense (no memory)
node4/class0/initiator[0-3]
node5/class0/initiator[0-3]
All the memory / bandwidth numbers are as expected.


So my conclusion is this works fine for suggesting processor to use for
given memory (or accelerator or whatever, though only if they are closely
coupled with the processors). Doesn't work for the what memory to use
for a given processor / pci card etc.  Sometimes there is no answer,
sometimes you have to search to find it.

Does it make more sense to just have two classes

1) Which memory is nearest to me?
2) Which processor is nearest to me? 
(3) which processor of type X is nearest to me is harder to answer but useful).

Note that case 2 is clearly covered well by the existing, but I can't actually
see what benefit having the target links has for that use case.

To illustrate how I think that would work.

Class 0, existing but with target links dropped.

What processor for each memory
node0/class0/initiator_nodelist 0
node1/class0/initiator_nodelist 1
node2/class0/initiator_nodelist 2
node3/class0/initiator_nodelist ""
node4/class0/initiator_nodelist 0-3
node5/class0/initatior_nodelist 0-3
All the memory stats reflect from the value for the given initiator to access this memory.

Class 1 new one for the what memory is nearest to me - no initiator files as that's 'me'.
node0/class1/target_nodelist 0
node1/class1/target_nodelist 1
node2/class1/target_nodelist 2
node3/class1/target_nodelist 0-2
node4/class1/target_nodelist "" as not specified as an initiator in hmat. 
				Ideally class1 wouldn't even be there.
node5/class1/target_nodelist "" same

For now we would have no information for accelerators in node4, 5 but for now
ACPI doesn't provide us the info for them anyway really.  I suppose you could
have HMAT describing 'initiators' in those nodes without there being any processors
in SRAT.  Let's park that one to solve another day.

Your pci example then becomes

+  # NODE=$(cat /sys/devices/pci:0000:00/.../numa_node)
+  # numactl --membind=$(cat /sys/devices/node/node${NODE}/class1/target_nodelist) \
+      --cpunodebind=$(cat /sys/devices/node/node${NODE}/class0/initiator_nodelist) \
+      -- <some-program-to-execute>

What do you think?

Jonathan

> 
> > This occurs because we loop over the targets looking for the best values and add
> > set the relevant bit in t->p_nodes based on that.  These memory only nodes have
> > a best value that happens to be equal from all the initiators.  The issue is it
> > isn't the one reported in the node0/class0.
> >
> > Also if we look in
> > /sys/bus/nodes/devices/node4/class0 there are no targets listed (there are the expected
> > 4 initiators 0-3).
> > 
> > I'm not sure what the intended behavior would be in this case.  
> 
> You mentioned that node 4 is a memory-only node, so it can't have any
> targets, right?
Depends on what is there that ACPI 6.2 doesn't describe :)  Can have
PCI cards for example.

Jonathan


