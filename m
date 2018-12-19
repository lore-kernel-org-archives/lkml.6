Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABF5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A539720869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545259638;
	bh=MLMGWi5cjWSTIwETIFeyETUoUs3RMVxywCoyrYA70gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VjeA124n52bqLZL9Ysu3JFeoXobUsUbCj8b1ttqoDB/yAqzJVQWQu8ziFils1A1ux
	 URJCqn1O/h22s+gmIfnZkMEerVoB8VKJm8m5UV1BoXLaK7wRP+PNI6TKQhbAP/c4qd
	 34hhuqEuTMgFnFPoVjTiNaC0nfaMbk2+bjWoMHLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbeLSWrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:47:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729135AbeLSWrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:47:15 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.90.192.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEFA22133F;
        Wed, 19 Dec 2018 22:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545259634;
        bh=MLMGWi5cjWSTIwETIFeyETUoUs3RMVxywCoyrYA70gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPuJI5KNCbXGa58tERvHVox0nCuJO+PLThx+7ooxBqV7f3Je3h4N+XU4DOQWHoh98
         bQaUS09hzd11ZuzU0HNmc99OSrHQsSX6m6mEApld6ko34p/rkxFlVDygYfUUmgoqwi
         +/FjvsJ7+qcodApjPr7jdR8QjFDMcdKDXlQ/tzuc=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 5/7] arm64: select ACPI PCI code only when both features are enabled
Date:   Wed, 19 Dec 2018 22:46:57 +0000
Message-Id: <20181219224659.4802-6-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181219224659.4802-1-okaya@kernel.org>
References: <20181219224659.4802-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI and PCI are no longer coupled to each other. Specify requirements
for both when pulling in code.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ea2ab0330e3a..bcb6262044d8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -5,7 +5,7 @@ config ARM64
 	select ACPI_GTDT if ACPI
 	select ACPI_IORT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
-	select ACPI_MCFG if ACPI
+	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_SPCR_TABLE if ACPI
 	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
@@ -163,7 +163,7 @@ config ARM64
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
-	select PCI_ECAM if ACPI
+	select PCI_ECAM if (ACPI && PCI)
 	select POWER_RESET
 	select POWER_SUPPLY
 	select REFCOUNT_FULL
-- 
2.19.0

