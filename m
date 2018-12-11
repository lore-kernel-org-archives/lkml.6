Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1A8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC6F20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC6F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbeLKBFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:05:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:24609 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbeLKBFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:05:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 17:05:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,340,1539673200"; 
   d="scan'208";a="117705161"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2018 17:05:42 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 00/12] Heterogeneous memory node attributes
Date:   Mon, 10 Dec 2018 18:02:58 -0700
Message-Id: <20181211010310.8551-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the second version for adding heterogeneous memory attributes to
the existing node sysfs representation.

Background:

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

Changes since v1:

  Reordered the patches. The ACPI and bare-bones HMAT parsing come
  first. The kernel interfaces, documentation and in-kernel users follow.

  For correctness, have the new generic ACPI parsing and their callbacks
  use the acpi union header type instead of the common header.

  Added node masks in addition to the node symlinks for primary memory and
  cpu nodes.

  Altered the naming conventions to clearly indicate the attributes are
  for primary access and capture the relationship for the new access
  attributes to their primary nodes.

  Added Documentation/ABI.

  Used 'struct device' instead of kobject for memory side caches.

  Initialize HMAT with subsys_initcall instead of device_init.

  Combined the numa performance documentation into a single file and
  moved it to admin-guide/mm/.

  Changelogs updated with spelling/grammar/editorial fixes, and include
  additional examples.

Keith Busch (12):
  acpi: Create subtable parsing infrastructure
  acpi/hmat: Parse and report heterogeneous memory
  node: Link memory nodes to their compute nodes
  Documentation/ABI: Add new node sysfs attributes
  acpi/hmat: Register processor domain to its memory
  node: Add heterogenous memory performance
  Documentation/ABI: Add node performance attributes
  acpi/hmat: Register performance attributes
  node: Add memory caching attributes
  Documentation/ABI: Add node cache attributes
  acpi/hmat: Register memory side cache attributes
  doc/mm: New documentation for memory performance

 Documentation/ABI/stable/sysfs-devices-node |  96 ++++++-
 Documentation/admin-guide/mm/numaperf.rst   | 171 ++++++++++++
 arch/x86/kernel/acpi/boot.c                 |  36 +--
 drivers/acpi/Kconfig                        |   9 +
 drivers/acpi/Makefile                       |   1 +
 drivers/acpi/hmat.c                         | 393 ++++++++++++++++++++++++++++
 drivers/acpi/numa.c                         |  16 +-
 drivers/acpi/scan.c                         |   4 +-
 drivers/acpi/tables.c                       |  76 +++++-
 drivers/base/Kconfig                        |   8 +
 drivers/base/node.c                         | 269 +++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c                |   2 +-
 drivers/mailbox/pcc.c                       |   2 +-
 include/linux/acpi.h                        |   6 +-
 include/linux/node.h                        |  49 ++++
 15 files changed, 1096 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/numaperf.rst
 create mode 100644 drivers/acpi/hmat.c

-- 
2.14.4

