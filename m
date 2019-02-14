Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6272BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1C6222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437261AbfBNRLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:11:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:10415 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393090AbfBNRK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:10:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 09:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; 
   d="scan'208";a="133613134"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Feb 2019 09:10:42 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv6 08/10] acpi/hmat: Register performance attributes
Date:   Thu, 14 Feb 2019 10:10:15 -0700
Message-Id: <20190214171017.9362-9-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190214171017.9362-1-keith.busch@intel.com>
References: <20190214171017.9362-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the best performance access attributes and register these with the
memory's node if HMAT provides the locality table. While HMAT does make
it possible to know performance for all possible initiator-target
pairings, we export only the local pairings at this time.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/acpi/hmat/hmat.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index b29f7160c7bb..6833c4897ff4 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -549,12 +549,27 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
 	}
 }
 
+static __init void hmat_register_target_perf(struct memory_target *target)
+{
+	unsigned mem_nid = pxm_to_node(target->memory_pxm);
+
+	if (!target->hmem_attrs.read_bandwidth &&
+	    !target->hmem_attrs.read_latency &&
+	    !target->hmem_attrs.write_bandwidth &&
+	    !target->hmem_attrs.write_latency)
+		return;
+
+	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
+}
+
 static __init void hmat_register_targets(void)
 {
 	struct memory_target *target;
 
-	list_for_each_entry(target, &targets, node)
+	list_for_each_entry(target, &targets, node) {
 		hmat_register_target_initiators(target);
+		hmat_register_target_perf(target);
+	}
 }
 
 static __init void hmat_free_structures(void)
-- 
2.14.4

