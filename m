Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A86C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82684218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfAXXIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:08:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:21167 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfAXXI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:08:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 15:08:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="313295731"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2019 15:08:22 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv5 00/10] Heterogeneuos memory node attributes
Date:   Thu, 24 Jan 2019 16:07:14 -0700
Message-Id: <20190124230724.10022-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

== Changes since v4 ==

  All public interfaces have kernel docs.

  Renamed "class" to "access", docs and changed logs updated
  accordingly. (Rafael)

  The sysfs hierarchy is altered to put initiators and targets in their
  own attribute group directories (Rafael).

  The node lists are removed. This feedback is in conflict with v1
  feedback, but consensus wants to remove multi-value sysfs attributes,
  which includes lists. We only have symlinks now, just like v1 provided.

  Documentation and code patches are combined such that the code
  introducing new attributes and its documentation are in the same
  patch. (Rafael and Dan).

  The performance attributes, bandwidth and latency, are moved into the
  initiators directory. This should make it obvious for which node
  access the attributes apply, which was previously ambiguous.
  (Jonathan Cameron).

  The HMAT code selecting "local" initiators is substantially changed.
  Only PXM's that have identical performance to the HMAT's processor PXM
  in Address Range Structure are registered. This is to avoid considering
  nodes identical when only one of several perf attributes are the same.
  (Jonathan Cameron).

  Verbose variable naming. Examples include "initiator" and "target"
  instead of "i" and "t", "mem_pxm" and "cpu_pxm" instead of "m" and
  "p". (Rafael)

  Compile fixes for when HMEM_REPORTING is not set. This is not a user
  selectable config option, default 'n', and will have to be selected
  by other config options that require it (Greg KH and Rafael).

== Background ==

Platforms may provide multiple types of cpu attached system memory. The
memory ranges for each type may have different characteristics that
applications may wish to know about when considering what node they want
their memory allocated from. 

It had previously been difficult to describe these setups as memory
rangers were generally lumped into the NUMA node of the CPUs. New
platform attributes have been created and in use today that describe
the more complex memory hierarchies that can be created.

This series' objective is to provide the attributes from such systems
that are useful for applications to know about, and readily usable with
existing tools and libraries.

Keith Busch (10):
  acpi: Create subtable parsing infrastructure
  acpi: Add HMAT to generic parsing tables
  acpi/hmat: Parse and report heterogeneous memory
  node: Link memory nodes to their compute nodes
  acpi/hmat: Register processor domain to its memory
  node: Add heterogenous memory access attributes
  acpi/hmat: Register performance attributes
  node: Add memory caching attributes
  acpi/hmat: Register memory side cache attributes
  doc/mm: New documentation for memory performance

 Documentation/ABI/stable/sysfs-devices-node   |  87 ++++-
 Documentation/admin-guide/mm/numaperf.rst     | 167 ++++++++
 arch/arm64/kernel/acpi_numa.c                 |   2 +-
 arch/arm64/kernel/smp.c                       |   4 +-
 arch/ia64/kernel/acpi.c                       |  12 +-
 arch/x86/kernel/acpi/boot.c                   |  36 +-
 drivers/acpi/Kconfig                          |   1 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/hmat/Kconfig                     |   9 +
 drivers/acpi/hmat/Makefile                    |   1 +
 drivers/acpi/hmat/hmat.c                      | 537 ++++++++++++++++++++++++++
 drivers/acpi/numa.c                           |  16 +-
 drivers/acpi/scan.c                           |   4 +-
 drivers/acpi/tables.c                         |  76 +++-
 drivers/base/Kconfig                          |   8 +
 drivers/base/node.c                           | 354 ++++++++++++++++-
 drivers/irqchip/irq-gic-v2m.c                 |   2 +-
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      |   2 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |   2 +-
 drivers/irqchip/irq-gic-v3-its.c              |   6 +-
 drivers/irqchip/irq-gic-v3.c                  |  10 +-
 drivers/irqchip/irq-gic.c                     |   4 +-
 drivers/mailbox/pcc.c                         |   2 +-
 include/linux/acpi.h                          |   6 +-
 include/linux/node.h                          |  60 ++-
 25 files changed, 1344 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/numaperf.rst
 create mode 100644 drivers/acpi/hmat/Kconfig
 create mode 100644 drivers/acpi/hmat/Makefile
 create mode 100644 drivers/acpi/hmat/hmat.c

-- 
2.14.4

