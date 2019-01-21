Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263DCC37125
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AD120870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548112804;
	bh=m1tquJenc8u2eB/s5oWBXrMEonoBRdLWAm/ApZ0NiV0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vs4fJWqtAGX5Fe6dyQE+jQNaDErTAMtguuP3iQurScNDE5n9wVk+dqoyRNLImL3Jm
	 Z9P9DMeoAHq6wGghbHdHjgumjxjPAVvV+wN/orHkkmk30tBCCmystBtMtdSME3XmKo
	 8vWDUW/VX2UsLD0cER+eF+eH2TCrX/MNDhirFAHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfAUXUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:20:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfAUXUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:20:01 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.83.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7C1E20870;
        Mon, 21 Jan 2019 23:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548112801;
        bh=m1tquJenc8u2eB/s5oWBXrMEonoBRdLWAm/ApZ0NiV0=;
        h=From:To:Cc:Subject:Date:From;
        b=SDyAvwltZ5/5K55H2sKemi/A9WroY7yJPPB+38JpA3vhd+Ik2x9oWm0Q7YdDtKafg
         VLWPnf6cO+8nfix+1aB31MtPH0fkt0uvk5U0qkRt6wRk328xEb19cw0CGI2KChkLOn
         TTLstBy+TpKVsagyQ57yFMolE8rMa7oGfcjzA370=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [for next][PATCH 1/2] mfd: Fix unmet dependency warning for MFD_TPS68470
Date:   Mon, 21 Jan 2019 23:19:57 +0000
Message-Id: <20190121231958.28255-1-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly.

WARNING: unmet direct dependencies detected for I2C_DESIGNWARE_PLATFORM
  Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ACPI [=y] && COMMON_CLK [=n] || !ACPI [=y])
  Selected by [y]:
  - MFD_TPS68470 [=y] && HAS_IOMEM [=y] && ACPI [=y] && I2C [=y]=y

MFD_TPS68470 is an ACPI only device and selects I2C_DESIGNWARE_PLATFORM.
I2C_DESIGNWARE_PLATFORM does not have any configuration today for ACPI
support without CONFIG_PCI set.

For sake of a quick fix this introduces a new mandatory dependency to the
driver which may survive without it. Otherwise we need to revisit the
driver architecture to address this properly.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f461460a2aeb..76f9909cf396 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1419,7 +1419,7 @@ config MFD_TPS65217
 
 config MFD_TPS68470
 	bool "TI TPS68470 Power Management / LED chips"
-	depends on ACPI && I2C=y
+	depends on ACPI && PCI && I2C=y
 	select MFD_CORE
 	select REGMAP_I2C
 	select I2C_DESIGNWARE_PLATFORM
-- 
2.19.0

