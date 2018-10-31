Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E66C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4F820821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4F820821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbeJaMUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:20:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:28201 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbeJaMUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:20:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 20:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="92552362"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Oct 2018 20:24:37 -0700
Subject: [PATCH 0/8] Introduce a device-dax bus-based device-model
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com
Date:   Tue, 30 Oct 2018 20:12:49 -0700
Message-ID: <154095556915.3271337.12581429676272726902.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prompted by the review of "[PATCH 0/9] Allow persistent memory to be
used like normal RAM" [1] introduce a new bus / device-driver-model
for device-dax.

Currently device-dax instances result from attaching an nvdimm namespace
device to the dax_pmem driver. These instances are registered with the
/sys/class/dax sub-system. With the expectation that platforms will
describe performance differentiated memory [2] for ranges other than
persistent memory (pmem) a new device-model is needed.

Arrange for dax_pmem to be one of potentially several drivers that know
how to discover differentiated memory and register a device instance on
the dax bus. The expectation is that, by default, this device is
consumed by the typical device-dax driver that will expose the range
through a /dev/daxX.Y character device. Optionally other drivers can
consume the dax device instance. For example, the kmem driver [1] can
attach to device-dax device instance to hot-add the related memory range
to the core page-allocator.

Going forward, provider drivers outside of dax_pmem can be created to
register other memories with unique performance properties.

Since /sys/class/dax is a released ABI, a compat driver is provided so
that distros can opt-in to the new bus based ABI. The /sys/class/dax
interface is then deprecated and scheduled to be removed.

[1]: https://lkml.org/lkml/2018/10/23/9
[2]: Section 5.2.27 Heterogeneous Memory Attribute Table (HMAT)
     http://www.uefi.org/sites/default/files/resources/ACPI%206_2_A_Sept29.pdf

---

Dan Williams (8):
      device-dax: Kill dax_region ida
      device-dax: Kill dax_region base
      device-dax: Remove multi-resource infrastructure
      device-dax: Start defining a dax bus model
      device-dax: Introduce bus + driver model
      device-dax: Move resource pinning+mapping into the common driver
      device-dax: Add support for a dax override driver
      device-dax: Add /sys/class/dax backwards compatibility


 Documentation/ABI/obsolete/sysfs-class-dax |   22 +
 drivers/dax/Kconfig                        |   12 +
 drivers/dax/Makefile                       |    5 
 drivers/dax/bus.c                          |  449 ++++++++++++++++++++++++++++
 drivers/dax/bus.h                          |   60 ++++
 drivers/dax/dax-private.h                  |   30 +-
 drivers/dax/dax.h                          |   18 -
 drivers/dax/device-dax.h                   |   25 --
 drivers/dax/device.c                       |  365 +++++------------------
 drivers/dax/pmem.c                         |  161 ----------
 drivers/dax/pmem/Makefile                  |    7 
 drivers/dax/pmem/compat.c                  |   73 +++++
 drivers/dax/pmem/core.c                    |   69 ++++
 drivers/dax/pmem/pmem.c                    |   40 ++
 drivers/dax/super.c                        |   41 ++-
 tools/testing/nvdimm/Kbuild                |    7 
 tools/testing/nvdimm/dax-dev.c             |   16 -
 17 files changed, 880 insertions(+), 520 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-class-dax
 create mode 100644 drivers/dax/bus.c
 create mode 100644 drivers/dax/bus.h
 delete mode 100644 drivers/dax/dax.h
 delete mode 100644 drivers/dax/device-dax.h
 delete mode 100644 drivers/dax/pmem.c
 create mode 100644 drivers/dax/pmem/Makefile
 create mode 100644 drivers/dax/pmem/compat.c
 create mode 100644 drivers/dax/pmem/core.c
 create mode 100644 drivers/dax/pmem/pmem.c
