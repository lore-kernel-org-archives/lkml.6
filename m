Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6hYkDyFEGVtrEAAAmS7hNA
	; Thu, 07 Jun 2018 14:41:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9212F608CA; Thu,  7 Jun 2018 14:41:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EAA57601C3;
	Thu,  7 Jun 2018 14:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAA57601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934599AbeFGOlc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:41:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40590 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932931AbeFGOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:41:28 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbj-0005a0-5W; Thu, 07 Jun 2018 15:09:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002yz-JY; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Juergen Gross" <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Chris Patterson" <cjp256@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.786314262@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 194/410] x86/xen: init %gs very early to avoid page
 faults with stack protector
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 4f277295e54c5b7340e48efea3fc5cc21a2872b7 upstream.

When running as Xen pv guest %gs is initialized some time after
C code is started. Depending on stack protector usage this might be
too late, resulting in page faults.

So setup %gs and MSR_GS_BASE in assembly code already.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Tested-by: Chris Patterson <cjp256@gmail.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -8,7 +8,9 @@
 
 #include <asm/boot.h>
 #include <asm/asm.h>
+#include <asm/msr.h>
 #include <asm/page_types.h>
+#include <asm/percpu.h>
 
 #include <xen/interface/elfnote.h>
 #include <xen/interface/features.h>
@@ -42,7 +44,20 @@ ENTRY(startup_xen)
 #else
 	mov %rsi,xen_start_info
 	mov $init_thread_union+THREAD_SIZE,%rsp
+
+	/* Set up %gs.
+	 *
+	 * The base of %gs always points to the bottom of the irqstack
+	 * union.  If the stack protector canary is enabled, it is
+	 * located at %gs:40.  Note that, on SMP, the boot cpu uses
+	 * init data section till per cpu areas are set up.
+	 */
+	movl	$MSR_GS_BASE,%ecx
+	movq	$INIT_PER_CPU_VAR(irq_stack_union),%rax
+	cdq
+	wrmsr
 #endif
+
 	jmp xen_start_kernel
 
 	__FINIT
