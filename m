Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A692C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4378720836
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546199778;
	bh=6LwgM5vCGyI5+gOPQlfhwIQ4Ci6rsTqpuImxprLFSOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BhaDW6DLqTIla3lKKxU9YMNw5N31Dlk645462WjQINwRUAvkPJJNi03pY090UffkI
	 70Pk2TEIunmahSA75d70d6KVJPEpdGNd6Mm4ZStzBq8icGhw0JfWFRB05WG8JfdeN0
	 OqJ/k+1Dk08PeRnPRrzf8pMm6e225HAbqk/hIw64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeL3T4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbeL3T4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:56:16 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.85.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AFB020836;
        Sun, 30 Dec 2018 19:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546199775;
        bh=6LwgM5vCGyI5+gOPQlfhwIQ4Ci6rsTqpuImxprLFSOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qb5UsOBiSXkiy7RzO2dEIMXpisl3as82qRZuHPYNJrfE7TXQ/zmkNjD4JKo5BYkSR
         Gpcjludqu/s7z+4Gg+tzuDwdlJPvGjnGvb9DbP3hUASlLQkk4q2CdVT/XrKTUZNxw9
         /Zw3BCUjTwPDwWt/Bu0YbxtANeZcV4qI7C7Zxxus=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 01/11] ACPI / LPSS: Make PCI dependency explicit
Date:   Sun, 30 Dec 2018 19:56:02 +0000
Message-Id: <20181230195612.6657-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181230195612.6657-1-okaya@kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

