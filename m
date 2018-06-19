Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE314C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD3F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD3F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755865AbeFSF1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:27:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:14970 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751602AbeFSF1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:27:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 22:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="50424270"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 22:27:12 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/9] iommu/vt-d: Improve PASID id and table management
Date:   Tue, 19 Jun 2018 13:17:20 +0800
Message-Id: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set improves the PASID id and PASID table management
for Intel IOMMU driver.

PATCH 1~3 replace per IOMMU idr name space with a global one.
Current per IOMMU idr doesn't work in some cases where one
application (associated with a PASID) might talk to two physical
devices simultaneously while the two devices could reside behind
two different IOMMU units.

PATCH 4~9 implement per device PASID table. Current per IOMMU
PASID table implementation is insecure in the cases where
multiple devices under one single IOMMU unit support PASID
feature. With per domain PASID table, we can achieve finer
protection and isolation granularity. This has been discussed
at https://lkml.org/lkml/2018/5/16/154.

Best regards,
Lu Baolu

Change log:
v1->v2:
  - Patches have been reviewed by "Liu Yi L <yi.l.liu@intel.com>".
  - An error case handling was added in PATCH 6/9.
  - Some commit messages are refined to be more accurate.
v2->v3:
  - Patches rebased on top of v4.18-rc1.
  - Replace per-domain with per-device pasid table.

Lu Baolu (9):
  iommu/vt-d: Global PASID name space
  iommu/vt-d: Avoid using idr_for_each_entry()
  iommu/vt-d: Apply global PASID in SVA
  iommu/vt-d: Move device_domain_info to header
  iommu/vt-d: Add for_each_device_domain() helper
  iommu/vt-d: Per PCI device pasid table interfaces
  iommu/vt-d: Allocate and free pasid table
  iommu/vt-d: Apply per pci device pasid table in SVA
  iommu/vt-d: Remove the obsolete per iommu pasid tables

 drivers/iommu/Makefile      |   2 +-
 drivers/iommu/intel-iommu.c | 142 ++++++++++++--------------
 drivers/iommu/intel-pasid.c | 238 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |  39 ++++++++
 drivers/iommu/intel-svm.c   |  79 ++++++---------
 include/linux/intel-iommu.h |  79 ++++++++++++++-
 6 files changed, 447 insertions(+), 132 deletions(-)
 create mode 100644 drivers/iommu/intel-pasid.c
 create mode 100644 drivers/iommu/intel-pasid.h

-- 
2.7.4

