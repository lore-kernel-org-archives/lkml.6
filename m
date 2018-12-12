Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B438C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFEB2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544635190;
	bh=FDlfxqfXz4k1qzOgW2nN5jd9MZxvTP//6qrH9ji9vjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uY1PrWa9eZUflbl+gthrUpajGNb9UVWFl3EkUwloC+UhxTse5xl+j0d1F9UTgxUqV
	 nKHeL3U7sCuUFtXzBT2MZJGTXih9AMF3sHaAVd0NVozoPAtJSbQnb1AeXcKx4IfjAl
	 NXK76VnmxyScpIJOoDIYcmt2WyYnnK6rV+5FwFSk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFEB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeLLRTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:19:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbeLLRTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:19:45 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.121.85.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BE4E20873;
        Wed, 12 Dec 2018 17:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544635184;
        bh=FDlfxqfXz4k1qzOgW2nN5jd9MZxvTP//6qrH9ji9vjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2nfQhImQonmDZL1UDfG7l5qBBzUQNQvB+st3sRbnrJg0rrEVpkLLRm0UrHNiCQhww
         SClnKNkixrN8fgVubZUt7YOjkUIFhzv8OAxoZXHYhSTUgDFEcqpYZ2zn2Fg9OepK5g
         E8tyAlsd0AZsmdbwZ7zPFJdWXdJYfqgYYBQDZlsQ=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 2/5] ACPI / OSL: Stub out acpi_os_read_pci_configuration when CONFIG_PCI is unset
Date:   Wed, 12 Dec 2018 17:19:37 +0000
Message-Id: <20181212171941.7437-3-okaya@kernel.org>
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
out acpi_os_read_pci_configuration function that depend on PCI.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/osl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index b48874b8e1ea..fb92b8a0ad31 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -773,6 +773,7 @@ acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 			       u64 *value, u32 width)
 {
+#ifdef CONFIG_PCI
 	int result, size;
 	u32 value32;
 
@@ -799,6 +800,12 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
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
-- 
2.19.0

