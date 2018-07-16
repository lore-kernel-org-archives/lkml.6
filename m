Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72051ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362C820864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362C820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeGPH0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:26:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:45301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeGPH0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:26:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 00:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="72647236"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2018 00:00:12 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 00/10] iommu/vt-d: Add scalable mode support
Date:   Mon, 16 Jul 2018 14:49:43 +0800
Message-Id: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
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

This patch series depends on a patch set titled ("iommu/vt-d:
Improve PASID id and table management") post here [4] which
implements global pasid namespace and per-device pasid table
APIs.

References:
[1] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
[2] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[3] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
[4] https://lkml.org/lkml/2018/7/14/69

Best regards,
Lu Baolu

Lu Baolu (10):
  iommu/vt-d: Enumerate the scalable mode capability
  iommu/vt-d: Manage scalalble mode PASID tables
  iommu/vt-d: Move page table helpers into header
  iommu/vt-d: Add second level page table interface
  iommu/vt-d: Setup pasid entry for RID2PASID support
  iommu/vt-d: Pass pasid table to context mapping
  iommu/vt-d: Setup context and enable RID2PASID support
  iommu/vt-d: Add first level page table interface
  iommu/vt-d: Shared virtual address in scalable mode
  iommu/vt-d: Remove deferred invalidation

 drivers/iommu/intel-iommu.c   | 252 +++++++++++++++++++-----------------
 drivers/iommu/intel-pasid.c   | 295 ++++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel-pasid.h   |  20 ++-
 drivers/iommu/intel-svm.c     |  74 +----------
 include/linux/dma_remapping.h |   9 +-
 include/linux/intel-iommu.h   |  54 ++++++--
 6 files changed, 485 insertions(+), 219 deletions(-)

-- 
2.7.4

