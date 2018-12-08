Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD0BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 21:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D57920837
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 21:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544305627;
	bh=60YJ7itwkgUOAKiZjqULe2wS1drD7u7lfau+oU3AgvA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SwBsuswz1dRnnMAE5xcBvXNhfKpdzLDhjavCZPSh5CXSsHocGde99f+Iiikepa2Dm
	 P7WLLZ4kCW+rE+zdyFeHwfd2Ko1OO3k48WiBl74puAx0IIj63ULbLkeJLvWQxdVMmO
	 ZKqhPXZ89ZQSGKWVvxY9rqCSpEQvOz5OiipJ24Dk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D57920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbeLHVrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 16:47:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbeLHVqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 16:46:49 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.15.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E8C820837;
        Sat,  8 Dec 2018 21:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544305609;
        bh=60YJ7itwkgUOAKiZjqULe2wS1drD7u7lfau+oU3AgvA=;
        h=From:To:Cc:Subject:Date:From;
        b=jgYAGYNdZEdmQONj4d+D0HFmHgUND9guy9BY842VRpWnf+N3o8KXwR3RfhR8NwFwm
         5QWKbWRaV/atVEZ7dD24BS2AVBy6EY57iDj0n9tVEMiK7pKtUvbu5BNIScBkWpAjWY
         a0ywFVQb5iy1fkOjFjQaCwoYZQ3oHewUyjoK42As=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] ACPI: Allow PCI to be disabled for reboot
Date:   Sat,  8 Dec 2018 21:46:41 +0000
Message-Id: <20181208214644.5374-1-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
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
 drivers/acpi/reboot.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index 6fa9c2a4cfe9..9aa367f098a6 100644
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
@@ -45,7 +48,10 @@ void acpi_reboot(void)
 		pci_bus_write_config_byte(bus0, devfn,
 				(rr->address & 0xffff), reset_value);
 		break;
-
+#else
+		return;
+#endif
+	}
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		printk(KERN_DEBUG "ACPI MEMORY or I/O RESET_REG.\n");
-- 
2.19.0

