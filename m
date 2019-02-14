Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE1BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C094D222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405729AbfBNGYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:24:16 -0500
Received: from ozlabs.org ([203.11.71.1]:44533 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfBNGYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:24:16 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 440RDt0MKLz9sML; Thu, 14 Feb 2019 17:24:13 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     aneesh.kumar@linux.vnet.ibm.com, jack@suse.cz,
        erhard_f@mailbox.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present()
Date:   Thu, 14 Feb 2019 17:23:39 +1100
Message-Id: <20190214062339.7139-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
rather than just checking that the value is non-zero, e.g.:

  static inline int pgd_present(pgd_t pgd)
  {
 -       return !pgd_none(pgd);
 +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
  }

Unfortunately this is broken on big endian, as the result of the
bitwise && is truncated to int, which is always zero because
_PAGE_PRESENT is 0x8000000000000000ul. This means pgd_present() and
pud_present() are always false at compile time, and the compiler
elides the subsequent code.

Remarkably with that bug present we are still able to boot and run
with few noticeable effects. However under some work loads we are able
to trigger a warning in the ext4 code:

  WARNING: CPU: 11 PID: 29593 at fs/ext4/inode.c:3927 .ext4_set_page_dirty+0x70/0xb0
  CPU: 11 PID: 29593 Comm: debugedit Not tainted 4.20.0-rc1 #1
  ...
  NIP .ext4_set_page_dirty+0x70/0xb0
  LR  .set_page_dirty+0xa0/0x150
  Call Trace:
   .set_page_dirty+0xa0/0x150
   .unmap_page_range+0xbf0/0xe10
   .unmap_vmas+0x84/0x130
   .unmap_region+0xe8/0x190
   .__do_munmap+0x2f0/0x510
   .__vm_munmap+0x80/0x110
   .__se_sys_munmap+0x14/0x30
   system_call+0x5c/0x70

The fix is simple, we need to convert the result of the bitwise && to
an int before returning it.

Thanks to Jan Kara and Aneesh for help with debugging.

Fixes: da7ad366b497 ("powerpc/mm/book3s: Update pmd_present to look at _PAGE_PRESENT bit")
Cc: stable@vger.kernel.org # v4.20+
Reported-by: Erhard F. <erhard_f@mailbox.org>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c9bfe526ca9d..d8c8d7c9df15 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -904,7 +904,7 @@ static inline int pud_none(pud_t pud)
 
 static inline int pud_present(pud_t pud)
 {
-	return (pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
+	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
 }
 
 extern struct page *pud_page(pud_t pud);
@@ -951,7 +951,7 @@ static inline int pgd_none(pgd_t pgd)
 
 static inline int pgd_present(pgd_t pgd)
 {
-	return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
+	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
 }
 
 static inline pte_t pgd_pte(pgd_t pgd)
-- 
2.20.1

