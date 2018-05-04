Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeEDBul (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 21:50:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:35622 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeEDBuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 21:50:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="37326225"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/9] iommu/vt-d: Improve PASID id and table management
Date: Fri,  4 May 2018 09:41:15 +0800
Message-Id: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
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

Change log:
v1->v2:
  - Patches have been reviewed by "Liu Yi L <yi.l.liu@intel.com>".
  - An error case handling was added in PATCH 6/9.
  - Some commit messages are refined to be more accurate.

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
 drivers/iommu/intel-iommu.c | 128 ++++++++++++++++-------------------------
 drivers/iommu/intel-pasid.c | 135 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |  34 +++++++++++
 drivers/iommu/intel-svm.c   |  98 ++++++++++++++++----------------
 include/linux/intel-iommu.h |  90 +++++++++++++++++++++++++++--
 6 files changed, 352 insertions(+), 135 deletions(-)
 create mode 100644 drivers/iommu/intel-pasid.c
 create mode 100644 drivers/iommu/intel-pasid.h

-- 
2.7.4
