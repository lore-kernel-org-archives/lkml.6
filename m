Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4461CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14703206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14703206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632977AbeKXDJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:09:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:37684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387726AbeKXDJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:09:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 559CDAE06;
        Fri, 23 Nov 2018 16:24:55 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen/x86: add diagnostic printout to xen_mc_flush() in case of error
Date:   Fri, 23 Nov 2018 17:24:51 +0100
Message-Id: <20181123162451.3351-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failure of an element of a Xen multicall is signalled via a WARN()
only unless the kernel is compiled with MC_DEBUG. It is impossible to
know which element failed and why it did so.

Change that by printing the related information even without MC_DEBUG,
even if maybe in some limited form (e.g. without information which
caller produced the failing element).

Move the printing out of the switch statement in order to have the
same information for a single call.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/multicalls.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/x86/xen/multicalls.c b/arch/x86/xen/multicalls.c
index 2bce7958ce8b..0766a08bdf45 100644
--- a/arch/x86/xen/multicalls.c
+++ b/arch/x86/xen/multicalls.c
@@ -69,6 +69,11 @@ void xen_mc_flush(void)
 
 	trace_xen_mc_flush(b->mcidx, b->argidx, b->cbidx);
 
+#if MC_DEBUG
+	memcpy(b->debug, b->entries,
+	       b->mcidx * sizeof(struct multicall_entry));
+#endif
+
 	switch (b->mcidx) {
 	case 0:
 		/* no-op */
@@ -87,32 +92,34 @@ void xen_mc_flush(void)
 		break;
 
 	default:
-#if MC_DEBUG
-		memcpy(b->debug, b->entries,
-		       b->mcidx * sizeof(struct multicall_entry));
-#endif
-
 		if (HYPERVISOR_multicall(b->entries, b->mcidx) != 0)
 			BUG();
 		for (i = 0; i < b->mcidx; i++)
 			if (b->entries[i].result < 0)
 				ret++;
+	}
 
+	if (WARN_ON(ret)) {
+		pr_err("%d of %d multicall(s) failed: cpu %d\n",
+		       ret, b->mcidx, smp_processor_id());
+		for (i = 0; i < b->mcidx; i++) {
+			if (b->entries[i].result < 0) {
 #if MC_DEBUG
-		if (ret) {
-			printk(KERN_ERR "%d multicall(s) failed: cpu %d\n",
-			       ret, smp_processor_id());
-			dump_stack();
-			for (i = 0; i < b->mcidx; i++) {
-				printk(KERN_DEBUG "  call %2d/%d: op=%lu arg=[%lx] result=%ld\t%pF\n",
-				       i+1, b->mcidx,
+				pr_err("  call %2d: op=%lu arg=[%lx] result=%ld\t%pF\n",
+				       i + 1,
 				       b->debug[i].op,
 				       b->debug[i].args[0],
 				       b->entries[i].result,
 				       b->caller[i]);
+#else
+				pr_err("  call %2d: op=%lu arg=[%lx] result=%ld\n",
+				       i + 1,
+				       b->entries[i].op,
+				       b->entries[i].args[0],
+				       b->entries[i].result);
+#endif
 			}
 		}
-#endif
 	}
 
 	b->mcidx = 0;
@@ -126,8 +133,6 @@ void xen_mc_flush(void)
 	b->cbidx = 0;
 
 	local_irq_restore(flags);
-
-	WARN_ON(ret);
 }
 
 struct multicall_space __xen_mc_entry(size_t args)
-- 
2.16.4

