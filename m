Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185245-2-1913463042325104305
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185244; b=rF5uUkKjSjewe1XP3nUPUXw7u0pGGaC37kwh05l8SNSEYrI
    9noMz5ArVzb3x8FCDVnKZI13yt4CkMhzsCLzZ0mvtuk0x2+zs632oUTN7VnbXkB1
    fkUoP/TGqkRnDNSpPDcq5MxvDzO149dIjn5IWK0VXHY9l0CUPmAhVD/aPZOVGiX5
    NSFRvzSRAIUzZ4P9G12NYm6FnwJSZsHcLvSjifUJDWnHcI3qh8hcBfyTGl9AIfpN
    SG42Pm0w7CZLzkJ3YzN8cbNbzglfe5mZWQBqR3bVGYKKNdlvZohpKGWzW9alXjoP
    u/PvRj6FeE8NNmGE8g+vbMKpFsWKkoouiWmu/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185244; bh=qw4wQuyyf6TTy+vXkeyS2h+5xE
    3jMh1IDEw2yEmpRU8=; b=MB8iH0ZrL6qISr+OuKHtZ3d0rRh4FZbQLQmIwldl6l
    3B1WVopQKKgPOO2zvaZUkhifnQIEoFomIWKBYSGYiwS1le/l4H0NpCDj1lk6DEKY
    H5VGvNtXpS59cHAhmd5/aUjFOa116BsR9SSlNgDw9qzg/CVGGm+lfPdfBPPMMnoV
    8hemFrfsXfh+lQiTjhKbJS3PtEQ8Gf4MKNTbibEx0YAIm+TxJM8Ixi3JoWUd5zm4
    kkOKTixs1jA11yjo8amuPvVrG7UiqNtGvvfnY4YKJzU8H7eYU46XPmeQtQDroFQ4
    2/KITRnHsR4gySP6lpalxhah3PtAf+jmUcpsnTrMWKtg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeBINmi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752978AbeBINmh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Hugh Dickins <hughd@google.com>
Subject: [PATCH 4.9 17/92] kaiser: allocate pgd with order 0 when pti=off
Date: Fri,  9 Feb 2018 14:38:46 +0100
Message-Id: <20180209133932.516958922@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugh Dickins <hughd@google.com>

The 4.9.77 version of "x86/pti/efi: broken conversion from efi to kernel
page table" looked nicer than the 4.4.112 version, but was suboptimal on
machines booted with "pti=off" (or on AMD machines): it allocated pgd
with an order 1 page whatever the setting of kaiser_enabled.

Fix that by moving the definition of PGD_ALLOCATION_ORDER from
asm/pgalloc.h to asm/pgtable.h, which already defines kaiser_enabled.

Fixes: 1b92c48a2eeb ("x86/pti/efi: broken conversion from efi to kernel page table")
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/pgalloc.h |   11 -----------
 arch/x86/include/asm/pgtable.h |    6 ++++++
 2 files changed, 6 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -27,17 +27,6 @@ static inline void paravirt_release_pud(
  */
 extern gfp_t __userpte_alloc_gfp;
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-/*
- * Instead of one PGD, we acquire two PGDs.  Being order-1, it is
- * both 8k in size and 8k-aligned.  That lets us just flip bit 12
- * in a pointer to swap between the two 4k halves.
- */
-#define PGD_ALLOCATION_ORDER 1
-#else
-#define PGD_ALLOCATION_ORDER 0
-#endif
-
 /*
  * Allocate and free page tables.
  */
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -20,9 +20,15 @@
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 extern int kaiser_enabled;
+/*
+ * Instead of one PGD, we acquire two PGDs.  Being order-1, it is
+ * both 8k in size and 8k-aligned.  That lets us just flip bit 12
+ * in a pointer to swap between the two 4k halves.
+ */
 #else
 #define kaiser_enabled 0
 #endif
+#define PGD_ALLOCATION_ORDER kaiser_enabled
 
 void ptdump_walk_pgd_level(struct seq_file *m, pgd_t *pgd);
 void ptdump_walk_pgd_level_checkwx(void);
