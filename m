Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C710C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F72D218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546452645;
	bh=I7KKclq9Em2I8wMxGqR11bB/kA03fa2yg+RaVQzY7WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c+VgC6YDN6Taa8G605ieBE75b9Gcb2IiuIFXXioqKrEz9i17eGzFbDV96hHWYIJS1
	 zsRvuFkwbswzgiAg4naGQVwWKmUfvp8NLvse7ynZXfvoQbgGwqfpn1Jg8ssWr276KA
	 HAuc5UVVqrgxcjxSgjwwwhCmpcglkGnGAhl/Wj90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfABSKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:10:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfABSKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:10:43 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [137.117.71.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0FE218EA;
        Wed,  2 Jan 2019 18:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546452642;
        bh=I7KKclq9Em2I8wMxGqR11bB/kA03fa2yg+RaVQzY7WY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6xIbeY5j4625FXyZhsX4BXIFOPh6K70JVbm+pwcNS+anOejiteAqmLB/Ijdfwbls
         SMkMC41S5ySSbQQet/DHpMTBpc+ZBWfMsD8WB8LORvu96zI+ihebyqhR7TXypWL5gK
         XE4PnYBuU6Ilp09nFpu1x3EGZgHluPb4WScrYRCk=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 01/11] ACPI / LPSS: Make PCI dependency explicit
Date:   Wed,  2 Jan 2019 18:10:28 +0000
Message-Id: <20190102181038.4418-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190102181038.4418-1-okaya@kernel.org>
References: <20190102181038.4418-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")', it is possible to build ACPI without any PCI support.
This code depends on PCI. Compile only when PCI is present.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/Makefile   | 3 ++-
 drivers/acpi/internal.h | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 7c6afc111d76..bb857421c2e8 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -41,7 +41,8 @@ acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-$(CONFIG_PCI)		+= pci_root.o pci_link.o pci_irq.o
 obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
-acpi-y				+= acpi_lpss.o acpi_apd.o
+acpi-$(CONFIG_PCI)		+= acpi_lpss.o
+acpi-y				+= acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
 acpi-$(CONFIG_ARM_AMBA)	+= acpi_amba.o
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 7e6952edb5b0..6a9e1fb8913a 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -81,7 +81,11 @@ void acpi_debugfs_init(void);
 #else
 static inline void acpi_debugfs_init(void) { return; }
 #endif
+#ifdef CONFIG_PCI
 void acpi_lpss_init(void);
+#else
+static inline void acpi_lpss_init(void) {}
+#endif
 
 void acpi_apd_init(void);
 
-- 
2.19.0

