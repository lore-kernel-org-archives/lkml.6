Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70131C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FF120BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="I6PCcwfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FF120BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbeGKLeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:34:14 -0400
Received: from 8bytes.org ([81.169.241.247]:37802 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733027AbeGKLeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:12 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 30944306F; Wed, 11 Jul 2018 13:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308607; bh=dfv0Zih1QJqgNawf7FbV+BW/CZ/u7bR2eHjCpA2aoNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6PCcwfoUJP0V1FltHewvANzNLt9DdlFM8x96hxSJ30yPSoqKtNnWN4rotOwQPrWg
         17LmacJdb9tv/jFhexsiE7kpeDVak/SQK8o8te+QpWaUOBkt39nvt+4cf2zZVQKRYk
         PAbVHsSKoVTDRe2MP1qZTooqxUyDr8DrVkIVJCcdo+EsS1EgAj0bWy9AENqZ8fQZQe
         K+O6MhX+tIeklBsVcMs3D1PxBOHLkcKFxszcE0WAWU3dGap2LQpLMhcUvWHJ2SRE7B
         wUVPRgd7uoCLHVX9Zrf9ufZPBGJxSCuT+b6uJy9vAzDGouZJ8/ZVsv9JqHlOIgBfIq
         HwRFqJxgBg/MA==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 28/39] x86/mm/pti: Keep permissions when cloning kernel text in pti_clone_kernel_text()
Date:   Wed, 11 Jul 2018 13:29:35 +0200
Message-Id: <1531308586-29340-29-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Mapping the kernel text area to user-space makes only sense
if it has the same permissions as in the kernel page-table.
If permissions are different this will cause a TLB reload
when using the kernel page-table, which is as good as not
mapping it at all.

On 64-bit kernels this patch makes no difference, as the
whole range cloned by pti_clone_kernel_text() is mapped RO
anyway. On 32 bit there are writeable mappings in the range,
so just keep the permissions as they are.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 4f6e933..fc77054 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -482,7 +482,7 @@ void pti_clone_kernel_text(void)
 	 * pti_set_kernel_image_nonglobal() did to clear the
 	 * global bit.
 	 */
-	pti_clone_pmds(start, end, _PAGE_RW);
+	pti_clone_pmds(start, end, 0);
 }
 
 /*
-- 
2.7.4

