Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37403C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E248B21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E248B21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389940AbeIUT5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:57:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:5429 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbeIUT5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:57:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 07:07:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="265564198"
Received: from otc-lr-04.jf.intel.com ([10.54.39.63])
  by fmsmga006.fm.intel.com with ESMTP; 21 Sep 2018 07:07:57 -0700
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, stable@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Fix PCI BDF address of M3UPI on SKX
Date:   Fri, 21 Sep 2018 07:07:06 -0700
Message-Id: <1537538826-55489-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The counters on M3UPI Link 0 and Link 3 don't count. Writing 0 to
these counters may causes system crash on some machines.

The PCI BDF addresses of M3UPI in current code are incorrect.
The correct addresses should be
D18:F1 	0x204D
D18:F2 	0x204E
D18:F5 	0x204D

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 51d7c11..3b3fc92 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3931,16 +3931,16 @@ static const struct pci_device_id skx_uncore_pci_ids[] = {
 		.driver_data = UNCORE_PCI_DEV_FULL_DATA(21, 5, SKX_PCI_UNCORE_M2PCIE, 3),
 	},
 	{ /* M3UPI0 Link 0 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204C),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 0, SKX_PCI_UNCORE_M3UPI, 0),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204D),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 1, SKX_PCI_UNCORE_M3UPI, 0),
 	},
 	{ /* M3UPI0 Link 1 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204D),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 1, SKX_PCI_UNCORE_M3UPI, 1),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204E),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 2, SKX_PCI_UNCORE_M3UPI, 1),
 	},
 	{ /* M3UPI1 Link 2 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204C),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 4, SKX_PCI_UNCORE_M3UPI, 2),
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x204D),
+		.driver_data = UNCORE_PCI_DEV_FULL_DATA(18, 5, SKX_PCI_UNCORE_M3UPI, 2),
 	},
 	{ /* end: all zeroes */ }
 };
-- 
2.7.4

