Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E20C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA0B21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA0B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJIDHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:07:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41926 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJIDHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:07:15 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g9bbB-0007lS-4s; Mon, 08 Oct 2018 21:53:49 +0200
Date:   Mon, 8 Oct 2018 21:53:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     x86@kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <joro@8bytes.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] x86/mm: Do not warn about PCI BIOS W+X mappings
Message-ID: <alpine.DEB.2.21.1810082151160.2455@nanos.tec.linutronix.de>
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

PCI BIOS requires the BIOS area 0x0A0000-0x0FFFFFF to be mapped W+X for
various legacy reasons. When CONFIG_DEBUG_WX is enabled, this triggers the
WX warning, but this is misleading because the mapping is required and is
not a result of an accidental oversight.

Prevent the full warning when PCI BIOS is enabled and the detected WX
mapping is in the BIOS area. Just emit a pr_warn() which denotes the
fact. This is partially duplicating the info which the PCI BIOS code emits
when it maps the area as executable, but that info is not in the context of
the WX checking output.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/mm/dump_pagetables.c |   35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

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
@@ -241,6 +243,29 @@ static unsigned long normalize_addr(unsi
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
+	WARN_ONCE(1, "x86/mm: Found insecure W+X mapping at address %p/%pS\n",
+		  (void *)st->start_address, (void *)st->start_address);
+}
+
 /*
  * This function gets called on a break in a continuous series
  * of PTE entries; the next one is different so we need to
@@ -276,14 +301,8 @@ static void note_page(struct seq_file *m
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
