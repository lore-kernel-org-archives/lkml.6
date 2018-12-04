Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72C8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889C4206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889C4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeLDSta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:49:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbeLDSta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:49:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A5573001E4E;
        Tue,  4 Dec 2018 18:49:29 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40EBD5C21C;
        Tue,  4 Dec 2018 18:49:21 +0000 (UTC)
Date:   Tue, 4 Dec 2018 13:49:19 -0500
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
Message-ID: <20181204184919.GD2937@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <9d745b99-22e3-c1b5-bf4f-d3e83113f57b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d745b99-22e3-c1b5-bf4f-d3e83113f57b@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 04 Dec 2018 18:49:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 10:02:55AM -0800, Dave Hansen wrote:
> On 12/3/18 3:34 PM, jglisse@redhat.com wrote:
> > This means that it is no longer sufficient to consider a flat view
> > for each node in a system but for maximum performance we need to
> > account for all of this new memory but also for system topology.
> > This is why this proposal is unlike the HMAT proposal [1] which
> > tries to extend the existing NUMA for new type of memory. Here we
> > are tackling a much more profound change that depart from NUMA.
> 
> The HMAT and its implications exist, in firmware, whether or not we do
> *anything* in Linux to support it or not.  Any system with an HMAT
> inherently reflects the new topology, via proximity domains, whether or
> not we parse the HMAT table in Linux or not.
> 
> Basically, *ACPI* has decided to extend NUMA.  Linux can either fight
> that or embrace it.  Keith's HMAT patches are embracing it.  These
> patches are appearing to fight it.  Agree?  Disagree?

Disagree, sorry if it felt that way that was not my intention. The
ACPI HMAT information can be use to populate the HMS file system
representation. My intention is not to fight Keith's HMAT patches
they are useful on their own. But i do not see how to evolve NUMA
to support device memory, so while Keith is taking a step into the
direction i want, i do not see how to cross to the place i need to
be. More on that below.

> 
> Also, could you add a simple, example program for how someone might use
> this?  I got lost in all the new sysfs and ioctl gunk.  Can you
> characterize how this would work with the *exiting* NUMA interfaces that
> we have?

That is the issue i can not expose device memory as NUMA node as
device memory is not cache coherent on AMD and Intel platform today.

More over in some case that memory is not visible at all by the CPU
which is not something you can express in the current NUMA node.
Here is an abreviated list of feature i need to support:
    - device private memory (not accessible by CPU or anybody else)
    - non-coherent memory (PCIE is not cache coherent for CPU access)
    - multiple path to access same memory either:
        - multiple _different_ physical address alias to same memory
        - device block can select which path they take to access some
          memory (it is not inside the page table but in how you program
          the device block)
    - complex topology that is not a tree where device link can have
      better characteristics than the CPU inter-connect between the
      nodes. They are existing today user that use topology information
      to partition their workload (HPC folks who have a fix platform).
    - device memory needs to stay under device driver control as some
      existing API (OpenGL, Vulkan) have different memory model and if
      we want the device to be use for those too then we need to keep
      the device driver in control of the device memory allocation


There is an example userspace program with the last patch in the serie.
But here is a high level overview of how one application looks today:

    1) Application get some dataset from some source (disk, network,
       sensors, ...)
    2) Application allocate memory on device A and copy over the dataset
    3) Application run some CPU code to format the copy of the dataset
       inside device A memory (rebuild pointers inside the dataset,
       this can represent millions and millions of operations)
    4) Application run code on device A that use the dataset
    5) Application allocate memory on device B and copy over result
       from device A
    6) Application run some CPU code to format the copy of the dataset
       inside device B (rebuild pointers inside the dataset,
       this can represent millions and millions of operations)
    7) Application run code on device B that use the dataset
    8) Application copy result over from device B and keep on doing its
       thing

How it looks with HMS:
    1) Application get some dataset from some source (disk, network,
       sensors, ...)
    2-3) Application calls HMS to migrate to device A memory
    4) Application run code on device A that use the dataset
    5-6) Application calls HMS to migrate to device B memory
    7) Application run code on device B that use the dataset
    8) Application calls HMS to migrate result to main memory

So we now avoid explicit copy and having to rebuild data structure
inside each device address space.


Above example is for migrate. Here is an example for how the
topology is use today:

    Application knows that the platform is running on have 16
    GPU split into 2 group of 8 GPUs each. GPU in each group can
    access each other memory with dedicated mesh links between
    each others. Full speed no traffic bottleneck.

    Application splits its GPU computation in 2 so that each
    partition runs on a group of interconnected GPU allowing
    them to share the dataset.

With HMS:
    Application can query the kernel to discover the topology of
    system it is running on and use it to partition and balance
    its workload accordingly. Same application should now be able
    to run on new platform without having to adapt it to it.

This is kind of naive i expect topology to be hard to use but maybe
it is just me being pesimistics. In any case today we have a chicken
and egg problem. We do not have a standard way to expose topology so
program that can leverage topology are only done for HPC where the
platform is standard for few years. If we had a standard way to expose
the topology then maybe we would see more program using it. At very
least we could convert existing user.


Policy is same kind of story, this email is long enough now :) But
i can write one down if you want.


Cheers,
Jérôme
