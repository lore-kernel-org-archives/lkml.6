Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9CDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D9A20869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545259627;
	bh=EUbhE/YcdveFWA/H0DNlItLQED6C7iZa/IkBsguCgnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FIlK31sBftOKSc9AomQ3M4XqvwvJ5c1MhEodcPAgtH70bBNcY6KB1M1l6c4QvnEQJ
	 NtO0JEFOzoK3Gn89DGBhysC+KZDn+ACUgbgk04Q+CpN+SIiIoPgWoGh1jRIlMw/1Pi
	 o2yVwIsEqpmL9F5dsiJK1SCriraADVbLPAg01eFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeLSWrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:47:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbeLSWrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:47:05 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.90.192.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89A320989;
        Wed, 19 Dec 2018 22:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545259625;
        bh=EUbhE/YcdveFWA/H0DNlItLQED6C7iZa/IkBsguCgnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ruv8JaTnjYFR9ZEUdED4cJGOrVlEG6iUGwgtNCUxdbFJ8R86yhmGXKjykTWNmoSxH
         6zwKjSFOEw3AHzteggTuCr8LDEO0Js8f5vbOA2jnY5ySu/f4DzNQEvosPTzli9vrXv
         Gyj7Y+JaPnvyqbp8xFISBhkI2NoNBx7Vbt/wFQg8=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 1/7] ACPI: Move PCI reset to a separate function
Date:   Wed, 19 Dec 2018 22:46:53 +0000
Message-Id: <20181219224659.4802-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181219224659.4802-1-okaya@kernel.org>
References: <20181219224659.4802-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting ready to factor out PCI specific code when CONFIG_PCI is unset.
Create a acpi_pci_reset() that kick starts PCI specific reset.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/reboot.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index 6fa9c2a4cfe9..d642a9dede52 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -4,11 +4,27 @@
 #include <linux/acpi.h>
 #include <acpi/reboot.h>
 
+static void acpi_pci_reboot(struct acpi_generic_address *rr, u8 reset_value)
+{
+	unsigned int devfn;
+	struct pci_bus *bus0;
+
+	/* The reset register can only live on bus 0. */
+	bus0 = pci_find_bus(0, 0);
+	if (!bus0)
+		return;
+	/* Form PCI device/function pair. */
+	devfn = PCI_DEVFN((rr->address >> 32) & 0xffff,
+			  (rr->address >> 16) & 0xffff);
+	pr_debug("Resetting with ACPI PCI RESET_REG.\n");
+	/* Write the value that resets us. */
+	pci_bus_write_config_byte(bus0, devfn,
+			(rr->address & 0xffff), reset_value);
+}
+
 void acpi_reboot(void)
 {
 	struct acpi_generic_address *rr;
-	struct pci_bus *bus0;
-	unsigned int devfn;
 	u8 reset_value;
 
 	if (acpi_disabled)
@@ -33,17 +49,7 @@ void acpi_reboot(void)
 	 * on a device on bus 0. */
 	switch (rr->space_id) {
 	case ACPI_ADR_SPACE_PCI_CONFIG:
-		/* The reset register can only live on bus 0. */
-		bus0 = pci_find_bus(0, 0);
-		if (!bus0)
-			return;
-		/* Form PCI device/function pair. */
-		devfn = PCI_DEVFN((rr->address >> 32) & 0xffff,
-				  (rr->address >> 16) & 0xffff);
-		printk(KERN_DEBUG "Resetting with ACPI PCI RESET_REG.\n");
-		/* Write the value that resets us. */
-		pci_bus_write_config_byte(bus0, devfn,
-				(rr->address & 0xffff), reset_value);
+		acpi_pci_reboot(rr, reset_value);
 		break;
 
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
-- 
2.19.0

