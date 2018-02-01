Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3617261-1517488844-2-8691492486265954517
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517488843; b=HeGh0+TivY0DkWgZoGkDqHQsHSC6KvqqqtnsOfPh1dYvGq0
    QTiRj0fKEmod4lr6D88W8sMvr+KgSBukUXS4aETcxnS+IuQNXyhTuc7qtU6A7XnU
    Ho+VSvmaM7ZpWXGFC1UqGKuAZ6sZj55MHENj0qjB7V+ZGzpEQDSfpDrQXtRDKQnL
    wsBdjdKkUCZI0LimHqIaPJ4u0ymYy87/tqlC7IKs5Y0LZqGYVczwDdpc+UvIhgO1
    qXa8xU4uJqLSUQggaZPRdflYGHErQEKGWHXgMK0xdAB1eXI7OTWWKaI1jlDoYnwr
    PADbp2pdzdSdtR7KW1I6v7mLAr7AcSpIAGIEnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517488843; bh=HUJFbB2uQYZ7Nus1r1m2ud5hqr
    kGK5JBhjIdQBpu+vI=; b=VfZJwpCFOG1x8+tzT2dMM+e3duitRM6QohJ5Y5BuWW
    obhmA8OS7V5p4KvNMKpNVd2+ffx3cOBjTqbQU55vxvIRjY1v1HX/IlsNStXzC92f
    S6HbVV0YExcw894tK+WRmj6+JVC8j8SUYhpMHph8yA4id+kBOyoKFOsZb7ynCpwh
    PGwFiXiFMaxVUhd2Xzi9Yz3jvpp9BuL6MaXZEstCtdrQDiDt/PcRspk7vXQCljJz
    eJ7uU7oogR0vrZQ8CvY2aQgsApTM1u6y2rx0qA2vrl5lRP22tJTzw7w9hY2Ale5m
    jQIe2kWUq7IDEmUMGp7g7aizI5zA+ZINO5BnU5sQrXLQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeBAMk0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 07:40:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:35954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752516AbeBAMkW (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Feb 2018 07:40:22 -0500
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] x86/xen: init %gs very early to avoid page faults with stack protector
Date: Thu,  1 Feb 2018 13:40:19 +0100
Message-Id: <20180201124019.11693-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When running as Xen pv guest %gs is initialized some time after
C code is started. Depending on stack protector usage this might be
too late, resulting in page faults.

So setup %gs and MSR_GS_BASE in assembly code already.

Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/xen-head.S | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 497cc55a0c16..96f26e026783 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -9,7 +9,9 @@
 
 #include <asm/boot.h>
 #include <asm/asm.h>
+#include <asm/msr.h>
 #include <asm/page_types.h>
+#include <asm/percpu.h>
 #include <asm/unwind_hints.h>
 
 #include <xen/interface/elfnote.h>
@@ -35,6 +37,20 @@ ENTRY(startup_xen)
 	mov %_ASM_SI, xen_start_info
 	mov $init_thread_union+THREAD_SIZE, %_ASM_SP
 
+#ifdef CONFIG_X86_64
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
+#endif
+
 	jmp xen_start_kernel
 END(startup_xen)
 	__FINIT
-- 
2.13.6
