Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB541C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EAB20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AeVJ2di5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EAB20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeILB2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:28:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51136 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeILB2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:28:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so31215wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 13:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LbUKct7aCdWJoxSXtup9+lM1PDdAUhM72EnRxWqk5mw=;
        b=AeVJ2di54Vut+R/85MSO7BKeE+mIN6e49uY+HlkMH4mBwVbqCo1khvOhC8Tka75mcY
         DUNlDoEmD4y4eNhqwMOXqTci95iuoxsrO2Q1n0WVMiPPxsRe8M0+h3ouQGMud2vC7KKm
         Z6Z02oAkyb3nunVj8ctFqug1ugSUlXLrBGj6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LbUKct7aCdWJoxSXtup9+lM1PDdAUhM72EnRxWqk5mw=;
        b=gE5Jix6V+wCkA6d4GIoUHZXEQflPAiXiI0JcubDTN32mQmlneHFtKMQinGHHiBQ59K
         UW4qj+NYTP1Uc6xj2pxx5gLQLoNDQlSO4f4qs66z8ExxaIBuH4aThloIxlfJcP7xyrWR
         UwBPvTfoaV5jNZWVqgvJJKiv9B0XmRe68Zi+IxLco27GzkPv3sIdmch0pQ99B98Ta1fP
         A0rJa7AVGA1HkPm49CVURBAcYuJkvzF0OtPjgiPBdzDkWBNFxhlY/cgOInH0eDOpMQKi
         7/ceqZ96galIn2RM8u5k2B4GrHQevb/jSTqSilZ4b5GIH11ue3ZY+DjS9cw17MTDrmuj
         7h0g==
X-Gm-Message-State: APzg51Dqc8Cwv4vzAP8bTcchLUyvyxQ+L7hnWr0328u2dHEwYSF+3slQ
        gchCtBanRMzbGMUfFyewSUaHdw==
X-Google-Smtp-Source: ANB0VdbMEeGiB9ULMktAtznrAsb1rUHo7YE8KhXwKzx+qIignPeQsQ35Jll81seabHGne2EDlHnrNQ==
X-Received: by 2002:a1c:f60c:: with SMTP id w12-v6mr2593343wmc.80.1536697623194;
        Tue, 11 Sep 2018 13:27:03 -0700 (PDT)
Received: from lbrmn-lnxub113.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k35-v6sm26187250wrc.14.2018.09.11.13.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 13:27:02 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, leif.lindholm@linaro.org, agraf@suse.de,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] efi/libstub/arm: default EFI_ARMSTUB_DTB_LOADER to y
Date:   Tue, 11 Sep 2018 13:26:38 -0700
Message-Id: <1536697598-3692-1-git-send-email-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default EFI_ARMSTUB_DTB_LOADER to y to allow the dtb= command
line parameter to function with efi loader.

Required for development purposes and to boot on existing bootloaders
that do not support devicetree provided by the platform or by the bootloader.

Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the DTB loader")
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/firmware/efi/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index d8e159f..0a84d01 100644
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
2.5.0

