Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbeBUKVu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:21:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57766 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932631AbeBUKTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:19:21 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] x86/mce: Issue the mcelog --ascii message on !AMD
Date: Wed, 21 Feb 2018 11:18:55 +0100
Message-Id: <20180221101900.10326-4-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180221101900.10326-1-bp@alien8.de>
References: <20180221101900.10326-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

mcelog cannot decode AMD MCEs.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 9c8cb58c77f8..b16b184d90c5 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -264,7 +264,9 @@ static void __print_mce(struct mce *m)
 static void print_mce(struct mce *m)
 {
 	__print_mce(m);
-	pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
+
+	if (m->cpuvendor != X86_VENDOR_AMD)
+		pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
 }
 
 #define PANIC_TIMEOUT 5 /* 5 seconds */
-- 
2.13.0
