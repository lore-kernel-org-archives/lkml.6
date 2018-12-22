Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3A4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B46B2195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392047AbeLVTLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:11:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42857 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbeLVTLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:11:39 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gamg9-0003eb-20; Sat, 22 Dec 2018 19:11:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] x86/fault: fix sign-extend of a unsigned that has been promoted to an int
Date:   Sat, 22 Dec 2018 19:11:16 +0000
Message-Id: <20181222191116.21831-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The shifting of desc.base2 by 24 bits will end up with a sign extension
error if the bit 7 of desc.base2 is set.  This because desc.base2 is
promoted to type int and then sign extended to an unsigned long, causing
the upper bits 32 bits to be set on the sign extension.  Fix this by
casting desc.base2 to unsigned long before the shift.

Detected by CoverityScan, CID#1475635 ("Unintended sign extension")

Fixes: a1a371c468f7 ("x86/fault: Decode page fault OOPSes better")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2ff25ad33233..9d5c75f02295 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -595,7 +595,7 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
 		return;
 	}
 
-	addr = desc.base0 | (desc.base1 << 16) | (desc.base2 << 24);
+	addr = desc.base0 | (desc.base1 << 16) | ((unsigned long)desc.base2 << 24);
 #ifdef CONFIG_X86_64
 	addr |= ((u64)desc.base3 << 32);
 #endif
-- 
2.19.1

