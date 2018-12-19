Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AA7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9554B20989
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545259629;
	bh=CdNSErPT5isDG9mC26VskUxt5/1BONHziImHLRyTOe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mI28UZCiSy85ZqhcAM1wr+f0aag2smI29wvoRn22PEkmX+TbUlBmUl1Oyul7rYzhg
	 n1qhiqQ2R/qyqzuqANEo46hW6smB6sYzqsX6nD2seJJTmeu62vHILJ3gNKQryl0TCF
	 DnIBfoB9da/IcqRd3BOADxRKQqdj53DfmgLR8ABU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbeLSWrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbeLSWrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:47:06 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.90.192.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3FA2133F;
        Wed, 19 Dec 2018 22:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545259626;
        bh=CdNSErPT5isDG9mC26VskUxt5/1BONHziImHLRyTOe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhrxUAs1RUjBfA+y2/IOa0ro6ZE6FoxzX+9o6TMm6HWcF5QCQPRhxIr0za9VhaKlS
         ghd7ss8YLksiqe07OqRECTnPB3p0nVACodO0KJ6xgAm9CvDp2hHWWVGxhXWZ0xsNiJ
         vpDYw7KK084M6sDUqL/eLwkdYuvZ3xYPKaOYrsFE=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 2/7] ACPI: Allow CONFIG_PCI to be unset for reboot
Date:   Wed, 19 Dec 2018 22:46:54 +0000
Message-Id: <20181219224659.4802-3-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181219224659.4802-1-okaya@kernel.org>
References: <20181219224659.4802-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make PCI reboot conditional on CONFIG_PCI set on the kernel configuration.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/reboot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index d642a9dede52..ca707f5b521d 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -4,6 +4,7 @@
 #include <linux/acpi.h>
 #include <acpi/reboot.h>
 
+#ifdef CONFIG_PCI
 static void acpi_pci_reboot(struct acpi_generic_address *rr, u8 reset_value)
 {
 	unsigned int devfn;
@@ -21,6 +22,13 @@ static void acpi_pci_reboot(struct acpi_generic_address *rr, u8 reset_value)
 	pci_bus_write_config_byte(bus0, devfn,
 			(rr->address & 0xffff), reset_value);
 }
+#else
+static inline void acpi_pci_reboot(struct acpi_generic_address *rr,
+				   u8 reset_value)
+{
+	pr_warn_once("PCI configuration space access is not supported\n");
+}
+#endif
 
 void acpi_reboot(void)
 {
-- 
2.19.0

