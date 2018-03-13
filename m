Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3628988-1520960651-2-3408671246406174681
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520960650; b=q+Nz51tjrMYZKXcKi3BDJUEV5gy4rJdJQYJSn7XKlCUnvAd
    zBgsTOyUt7Nf3lZn3cQqgF/xs8Mg62+DyXb43Ug9/5izVfvHJKCyaQQNjFUlMiDX
    Wgl8LEwCpPMuoMwYTjA+g1ADAw7kHnU34gz3NeLm46sHuCLXoE4V8p1IAgKZFK40
    ehNGV6G8eI8QKpTa2s8kl4QQFdpCQ3GQPgQRRzomrLlu/AV8htWOigFDeePOa3RV
    Bg7XQzIdpdi6ItDjf+qqgQYQaTP0g+aYg/knctfCJANsI8KbawfBSlaUZvkYRpxT
    FQUbuXQx4mwVNNK2rLFqoB70mEZ/BA2fzIy7cqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520960650;
    bh=jDQIR12hhTdGYeJe1og7QQ4rDMbB+zxrKgBKaRyT3PY=; b=MC+0q6b0oKA8
    wbU+Y5sjB9c3FmxeQ7lxyN+WCeGE9oVKEt9do7yOnZgwsjItbJ56HQHQqUUxQnmU
    Eo9zrHYgf65n+u0mfouWfdSu+/ZkdC9C7u5kG9Tf5fjTUNJU1mvBpFRWiURDCH0l
    gwXIOw/V4glF6mTkSKSCFMiu0AEsA57SvIYvfh42gMZJqb2L6bZb7R1r48wO4Maf
    40M1Bn+ua4+ZCjKSJdH2CahxhPFpJSIgY8LlyqqIu1D+Dl5tX0QFsXJtNMD4YVV+
    IO033RjURryfDqmmUT2dJWVY6NYNW5oPeu0BSAI4t94OgksZCMHhAZMPipFNFl+E
    xA6P1VT4TQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933082AbeCMRDz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 13:03:55 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:38416 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932303AbeCMRDx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 13:03:53 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: bp@alien8.de, luto@kernel.org, gratian.crisan@ni.com,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] x86/mm: fix vmalloc_fault to use pXd_large
Date: Tue, 13 Mar 2018 11:03:46 -0600
Message-Id: <20180313170347.3829-2-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313170347.3829-1-toshi.kani@hpe.com>
References: <20180313170347.3829-1-toshi.kani@hpe.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Gratian Crisan reported that vmalloc_fault() crashes when
CONFIG_HUGETLBFS is not set since the function inadvertently
uses pXn_huge(), which always return 0 in this case.  ioremap()
does not depend on CONFIG_HUGETLBFS.

Fix vmalloc_fault() to call pXd_large() instead.

fixes: f4eafd8bcd52 ("x86/mm: Fix vmalloc_fault() to handle large pages properly")
Reported-by: Gratian Crisan <gratian.crisan@ni.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Gratian Crisan <gratian.crisan@ni.com>
Cc: stable@vger.kernel.org
---
 arch/x86/mm/fault.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index c88573d90f3e..25a30b5d6582 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -330,7 +330,7 @@ static noinline int vmalloc_fault(unsigned long address)
 	if (!pmd_k)
 		return -1;
 
-	if (pmd_huge(*pmd_k))
+	if (pmd_large(*pmd_k))
 		return 0;
 
 	pte_k = pte_offset_kernel(pmd_k, address);
@@ -475,7 +475,7 @@ static noinline int vmalloc_fault(unsigned long address)
 	if (pud_none(*pud) || pud_pfn(*pud) != pud_pfn(*pud_ref))
 		BUG();
 
-	if (pud_huge(*pud))
+	if (pud_large(*pud))
 		return 0;
 
 	pmd = pmd_offset(pud, address);
@@ -486,7 +486,7 @@ static noinline int vmalloc_fault(unsigned long address)
 	if (pmd_none(*pmd) || pmd_pfn(*pmd) != pmd_pfn(*pmd_ref))
 		BUG();
 
-	if (pmd_huge(*pmd))
+	if (pmd_large(*pmd))
 		return 0;
 
 	pte_ref = pte_offset_kernel(pmd_ref, address);
