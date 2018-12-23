Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13584C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19672184D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545607530;
	bh=4yGD8ZounH4LAxYICqO3kmRdulazSfBWRv82PoMQVfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2KJoJM9iyfn1Ua2eU4Y/Jun99W7OGQJ9jEHkK4LSugwJBluDIglKFP7bKaLZjvHlF
	 s7NhiAjQ0QnxXo1RVJ+lNA9Yq+u1GWMnxfi3o7d6aNihPZ/5Mh1wTi6XAfiZsGB85k
	 4KeRkhRkIJPtndOLht7FobU3+cnKOs05/BuzsIRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbeLWXZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:25:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbeLWXZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 18:25:28 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.82.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC8BA2184D;
        Sun, 23 Dec 2018 23:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545607527;
        bh=4yGD8ZounH4LAxYICqO3kmRdulazSfBWRv82PoMQVfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIWqzwtimb5rlKVNW7HfOONbxOI5SxP0LBkdjrjB3O2Kka1zRfVZX81hG3bF0SX/n
         EcxD/ZuOoTk353DNoFhAaIdqLV+6/20YE3D2oT8Pl5nssybyBiFothZf+MzRZKuux8
         vu+X7IH52Kc08JQwgudEJIl4iemoIlqKrSz2OFD8=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 01/11] ACPI / LPSS: Make PCI dependency explicit
Date:   Sun, 23 Dec 2018 23:25:10 +0000
Message-Id: <20181223232521.11320-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181223232521.11320-1-okaya@kernel.org>
References: <20181223232521.11320-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code depends on PCI. Compile only when PCI is present.

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

