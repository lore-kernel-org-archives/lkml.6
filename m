Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07965C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70BB2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfA0Ox5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:53:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:24709 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfA0Ox4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:53:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2019 06:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,530,1539673200"; 
   d="scan'208";a="139196826"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2019 06:53:55 -0800
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, songliubraving@fb.com,
        Kan Liang <kan.liang@linux.intel.com>, stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel/uncore: Add Node ID mask
Date:   Sun, 27 Jan 2019 06:53:14 -0800
Message-Id: <1548600794-33162-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some PCI uncore PMUs cannot be registered on a 8-socket system (HPE
Superdome Flex).

To understand which Socket the PCI uncore PMUs belong to, perf retrieves
the local Node ID of the uncore device from CPUNODEID(0xC0) of the PCI
configuration space, and the mapping between Socket ID and Node ID from
GIDNIDMAP(0xD4). The Socket ID can be calculated accordingly.
The local Node ID is only available at bit 2:0, but current code doesn't
mask it. If a BIOS doesn't clear the rest of the bits, a wrong Node ID
will be fetched.

Filter the Node ID by adding a mask.

Fixes: 7c94ee2e0917 ("perf/x86: Add Intel Nehalem and Sandy Bridge-EP uncore support")
Reported-by: Song Liu <songliubraving@fb.com>
Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/uncore_snbep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index c07bee3..b10e043 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1222,6 +1222,8 @@ static struct pci_driver snbep_uncore_pci_driver = {
 	.id_table	= snbep_uncore_pci_ids,
 };
 
+#define NODE_ID_MASK	0x7
+
 /*
  * build pci bus to socket mapping
  */
@@ -1243,7 +1245,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 		err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
 		if (err)
 			break;
-		nodeid = config;
+		nodeid = config & NODE_ID_MASK;
 		/* get the Node ID mapping */
 		err = pci_read_config_dword(ubox_dev, idmap_loc, &config);
 		if (err)
-- 
2.7.4

