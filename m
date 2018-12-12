Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EECC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4B42086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544592534;
	bh=x3yt7cDSFI/vvKew8gCptbNdrB7mS16lpcqtXDBJ/Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VzTV+qxyBQEWzqbLAiHqp+5s05bKAizT8eMMYi5aiVyM0Gf1JFIO66TE3DyQuwFoe
	 uuAq+0usW0VNIVTL1gqysZVlI03uxH7e/01va38Ti5m4C44zJ5A/WBrvVMhW6hFwVQ
	 mmJlBUwCjby39DWCsbDzAg9ruZTfgyjcE5srR9vw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4B42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbeLLF2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:28:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeLLF2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:28:50 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.78.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D8A220870;
        Wed, 12 Dec 2018 05:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544592529;
        bh=x3yt7cDSFI/vvKew8gCptbNdrB7mS16lpcqtXDBJ/Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0UgH6b+X1g22/1jknrBhlXieb4b0iY8UTGmN4ct1TVnbZ4Zrf397cJQdEA0CCR7OK
         F2SnDnIs97TnNTV4dxp2yCDPzbah2j1Sk1nxJgmlOYVvrBkNPMfwqnnQ0E2RAumlpW
         MJrtmQ1e6gOHHbAnOCVypkv+9K0WWPHCOXJRUN40=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/5] ACPI / OSL: Stub out acpi_os_read_pci_configuration when CONFIG_PCI is unset
Date:   Wed, 12 Dec 2018 05:28:42 +0000
Message-Id: <20181212052846.32370-3-okaya@kernel.org>
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

