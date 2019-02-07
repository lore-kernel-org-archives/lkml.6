Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A31C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B76A20823
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfBGJyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:54:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbfBGJyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:54:01 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 89CA8EC8D4B0CDB62978;
        Thu,  7 Feb 2019 17:53:59 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 7 Feb 2019
 17:53:50 +0800
Date:   Thu, 7 Feb 2019 09:53:36 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCHv5 00/10] Heterogeneuos memory node attributes
Message-ID: <20190207095336.0000529f@huawei.com>
In-Reply-To: <20190124230724.10022-1-keith.busch@intel.com>
References: <20190124230724.10022-1-keith.busch@intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
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

As a general heads up, ACPI 6.3 is out and makes some changes.
Discussions I've had in the past suggested there were few systems
shipping with 6.2 HMAT and that many firmwares would start at 6.3.
Of course, that might not be true, but there was fairly wide participation
in the meeting so fingers crossed it's accurate.

https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf

Particular points to note:
1. Most of the Memory Proximity Domain Attributes Structure was deprecated.
   This includes the reservation hint which has been replaced
   with a new mechanism (not used in this patch set)

2. Base units for latency changed to picoseconds.  There is a lot more
   explanatory text around how those work.

3. The measurements of latency and bandwidth no longer have an
   'aggregate performance' version.  Given the work load was not described
   this never made any sense.  Better for a knowledgeable bit of software
   to work out it's own estimate.

4. There are now Generic Initiator Domains that have neither memory nor
   processors.  I'll come back with proposals on handling those soon if
   no one beats me to it. (I think it's really easy but may be wrong ;)
   I've not really thought out how this series applies to GI only domains
   yet.  Probably not useful to know you have an accelerator near to
   particular memory if you are deciding where to pin your host processor
   task ;)

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


