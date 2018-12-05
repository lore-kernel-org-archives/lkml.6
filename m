Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9236C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF7E2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF7E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeLEAPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:15:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbeLEAPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:15:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9ADD8F50A;
        Wed,  5 Dec 2018 00:15:50 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DB415C25C;
        Wed,  5 Dec 2018 00:15:46 +0000 (UTC)
Date:   Tue, 4 Dec 2018 19:15:44 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
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
Message-ID: <20181205001544.GR2937@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <6e2a1dba-80a8-42bf-127c-2f5c2441c248@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e2a1dba-80a8-42bf-127c-2f5c2441c248@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 05 Dec 2018 00:15:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 03:54:22PM -0800, Dave Hansen wrote:
> On 12/3/18 3:34 PM, jglisse@redhat.com wrote:
> > This patchset use the above scheme to expose system topology through
> > sysfs under /sys/bus/hms/ with:
> >     - /sys/bus/hms/devices/v%version-%id-target/ : a target memory,
> >       each has a UID and you can usual value in that folder (node id,
> >       size, ...)
> > 
> >     - /sys/bus/hms/devices/v%version-%id-initiator/ : an initiator
> >       (CPU or device), each has a HMS UID but also a CPU id for CPU
> >       (which match CPU id in (/sys/bus/cpu/). For device you have a
> >       path that can be PCIE BUS ID for instance)
> > 
> >     - /sys/bus/hms/devices/v%version-%id-link : an link, each has a
> >       UID and a file per property (bandwidth, latency, ...) you also
> >       find a symlink to every target and initiator connected to that
> >       link.
> > 
> >     - /sys/bus/hms/devices/v%version-%id-bridge : a bridge, each has
> >       a UID and a file per property (bandwidth, latency, ...) you
> >       also find a symlink to all initiators that can use that bridge.
> 
> We support 1024 NUMA nodes on x86.  The ACPI HMAT expresses the
> connections between each node.  Let's suppose that each node has some
> CPUs and some memory.
> 
> That means we'll have 1024 target directories in sysfs, 1024 initiator
> directories in sysfs, and 1024*1024 link directories.  Or, would the
> kernel be responsible for "compiling" the firmware-provided information
> down into a more manageable number of links?
> 
> Some idiot made the mistake of having one sysfs directory per 128MB of
> memory way back when, and now we have hundreds of thousands of
> /sys/devices/system/memory/memoryX directories.  That sucks to manage.
> Isn't this potentially repeating that mistake?
> 
> Basically, is sysfs the right place to even expose this much data?

I definitly want to avoid the memoryX mistake. So i do not want to
see one link directory per device. Taking my simple laptop as an
example with 4 CPUs, a wifi and 2 GPU (the integrated one and a
discret one):

link0: cpu0 cpu1 cpu2 cpu3
link1: wifi (2 pcie lane)
link2: gpu0 (unknown number of lane but i believe it has higher
             bandwidth to main memory)
link3: gpu1 (16 pcie lane)
link4: gpu1 and gpu memory

So one link directory per number of pcie lane your device have
so that you can differentiate on bandwidth. The main memory is
symlinked inside all the link directory except link4. The GPU
discret memory is only in link4 directory as it is only
accessible by the GPU (we could add it under link3 too with the
non cache coherent property attach to it).


The issue then becomes how to convert down the HMAT over verbose
information to populate some reasonable layout for HMS. For that
i would say that create a link directory for each different
matrix cell. As an example let say that each entry in the matrix
has bandwidth and latency then we create a link directory for
each combination of bandwidth and latency. On simple system that
should boils down to a handfull of combination roughly speaking
mirroring the example above of one link directory per number of
PCIE lane for instance.

I don't think i have a system with an HMAT table if you have one
HMAT table to provide i could show up the end result.

Note i believe the ACPI HMAT matrix is a bad design for that
reasons ie there is lot of commonality in many of the matrix
entry and many entry also do not make sense (ie initiator not
being able to access all the targets). I feel that link/bridge
is much more compact and allow to represent any directed graph
with multiple arrows from one node to another same node.

Cheers,
Jérôme
