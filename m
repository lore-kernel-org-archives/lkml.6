Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB5C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C11C2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C11C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbeLKBFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:05:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:24625 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbeLKBFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:05:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 17:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,340,1539673200"; 
   d="scan'208";a="117705205"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2018 17:05:50 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 08/12] acpi/hmat: Register performance attributes
Date:   Mon, 10 Dec 2018 18:03:06 -0700
Message-Id: <20181211010310.8551-9-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181211010310.8551-1-keith.busch@intel.com>
References: <20181211010310.8551-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the best performance access attributes and register these with the
memory's node if HMAT provides the locality table.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/acpi/Kconfig |  1 +
 drivers/acpi/hmat.c  | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 9a05af3a18cf..6b5f6ca690af 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -330,6 +330,7 @@ config ACPI_NUMA
 config ACPI_HMAT
 	bool "ACPI Heterogeneous Memory Attribute Table Support"
 	depends on ACPI_NUMA
+	select HMEM_REPORTING
 	help
 	 Parses representation of the ACPI Heterogeneous Memory Attributes
 	 Table (HMAT) and set the memory node relationships and access
diff --git a/drivers/acpi/hmat.c b/drivers/acpi/hmat.c
index 5d8747ad025f..40bc83f4b593 100644
--- a/drivers/acpi/hmat.c
+++ b/drivers/acpi/hmat.c
@@ -23,6 +23,8 @@ struct memory_target {
 	struct list_head node;
 	unsigned int memory_pxm;
 	unsigned long p_nodes[BITS_TO_LONGS(MAX_NUMNODES)];
+	bool hmem_valid;
+	struct node_hmem_attrs hmem;
 };
 
 static __init struct memory_target *find_mem_target(unsigned int m)
@@ -108,6 +110,34 @@ static __init void hmat_update_access(u8 type, u32 value, u32 *best)
 	}
 }
 
+static __init void hmat_update_target(struct memory_target *t, u8 type,
+				      u32 value)
+{
+	switch (type) {
+	case ACPI_HMAT_ACCESS_LATENCY:
+		t->hmem.read_latency = value;
+		t->hmem.write_latency = value;
+		break;
+	case ACPI_HMAT_READ_LATENCY:
+		t->hmem.read_latency = value;
+		break;
+	case ACPI_HMAT_WRITE_LATENCY:
+		t->hmem.write_latency = value;
+		break;
+	case ACPI_HMAT_ACCESS_BANDWIDTH:
+		t->hmem.read_bandwidth = value;
+		t->hmem.write_bandwidth = value;
+		break;
+	case ACPI_HMAT_READ_BANDWIDTH:
+		t->hmem.read_bandwidth = value;
+		break;
+	case ACPI_HMAT_WRITE_BANDWIDTH:
+		t->hmem.write_bandwidth = value;
+		break;
+	}
+	t->hmem_valid = true;
+}
+
 static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 				      const unsigned long end)
 {
@@ -166,6 +196,8 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 					set_bit(p_node, t->p_nodes);
 			}
 		}
+		if (t && best)
+			hmat_update_target(t, type, best);
 	}
 	return 0;
 }
@@ -267,6 +299,8 @@ static __init void hmat_register_targets(void)
 		m = pxm_to_node(t->memory_pxm);
 		for_each_set_bit(p, t->p_nodes, MAX_NUMNODES)
 			register_memory_node_under_compute_node(m, p);
+		if (t->hmem_valid)
+			node_set_perf_attrs(m, &t->hmem);
 		kfree(t);
 	}
 }
-- 
2.14.4

