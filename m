Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D07AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E942098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GlxvtY58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E942098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbeGJV0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:26:50 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35465 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732376AbeGJV0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:26:49 -0400
Received: by mail-qt0-f193.google.com with SMTP id a5-v6so5153084qtp.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GIp3IHbYLo8LmNf5T5MLKeHYxeGzpryFNE9LP9lNWt4=;
        b=GlxvtY58JXaHmvBmk3uCe5+FXACBhURbZ35QXktFgi6sbM5Jcbes4fsy1Y7VVZ+5i/
         zRyq00cd9/JmhRAgugpeVz2izqAAoLfDGdzaCGD7r5rFJYDjgULM9jdYECIv/S+6PF1t
         f3CeJ0pwu2fYmPTGqZ4xbhYA5ijC2a0gGeuTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GIp3IHbYLo8LmNf5T5MLKeHYxeGzpryFNE9LP9lNWt4=;
        b=CLPLO5Pzua2/yT2QidfntiyQaBER039j3Cfgm/e7gKpfbhEmJgkSHx2Qq2J0qJnpg3
         ihFn6+S1qabDp7BM4uMMX5lHZgpwExGrurvtlyo2pdCWJteofXK5dfrSqLnKcgful+Vm
         gpXJ66OGsejUT0yQHU9QB+F9wzdGnREVkNg3kxbAerLmgCPp4WIfziwvGYMhyJNcxuJa
         GQsGJddJyhSSC6iwFRQcfkIE378BR6gbslOWrcaILOBhdLAMlNoBjFjD2pK3GRGf45WD
         1PQqseG7Noo/uukvJEjLdd1VwXEAyX4d8H2ZqFh89VSSXKj31kqGJ83piLkJCEoPuKmm
         L98A==
X-Gm-Message-State: APt69E3Osx67STZXzbjcycK3RYBuvmvNtdUwjsOiNSdj6pG74x/OB8hw
        E89nb7tf9dMMDSYbUELTvkRI4A==
X-Google-Smtp-Source: AAOMgpcB4b14tsCV17Ck6fdm3XuZ4TIK8LTm54SFOJt5qHOw4jGfk0hDuB46fQam3VrcYrLPGgjIBg==
X-Received: by 2002:a0c:f3d1:: with SMTP id f17-v6mr23228149qvm.66.1531257951979;
        Tue, 10 Jul 2018 14:25:51 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b21-v6sm6638912qtp.26.2018.07.10.14.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 14:25:50 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: [PATCH 2/2] arm64: dts: stingray: add bcm958802a802x dts
Date:   Tue, 10 Jul 2018 14:25:31 -0700
Message-Id: <1531257931-11591-3-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1531257931-11591-1-git-send-email-ray.jui@broadcom.com>
References: <1531257931-11591-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>

Add bcm958802a802x dts to be used on all Stingray smart NIC PS225 board
variants

Signed-off-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/Makefile     |  2 ++
 .../boot/dts/broadcom/stingray/bcm958802a802x.dts  | 26 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts

diff --git a/arch/arm64/boot/dts/broadcom/stingray/Makefile b/arch/arm64/boot/dts/broadcom/stingray/Makefile
index c4d06cf..20c7d0a 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/Makefile
+++ b/arch/arm64/boot/dts/broadcom/stingray/Makefile
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958742k.dtb
 dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958742t.dtb
+
+dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958802a802x.dtb
diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts
new file mode 100644
index 0000000..a41facd
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+/*
+ *Copyright(c) 2018 Broadcom
+ */
+
+/dts-v1/;
+
+#include "stingray-board-base.dtsi"
+
+/ {
+	compatible = "brcm,bcm958802a802x", "brcm,stingray";
+	model = "Stingray PS225xx (BCM958802A802x)";
+};
+
+&enet {
+	status = "disabled";
+};
+
+&sdio0 {
+	no-1-8-v;
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.1.4

