Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE6C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2A020C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V39Jy7L2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2A020C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbeISDNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:13:04 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54600 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730331AbeISDNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:13:04 -0400
Received: by mail-it0-f65.google.com with SMTP id f14-v6so5474616ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 14:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w+VRD2Tl3jpAXs+NZaGNcbb96l49trHCObOMZHjoKPA=;
        b=V39Jy7L2fq0wv4eZzLnznzM94erLPLuOoKrJDkVZFlBjluVKqEf0EWRCSRwLdFc+hv
         dRg4cZb9AAX8D5Km9SuGtDDak+AbiQ2DphTbBjNbwVRVOlbjA3c71/Q2JRqUuJ1InMlp
         PEVO8YBgNkla4AErY1MIhUzRBUDzLtj5HcnSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w+VRD2Tl3jpAXs+NZaGNcbb96l49trHCObOMZHjoKPA=;
        b=f6wOmq9aq09F5Rp0KnKdosgJuBYUHY5EUkJXTmpYaY+6cwDTxRwOyoCvGiqZ087oRo
         E3+eI4OXtrDi18ze+7Q/DeZ5cm7f3mpTDmgu2evo93HHZzT4pHqi7LkepIRWjUmEpYhm
         jJYSU3OaOxTUiNUWGmEF9SXnHqkINC9s+Fm+Mo02nrv6/KH9Wixb+sJTqkaA3Hpm907T
         fL6Yf3PwUEV0xh02b2xSkKy0PlMCvEMsZ1riDJym+HkpUtExlZIwQiB7twFKS+BxAm1B
         3RA/UiEAX7g0W5KR8StpjFpPGNdcZxAnpf9X0g2m3Y2l5AS98Bpz2O1MoZsNOLKyITeA
         QHWw==
X-Gm-Message-State: APzg51AQY2ofZ0uKLJgU/Uqo7bKtk76/zicWBPk1aGRyeXZLR+vuvSza
        AoRMqwxm5KcZaF2oDY+eJWaobA==
X-Google-Smtp-Source: ANB0VdbDrOFUXseOhN7YJB1ddXR/W5EhE2Eo3eoNdTFEodmyDiax5LSA4REgeD+e93LoC1oIzBdKrQ==
X-Received: by 2002:a02:8c5d:: with SMTP id j29-v6mr27779759jal.28.1537306712422;
        Tue, 18 Sep 2018 14:38:32 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id m123-v6sm5018285itg.29.2018.09.18.14.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 14:38:31 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] efi/libstub/arm: default EFI_ARMSTUB_DTB_LOADER to y
Date:   Tue, 18 Sep 2018 14:36:52 -0700
Message-Id: <20180918213652.5648-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918213652.5648-1-ard.biesheuvel@linaro.org>
References: <20180918213652.5648-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Branden <scott.branden@broadcom.com>

Default EFI_ARMSTUB_DTB_LOADER to y to allow the dtb= command
line parameter to function with efi loader.

Required for development purposes and to boot on existing bootloaders
that do not support devicetree provided by the firmware or by the
bootloader.

Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option ...")
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index d8e159feb573..89110dfc7127 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -90,14 +90,17 @@ config EFI_ARMSTUB
 config EFI_ARMSTUB_DTB_LOADER
 	bool "Enable the DTB loader"
 	depends on EFI_ARMSTUB
+	default y
 	help
 	  Select this config option to add support for the dtb= command
 	  line parameter, allowing a device tree blob to be loaded into
 	  memory from the EFI System Partition by the stub.
 
-	  The device tree is typically provided by the platform or by
-	  the bootloader, so this option is mostly for development
-	  purposes only.
+	  If the device tree is provided by the platform or by
+	  the bootloader this option may not be needed.
+	  But, for various development reasons and to maintain existing
+	  functionality for bootloaders that do not have such support
+	  this option is necessary.
 
 config EFI_BOOTLOADER_CONTROL
 	tristate "EFI Bootloader Control"
-- 
2.17.1

