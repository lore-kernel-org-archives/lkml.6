Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E005C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AA320855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AA320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeIHB5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:57:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeIHB5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:57:23 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B24B1FD4;
        Fri,  7 Sep 2018 21:14:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 031/145] powerpc/pkeys: key allocation/deallocation must not change pkey registers
Date:   Fri,  7 Sep 2018 23:08:17 +0200
Message-Id: <20180907210906.519721463@linuxfoundation.org>
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

commit 4a4a5e5d2aadc793be95024f454cf511d115b62d upstream.

Key allocation and deallocation has the side effect of programming the
UAMOR/AMR/IAMR registers. This is wrong, since its the responsibility of
the application and not that of the kernel, to modify the permission on
the key.

Do not modify the pkey registers at key allocation/deallocation.

This patch also fixes a bug where a sys_pkey_free() resets the UAMOR
bits of the key, thus making its permissions unmodifiable from user
space. Later if the same key gets reallocated from a different thread
this thread will no longer be able to change the permissions on the key.

Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
Cc: stable@vger.kernel.org # v4.16+
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/pkeys.h |   11 -----------
 arch/powerpc/mm/pkeys.c          |   27 ---------------------------
 2 files changed, 38 deletions(-)

--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -94,8 +94,6 @@ static inline bool mm_pkey_is_allocated(
 		__mm_pkey_is_allocated(mm, pkey));
 }
 
-extern void __arch_activate_pkey(int pkey);
-extern void __arch_deactivate_pkey(int pkey);
 /*
  * Returns a positive, 5-bit key on success, or -1 on failure.
  * Relies on the mmap_sem to protect against concurrency in mm_pkey_alloc() and
@@ -124,11 +122,6 @@ static inline int mm_pkey_alloc(struct m
 	ret = ffz((u32)mm_pkey_allocation_map(mm));
 	__mm_pkey_allocated(mm, ret);
 
-	/*
-	 * Enable the key in the hardware
-	 */
-	if (ret > 0)
-		__arch_activate_pkey(ret);
 	return ret;
 }
 
@@ -140,10 +133,6 @@ static inline int mm_pkey_free(struct mm
 	if (!mm_pkey_is_allocated(mm, pkey))
 		return -EINVAL;
 
-	/*
-	 * Disable the key in the hardware
-	 */
-	__arch_deactivate_pkey(pkey);
 	__mm_pkey_free(mm, pkey);
 
 	return 0;
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -218,33 +218,6 @@ static inline void init_iamr(int pkey, u
 	write_iamr(old_iamr | new_iamr_bits);
 }
 
-static void pkey_status_change(int pkey, bool enable)
-{
-	u64 old_uamor;
-
-	/* Reset the AMR and IAMR bits for this key */
-	init_amr(pkey, 0x0);
-	init_iamr(pkey, 0x0);
-
-	/* Enable/disable key */
-	old_uamor = read_uamor();
-	if (enable)
-		old_uamor |= (0x3ul << pkeyshift(pkey));
-	else
-		old_uamor &= ~(0x3ul << pkeyshift(pkey));
-	write_uamor(old_uamor);
-}
-
-void __arch_activate_pkey(int pkey)
-{
-	pkey_status_change(pkey, true);
-}
-
-void __arch_deactivate_pkey(int pkey)
-{
-	pkey_status_change(pkey, false);
-}
-
 /*
  * Set the access rights in AMR IAMR and UAMOR registers for @pkey to that
  * specified in @init_val.


