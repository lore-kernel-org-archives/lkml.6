Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4E2D1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F383208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F383208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935207AbeFMJ6M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:58:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:54638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934279AbeFMJ6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:58:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A3C63AC1E;
        Wed, 13 Jun 2018 09:58:09 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen: don't use privcmd_call() from xen_mc_flush()
Date:   Wed, 13 Jun 2018 11:58:06 +0200
Message-Id: <20180613095806.2978-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using privcmd_call() for a singleton multicall seems to be wrong, as
privcmd_call() is using stac()/clac() to enable hypervisor access to
Linux user space.

Add a new xen_single_call() function to be use for that purpose.

Reported-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/xen/hypercall.h | 25 +++++++++++++++++++------
 arch/x86/xen/multicalls.c            |  6 +++---
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index bfd882617613..6b2f90a0b149 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -209,24 +209,37 @@ extern struct { char _entry[32]; } hypercall_page[];
 })
 
 static inline long
-privcmd_call(unsigned call,
-	     unsigned long a1, unsigned long a2,
-	     unsigned long a3, unsigned long a4,
-	     unsigned long a5)
+xen_single_call(unsigned int call,
+		unsigned long a1, unsigned long a2,
+		unsigned long a3, unsigned long a4,
+		unsigned long a5)
 {
 	__HYPERCALL_DECLS;
 	__HYPERCALL_5ARG(a1, a2, a3, a4, a5);
 
-	stac();
 	asm volatile(CALL_NOSPEC
 		     : __HYPERCALL_5PARAM
 		     : [thunk_target] "a" (&hypercall_page[call])
 		     : __HYPERCALL_CLOBBER5);
-	clac();
 
 	return (long)__res;
 }
 
+static inline long
+privcmd_call(unsigned int call,
+	     unsigned long a1, unsigned long a2,
+	     unsigned long a3, unsigned long a4,
+	     unsigned long a5)
+{
+	long res;
+
+	stac();
+	res = xen_single_call(call, a1, a2, a3, a4, a5);
+	clac();
+
+	return res;
+}
+
 static inline int
 HYPERVISOR_set_trap_table(struct trap_info *table)
 {
diff --git a/arch/x86/xen/multicalls.c b/arch/x86/xen/multicalls.c
index dc502ca8263e..2bce7958ce8b 100644
--- a/arch/x86/xen/multicalls.c
+++ b/arch/x86/xen/multicalls.c
@@ -80,9 +80,9 @@ void xen_mc_flush(void)
 		   and just do the call directly. */
 		mc = &b->entries[0];
 
-		mc->result = privcmd_call(mc->op,
-					  mc->args[0], mc->args[1], mc->args[2], 
-					  mc->args[3], mc->args[4]);
+		mc->result = xen_single_call(mc->op, mc->args[0], mc->args[1],
+					     mc->args[2], mc->args[3],
+					     mc->args[4]);
 		ret = mc->result < 0;
 		break;
 
-- 
2.13.7

