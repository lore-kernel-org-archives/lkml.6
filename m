Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF19C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F15F2089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F15F2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbeG0LWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:22:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbeG0LWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:22:51 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B6BC5CBA;
        Fri, 27 Jul 2018 10:01:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jason Andryuk <jandryuk@gmail.com>
Subject: [PATCH 4.14 04/48] xen/PVH: Set up GS segment for stack canary
Date:   Fri, 27 Jul 2018 11:59:49 +0200
Message-Id: <20180727095918.941271116@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

commit 98014068328c5574de9a4a30b604111fd9d8f901 upstream.

We are making calls to C code (e.g. xen_prepare_pvh()) which may use
stack canary (stored in GS segment).

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Cc: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/xen-pvh.S |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -54,6 +54,9 @@
  * charge of setting up it's own stack, GDT and IDT.
  */
 
+#define PVH_GDT_ENTRY_CANARY	4
+#define PVH_CANARY_SEL		(PVH_GDT_ENTRY_CANARY * 8)
+
 ENTRY(pvh_start_xen)
 	cld
 
@@ -98,6 +101,12 @@ ENTRY(pvh_start_xen)
 	/* 64-bit entry point. */
 	.code64
 1:
+	/* Set base address in stack canary descriptor. */
+	mov $MSR_GS_BASE,%ecx
+	mov $_pa(canary), %eax
+	xor %edx, %edx
+	wrmsr
+
 	call xen_prepare_pvh
 
 	/* startup_64 expects boot_params in %rsi. */
@@ -107,6 +116,17 @@ ENTRY(pvh_start_xen)
 
 #else /* CONFIG_X86_64 */
 
+	/* Set base address in stack canary descriptor. */
+	movl $_pa(gdt_start),%eax
+	movl $_pa(canary),%ecx
+	movw %cx, (PVH_GDT_ENTRY_CANARY * 8) + 2(%eax)
+	shrl $16, %ecx
+	movb %cl, (PVH_GDT_ENTRY_CANARY * 8) + 4(%eax)
+	movb %ch, (PVH_GDT_ENTRY_CANARY * 8) + 7(%eax)
+
+	mov $PVH_CANARY_SEL,%eax
+	mov %eax,%gs
+
 	call mk_early_pgtbl_32
 
 	mov $_pa(initial_page_table), %eax
@@ -150,9 +170,13 @@ gdt_start:
 	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
 #endif
 	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* __KERNEL_DS */
+	.quad GDT_ENTRY(0x4090, 0, 0x18)    /* PVH_CANARY_SEL */
 gdt_end:
 
-	.balign 4
+	.balign 16
+canary:
+	.fill 48, 1, 0
+
 early_stack:
 	.fill 256, 1, 0
 early_stack_end:


