Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9BBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF8E208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF8E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeK1O56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:57:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:51625 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeK1O56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:57:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 19:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,289,1539673200"; 
   d="scan'208";a="113554325"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga002.fm.intel.com with ESMTP; 27 Nov 2018 19:57:47 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 00/12] iommu/vt-d: Add scalable mode support
Date:   Wed, 28 Nov 2018 11:54:37 +0800
Message-Id: <20181128035449.10226-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Intel vt-d rev3.0 [1] introduces a new translation mode called
'scalable mode', which enables PASID-granular translations for
first level, second level, nested and pass-through modes. The
vt-d scalable mode is the key ingredient to enable Scalable I/O
Virtualization (Scalable IOV) [2] [3], which allows sharing a
device in minimal possible granularity (ADI - Assignable Device
Interface). It also includes all the capabilities required to
enable Shared Virtual Addressing (SVA). As a result, previous
Extended Context (ECS) mode is deprecated (no production ever
implements ECS).

Each scalable mode pasid table entry is 64 bytes in length, with
fields point to the first level page table and the second level
page table. The PGTT (Pasid Granular Translation Type) field is
used by hardware to determine the translation type.


          A Scalable Mode            .-------------.
           PASID Entry             .-|             |
       .------------------.      .-| | 1st Level   |
      7|                  |      | | | Page Table  |
       .------------------.      | | |             |
      6|                  |      | | |             |
       '------------------'      | | '-------------'
      5|                  |      | '-------------'
       '------------------'      '-------------'
      4|                  |    ^
       '------------------'   /
      3|                  |  /       .-------------.
       .----.-------.-----. /      .-|             |
      2|    | FLPTR |     |/     .-| | 2nd Level   |
       .----'-------'-----.      | | | Page Table  |
      1|                  |      | | |             |
       .-.-------..------..      | | |             |
      0| | SLPTR || PGTT ||----> | | '-------------'
       '-'-------''------''      | '-------------'
       6             |    0      '-------------'
       3             v
             .------------------------------------.
             | PASID Granular Translation Type    |
             |                                    |
             | 001b: 1st level translation only   |
             | 101b: 2nd level translation only   |
             | 011b: Nested translation           |
             | 100b: Pass through                 |
             '------------------------------------'

This patch series adds the scalable mode support in the Intel
IOMMU driver. It will make all the Intel IOMMU features work
in scalable mode. The changes are all constrained within the
Intel IOMMU driver, as it's purely internal format change.

References:
[1] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
[2] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[3] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf

Change log:
v4->v5:
  - [04/12] Add a comment to explain why we only print
            two QWORDs of an invalid descriptor.
  - [06/12] Fix domain agaw being less than iommu agaw.
  - [09/12] Move data type to local branch.
  - [11/12] Hold iommu lock when setup pasid entry for
            SVM.
  - All rebased on top of vt-d branch of iommu tree.

v3->v4:
  - Rebase all patches to 4.20-rc1.
  - Use the right PASID directory table size.
  - Add a function for pass through translation setting up.
  - Refine the parameters passed to first level translation
    mode interface.

v2->v3:
  - Rebase all patches on top of vt-d branch of iommu repo.
  - Set the pasid directory table size to 1 page for devices
    which have no pasid support.
  - Fix various comments received during v2 review period.
    All were code style related.

v1->v2:
  - Rebase all patches on top of v4.19-rc1;
  - Add 256-bit invalidation descriptor support;
  - Reserve a domain id for first level and pass-through
    usage to make hardware cache entries more efficiently;
  - Various code refinements.

Lu Baolu (12):
  iommu/vt-d: Enumerate the scalable mode capability
  iommu/vt-d: Manage scalalble mode PASID tables
  iommu/vt-d: Move page table helpers into header
  iommu/vt-d: Add 256-bit invalidation descriptor support
  iommu/vt-d: Reserve a domain id for FL and PT modes
  iommu/vt-d: Add second level page table interface
  iommu/vt-d: Setup pasid entry for RID2PASID support
  iommu/vt-d: Pass pasid table to context mapping
  iommu/vt-d: Setup context and enable RID2PASID support
  iommu/vt-d: Add first level page table interface
  iommu/vt-d: Shared virtual address in scalable mode
  iommu/vt-d: Remove deferred invalidation

 .../admin-guide/kernel-parameters.txt         |  12 +-
 drivers/iommu/dmar.c                          |  91 ++--
 drivers/iommu/intel-iommu.c                   | 336 ++++++-------
 drivers/iommu/intel-pasid.c                   | 447 +++++++++++++++++-
 drivers/iommu/intel-pasid.h                   |  40 +-
 drivers/iommu/intel-svm.c                     | 170 +++----
 drivers/iommu/intel_irq_remapping.c           |   6 +-
 include/linux/intel-iommu.h                   |  75 ++-
 8 files changed, 826 insertions(+), 351 deletions(-)

-- 
2.17.1

