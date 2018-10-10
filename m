Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C9DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B582064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B582064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeJJUla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:41:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42671 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJUla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:41:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9ADIqqC1485272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Oct 2018 06:18:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9ADIoGj1485269;
        Wed, 10 Oct 2018 06:18:50 -0700
Date:   Wed, 10 Oct 2018 06:18:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c200dac78fec66d87ef262cac38cfe4feabdf737@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, keescook@chromium.org,
        bp@suse.de, pmenzel@molgen.mpg.de, bhelgaas@google.com
Reply-To: bhelgaas@google.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          joro@8bytes.org, keescook@chromium.org, bp@suse.de,
          pmenzel@molgen.mpg.de, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <alpine.DEB.2.21.1810082151160.2455@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1810082151160.2455@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Do not warn about PCI BIOS W+X mappings
Git-Commit-ID: c200dac78fec66d87ef262cac38cfe4feabdf737
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

Commit-ID:  c200dac78fec66d87ef262cac38cfe4feabdf737
Gitweb:     https://git.kernel.org/tip/c200dac78fec66d87ef262cac38cfe4feabdf737
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 8 Oct 2018 21:53:48 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 10 Oct 2018 15:16:13 +0200

x86/mm: Do not warn about PCI BIOS W+X mappings

PCI BIOS requires the BIOS area 0x0A0000-0x0FFFFFF to be mapped W+X for
various legacy reasons. When CONFIG_DEBUG_WX is enabled, this triggers the
WX warning, but this is misleading because the mapping is required and is
not a result of an accidental oversight.

Prevent the full warning when PCI BIOS is enabled and the detected WX
mapping is in the BIOS area. Just emit a pr_warn() which denotes the
fact. This is partially duplicating the info which the PCI BIOS code emits
when it maps the area as executable, but that info is not in the context of
the WX checking output.

Remove the extra %p printout in the WARN_ONCE() while at it. %pS is enough.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Borislav Petkov <bp@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1810082151160.2455@nanos.tec.linutronix.de

---
 arch/x86/mm/dump_pagetables.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index a12afff146d1..fc37bbd23eb8 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -19,7 +19,9 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/highmem.h>
+#include <linux/pci.h>
 
+#include <asm/e820/types.h>
 #include <asm/pgtable.h>
 
 /*
@@ -241,6 +243,29 @@ static unsigned long normalize_addr(unsigned long u)
 	return (signed long)(u << shift) >> shift;
 }
 
+static void note_wx(struct pg_state *st)
+{
+	unsigned long npages;
+
+	npages = (st->current_address - st->start_address) / PAGE_SIZE;
+
+#ifdef CONFIG_PCI_BIOS
+	/*
+	 * If PCI BIOS is enabled, the PCI BIOS area is forced to WX.
+	 * Inform about it, but avoid the warning.
+	 */
+	if (pcibios_enabled && st->start_address >= PAGE_OFFSET + BIOS_BEGIN &&
+	    st->current_address <= PAGE_OFFSET + BIOS_END) {
+		pr_warn_once("x86/mm: PCI BIOS W+X mapping %lu pages\n", npages);
+		return;
+	}
+#endif
+	/* Account the WX pages */
+	st->wx_pages += npages;
+	WARN_ONCE(1, "x86/mm: Found insecure W+X mapping at address %pS\n",
+		  (void *)st->start_address);
+}
+
 /*
  * This function gets called on a break in a continuous series
  * of PTE entries; the next one is different so we need to
@@ -276,14 +301,8 @@ static void note_page(struct seq_file *m, struct pg_state *st,
 		unsigned long delta;
 		int width = sizeof(unsigned long) * 2;
 
-		if (st->check_wx && (eff & _PAGE_RW) && !(eff & _PAGE_NX)) {
-			WARN_ONCE(1,
-				  "x86/mm: Found insecure W+X mapping at address %p/%pS\n",
-				  (void *)st->start_address,
-				  (void *)st->start_address);
-			st->wx_pages += (st->current_address -
-					 st->start_address) / PAGE_SIZE;
-		}
+		if (st->check_wx && (eff & _PAGE_RW) && !(eff & _PAGE_NX))
+			note_wx(st);
 
 		/*
 		 * Now print the actual finished series
