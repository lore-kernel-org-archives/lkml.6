Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB55CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFB3218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546452701;
	bh=CIZPvz2pxw0T1ievRoUSgQlu2J4eAlsxbA5VjoOo5p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MdhwESewOTt1MI8x3BWI3OL37BtfT7FuZCftc4aVsbEiR6h2BN5g/VNimIRct3iY1
	 4r9N9Ws++CCBlrxz5ro76DXL56fngIjW2TGYN54xmHR2Yx+hJdTfyNRyrCD1D6vp9h
	 gMDczgx6eIRZUOFbHwto4TM95aoX88ahSyBk3kEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfABSLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:11:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfABSKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:10:43 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [137.117.71.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6D5C21905;
        Wed,  2 Jan 2019 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546452643;
        bh=CIZPvz2pxw0T1ievRoUSgQlu2J4eAlsxbA5VjoOo5p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qeWuXVuHvIdiW0RKUrEzw+34+wnd8gV0FzlJSi5m1GBDxeyfezNZuUZB0dj/m+D8e
         QcdACRtjn8oOS4ZMA3GhuVpXOd9oHNOhiYoS+O+2GmoJfdVQpE2CbKOfUM1SLXsKAx
         vqaPDT56wHm2V3jFmCwEcxLJLlAoQaLRLx4rDDwI=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 02/11] ata: pata_acpi: Make PCI dependency explicit
Date:   Wed,  2 Jan 2019 18:10:29 +0000
Message-Id: <20190102181038.4418-3-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190102181038.4418-1-okaya@kernel.org>
References: <20190102181038.4418-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly. PATA_ACPI is a PCI device driver but the PCI
dependency has not been explicitly called out.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 4ca7a6b4eaae..8218db17ebdb 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1091,7 +1091,7 @@ comment "Generic fallback / legacy drivers"
 
 config PATA_ACPI
 	tristate "ACPI firmware driver for PATA"
-	depends on ATA_ACPI && ATA_BMDMA
+	depends on ATA_ACPI && ATA_BMDMA && PCI
 	help
 	  This option enables an ACPI method driver which drives
 	  motherboard PATA controller interfaces through the ACPI
-- 
2.19.0

