Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25DAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E65D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545101787;
	bh=O1iV8iGb3yIcvPrCxOvzAXaK0zclyJSK3tHX+FXJ3xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SkZ4GO90aGrXvjCg7PdrcR9PK8ZXbrDwUGwp+2BHhtb9UUoMQ6yBLVVCdar7BOmqX
	 YnJBN380Qu8ewDi0HoJAqN4xU6WzWlMlqG1NdlD6zkO+pNDiqOSvzQ183toO0gvYkY
	 kAAE6gKxDSqTlA3k+RdpOChk8vaW968Y260k3JdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeLRC40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:56:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbeLRC4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:56:20 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.210.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D4AC2184C;
        Tue, 18 Dec 2018 02:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545101780;
        bh=O1iV8iGb3yIcvPrCxOvzAXaK0zclyJSK3tHX+FXJ3xQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txwGJ67QUG42bOaBt4nlKsGAjD6YHFEc/ROy4yUBgwVwMXTIBbYPZUx7Icei0LcuF
         bL0CD5vJ+9/H5j2r/I66fJC/UeJ0Ufd+a86RwPrKCKwsXc8Hm8Lz76vJ/CJLt4sAFP
         diLZRrGNqHF2ZULvNJkXZs/NfdVgvRQGPMLfzHCE=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 6/7] ACPI/IORT: Stub out ACS functions when CONFIG_PCI is not set
Date:   Tue, 18 Dec 2018 02:56:05 +0000
Message-Id: <20181218025606.32668-7-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181218025606.32668-1-okaya@kernel.org>
References: <20181218025606.32668-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove PCI dependent code out of iort.c when CONFIG_PCI is not defined.
A quick search reveals the following functions:
1. pci_request_acs()
2. pci_domain_nr()
3. pci_is_root_bus()
4. to_pci_dev()

Both pci_domain_nr() and pci_is_root_bus() are defined in linux/pci.h.
pci_domain_nr() is a stub function when CONFIG_PCI is not set and
pci_is_root_bus() just returns a reference to a structure member which
is still valid without CONFIG_PCI set.

to_pci_dev() is a macro that expands to container_of.

pci_request_acs() is the only code that gets pulled in from drivers/pci/*.c

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/arm64/iort.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70f4e80b9246..beb7e4c05bf5 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1435,8 +1435,14 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 	return ret;
 }
 
-static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
+#ifdef CONFIG_PCI
+static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 {
+	static bool acs_enabled __initdata;
+
+	if (acs_enabled)
+		return;
+
 	if (iort_node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
 		struct acpi_iort_node *parent;
 		struct acpi_iort_id_mapping *map;
@@ -1458,13 +1464,16 @@ static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
 			if ((parent->type == ACPI_IORT_NODE_SMMU) ||
 				(parent->type == ACPI_IORT_NODE_SMMU_V3)) {
 				pci_request_acs();
-				return true;
+				acs_enabled = true;
+				return;
 			}
 		}
 	}
-
-	return false;
+	return;
 }
+#else
+static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
+#endif
 
 static void __init iort_init_platform_devices(void)
 {
@@ -1472,7 +1481,6 @@ static void __init iort_init_platform_devices(void)
 	struct acpi_table_iort *iort;
 	struct fwnode_handle *fwnode;
 	int i, ret;
-	bool acs_enabled = false;
 	const struct iort_dev_config *ops;
 
 	/*
@@ -1493,8 +1501,7 @@ static void __init iort_init_platform_devices(void)
 			return;
 		}
 
-		if (!acs_enabled)
-			acs_enabled = iort_enable_acs(iort_node);
+		iort_enable_acs(iort_node);
 
 		ops = iort_get_dev_cfg(iort_node);
 		if (ops) {
-- 
2.19.0

