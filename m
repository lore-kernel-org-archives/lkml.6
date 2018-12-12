Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFE1C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A4B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544635204;
	bh=iGAVxKq1iO2xLjOIllpXFqks25VHwv/ORYwa3/+kFAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PP86J7pVq+Ilox3L3Ykf2XK1odqLKYSKeq40W98WbZzS3p/ixmRZhsJfr4EuQRp7+
	 H4E0zXSznjULoB7+5O+H6zoVP/BX9rtXFNvWM780PqAUPnw1Dx4mpfaWONcGoMBSsZ
	 qFJlCGLXVLoZHjcNb9ID5uUBmj/hhTP1/NvS8hlA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A4B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeLLRTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:19:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbeLLRTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:19:46 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.121.85.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A29120851;
        Wed, 12 Dec 2018 17:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544635185;
        bh=iGAVxKq1iO2xLjOIllpXFqks25VHwv/ORYwa3/+kFAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGc0/1ztTleKfRwnT7Z5loEn/C8/4xFXZHEOwucJ3BCjKJtIQSkcBFo9IUcPKtymu
         eytnU3bBrIQrxLXpRPFcuSzGogz0kwgjN1RnQUbG3Y6/jXmINSoCO5on7XZgXaO3c3
         0v0kpzFOesr1RdfehG/vqlf6gEC4uDOHKUcd3fvU=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 3/5] ACPI / OSL: Stub out acpi_os_write_pci_configuration when CONFIG_PCI is unset
Date:   Wed, 12 Dec 2018 17:19:38 +0000
Message-Id: <20181212171941.7437-4-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181212171941.7437-1-okaya@kernel.org>
References: <20181212171941.7437-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting ready to allow CONFIG_PCI to be disabled with ACPI enabled. Stub
out acpi_os_write_pci_configuration function that depend on PCI.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/osl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index fb92b8a0ad31..524fd5f33ea4 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -812,6 +812,7 @@ acpi_status
 acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				u64 value, u32 width)
 {
+#ifdef CONFIG_PCI
 	int result, size;
 
 	switch (width) {
@@ -833,6 +834,12 @@ acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
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

