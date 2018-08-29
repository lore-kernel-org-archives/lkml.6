Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801C1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BBC20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X6f5zqeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BBC20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeH2VTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:19:43 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33368 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeH2VTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:19:43 -0400
Received: by mail-qk0-f195.google.com with SMTP id z78-v6so3885311qka.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZPYZr3HEv6RRDoFl9ff97XTjIiPi8FHoza0Nzjknvuo=;
        b=X6f5zqeoX5wvJf3jZ+CF2JGs4nQ5x9BZHO5JJYSQ0UnrP3eXw4sMXZ2dcZWW/uMRDX
         iAGKzWroqI8OHY4y1arJ30PZXyW/yKpSAJD9mQb/zgRx7hYjEfql0QromCotxKst0Pf6
         SF9AztDiqEW3NvGhf7VSW837f4ZpBVXLp8+38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZPYZr3HEv6RRDoFl9ff97XTjIiPi8FHoza0Nzjknvuo=;
        b=pSF5F8YuZ47eLSxa474sec5mweYovfE2LKX8BA3kS596RyD1thbyvBz5d3A3IwmlWu
         6FJLxLheotCyPHekvIcuhmXJDXRU9PXmL/laoXqdv4NtQZjoG06B7n6DlMTkZS4U/hXE
         pIYEcgg/xW88WBQOVDa/4VjsqqES46qlg9FRgSGg4EdA/40zCMpbWSqzPNE3iNft3Sfi
         mpwWKekayghgtFHoD2CIJlGWSRMvGIhW69ll61ZhvwMrjcO2tuNPQahswM3Llt8Ibh2N
         O7ZNxbHPFI6f+aRv9qtJ6GyM8vzZEp1orNVsH05bC5D+jx/AVhOqVNqv88WJu+fLmWNC
         499A==
X-Gm-Message-State: APzg51DtD7vqPhz0L2vfpo1i3nVEl9MpU6Tu6pTZKavQ6GqaSTmO3iQ0
        dsJOQDu6zMJ2Uk6arQgxazjs/w==
X-Google-Smtp-Source: ANB0Vdbx5pqdQVtw6ROxtUcHQ8Hs3BypVQCIqrOXGi1XxP+O+0lyke5r2kpNk/zEQTySBxW4yhpZTw==
X-Received: by 2002:a37:9404:: with SMTP id w4-v6mr7474560qkd.50.1535563307928;
        Wed, 29 Aug 2018 10:21:47 -0700 (PDT)
Received: from lbrmn-lnxub113.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v72-v6sm2630083qkb.84.2018.08.29.10.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 10:21:47 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
Date:   Wed, 29 Aug 2018 10:21:27 -0700
Message-Id: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
parameter to function with efi loader.

Required to boot on existing bootloaders that do not support devicetree
provided by the platform or by the bootloader.

Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the DTB loader")
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5..157cac9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -114,6 +114,7 @@ CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
 CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_ARM_TEGRA186_CPUFREQ=y
+CONFIG_EFI_ARMSTUB_DTB_LOADER=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
2.5.0

