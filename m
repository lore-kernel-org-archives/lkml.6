Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11E9C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA3C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544592536;
	bh=+4cli/iNnX8QC4pzCFG3qvoz0WOha7DDwQIx/NnB/Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VRgVhLJGLp1stYSilbW4QZ9ZgZWxxxXVzVJB0XaO5ceYh1az9nEABDUo9T6RsalLI
	 IYYUWJXvyNALXDB4W5s7gBU+Vu69JyMm0eHaQn+4My5ZensLOgINgot7B8pCofrfLr
	 0cAQSqh6TgnpYZXHPhcKhL9B9p0ZX//Fwso8ep4I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA3C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeLLF2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:28:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbeLLF2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:28:51 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.78.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4041020851;
        Wed, 12 Dec 2018 05:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544592530;
        bh=+4cli/iNnX8QC4pzCFG3qvoz0WOha7DDwQIx/NnB/Mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xNf0cJbdLITHSIV0LtpBj4a0/yCKg1oWlD6yY8kYmx+JWC6gbu5TorOupI7UYrUc1
         PfB4g5zgy6fAZuId45P9iz/CAzbYPEbP+w66AAgEUXByfZixUA5Oa9Tmn5/NUx6b/a
         l96V/QU2GzO7txgY0TLYRjPZecaXoqTym9LN3vVQ=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 3/5] ACPI / OSL: Stub out acpi_os_write_pci_configuration when CONFIG_PCI is unset
Date:   Wed, 12 Dec 2018 05:28:43 +0000
Message-Id: <20181212052846.32370-4-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181212052846.32370-1-okaya@kernel.org>
References: <20181212052846.32370-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting ready to allow PCI to be disabled with ACPI enabled. Stub out
acpi_os_write_pci_configuration function that depend on PCI.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/osl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3e82b50ba811..7b1e58f93f37 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -809,6 +809,7 @@ acpi_status
 acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				u64 value, u32 width)
 {
+#ifdef CONFIG_PCI
 	int result, size;
 
 	switch (width) {
@@ -830,6 +831,9 @@ acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
+#else
+	return pr_warn_once("CONFIG_PCI is disabled\n") ? AE_SUPPORT : AE_OK;
+#endif
 }
 
 static void acpi_os_execute_deferred(struct work_struct *work)
-- 
2.19.0

