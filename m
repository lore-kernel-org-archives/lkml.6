Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954A3C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 21:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5D520850
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 21:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544305617;
	bh=bxQjlTD/toFo7TIcjmD1Vf7Q2DUbI9zj/A7TKnRsmbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FijJ3kpqgXrzRk5J2dGCK5nWagkYoQbeuWhGyOUl1BqJ5q9RkviKchuX/QnpqaE8T
	 qXcErVJdctpDDMQDbleoch8fO+wMQDaYS8tVIwOhEmWv03/yjoIbygLVe5aBo3B94Y
	 NTJYblkTylt29Xp+TvVLgA1xRdymBr6nnDjfa/uc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5D520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLHVqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 16:46:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbeLHVqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 16:46:50 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.15.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B2E820989;
        Sat,  8 Dec 2018 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544305609;
        bh=bxQjlTD/toFo7TIcjmD1Vf7Q2DUbI9zj/A7TKnRsmbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5TYrlyGrYEIM74qP6upvTuOiPqQa/xFHUItib79j9fQZ+ASOqa9yq+7CNbxMZ3qc
         6/b2RvHXfwaxcSQjrZb4Kn0XHZ8A41X9pXekCArLqi+lr4vlwr/pig5amNaGY8GcPu
         L8GfbsCWVPs3ximRZtLNlAvvAGwS/kcX3L1iHB6c=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] ACPI / OSL: Allow PCI to be disabled
Date:   Sat,  8 Dec 2018 21:46:42 +0000
Message-Id: <20181208214644.5374-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181208214644.5374-1-okaya@kernel.org>
References: <20181208214644.5374-1-okaya@kernel.org>
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

