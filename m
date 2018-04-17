Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeDQDMQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 23:12:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:3585 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbeDQDMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 23:12:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,461,1517904000";
   d="scan'208";a="48447600"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/9] iommu/vt-d: Improve PASID id and table management
Date: Tue, 17 Apr 2018 11:03:13 +0800
Message-Id: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set improves the PASID id and PASID table management
for Intel IOMMU driver.

PATCH 1~3 replace per IOMMU idr name space with a global one.
Current per IOMMU idr doesn't work in some cases where one
application (associated with a PASID) might talk to two physical
devices simultaneously while the two devices could reside behind
two different IOMMU units.

PATCH 4~9 implement per domain PASID table. Current per IOMMU
PASID table implementation is insecure in the cases where
multiple devices under one single IOMMU unit support PASID
feature. With per domain PASID table, we can achieve finer
protection and isolation granularity.

Best regards,
Lu Baolu

Lu Baolu (9):
  iommu/vt-d: Global PASID name space
  iommu/vt-d: Decouple idr bond pointer from svm
  iommu/vt-d: Use global PASID for SVM usage
  iommu/vt-d: Move device_domain_info to header
  iommu/vt-d: Per domain pasid table interfaces
  iommu/vt-d: Allocate and free pasid table
  iommu/vt-d: Calculate PTS value
  iommu/vt-d: Use per-domain pasid table
  iommu/vt-d: Clean up PASID talbe management for SVM

 drivers/iommu/Makefile      |   2 +-
 drivers/iommu/intel-iommu.c | 122 +++++++++++++++------------------------
 drivers/iommu/intel-pasid.c | 135 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |  34 +++++++++++
 drivers/iommu/intel-svm.c   |  98 ++++++++++++++++----------------
 include/linux/intel-iommu.h |  90 +++++++++++++++++++++++++++--
 6 files changed, 346 insertions(+), 135 deletions(-)
 create mode 100644 drivers/iommu/intel-pasid.c
 create mode 100644 drivers/iommu/intel-pasid.h

-- 
2.7.4
