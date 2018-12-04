Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1287C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662832081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662832081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeLDOog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:44:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbeLDOof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:44:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57C94308624F;
        Tue,  4 Dec 2018 14:44:34 +0000 (UTC)
Received: from redhat.com (ovpn-123-203.rdu2.redhat.com [10.10.123.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F3548273F;
        Tue,  4 Dec 2018 14:44:30 +0000 (UTC)
Date:   Tue, 4 Dec 2018 09:44:28 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Vivek Kini <vkini@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Ben Woodard <woodard@redhat.com>, linux-acpi@vger.kernel.org
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Message-ID: <20181204144422.GA3917@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <d6899765-a3b1-464b-d310-862161e07d98@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6899765-a3b1-464b-d310-862161e07d98@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 04 Dec 2018 14:44:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:14:14PM +0530, Aneesh Kumar K.V wrote:
> On 12/4/18 5:04 AM, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>

[...]

> > This patchset use the above scheme to expose system topology through
> > sysfs under /sys/bus/hms/ with:
> >      - /sys/bus/hms/devices/v%version-%id-target/ : a target memory,
> >        each has a UID and you can usual value in that folder (node id,
> >        size, ...)
> > 
> >      - /sys/bus/hms/devices/v%version-%id-initiator/ : an initiator
> >        (CPU or device), each has a HMS UID but also a CPU id for CPU
> >        (which match CPU id in (/sys/bus/cpu/). For device you have a
> >        path that can be PCIE BUS ID for instance)
> > 
> >      - /sys/bus/hms/devices/v%version-%id-link : an link, each has a
> >        UID and a file per property (bandwidth, latency, ...) you also
> >        find a symlink to every target and initiator connected to that
> >        link.
> > 
> >      - /sys/bus/hms/devices/v%version-%id-bridge : a bridge, each has
> >        a UID and a file per property (bandwidth, latency, ...) you
> >        also find a symlink to all initiators that can use that bridge.
> 
> is that version tagging really needed? What changes do you envision with
> versions?

I kind of dislike it myself but this is really to keep userspace from
inadvertently using some kind of memory/initiator/link/bridge that it
should not be using if it does not understand what are the implication.

If it was a file inside the directory there is a big chance that user-
space will overlook it. So an old program on a new platform with a new
kind of weird memory like un-coherent memory might start using it and
get all weird result. If version is in the directory name it kind of
force userspace to only look at memory/initiator/link/bridge it does
understand and can use safely.

So i am doing this in hope that it will protect application when new
type of things pops up. We have too many example where we can not
evolve something because existing application have bake in assumptions
about it.


[...]

> > 3) Tracking and applying heterogeneous memory policies
> > ------------------------------------------------------
> > 
> > Current memory policy infrastructure is node oriented, instead of
> > changing that and risking breakage and regression this patchset add a
> > new heterogeneous policy tracking infra-structure. The expectation is
> > that existing application can keep using mbind() and all existing
> > infrastructure under-disturb and unaffected, while new application
> > will use the new API and should avoid mix and matching both (as they
> > can achieve the same thing with the new API).
> > 
> > Also the policy is not directly tie to the vma structure for a few
> > reasons:
> >      - avoid having to split vma for policy that do not cover full vma
> >      - avoid changing too much vma code
> >      - avoid growing the vma structure with an extra pointer
> > So instead this patchset use the mmu_notifier API to track vma liveness
> > (munmap(),mremap(),...).
> > 
> > This patchset is not tie to process memory allocation either (like said
> > at the begining this is not and end to end patchset but a starting
> > point). It does however demonstrate how migration to device memory can
> > work under this scheme (using nouveau as a demonstration vehicle).
> > 
> > The overall design is simple, on hbind() call a hms policy structure
> > is created for the supplied range and hms use the callback associated
> > with the target memory. This callback is provided by device driver
> > for device memory or by core HMS for regular main memory. The callback
> > can decide to migrate the range to the target memories or do nothing
> > (this can be influenced by flags provided to hbind() too).
> > 
> > 
> > Latter patches can tie page fault with HMS policy to direct memory
> > allocation to the right target. For now i would rather postpone that
> > discussion until a consensus is reach on how to move forward on all
> > the topics presented in this email. Start smalls, grow big ;)
> > 
> > 
> 
> I liked the simplicity of keeping it outside all the existing memory
> management policy code. But that that is also the drawback isn't it?
> We now have multiple entities tracking cpu and memory. (This reminded me of
> how we started with memcg in the early days).

This is a hard choice, the rational is that either application use this
new API either it use the old one. So the expectation is that both should
not co-exist in a process. Eventualy both can be consolidated into one
inside the kernel while maintaining the different userspace API. But i
feel that it is better to get to that point slowly while we experiment
with the new API. I feel that we need to gain some experience with the
new API on real workload to convince ourself that it is something we can
leave with. If we reach that point than we can work on consolidating
kernel code into one. In the meantime this experiment does not disrupt
or regress existing API. I took the cautionary road.


> Once we have these different types of targets, ideally the system should
> be able to place them in the ideal location based on the affinity of the
> access. ie. we should automatically place the memory such that
> initiator can access the target optimally. That is what we try to do with
> current system with autonuma. (You did mention that you are not looking at
> how this patch series will evolve to automatic handling of placement right
> now.) But i guess we want to see if the framework indeed help in achieving
> that goal. Having HMS outside the core memory
> handling routines will be a road blocker there?

So evolving autonuma gonna be a thing on its own, the issue is that auto-
numa revolve around CPU id and use a handful of bits to try to catch CPU
access pattern. With device in the mix it is much harder, first using the
page fault trick of autonuma might not be the best idea, second we can get
a lot of informations from IOMMU, bridge chipset or device itself on what
is accessed by who.

So my believe on that front is that its gonna be something different, like
tracking range of virtual address and maintaining a data structure for
range (not per page).

All this is done in core mm code, i am just keeping out of vma struct or
other struct to avoid growing them when and wasting thing when thit is not
in use. So it is very much inside core handling routines, it is just
optional.

In any case i believe that explicit placement (where application hbind()
thing) will be the first main use case. Once we have that figured out (or
at least once we believe we have it figured out :)) then we can look into
auto-heterogeneous.

Cheers,
Jérôme
