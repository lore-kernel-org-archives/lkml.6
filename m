Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADE0C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A84223C4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A84223C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933329AbeFUVSG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:18:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:27241 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754264AbeFUVSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:18:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 14:18:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="48912124"
Received: from hanvin-mobl2.amr.corp.intel.com ([10.254.42.214])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2018 14:18:02 -0700
From:   "H. Peter Anvin, Intel" <h.peter.anvin@intel.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "H. Peter Anvin" <hpa@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        "Markus T . Metzger" <markus.t.metzger@intel.com>
Subject: [PATCH v3 4/7] x86/tls: create an explicit config symbol for the TLS area in the GDT
Date:   Thu, 21 Jun 2018 14:17:51 -0700
Message-Id: <20180621211754.12757-5-h.peter.anvin@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180621211754.12757-1-h.peter.anvin@intel.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@linux.intel.com>

Instead of using X86_32 || IA32_EMULATION, which is really rather ugly
in the Makefile especially, create a dedicated config symbol for the
TLS area.  This will be further used in subsequent patches.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Markus T. Metzger <markus.t.metzger@intel.com>
---
 arch/x86/Kconfig         | 4 ++++
 arch/x86/kernel/Makefile | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1dbb4ee19d7..e48036e3f158 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2937,6 +2937,10 @@ config X86_DMA_REMAP
 config HAVE_GENERIC_GUP
 	def_bool y
 
+config X86_TLS_AREA
+       def_bool y
+       depends on IA32_EMULATION || X86_32
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 02d6f5cf4e70..d26ef8a40a88 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -65,8 +65,7 @@ obj-y			+= resource.o
 obj-y				+= process.o
 obj-y				+= fpu/
 obj-y				+= ptrace.o
-obj-$(CONFIG_X86_32)		+= tls.o
-obj-$(CONFIG_IA32_EMULATION)	+= tls.o
+obj-$(CONFIG_X86_TLS_AREA)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
-- 
2.14.4

