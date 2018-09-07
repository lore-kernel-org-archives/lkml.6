Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882ACC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358D720645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358D720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbeIHB6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:58:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42544 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbeIHB6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:58:14 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 209ECFA4;
        Fri,  7 Sep 2018 21:15:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 034/145] powerpc/pkeys: Preallocate execute-only key
Date:   Fri,  7 Sep 2018 23:08:20 +0200
Message-Id: <20180907210907.239984327@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ram Pai <linuxram@us.ibm.com>

commit a4fcc877d4e18b5efe26e93f08f0cfd4e278c7d9 upstream.

execute-only key is allocated dynamically. This is a problem. When a
thread implicitly creates an execute-only key, and resets the UAMOR
for that key, the UAMOR value does not percolate to all the other
threads. Any other thread may ignorantly change the permissions on the
key. This can cause the key to be not execute-only for that thread.

Preallocate the execute-only key and ensure that no thread can change
the permission of the key, by resetting the corresponding bit in
UAMOR.

Fixes: 5586cf61e108 ("powerpc: introduce execute-only pkey")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/pkeys.c |   63 +++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 45 deletions(-)

--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -18,6 +18,7 @@ u32  initial_allocation_mask;	/* Bits se
 u64  pkey_amr_mask;		/* Bits in AMR not to be touched */
 u64  pkey_iamr_mask;		/* Bits in AMR not to be touched */
 u64  pkey_uamor_mask;		/* Bits in UMOR not to be touched */
+int  execute_only_key = 2;
 
 #define AMR_BITS_PER_PKEY 2
 #define AMR_RD_BIT 0x1UL
@@ -120,7 +121,8 @@ int pkey_initialize(void)
 #else
 	os_reserved = 0;
 #endif
-	initial_allocation_mask  = (0x1 << 0) | (0x1 << 1);
+	initial_allocation_mask  = (0x1 << 0) | (0x1 << 1) |
+					(0x1 << execute_only_key);
 
 	/* register mask is in BE format */
 	pkey_amr_mask = ~0x0ul;
@@ -128,9 +130,11 @@ int pkey_initialize(void)
 
 	pkey_iamr_mask = ~0x0ul;
 	pkey_iamr_mask &= ~(0x3ul << pkeyshift(0));
+	pkey_iamr_mask &= ~(0x3ul << pkeyshift(execute_only_key));
 
 	pkey_uamor_mask = ~0x0ul;
 	pkey_uamor_mask &= ~(0x3ul << pkeyshift(0));
+	pkey_uamor_mask &= ~(0x3ul << pkeyshift(execute_only_key));
 
 	/* mark the rest of the keys as reserved and hence unavailable */
 	for (i = (pkeys_total - os_reserved); i < pkeys_total; i++) {
@@ -138,6 +142,17 @@ int pkey_initialize(void)
 		pkey_uamor_mask &= ~(0x3ul << pkeyshift(i));
 	}
 
+	if (unlikely((pkeys_total - os_reserved) <= execute_only_key)) {
+		/*
+		 * Insufficient number of keys to support
+		 * execute only key. Mark it unavailable.
+		 * Any AMR, UAMOR, IAMR bit set for
+		 * this key is irrelevant since this key
+		 * can never be allocated.
+		 */
+		execute_only_key = -1;
+	}
+
 	return 0;
 }
 
@@ -148,8 +163,7 @@ void pkey_mm_init(struct mm_struct *mm)
 	if (static_branch_likely(&pkey_disabled))
 		return;
 	mm_pkey_allocation_map(mm) = initial_allocation_mask;
-	/* -1 means unallocated or invalid */
-	mm->context.execute_only_pkey = -1;
+	mm->context.execute_only_pkey = execute_only_key;
 }
 
 static inline u64 read_amr(void)
@@ -301,48 +315,7 @@ static inline bool pkey_allows_readwrite
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
-	bool need_to_set_mm_pkey = false;
-	int execute_only_pkey = mm->context.execute_only_pkey;
-	int ret;
-
-	/* Do we need to assign a pkey for mm's execute-only maps? */
-	if (execute_only_pkey == -1) {
-		/* Go allocate one to use, which might fail */
-		execute_only_pkey = mm_pkey_alloc(mm);
-		if (execute_only_pkey < 0)
-			return -1;
-		need_to_set_mm_pkey = true;
-	}
-
-	/*
-	 * We do not want to go through the relatively costly dance to set AMR
-	 * if we do not need to. Check it first and assume that if the
-	 * execute-only pkey is readwrite-disabled than we do not have to set it
-	 * ourselves.
-	 */
-	if (!need_to_set_mm_pkey && !pkey_allows_readwrite(execute_only_pkey))
-		return execute_only_pkey;
-
-	/*
-	 * Set up AMR so that it denies access for everything other than
-	 * execution.
-	 */
-	ret = __arch_set_user_pkey_access(current, execute_only_pkey,
-					  PKEY_DISABLE_ACCESS |
-					  PKEY_DISABLE_WRITE);
-	/*
-	 * If the AMR-set operation failed somehow, just return 0 and
-	 * effectively disable execute-only support.
-	 */
-	if (ret) {
-		mm_pkey_free(mm, execute_only_pkey);
-		return -1;
-	}
-
-	/* We got one, store it and use it from here on out */
-	if (need_to_set_mm_pkey)
-		mm->context.execute_only_pkey = execute_only_pkey;
-	return execute_only_pkey;
+	return mm->context.execute_only_pkey;
 }
 
 static inline bool vma_is_pkey_exec_only(struct vm_area_struct *vma)


