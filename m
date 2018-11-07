Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3454AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0285520827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0285520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeKHCcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:32:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:41874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727699AbeKHCcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:32:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B2DEB6C6;
        Wed,  7 Nov 2018 17:01:02 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v2] x86/xen: fix pv boot
Date:   Wed,  7 Nov 2018 18:01:00 +0100
Message-Id: <20181107170100.9435-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9da3f2b7405440 ("x86/fault: BUG() when uaccess helpers fault on
kernel addresses") introduced a regression for booting Xen PV guests.

Xen PV guests are using __put_user() and __get_user() for accessing the
p2m map (physical to machine frame number map) as accesses might fail
in case of not populated areas of the map.

With above commit using __put_user() and __get_user() for accessing
kernel pages is no longer valid. So replace the Xen hack by adding
appropriate p2m access functions using the default fixup handler.

Fixes: 9da3f2b7405440 ("x86/fault: BUG() when uaccess helpers fault on kernel addresses")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/xen/page.h | 35 +++++++++++++++++++++++++++++++----
 arch/x86/xen/p2m.c              |  3 +--
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
index 123e669bf363..790ce08e41f2 100644
--- a/arch/x86/include/asm/xen/page.h
+++ b/arch/x86/include/asm/xen/page.h
@@ -9,7 +9,7 @@
 #include <linux/mm.h>
 #include <linux/device.h>
 
-#include <linux/uaccess.h>
+#include <asm/extable.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
@@ -93,12 +93,39 @@ clear_foreign_p2m_mapping(struct gnttab_unmap_grant_ref *unmap_ops,
  */
 static inline int xen_safe_write_ulong(unsigned long *addr, unsigned long val)
 {
-	return __put_user(val, (unsigned long __user *)addr);
+	int ret = 0;
+
+	asm volatile("1: mov %[val], %[ptr]\n"
+		     "2:\n"
+		     ".section .fixup, \"ax\"\n"
+		     "3: sub $1, %[ret]\n"
+		     "   jmp 2b\n"
+		     ".previous\n"
+		     _ASM_EXTABLE(1b, 3b)
+		     : [ret] "+r" (ret), [ptr] "=m" (*addr)
+		     : [val] "r" (val));
+
+	return ret;
 }
 
-static inline int xen_safe_read_ulong(unsigned long *addr, unsigned long *val)
+static inline int xen_safe_read_ulong(const unsigned long *addr,
+				      unsigned long *val)
 {
-	return __get_user(*val, (unsigned long __user *)addr);
+	int ret = 0;
+	unsigned long rval = ~0ul;
+
+	asm volatile("1: mov %[ptr], %[rval]\n"
+		     "2:\n"
+		     ".section .fixup, \"ax\"\n"
+		     "3: sub $1, %[ret]\n"
+		     "   jmp 2b\n"
+		     ".previous\n"
+		     _ASM_EXTABLE(1b, 3b)
+		     : [ret] "+r" (ret), [rval] "+r" (rval)
+		     : [ptr] "m" (*addr));
+	*val = rval;
+
+	return ret;
 }
 
 #ifdef CONFIG_XEN_PV
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index b06731705529..055e37e43541 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -656,8 +656,7 @@ bool __set_phys_to_machine(unsigned long pfn, unsigned long mfn)
 
 	/*
 	 * The interface requires atomic updates on p2m elements.
-	 * xen_safe_write_ulong() is using __put_user which does an atomic
-	 * store via asm().
+	 * xen_safe_write_ulong() is using an atomic store via asm().
 	 */
 	if (likely(!xen_safe_write_ulong(xen_p2m_addr + pfn, mfn)))
 		return true;
-- 
2.16.4

