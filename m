Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E025C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2B921871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546682805;
	bh=c5VrHRZ0RHiz+jVT7Mu3/5uIICO3oWNpC9hywkO9kqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HYG4ZdV+NfxKCk0dxwvRfgPahi32zMUm5OddSUOcRI5z1Vjr2TDA3hUCmGbnNTfHZ
	 TbG4bfHvegTWVbqHZuQg0ZjIB8QR0AhaFAaUlQ3gEYiZn1uvQ7LuCtY4V20zMHXq+z
	 7PWgh47sko4BY/tKr/txN1w7kJPGVhtXETWVLCBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfAEKGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 05:06:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfAEKGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 05:06:25 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [104.211.55.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B5D32070C;
        Sat,  5 Jan 2019 10:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546682784;
        bh=c5VrHRZ0RHiz+jVT7Mu3/5uIICO3oWNpC9hywkO9kqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHmmrm20t+2cXp1KS6ddLzYMEZgSfnAOTqv/QYahgQl7WXojX0V9ivrYBYZ79CXyt
         zM1ORQQzlzW4dI8aLVQujLN88dyeUWNgkWEFntV5kY8CIT06e3LVGN3eumJX2S+8Rz
         L8Af4r9Dgmt2K0y0c2NyZ3+69q9XcLOKWFQTH9gg=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Smith <alex.smith@imgtec.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
Date:   Sat,  5 Jan 2019 10:06:04 +0000
Message-Id: <20190105100606.6673-10-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190105100606.6673-1-okaya@kernel.org>
References: <20190105100606.6673-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly. This driver relies on IOSF_MBI and IOSF_MBI depends
on PCI. For this reason, add a direct dependency to CONFIG_PCI here.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e26b8145efb3..1b9401fe94c0 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -116,7 +116,7 @@ config MMC_RICOH_MMC
 
 config MMC_SDHCI_ACPI
 	tristate "SDHCI support for ACPI enumerated SDHCI controllers"
-	depends on MMC_SDHCI && ACPI
+	depends on MMC_SDHCI && ACPI && PCI
 	select IOSF_MBI if X86
 	help
 	  This selects support for ACPI enumerated SDHCI controllers,
-- 
2.19.0

