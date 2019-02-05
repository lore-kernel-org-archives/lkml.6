Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3A4C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C60207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JXPzxx4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbfBENKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:10:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56198 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfBENKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:10:47 -0500
Received: from zn.tnic (p200300EC2BCB6B00213B35D40B3412ED.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:213b:35d4:b34:12ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A92C1EC0943;
        Tue,  5 Feb 2019 14:10:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549372245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=aLa1xfvpX+JnYPyj/319nZuts2+WwOb5m9TmDojNGEA=;
        b=JXPzxx4Ulb2zzU2N2vWEEKWf46insgQBniDhQVBzTjVA6FUzKbbB7uiEBR2EarkOisnUe4
        6icLJmJeaeQR8vaWBtiVW6nJP1U+ozdxzAh8eN6FxiVgeedT16blRwY9geMSdP0amLarV0
        7WnFBHnXXv53E41M3Rbs6DUV/ibJHTQ=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/boot: Fix randconfig build error due to MEMORY_HOTREMOVE
Date:   Tue,  5 Feb 2019 14:10:33 +0100
Message-Id: <20190205131033.9564-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

When building randconfigs, one of the failures is:

  ld: arch/x86/boot/compressed/kaslr.o: in function `choose_random_location':
  kaslr.c:(.text+0xbf7): undefined reference to `count_immovable_mem_regions'
  ld: kaslr.c:(.text+0xcbe): undefined reference to `immovable_mem'
  make[2]: *** [arch/x86/boot/compressed/vmlinux] Error 1

because CONFIG_ACPI is not enabled in this particular .config but
CONFIG_MEMORY_HOTREMOVE is and count_immovable_mem_regions() is
unresolvable because it is defined in compressed/acpi.c which is the
compilation unit that depends on CONFIG_ACPI.

Add CONFIG_ACPI to the explicit dependencies for MEMORY_HOTREMOVE.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 arch/x86/boot/compressed/misc.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index a2039afe14a7..fa0332dda9f2 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -670,7 +670,7 @@ static bool process_mem_region(struct mem_vector *region,
 		return 0;
 	}
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
+#if defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
 	/*
 	 * If immovable memory found, filter the intersection between
 	 * immovable memory and @region.
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 5b8d51996cdd..fd13655e0f9b 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -129,7 +129,7 @@ acpi_physical_address get_rsdp_addr(void);
 static inline acpi_physical_address get_rsdp_addr(void) { return 0; }
 #endif
 
-#if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE)
+#if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
 extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
 int count_immovable_mem_regions(void);
 #else
-- 
2.19.1

