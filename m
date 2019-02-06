Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FBFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D42217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfBFK4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:56:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44625 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFK4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:56:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x16AuKgF1258084
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Feb 2019 02:56:20 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x16AuJYi1258077;
        Wed, 6 Feb 2019 02:56:19 -0800
Date:   Wed, 6 Feb 2019 02:56:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-82df8261c6a9523511d83ac367c7d64375ebabf4@git.kernel.org>
Cc:     tglx@linutronix.de, bp@suse.de, fanc.fnst@cn.fujitsu.com,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, bp@suse.de, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, fanc.fnst@cn.fujitsu.com
In-Reply-To: <20190205131033.9564-1-bp@alien8.de>
References: <20190205131033.9564-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Fix randconfig build error due to
 MEMORY_HOTREMOVE
Git-Commit-ID: 82df8261c6a9523511d83ac367c7d64375ebabf4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  82df8261c6a9523511d83ac367c7d64375ebabf4
Gitweb:     https://git.kernel.org/tip/82df8261c6a9523511d83ac367c7d64375ebabf4
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 5 Feb 2019 14:04:01 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 6 Feb 2019 11:48:42 +0100

x86/boot: Fix randconfig build error due to MEMORY_HOTREMOVE

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
Link: https://lkml.kernel.org/r/20190205131033.9564-1-bp@alien8.de
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
