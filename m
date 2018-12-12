Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85630C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4420620870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544592254;
	bh=x3yt7cDSFI/vvKew8gCptbNdrB7mS16lpcqtXDBJ/Hg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ypf85GCWH5fAxSVDxDJn8nIYl8moiMAwuU/Pkmiplkl+Yd9ZbkZ/KAPA2ZiFvRb6j
	 K9aWHVm6lnH3QA7m7TbDtbHASp+DOdlv4E1BHySJkRkVxH4SZ4rPYS14L7Hhs9JnDW
	 nXADhcegPyRzySLSib/0isxsJoQwKlFTzv0OYC0I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4420620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeLLFYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:24:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeLLFYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:24:12 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.78.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E776E20851;
        Wed, 12 Dec 2018 05:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544592252;
        bh=x3yt7cDSFI/vvKew8gCptbNdrB7mS16lpcqtXDBJ/Hg=;
        h=From:To:Cc:Subject:Date:From;
        b=jZ8L88nvrmdWaDC25HfZ/SfGzto5LjdA2rk5101qvOujg22s1jDxYK6DNJChue9Om
         Lzbwtpf4ERUnCvc2EyPFOnwJFvJWTs1FS1y76YqAXpdpKGFhN1siZh2fu5z7YpdqGp
         1faO7xg5QGc4qwPKXxRPT96lAkUXBQ0a8Gde5FWM=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/4] ACPI / OSL: Stub out acpi_os_read_pci_configuration when CONFIG_PCI is unset
Date:   Wed, 12 Dec 2018 05:23:56 +0000
Message-Id: <20181212052359.31808-1-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting ready to allow PCI to be disabled with ACPI enabled. Stub out
acpi_os_read_pci_configuration function that depend on PCI.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/osl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index b48874b8e1ea..3e82b50ba811 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -773,6 +773,7 @@ acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 			       u64 *value, u32 width)
 {
+#ifdef CONFIG_PCI
 	int result, size;
 	u32 value32;
 
@@ -799,6 +800,9 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 	*value = value32;
 
 	return (result ? AE_ERROR : AE_OK);
+#else
+	return pr_warn_once("CONFIG_PCI is disabled\n") ? AE_SUPPORT : AE_OK;
+#endif
 }
 
 acpi_status
-- 
2.19.0

