Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77D6C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19AC2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpsaTjH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfAGIZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:25:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35081 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfAGIZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:25:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so21486485pfi.2;
        Mon, 07 Jan 2019 00:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FUAdpWzYkaZQ7cKjXSUhDyEM0yF0ukdWVs83m8Rnkfs=;
        b=WpsaTjH0GSOY8pp+G4lzi1PrSguAYfVm/p4qHEWhvgQrawlLo9XS0RVQLsOpMHW0Fl
         lCUCsrYnWoipDa9oq+yVUm95CSEerBiJJq4jgzVAXRdT0bektnONKicSTWteqn+QBTPu
         U6XWhvyCKxU8BuTJNVH+P0jhPvwanx92nAisr/Cn2YR9bNNYB2f9APGEsdFa/Hn+o7Ch
         OHzH8QsB7xvixUrWCgKZoDELPswnIjQwMJRUi3Q0s94X8IzLzu1pGTr6PuuhVUzxw1GX
         DStLOweHTft6kqKBxmN6u/I4oqoNoYIjiCFn9nHpsFBcG22LNEMjq8L9S7aIZL6J61OT
         bipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FUAdpWzYkaZQ7cKjXSUhDyEM0yF0ukdWVs83m8Rnkfs=;
        b=kJBkMxRa0b6P9YhDSJ2MYoRNzbg8oBzGBWgc/xwMvIuWxafveGYFAwVx5wwBZ/gdxs
         oaYBJlWQfMknnIC5i40FWUaxpmQ1QY7WydLzA/1euCmyTe/0VnazTxVa0JPI9VibjYZ3
         Te7dCg9enZgajaBYPBDtO63bgnhUkkAKUblXND0yFglpB3qyLTmA+YBjiXpykWL49/g0
         v3Oqa+D9k+i8jCe5dcD8fZDoPSUAlS8H9cCR+A9sBe70KhaYmfso3Nqt3+3R7qUCs9MK
         fJyEBxMNRtOlsaiz2qSV+zjXA0L2v0knV/pfN60Gq/rrn90J/ZaKMBLiTLRO/nPTS/+9
         KDCA==
X-Gm-Message-State: AJcUukfWiarp3SU7T5uhb0ZKOiKLImZslRiuEOpZiTgtoZCMBlRSwKFa
        WKUIzNgD0qze59ik1lz6VA==
X-Google-Smtp-Source: ALg8bN6ydsRLMGZA8iCiLYC01Q+lz7amk48EVGJ/JKimsC8ZgjKhelCUdCFMAXi85C/XZRi0pHvgQw==
X-Received: by 2002:a63:2507:: with SMTP id l7mr27885751pgl.22.1546849502829;
        Mon, 07 Jan 2019 00:25:02 -0800 (PST)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t3sm76981674pgv.31.2019.01.07.00.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 00:25:02 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org, linux-acpi@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] acpi: change the topo of acpi_table_upgrade()
Date:   Mon,  7 Jan 2019 16:24:42 +0800
Message-Id: <1546849485-27933-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current acpi_table_upgrade() relies on initrd_start, but this var is
only valid after relocate_initrd(). There is requirement to extract the
acpi info from initrd before memblock-allocator can work(see [2/4]), hence
acpi_table_upgrade() need to accept the input param directly.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/kernel/setup.c | 2 +-
 arch/x86/kernel/setup.c   | 2 +-
 drivers/acpi/tables.c     | 4 +---
 include/linux/acpi.h      | 4 ++--
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4b0e123..48cb98c 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -315,7 +315,7 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 	efi_apply_persistent_mem_reservations();
 
-	acpi_table_upgrade();
+	acpi_table_upgrade((void *)initrd_start, initrd_end - initrd_start);
 
 	/* Parse the ACPI tables for possible boot-time configuration */
 	acpi_boot_table_init();
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a5..acbcd62 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1175,8 +1175,8 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_initrd();
 
-	acpi_table_upgrade();
 
+	acpi_table_upgrade((void *)initrd_start, initrd_end - initrd_start);
 	vsmp_init();
 
 	io_delay_init();
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 48eabb6..d29b05c 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -471,10 +471,8 @@ static DECLARE_BITMAP(acpi_initrd_installed, NR_ACPI_INITRD_TABLES);
 
 #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
 
-void __init acpi_table_upgrade(void)
+void __init acpi_table_upgrade(void *data, size_t size)
 {
-	void *data = (void *)initrd_start;
-	size_t size = initrd_end - initrd_start;
 	int sig, no, table_nr = 0, total_offset = 0;
 	long offset = 0;
 	struct acpi_table_header *table;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 87715f2..44dcbba 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1272,9 +1272,9 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *fwnode,
 #endif
 
 #ifdef CONFIG_ACPI_TABLE_UPGRADE
-void acpi_table_upgrade(void);
+void acpi_table_upgrade(void *data, size_t size);
 #else
-static inline void acpi_table_upgrade(void) { }
+static inline void acpi_table_upgrade(void *data, size_t size) { }
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_ACPI_WATCHDOG)
-- 
2.7.4

