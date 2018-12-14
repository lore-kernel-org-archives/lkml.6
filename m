Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BCDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D297206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544805205;
	bh=p9qvVHV9nKGHqNLq+91oTrAC9ljetBkDKMlNDrEsRaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jbOANpIqVh5B6OP2jwvkKPJFvm04VRKswT61QXCSnIzzVEskTFHxcIpdrd3gQzgoZ
	 HoJIB0tzdf+2a/+rdIM/bi/czubRniMahas3WXIHTCXNR62R5Ew1gpgBWlriBx5d9A
	 nZc2u/5flw9PmCZ44EDB+k+qg7dGc9f61v6hi1WU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbeLNQdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:33:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbeLNQdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:33:22 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.30.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38ADE2070B;
        Fri, 14 Dec 2018 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544805202;
        bh=p9qvVHV9nKGHqNLq+91oTrAC9ljetBkDKMlNDrEsRaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L21JEqC+IMz3A18ouQqhIfY4mJNBO1nDlAZPV8wcFKrOB6W9XNdNcaUYz1yGd36bt
         A+B3DG/n8wZxXb1pXalT5V/oQipfHbbuL+sDLni4UwIoZKBBA7NSHzsoxKvW4hb4pf
         NNIWvyQpYoJCTdrK8J1T1HY3OSb0z6VV66vhczpw=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 1/6] ACPI: Allow CONFIG_PCI to be unset for reboot
Date:   Fri, 14 Dec 2018 16:33:14 +0000
Message-Id: <20181214163319.27479-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181214163319.27479-1-okaya@kernel.org>
References: <20181214163319.27479-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make PCI reboot conditional on PCI support being present on the kernel
configuration.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/reboot.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index 6fa9c2a4cfe9..d75e637ee36a 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -7,8 +7,6 @@
 void acpi_reboot(void)
 {
 	struct acpi_generic_address *rr;
-	struct pci_bus *bus0;
-	unsigned int devfn;
 	u8 reset_value;
 
 	if (acpi_disabled)
@@ -33,6 +31,11 @@ void acpi_reboot(void)
 	 * on a device on bus 0. */
 	switch (rr->space_id) {
 	case ACPI_ADR_SPACE_PCI_CONFIG:
+	{
+#ifdef CONFIG_PCI
+		unsigned int devfn;
+		struct pci_bus *bus0;
+
 		/* The reset register can only live on bus 0. */
 		bus0 = pci_find_bus(0, 0);
 		if (!bus0)
@@ -44,8 +47,9 @@ void acpi_reboot(void)
 		/* Write the value that resets us. */
 		pci_bus_write_config_byte(bus0, devfn,
 				(rr->address & 0xffff), reset_value);
+#endif
 		break;
-
+	}
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		printk(KERN_DEBUG "ACPI MEMORY or I/O RESET_REG.\n");
-- 
2.19.0

