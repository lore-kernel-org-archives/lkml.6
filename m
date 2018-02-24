Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-523801-1519451400-2-13516114795263246068
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519451398; b=sJqImdIW0Vhe4Ib4Y5s2i4vpZmSqrHsbxJOSB7lPr1ILsP0
    fEAPivh0MaeXCfUFdV8FpvRAMbtgapDP5guAqEUD+Z+GWDGQGx0lN6t5MSdj7EE1
    9RZF15G5ybP94FQ9VISquez3whzo36etxelRU65lJyKpbctrQ06t1B45XV/gM1YS
    HSUoF80xVFjfY9TV97etO3+oDszHL3pX2kyFlJs5BapaJL6hOp3Du47rZzepyztB
    BRxYNhiRq6la+Oso1bC9BXWS4QC3YPlaOXHYuTfax76wa/THgjYVDDziZgyeMsWi
    MC/UqrId+6ZRC3Il945/Madth0Z84ObeOz5fadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519451398; bh=8pfunhc0oM+ZXTDyijAT6T4KCD
    7SGdraBbYkRlRorRQ=; b=ejZzGW+hEu/RAcnm2PUHiU5Dlu+E65vLk6KkFrSK8k
    6Ocdk0T2CtMEdUZkeEf0TjPSwks0Vd1t2mWuJHHBftrsQpq1w9DE4AJ6PnAto8j2
    WrS8fYc3iea/T4eRdffDvlaM2kuUF/Hl1V4QYNFacAVjtWew7XNzCfGpIz7Oihis
    8wdoHgRnZXyQhMQApUxJf0FCnv6xt2nWwcr7s2tlfryWeR1os14qwDSgNcaTUEXB
    HZNxYk9LX3D5GhqtksE6ht+WH+zcNIOe/ed9BEqF+cLEImCpwyYevR2m7Mpr0yjh
    SXO/K7v74EcUiY9TluIL5KDMLJyjc+uuFGyM6uVRoUWQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750841AbeBXFtw (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Feb 2018 00:49:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:43625 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbeBXFtw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 24 Feb 2018 00:49:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,386,1515484800";
   d="scan'208";a="33760288"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "# v4 . 4+" <stable@vger.kernel.org>
Subject: [PATCH 1/1] iommu/vt-d: Fix a potential memory leak
Date: Sat, 24 Feb 2018 13:42:27 +0800
Message-Id: <1519450947-9760-1-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A memory block was allocated in intel_svm_bind_mm() but never freed
in a failure path. This patch fixes this by free it to avoid memory
leakage.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 35a408d..3d4b924 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -396,6 +396,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 				pasid_max - 1, GFP_KERNEL);
 		if (ret < 0) {
 			kfree(svm);
+			kfree(sdev);
 			goto out;
 		}
 		svm->pasid = ret;
-- 
2.7.4
