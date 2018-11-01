Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48959C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24912081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24912081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeKASjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:39:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57148 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeKASjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:39:18 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gI9PH-0001aj-OX; Thu, 01 Nov 2018 10:36:51 +0100
Date:   Thu, 1 Nov 2018 10:36:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        mm-commits@vger.kernel.org,
        Ravikiran Thirumalai <kiran@scalemp.com>,
        Shai Fultheim <shai@scalemp.com>, X86 ML <x86@kernel.org>
Subject: [PATCH] x86/build: Build VSMP support only if selected
In-Reply-To: <9e14d183-55a4-8299-7a18-0404e50bf004@infradead.org>
Message-ID: <alpine.DEB.2.21.1811011032190.1642@nanos.tec.linutronix.de>
References: <20181030230905.xHZmM%akpm@linux-foundation.org> <9e14d183-55a4-8299-7a18-0404e50bf004@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VSMP support is built even if CONFIG_X86_VSMP is not set. This leads to a build
breakage when CONFIG_PCI is disabled as well.

Build VSMP code only when selected.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ae13bc974416..b6b911c4c7f3 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -33,7 +33,7 @@
 extern u64 relocated_ramdisk;
 
 /* Interrupt control for vSMPowered x86_64 systems */
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && defined(CONFIG_X86_VSMP)
 void vsmp_init(void);
 #else
 static inline void vsmp_init(void) { }
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8824d01c0c35..647ce52b17d5 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -148,5 +148,5 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_CALGARY_IOMMU)	+= pci-calgary_64.o tce_64.o
 
 	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
-	obj-y				+= vsmp_64.o
+	obj-$(CONFIG_X86_VSMP)		+= vsmp_64.o
 endif
