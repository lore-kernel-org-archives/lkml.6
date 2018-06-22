Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE36C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A47D246D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A47D246D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933801AbeFVRmx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:42:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52199 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932973AbeFVRmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:42:51 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AA864686C0D83;
        Sat, 23 Jun 2018 01:42:46 +0800 (CST)
Received: from localhost (10.47.144.153) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.382.0; Sat, 23 Jun 2018
 01:42:41 +0800
Date:   Fri, 22 Jun 2018 18:42:23 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Punit Agrawal <punit.agrawal@arm.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <tnowicki@caviumnetworks.com>, Xie XiuQi <xiexiuqi@huawei.com>,
        <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        zhongjiang <zhongjiang@huawei.com>, <wanghuiqiang@huawei.com>
Subject: Re: [PATCH 1/2] arm64: avoid alloc memory on offline node
Message-ID: <20180622184223.00007bc3@huawei.com>
In-Reply-To: <87y3f7yv89.fsf@e105922-lin.cambridge.arm.com>
References: <20180619120714.GE13685@dhcp22.suse.cz>
        <874lhz3pmn.fsf@e105922-lin.cambridge.arm.com>
        <20180619140818.GA16927@e107981-ln.cambridge.arm.com>
        <87wouu3jz1.fsf@e105922-lin.cambridge.arm.com>
        <20180619151425.GH13685@dhcp22.suse.cz>
        <87r2l23i2b.fsf@e105922-lin.cambridge.arm.com>
        <20180619163256.GA18952@e107981-ln.cambridge.arm.com>
        <814205eb-ae86-a519-bed0-f09b8e2d3a02@huawei.com>
        <87602d3ccl.fsf@e105922-lin.cambridge.arm.com>
        <5c083c9c-473f-f504-848b-48506d0fd380@huawei.com>
        <20180622091153.GU10465@dhcp22.suse.cz>
        <87y3f7yv89.fsf@e105922-lin.cambridge.arm.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.144.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 11:24:38 +0100
Punit Agrawal <punit.agrawal@arm.com> wrote:

> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Fri 22-06-18 16:58:05, Hanjun Guo wrote:  
> >> On 2018/6/20 19:51, Punit Agrawal wrote:  
> >> > Xie XiuQi <xiexiuqi@huawei.com> writes:
> >> >   
> >> >> Hi Lorenzo, Punit,
> >> >>
> >> >>
> >> >> On 2018/6/20 0:32, Lorenzo Pieralisi wrote:  
> >> >>> On Tue, Jun 19, 2018 at 04:35:40PM +0100, Punit Agrawal wrote:  
> >> >>>> Michal Hocko <mhocko@kernel.org> writes:
> >> >>>>  
> >> >>>>> On Tue 19-06-18 15:54:26, Punit Agrawal wrote:
> >> >>>>> [...]  
> >> >>>>>> In terms of $SUBJECT, I wonder if it's worth taking the original patch
> >> >>>>>> as a temporary fix (it'll also be easier to backport) while we work on
> >> >>>>>> fixing these other issues and enabling memoryless nodes.  
> >> >>>>>
> >> >>>>> Well, x86 already does that but copying this antipatern is not really
> >> >>>>> nice. So it is good as a quick fix but it would be definitely much
> >> >>>>> better to have a robust fix. Who knows how many other places might hit
> >> >>>>> this. You certainly do not want to add a hack like this all over...  
> >> >>>>
> >> >>>> Completely agree! I was only suggesting it as a temporary measure,
> >> >>>> especially as it looked like a proper fix might be invasive.
> >> >>>>
> >> >>>> Another fix might be to change the node specific allocation to node
> >> >>>> agnostic allocations. It isn't clear why the allocation is being
> >> >>>> requested from a specific node. I think Lorenzo suggested this in one of
> >> >>>> the threads.  
> >> >>>
> >> >>> I think that code was just copypasted but it is better to fix the
> >> >>> underlying issue.
> >> >>>  
> >> >>>> I've started putting together a set fixing the issues identified in this
> >> >>>> thread. It should give a better idea on the best course of action.  
> >> >>>
> >> >>> On ACPI ARM64, this diff should do if I read the code correctly, it
> >> >>> should be (famous last words) just a matter of mapping PXMs to nodes for
> >> >>> every SRAT GICC entry, feel free to pick it up if it works.
> >> >>>
> >> >>> Yes, we can take the original patch just because it is safer for an -rc
> >> >>> cycle even though if the patch below would do delaying the fix for a
> >> >>> couple of -rc (to get it tested across ACPI ARM64 NUMA platforms) is
> >> >>> not a disaster.  
> >> >>
> >> >> I tested this patch on my arm board, it works.  
> >> > 
> >> > I am assuming you tried the patch without enabling support for
> >> > memory-less nodes.
> >> > 
> >> > The patch de-couples the onlining of numa nodes (as parsed from SRAT)
> >> > from NR_CPUS restriction. When it comes to building zonelists, the node
> >> > referenced by the PCI controller also has zonelists initialised.
> >> > 
> >> > So it looks like a fallback node is setup even if we don't have
> >> > memory-less nodes enabled. I need to stare some more at the code to see
> >> > why we need memory-less nodes at all then ...  
> >> 
> >> Yes, please. From my limited MM knowledge, zonelists should not be
> >> initialised if no CPU and no memory on this node, correct me if I'm
> >> wrong.  
> >
> > Well, as long as there is a code which can explicitly ask for a specific
> > node than it is safer to have zonelists configured. Otherwise you just
> > force callers to add hacks and figure out the proper placement there.
> > Zonelists should be cheep to configure for all possible nodes. It's not
> > like we are talking about huge amount of resources.  
> 
> I agree. The current problem stems from not configuring the zonelists
> for nodes that don't have onlined cpu and memory. Lorenzo's patch fixes
> the configuration of such nodes.
> 
> For allocation requests targeting memory-less nodes, the allocator will
> take the slow path and fall back to one of the other nodes based on the
> zonelists.
> 
> I'm not sure how common such allocations are but I'll work on enabling
> CONFIG_HAVE_MEMORYLESS_NODES on top of Lorenzo's patch. AIUI, this
> config improves the fallback mechanism by starting the search from a
> near-by node with memory.

I'll test it when back in the office, but I had a similar issue with
memory only nodes when I moved the SRAT listing for cpus from the 4
4th mode to the 3rd node to fake some memory I could hot unplug.
This gave a memory only node for the last node on the system.

When I instead moved cpus from the 3rd node to the 4th (so the node
with only memory was now in the middle, everything worked).

Was odd, and I'd been meaning to chase it down but hadn't gotten to it
yet.  If I get time I'll put together some test firmwares as see if there
are any other nasty corner cases we aren't handling.

Jonathan

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


