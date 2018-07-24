Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDADC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D399D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D399D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=isi.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbeGXO46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:56:58 -0400
Received: from mail-c.ads.isi.edu ([128.9.180.198]:41855 "EHLO
        mail-c.ads.isi.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388315AbeGXO46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:56:58 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jul 2018 10:56:58 EDT
X-IronPort-AV: E=Sophos;i="5.51,398,1526367600"; 
   d="scan'208";a="6610587"
Received: from guest228.east.isi.edu (HELO localhost) ([65.123.202.228])
  by mail-c.ads.isi.edu with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 06:47:17 -0700
From:   Alexei Colin <acolin@isi.edu>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Alex Bounine <alex.bou9@gmail.com>,
        Barry Wood <barry.wood@idt.com>,
        John Paul Walters <jwalters@isi.edu>,
        Alexei Colin <acolin@isi.edu>
Subject: [PATCH] arm64: enable RapidIO config options in Kconfig
Date:   Tue, 24 Jul 2018 09:45:14 -0400
Message-Id: <20180724134513.86796-1-acolin@isi.edu>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 SoCs with a PCI bus present the RapiodIO options; SoCs with
RapidIO IP blocks but without a PCI bus, need to select HAS_RAPIDIO in
Kconfig.platforms.

HAS_RAPIDIO was chosen over HAVE_RAPIDIO to be consistent with
other architectures which already define this flag (powerpc).

Signed-off-by: Alexei Colin <acolin@isi.edu>
---

Tested that kernel builds with RapidIO subsystem and switch drivers and that
modules insert successfully in a custom Qemu hardware model.
Maintainers for RapidIO subsystem CCed.
Similar patch for ARM has been submitted.

 arch/arm64/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..8dceaa5b674c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -293,6 +293,22 @@ config PCI_SYSCALL
 
 source "drivers/pci/Kconfig"
 
+config HAS_RAPIDIO
+	bool
+	default n
+
+config RAPIDIO
+	tristate "RapidIO support"
+	depends on HAS_RAPIDIO || PCI
+	help
+	  This feature enables support for RapidIO high-performance
+	  packet-switched interconnect.
+
+	  If you say Y here, the kernel will include drivers and
+	  infrastructure code to support RapidIO interconnect devices.
+
+source "drivers/rapidio/Kconfig"
+
 endmenu
 
 menu "Kernel Features"
-- 
2.18.0

