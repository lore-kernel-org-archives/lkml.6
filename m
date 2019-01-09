Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2219C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB237206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfAIRsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:48:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:34829 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfAIRsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:48:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 09:48:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="115485651"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2019 09:48:01 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 12/13] acpi/hmat: Register memory side cache attributes
Date:   Wed,  9 Jan 2019 10:43:40 -0700
Message-Id: <20190109174341.19818-13-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190109174341.19818-1-keith.busch@intel.com>
References: <20190109174341.19818-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register memory side cache attributes with the memory's node if HMAT
provides the side cache iniformation table.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/acpi/hmat.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/acpi/hmat.c b/drivers/acpi/hmat.c
index 45e20dc677f9..9efdd0a63a79 100644
--- a/drivers/acpi/hmat.c
+++ b/drivers/acpi/hmat.c
@@ -206,6 +206,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 				   const unsigned long end)
 {
 	struct acpi_hmat_cache *cache = (void *)header;
+	struct node_cache_attrs cache_attrs;
 	u32 attrs;
 
 	if (cache->header.length < sizeof(*cache)) {
@@ -219,6 +220,37 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 		cache->memory_PD, cache->cache_size, attrs,
 		cache->number_of_SMBIOShandles);
 
+	cache_attrs.size = cache->cache_size;
+	cache_attrs.level = (attrs & ACPI_HMAT_CACHE_LEVEL) >> 4;
+	cache_attrs.line_size = (attrs & ACPI_HMAT_CACHE_LINE_SIZE) >> 16;
+
+	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
+	case ACPI_HMAT_CA_DIRECT_MAPPED:
+		cache_attrs.associativity = NODE_CACHE_DIRECT_MAP;
+		break;
+	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
+		cache_attrs.associativity = NODE_CACHE_INDEXED;
+		break;
+	case ACPI_HMAT_CA_NONE:
+	default:
+		cache_attrs.associativity = NODE_CACHE_OTHER;
+		break;
+	}
+
+	switch ((attrs & ACPI_HMAT_WRITE_POLICY) >> 12) {
+	case ACPI_HMAT_CP_WB:
+		cache_attrs.write_policy = NODE_CACHE_WRITE_BACK;
+		break;
+	case ACPI_HMAT_CP_WT:
+		cache_attrs.write_policy = NODE_CACHE_WRITE_THROUGH;
+		break;
+	case ACPI_HMAT_CP_NONE:
+	default:
+		cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
+		break;
+	}
+
+	node_add_cache(pxm_to_node(cache->memory_PD), &cache_attrs);
 	return 0;
 }
 
-- 
2.14.4

