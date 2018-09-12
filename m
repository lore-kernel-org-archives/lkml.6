Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98064C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A68220880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A68220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeILFLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:11:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:30629 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeILFLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:11:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 17:09:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72213067"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 17:09:58 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v8 0/6] Add Intel IOMMU debugfs support
Date:   Tue, 11 Sep 2018 17:11:35 -0700
Message-Id: <20180912001141.64025-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

This series aims to add debugfs support for Intel IOMMU. It exposes IOMMU
registers, internal context and dumps individual table entries to help debug
Intel IOMMUs.

Patches 1-3 do the ground work for the following patches by reorganizing
some Intel IOMMU data structures, creating a new config option -
INTEL_IOMMU_DEBUGFS and adding an Intel IOMMU debugfs directory. The following
patches add debugfs support for IOMMU resigter contents, Interrupt remapping
and context internals in that order. The information can be accessed in sysfs
at '/sys/kernel/debug/iommu/intel/'.

This series is based on the new VT-d 3.0 specification [1]. The scalable mode
and PASID table debugfs patches are not part of this series. They would be
submitted later once the IOMMU driver patches for the same are accepted and
merged upstream.

Regards,
Sohil

[1] https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf

Changes since v7:
 - Move to the common iommu directory approach suggested by Joerg
 - Remove ECS debugfs support that has been deprecated with the new VT-d spec
 - Change filename to intel-iommu-debugfs.c
 - Remove the pasid table debugfs patch
 - Add MTRR and Virtual command register support
 - Use locks to protect register and table access
 - Improve seq_printf formatting
 - Simplify and split the patches differently

Changes since v6:
 - Split patch 1/5 and 2/5 differently
 - Simplify and improve code formatting
 - Use macro for register set definitions
 - Fix compiler warning for readq
 - Add Co-Developed-by tag to commit messages

Changes since v5:
 - Change the order of includes to an alphabetical order
 - Change seq_printf and seq_puts formatting

Changes since v4:
 - Change to a SPDX license tag
 - Fix seq_printf formatting and remove leading '\n's

Changes since v3:
 - Remove an unused function parameter from some of the functions
 - Fix checkpatch.pl warnings
 - Remove error reporting for debugfs_create_file functions
 - Fix unnecessary reprogramming of the context entries
 - Simplify and merge the show context and extended context patch into one
 - Remove redundant IOMMU null check under for_each_active_iommu
 - Update the commit title to be consistent

Changes since v2:
 - Added a macro for seq file operations based on recommendation by Andy 
   Shevchenko. The marco can be moved to seq_file.h at a future point
 - Changed the debugfs file names to more relevant ones
 - Added information for MTRR registers in the regset file

Changes since v1:
 - Fixed seq_printf formatting
 - Handled the case when Interrupt remapping is not enabled


Gayatri Kammela (1):
  iommu/vt-d: Add debugfs support to show register contents

Sohil Mehta (5):
  iommu/vt-d: Relocate struct/function declarations to its header files
  iommu/vt-d: Update register definitions to VT-d 3.0 specification
  iommu/vt-d: Enable base Intel IOMMU debugfs support
  iommu/vt-d: Add debugfs support for Interrupt remapping
  iommu/vt-d: Add debugfs support to show context internals

 arch/x86/include/asm/irq_remapping.h |   2 +
 drivers/iommu/Kconfig                |  13 ++
 drivers/iommu/Makefile               |   1 +
 drivers/iommu/intel-iommu-debugfs.c  | 314 +++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c          |  32 +--
 drivers/iommu/intel_irq_remapping.c  |   2 +-
 include/linux/intel-iommu.h          |  72 ++++++
 7 files changed, 407 insertions(+), 29 deletions(-)
 create mode 100644 drivers/iommu/intel-iommu-debugfs.c

-- 
2.18.0

