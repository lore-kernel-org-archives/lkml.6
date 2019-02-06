Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2993C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAB820B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbfBFMbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:31:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728044AbfBFMbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:31:24 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3812BA6B04A7DDE2C50F;
        Wed,  6 Feb 2019 20:31:22 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Feb 2019
 20:31:11 +0800
Date:   Wed, 6 Feb 2019 12:31:00 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCHv5 00/10] Heterogeneuos memory node attributes
Message-ID: <20190206123100.0000094a@huawei.com>
In-Reply-To: <20190124230724.10022-1-keith.busch@intel.com>
References: <20190124230724.10022-1-keith.busch@intel.com>
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

On Thu, 24 Jan 2019 16:07:14 -0700
Keith Busch <keith.busch@intel.com> wrote:

> == Changes since v4 ==
> 
>   All public interfaces have kernel docs.
> 
>   Renamed "class" to "access", docs and changed logs updated
>   accordingly. (Rafael)
> 
>   The sysfs hierarchy is altered to put initiators and targets in their
>   own attribute group directories (Rafael).
> 
>   The node lists are removed. This feedback is in conflict with v1
>   feedback, but consensus wants to remove multi-value sysfs attributes,
>   which includes lists. We only have symlinks now, just like v1 provided.
> 
>   Documentation and code patches are combined such that the code
>   introducing new attributes and its documentation are in the same
>   patch. (Rafael and Dan).
> 
>   The performance attributes, bandwidth and latency, are moved into the
>   initiators directory. This should make it obvious for which node
>   access the attributes apply, which was previously ambiguous.
>   (Jonathan Cameron).
> 
>   The HMAT code selecting "local" initiators is substantially changed.
>   Only PXM's that have identical performance to the HMAT's processor PXM
>   in Address Range Structure are registered. This is to avoid considering
>   nodes identical when only one of several perf attributes are the same.
>   (Jonathan Cameron).
> 
>   Verbose variable naming. Examples include "initiator" and "target"
>   instead of "i" and "t", "mem_pxm" and "cpu_pxm" instead of "m" and
>   "p". (Rafael)
> 
>   Compile fixes for when HMEM_REPORTING is not set. This is not a user
>   selectable config option, default 'n', and will have to be selected
>   by other config options that require it (Greg KH and Rafael).
> 
> == Background ==
> 
> Platforms may provide multiple types of cpu attached system memory. The
> memory ranges for each type may have different characteristics that
> applications may wish to know about when considering what node they want
> their memory allocated from. 
> 
> It had previously been difficult to describe these setups as memory
> rangers were generally lumped into the NUMA node of the CPUs. New
> platform attributes have been created and in use today that describe
> the more complex memory hierarchies that can be created.
> 
> This series' objective is to provide the attributes from such systems
> that are useful for applications to know about, and readily usable with
> existing tools and libraries.

Hi Keith,

Seems to be heading in the right direction to me... (though I personally
want to see the whole of HMAT expose, but meh, that seems unpopular :)

I've fired up a new test rig (someone pinched the fan on the previous one)
that I can make present pretty much anything to this code.

First up is a system with 4 nodes with cpu and local ddr [0-3] + 1 remote node
with just memory [4]. All the figures as you might expect between the nodes with
CPUs. The remote node has equal numbers from all the cpus.

First some general comments on places this doesn't work as my gut feeling
said it would...

I'm going to keep this somewhat vague on certain points as ACPI 6.3 should
be public any day now and I think it is fair to say we should take into
account any changes in there...
There is definitely one place the current patches won't work with 6.3, but
I'll point it out in a few days.  There may be others.

1) It seems this version added a hard dependence on having the memory node
   listed in the Memory Proximity Domain attribute structures.  I'm not 100%
   sure there is actually any requirement to have those structures. If you aren't
   using the hint bit, they don't convey any information.  It could be argued
   that they provide info on what is found in the other hmat entries, but there
   is little purpose as those entries are explicit in what the provide.
   (Given I didn't have any of these structures and things  worked fine with
    v4 it seems this is a new check).

   This is also somewhat inconsistent.
   a) If a given entry isn't there, we still get for example
      node4/access0/initiators/[read|write]_* but all values are 0.
      If we want to do the check you have it needs to not create the files in
      this case.  Whilst they have no meaning as there are no initiators, it
      is inconsistent to my mind.

   b) Having one "Memory Proximity Domain attribute structure" for node 4 linking
      it to node0 is sufficient to allow
      node4/access0/initiators/node0
      node4/access0/initiators/node1
      node4/access0/initiators/node2
      node4/access0/initiators/node3
      I think if we are going to enforce the presence of that structure then only
      the node0 link should exist.

2) Error handling could perhaps do to spit out some nasty warnings.
   If we have an entry for nodes that don't exist we shouldn't just fail silently,
   that's just one example I managed to trigger with minor table tweaking.

Personally I would just get rid of enforcing anything based on the presence of
that structure.

I'll send more focused comments on some of the individual patches.

Thanks,

Jonathan
   

> 
> Keith Busch (10):
>   acpi: Create subtable parsing infrastructure
>   acpi: Add HMAT to generic parsing tables
>   acpi/hmat: Parse and report heterogeneous memory
>   node: Link memory nodes to their compute nodes
>   acpi/hmat: Register processor domain to its memory
>   node: Add heterogenous memory access attributes
>   acpi/hmat: Register performance attributes
>   node: Add memory caching attributes
>   acpi/hmat: Register memory side cache attributes
>   doc/mm: New documentation for memory performance
> 
>  Documentation/ABI/stable/sysfs-devices-node   |  87 ++++-
>  Documentation/admin-guide/mm/numaperf.rst     | 167 ++++++++
>  arch/arm64/kernel/acpi_numa.c                 |   2 +-
>  arch/arm64/kernel/smp.c                       |   4 +-
>  arch/ia64/kernel/acpi.c                       |  12 +-
>  arch/x86/kernel/acpi/boot.c                   |  36 +-
>  drivers/acpi/Kconfig                          |   1 +
>  drivers/acpi/Makefile                         |   1 +
>  drivers/acpi/hmat/Kconfig                     |   9 +
>  drivers/acpi/hmat/Makefile                    |   1 +
>  drivers/acpi/hmat/hmat.c                      | 537 ++++++++++++++++++++++++++
>  drivers/acpi/numa.c                           |  16 +-
>  drivers/acpi/scan.c                           |   4 +-
>  drivers/acpi/tables.c                         |  76 +++-
>  drivers/base/Kconfig                          |   8 +
>  drivers/base/node.c                           | 354 ++++++++++++++++-
>  drivers/irqchip/irq-gic-v2m.c                 |   2 +-
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c      |   2 +-
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |   2 +-
>  drivers/irqchip/irq-gic-v3-its.c              |   6 +-
>  drivers/irqchip/irq-gic-v3.c                  |  10 +-
>  drivers/irqchip/irq-gic.c                     |   4 +-
>  drivers/mailbox/pcc.c                         |   2 +-
>  include/linux/acpi.h                          |   6 +-
>  include/linux/node.h                          |  60 ++-
>  25 files changed, 1344 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/admin-guide/mm/numaperf.rst
>  create mode 100644 drivers/acpi/hmat/Kconfig
>  create mode 100644 drivers/acpi/hmat/Makefile
>  create mode 100644 drivers/acpi/hmat/hmat.c
> 


