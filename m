Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DB8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5C721848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBTSZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:25:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:46760 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfBTSZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:25:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 10:25:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,392,1544515200"; 
   d="scan'208";a="119478926"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 20 Feb 2019 10:25:33 -0800
Date:   Wed, 20 Feb 2019 11:25:27 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv6 00/10] Heterogenous memory node attributes
Message-ID: <20190220182527.GD4451@localhost.localdomain>
References: <20190214171017.9362-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214171017.9362-1-keith.busch@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:10:07AM -0700, Keith Busch wrote:
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
> existing tools and libraries. Those applications may query performance
> attributes relative to a particular CPU they're running on in order to
> make more informed choices for where they want to allocate hot and cold
> data. This works with mbind() or the numactl library.

Hi all,

So this seems very calm at this point. Unless there are any late concerns
or suggestions, could we open consideration for queueing in a staging
tree for a future merge window?

Thanks,
Keith

 
> Keith Busch (10):
>   acpi: Create subtable parsing infrastructure
>   acpi: Add HMAT to generic parsing tables
>   acpi/hmat: Parse and report heterogeneous memory
>   node: Link memory nodes to their compute nodes
>   node: Add heterogenous memory access attributes
>   node: Add memory-side caching attributes
>   acpi/hmat: Register processor domain to its memory
>   acpi/hmat: Register performance attributes
>   acpi/hmat: Register memory side cache attributes
>   doc/mm: New documentation for memory performance
> 
>  Documentation/ABI/stable/sysfs-devices-node   |  89 +++-
>  Documentation/admin-guide/mm/numaperf.rst     | 164 +++++++
>  arch/arm64/kernel/acpi_numa.c                 |   2 +-
>  arch/arm64/kernel/smp.c                       |   4 +-
>  arch/ia64/kernel/acpi.c                       |  12 +-
>  arch/x86/kernel/acpi/boot.c                   |  36 +-
>  drivers/acpi/Kconfig                          |   1 +
>  drivers/acpi/Makefile                         |   1 +
>  drivers/acpi/hmat/Kconfig                     |   9 +
>  drivers/acpi/hmat/Makefile                    |   1 +
>  drivers/acpi/hmat/hmat.c                      | 677 ++++++++++++++++++++++++++
>  drivers/acpi/numa.c                           |  16 +-
>  drivers/acpi/scan.c                           |   4 +-
>  drivers/acpi/tables.c                         |  76 ++-
>  drivers/base/Kconfig                          |   8 +
>  drivers/base/node.c                           | 351 ++++++++++++-
>  drivers/irqchip/irq-gic-v2m.c                 |   2 +-
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c      |   2 +-
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |   2 +-
>  drivers/irqchip/irq-gic-v3-its.c              |   6 +-
>  drivers/irqchip/irq-gic-v3.c                  |  10 +-
>  drivers/irqchip/irq-gic.c                     |   4 +-
>  drivers/mailbox/pcc.c                         |   2 +-
>  include/linux/acpi.h                          |   6 +-
>  include/linux/node.h                          |  60 ++-
>  25 files changed, 1480 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/admin-guide/mm/numaperf.rst
>  create mode 100644 drivers/acpi/hmat/Kconfig
>  create mode 100644 drivers/acpi/hmat/Makefile
>  create mode 100644 drivers/acpi/hmat/hmat.c
