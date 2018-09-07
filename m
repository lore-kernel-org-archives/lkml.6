Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89CAC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6C020645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6C020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeIHB6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:58:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeIHB6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:58:30 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C2F07FA4;
        Fri,  7 Sep 2018 21:15:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 029/145] powerpc/pkeys: Give all threads control of their key permissions
Date:   Fri,  7 Sep 2018 23:08:15 +0200
Message-Id: <20180907210906.304614575@linuxfoundation.org>
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

commit a57a04c76e06822e4377831611364c846b7202ca upstream.

Currently in a multithreaded application, a key allocated by one
thread is not usable by other threads. By "not usable" we mean that
other threads are unable to change the access permissions for that
key for themselves.

When a new key is allocated in one thread, the corresponding UAMOR
bits for that thread get enabled, however the UAMOR bits for that key
for all other threads remain disabled.

Other threads have no way to set permissions on the key, and the
current default permissions are that read/write is enabled for all
keys, which means the key has no effect for other threads. Although
that may be the desired behaviour in some circumstances, having all
threads able to control their permissions for the key is more
flexible.

The current behaviour also differs from the x86 behaviour, which is
problematic for users.

To fix this, enable the UAMOR bits for all keys, at process
creation (in start_thread(), ie exec time). Since the contents of
UAMOR are inherited at fork, all threads are capable of modifying the
permissions on any key.

This is technically an ABI break on powerpc, but pkey support is fairly
new on powerpc and not widely used, and this brings us into
line with x86.

Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
Cc: stable@vger.kernel.org # v4.16+
Tested-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
[mpe: Reword some of the changelog]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/pkeys.c |   44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -15,8 +15,9 @@ bool pkey_execute_disable_supported;
 int  pkeys_total;		/* Total pkeys as per device tree */
 bool pkeys_devtree_defined;	/* pkey property exported by device tree */
 u32  initial_allocation_mask;	/* Bits set for reserved keys */
-u64  pkey_amr_uamor_mask;	/* Bits in AMR/UMOR not to be touched */
+u64  pkey_amr_mask;		/* Bits in AMR not to be touched */
 u64  pkey_iamr_mask;		/* Bits in AMR not to be touched */
+u64  pkey_uamor_mask;		/* Bits in UMOR not to be touched */
 
 #define AMR_BITS_PER_PKEY 2
 #define AMR_RD_BIT 0x1UL
@@ -119,20 +120,26 @@ int pkey_initialize(void)
 #else
 	os_reserved = 0;
 #endif
-	initial_allocation_mask = ~0x0;
-	pkey_amr_uamor_mask = ~0x0ul;
+	initial_allocation_mask  = (0x1 << 0) | (0x1 << 1);
+
+	/* register mask is in BE format */
+	pkey_amr_mask = ~0x0ul;
 	pkey_iamr_mask = ~0x0ul;
-	/*
-	 * key 0, 1 are reserved.
-	 * key 0 is the default key, which allows read/write/execute.
-	 * key 1 is recommended not to be used. PowerISA(3.0) page 1015,
-	 * programming note.
-	 */
-	for (i = 2; i < (pkeys_total - os_reserved); i++) {
-		initial_allocation_mask &= ~(0x1 << i);
-		pkey_amr_uamor_mask &= ~(0x3ul << pkeyshift(i));
+
+	for (i = 0; i < (pkeys_total - os_reserved); i++) {
+		pkey_amr_mask &= ~(0x3ul << pkeyshift(i));
 		pkey_iamr_mask &= ~(0x1ul << pkeyshift(i));
 	}
+
+	pkey_uamor_mask = ~0x0ul;
+	pkey_uamor_mask &= ~(0x3ul << pkeyshift(0));
+
+	/* mark the rest of the keys as reserved and hence unavailable */
+	for (i = (pkeys_total - os_reserved); i < pkeys_total; i++) {
+		initial_allocation_mask |= (0x1 << i);
+		pkey_uamor_mask &= ~(0x3ul << pkeyshift(i));
+	}
+
 	return 0;
 }
 
@@ -289,9 +296,6 @@ void thread_pkey_regs_restore(struct thr
 	if (static_branch_likely(&pkey_disabled))
 		return;
 
-	/*
-	 * TODO: Just set UAMOR to zero if @new_thread hasn't used any keys yet.
-	 */
 	if (old_thread->amr != new_thread->amr)
 		write_amr(new_thread->amr);
 	if (old_thread->iamr != new_thread->iamr)
@@ -305,9 +309,13 @@ void thread_pkey_regs_init(struct thread
 	if (static_branch_likely(&pkey_disabled))
 		return;
 
-	thread->amr = read_amr() & pkey_amr_uamor_mask;
-	thread->iamr = read_iamr() & pkey_iamr_mask;
-	thread->uamor = read_uamor() & pkey_amr_uamor_mask;
+	thread->amr = pkey_amr_mask;
+	thread->iamr = pkey_iamr_mask;
+	thread->uamor = pkey_uamor_mask;
+
+	write_uamor(pkey_uamor_mask);
+	write_amr(pkey_amr_mask);
+	write_iamr(pkey_iamr_mask);
 }
 
 static inline bool pkey_allows_readwrite(int pkey)


