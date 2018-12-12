Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE020C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF582086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544635185;
	bh=p9qvVHV9nKGHqNLq+91oTrAC9ljetBkDKMlNDrEsRaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TE0QyQlNW7IUX4BR6UO6Qe1BkOiOXtpu/Wf9gqVWNQw5Gr0IbHvLaYm6AguU+bYy9
	 NTaV+lMwKuy9vn6fp0siMSychIJ4UmCxTn8AKh/mje0yTa6dmeNKfhCxrXGMd4ixtz
	 paGzrM8GRlK5Xmyo8pSqLo93f2v2AeVC0KZFufek=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF582086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeLLRTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbeLLRTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:19:44 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.121.85.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CFF220870;
        Wed, 12 Dec 2018 17:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544635184;
        bh=p9qvVHV9nKGHqNLq+91oTrAC9ljetBkDKMlNDrEsRaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsT4sQsOw+85QmxcGOeN6BKKrPBgGbJ/7S4/mPwk4zNuxJAVc3pOV3hoQYMXSAqcJ
         4I9aMItg/XJmRH2XTDVVSNP5K6gE2HPjhz+sgMXHEpSJi4IgSQx2CGWFipqboC2B5P
         DnU/RCGKnjtaUCfP3Q5ov49FpD36HXJA946RMOeo=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 1/5] ACPI: Allow CONFIG_PCI to be unset for reboot
Date:   Wed, 12 Dec 2018 17:19:36 +0000
Message-Id: <20181212171941.7437-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181212171941.7437-1-okaya@kernel.org>
References: <20181212171941.7437-1-okaya@kernel.org>
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

