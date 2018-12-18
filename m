Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC13C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409E221855
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545101781;
	bh=huE7+kw7prZWjnTByz2rTYX+7JxBV1By3zjE6tcZvOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c3+pFIl0cox5YGaDzyzq/eiM+4LxkNOgUEqcN68fknby+AjWZdwnycYKrTxuMPGly
	 NmjZ0BatgdK93huCb/MdV0b5cSY5X/z6VA1jUhgYmmMMJNmBlKVmnStSr6TH59kLvJ
	 rCV00YokbUNrk0gStdRXAYHwfnNmZIPyhaRVQwHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeLRC4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:56:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbeLRC4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:56:11 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.210.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A5F217D9;
        Tue, 18 Dec 2018 02:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545101770;
        bh=huE7+kw7prZWjnTByz2rTYX+7JxBV1By3zjE6tcZvOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LN/9WacbMPk1VvyOEwSVccMq2nohKmzjHhc7vfd08wxztCnlccAj1ekWYTaUK3DP0
         h15vtQVKLFu60KBu7XGblbOLgwvwrmRdkRfFLIRC/VsruHl5TRSaxqIm6MS+FxaIyn
         dlJMPhiP8LnSSv2RN6YjHzFD8Y8L5tI7J01n+Scc=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 2/7] ACPI / OSL: Stub out acpi_os_(read/write)_pci_configurations()
Date:   Tue, 18 Dec 2018 02:56:01 +0000
Message-Id: <20181218025606.32668-3-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181218025606.32668-1-okaya@kernel.org>
References: <20181218025606.32668-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting ready to allow CONFIG_PCI to be unset with ACPI enabled. Stub out
acpi_os_read_pci_configuration and acpi_os_write_pci_configuration
functions when CONFIG_PCI is not defined.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/osl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index b48874b8e1ea..524fd5f33ea4 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -773,6 +773,7 @@ acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 			       u64 *value, u32 width)
 {
+#ifdef CONFIG_PCI
 	int result, size;
 	u32 value32;
 
@@ -799,12 +800,19 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 	*value = value32;
 
 	return (result ? AE_ERROR : AE_OK);
+#else
+	int rc;
+
+	rc = pr_warn_once("PCI configuration space access is not supported\n");
+	return rc ? AE_SUPPORT : AE_OK;
+#endif
 }
 
 acpi_status
 acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				u64 value, u32 width)
 {
+#ifdef CONFIG_PCI
 	int result, size;
 
 	switch (width) {
@@ -826,6 +834,12 @@ acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
+#else
+	int rc;
+
+	rc = pr_warn_once("PCI configuration space access is not supported\n");
+	return rc ? AE_SUPPORT : AE_OK;
+#endif
 }
 
 static void acpi_os_execute_deferred(struct work_struct *work)
-- 
2.19.0

