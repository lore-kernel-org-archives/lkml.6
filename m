Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40315C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100BA20869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545259652;
	bh=21UWrCvIeuYfXLqlJQBGvU1KsSjm4EIUD/Krr9pA8ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AsAd8QucoUJTbkL9TLN4xs10Lojd0S+QS8HRJyuISsQi4FBZ7WksiMeOMjxzNjNO6
	 Eh+u307ms7GF/yJEbo6hvbIBNmXFHQ/mhsqMt2NqBT3cymBhtd2E/8P3tEBNPPYudv
	 9esNHfFkOwajkUZBZyLe9OaFzwMw73GV0uQIvU7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeLSWrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbeLSWrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:47:16 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.90.192.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C31E32146F;
        Wed, 19 Dec 2018 22:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545259635;
        bh=21UWrCvIeuYfXLqlJQBGvU1KsSjm4EIUD/Krr9pA8ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phFcGRRZJajIVZG6Y/C1DAf+Vn5eS3QmRQY6f9oYSzVoh9zmikBotnpyZwChRKEru
         tL/ZKEJKLeeVLtjY3z/1CyAp4mM04wkZkUXSKcBNZ8PtV+lvwQQ8Ysjiau5QpnQ+j6
         CPRT3SXdNgyOZ4SOxlkdWk2gdN0CX7In1V2BufjY=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 6/7] ACPI/IORT: Stub out ACS functions when CONFIG_PCI is not set
Date:   Wed, 19 Dec 2018 22:46:58 +0000
Message-Id: <20181219224659.4802-7-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181219224659.4802-1-okaya@kernel.org>
References: <20181219224659.4802-1-okaya@kernel.org>
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
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/acpi/arm64/iort.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70f4e80b9246..2159ad9bf9ed 100644
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
@@ -1458,13 +1464,15 @@ static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
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
 }
+#else
+static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
+#endif
 
 static void __init iort_init_platform_devices(void)
 {
@@ -1472,7 +1480,6 @@ static void __init iort_init_platform_devices(void)
 	struct acpi_table_iort *iort;
 	struct fwnode_handle *fwnode;
 	int i, ret;
-	bool acs_enabled = false;
 	const struct iort_dev_config *ops;
 
 	/*
@@ -1493,8 +1500,7 @@ static void __init iort_init_platform_devices(void)
 			return;
 		}
 
-		if (!acs_enabled)
-			acs_enabled = iort_enable_acs(iort_node);
+		iort_enable_acs(iort_node);
 
 		ops = iort_get_dev_cfg(iort_node);
 		if (ops) {
-- 
2.19.0

