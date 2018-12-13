Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96548C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FDA20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676543;
	bh=iGAVxKq1iO2xLjOIllpXFqks25VHwv/ORYwa3/+kFAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N6qUTcwSF3ZgVTw62q5iP91ddXmkvJ+ZxbXbywQPFzocnvrnUeuxh+LgRLWHBoCoU
	 aip++S1DhM29XuNrcFx7PTuoArS/dPRAslOolDLTwyyNVUmBOgZj3qgyhNHIFYEOI2
	 iI7hBY02foCTQu/5VlyuabuFwwTgFWeLhQ1IQiSs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FDA20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeLMEtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:49:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbeLMEsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:48:38 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.121.85.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E32EF20870;
        Thu, 13 Dec 2018 04:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544676518;
        bh=iGAVxKq1iO2xLjOIllpXFqks25VHwv/ORYwa3/+kFAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFfHEDHtgi396HxYO3H4NI7lK9WGJZbmWLO31D8p6+kUYDzfe4wOwo/HX3p+OQVlV
         eB9/cVvc80Kc/z2xge9p8j7MnrGTzENtPTMRIVL/KdDJQ85RuWNOe4WCoN4RDIgbwa
         jxO+O8t8cu6H+TKAOZgL4jI8E8T7mWcTBn78JDBE=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 3/5] ACPI / OSL: Stub out acpi_os_write_pci_configuration when CONFIG_PCI is unset
Date:   Thu, 13 Dec 2018 04:48:31 +0000
Message-Id: <20181213044833.23952-4-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181213044833.23952-1-okaya@kernel.org>
References: <20181213044833.23952-1-okaya@kernel.org>
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

