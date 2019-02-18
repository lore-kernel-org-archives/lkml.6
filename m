Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23401C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AB12190B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497720;
	bh=x0574sUupL9CU83IeAQOMpUhVwG+gvJYSkgJdzPCwS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w0yOX7xfqmyXOtgx3mZK+PgLHCJiNm2JmnVo+e7AHH3P7sg4Xt4TS3/nmpTCzkZw/
	 pgnEUShGJXp1QkEvgAIEq6mSHQYPmCGvW3WPRwiC2OwS1aVEoo4n4uWaoldby356Sm
	 gS8rPOWK7AeFIrETnM4hApa1qrEco33oo9GYGbEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfBRNsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731446AbfBRNsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:48:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C37FA21905;
        Mon, 18 Feb 2019 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497714;
        bh=x0574sUupL9CU83IeAQOMpUhVwG+gvJYSkgJdzPCwS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzcRQ1mh0nDhUPIgCmisi9KT0j1l7ipww2Xq7NK71vrH8vSixv8W5JF1WZ4fINO4C
         hln3IgR/t/IM4IVpxeka/4eGsfXpH01EUveczkjDkIdQFu3bsnU1hOOzfP1ZjYsFbE
         25n6qCD1r3qcQdsLyTWa65nJ0C0ZMw3y9W6MBcVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Erhard F." <erhard_f@mailbox.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.20 79/92] powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present()
Date:   Mon, 18 Feb 2019 14:43:22 +0100
Message-Id: <20190218133502.374352636@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit a58007621be33e9f7c7bed5d5ff8ecb914e1044a upstream.

In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
rather than just checking that the value is non-zero, e.g.:

  static inline int pgd_present(pgd_t pgd)
  {
 -       return !pgd_none(pgd);
 +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
  }

Unfortunately this is broken on big endian, as the result of the
bitwise & is truncated to int, which is always zero because
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

The fix is simple, we need to convert the result of the bitwise & to
an int before returning it.

Thanks to Erhard, Jan Kara and Aneesh for help with debugging.

Fixes: da7ad366b497 ("powerpc/mm/book3s: Update pmd_present to look at _PAGE_PRESENT bit")
Cc: stable@vger.kernel.org # v4.20+
Reported-by: Erhard F. <erhard_f@mailbox.org>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/book3s/64/pgtable.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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


