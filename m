Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F3AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213F12084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544465605;
	bh=bxQjlTD/toFo7TIcjmD1Vf7Q2DUbI9zj/A7TKnRsmbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cj24cmAF/OqFwRM52gk0oMtn4OjoNOXVV+aIlIdf0TbUkCCZM8PVFCtQAIBmtfcDm
	 t8vLn9M+i5uZ1KOtyeZ6m6AIEXZcqg27JWbFMLK0VMkbOpsCLFa5v7VEXjcZuJtbmX
	 rEw+jqwcRluzZMoiuupFwcFMaecverzBMTa9D9xM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213F12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeLJSNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:13:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728832AbeLJSNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:13:19 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.121.107.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5500B2086D;
        Mon, 10 Dec 2018 18:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544465598;
        bh=bxQjlTD/toFo7TIcjmD1Vf7Q2DUbI9zj/A7TKnRsmbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1DI0k5sSnbjkHAnecGEzwQZGj5nWU1HPya82Rhi/vOCPyGbswswtRg9THlsuVnl6r
         4cEXeFAS7e6YIqfJ3yhHYK+D3nqKbJw6lf+D5qFGn9tTnds34Gs8FL5Wjv28uZ5LcJ
         MOr+YOXRmPOL8NBGp7u4Fr/jRvXfXmdhXri3Q2L0=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
Date:   Mon, 10 Dec 2018 18:13:14 +0000
Message-Id: <20181210181315.5023-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181210181315.5023-1-okaya@kernel.org>
References: <20181210181315.5023-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting ready to allow PCI to be disabled with ACPI enabled. Stub
out calls that depend on PCI.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/osl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index b48874b8e1ea..0d3ed659cfe8 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -773,6 +773,7 @@ acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 			       u64 *value, u32 width)
 {
+#ifdef CONFIG_PCI
 	int result, size;
 	u32 value32;
 
@@ -799,12 +800,16 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 	*value = value32;
 
 	return (result ? AE_ERROR : AE_OK);
+#else
+	return AE_SUPPORT;
+#endif
 }
 
 acpi_status
 acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				u64 value, u32 width)
 {
+#ifdef CONFIG_PCI
 	int result, size;
 
 	switch (width) {
@@ -826,6 +831,9 @@ acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
+#else
+	return AE_SUPPORT;
+#endif
 }
 
 static void acpi_os_execute_deferred(struct work_struct *work)
-- 
2.19.0

