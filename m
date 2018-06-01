Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeFALa7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:30:59 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:58832 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFALaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:30:52 -0400
X-IronPort-AV: E=Sophos;i="5.49,465,1520899200";
   d="scan'208";a="734817710"
From: Filippo Sironi <sironi@amazon.de>
To: sironi@amazon.de, tony.luck@intel.com, bp@alien8.de,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/MCE: Get microcode revision from cpu_info instead of boot_cpu_data
Date: Fri,  1 Jun 2018 13:30:26 +0200
Message-Id: <1527852626-7258-1-git-send-email-sironi@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check
records") extended MCE entries to report the microcode revision taken
from boot_cpu_data. Unfortunately, boot_cpu_data isn't updated on late
microcode loading, thus making MCE entries slightly incorrect.
Use cpu_info instead, which is updated on late microcode loading.

Fixes: fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check records")
Signed-off-by: Filippo Sironi <sironi@amazon.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/cpu/mcheck/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 42cf2880d0ed..4be323f9b390 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -134,7 +134,7 @@ void mce_setup(struct mce *m)
 	if (this_cpu_has(X86_FEATURE_INTEL_PPIN))
 		rdmsrl(MSR_PPIN, m->ppin);
 
-	m->microcode = boot_cpu_data.microcode;
+	m->microcode = cpu_data(m->extcpu).microcode;
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
-- 
2.7.4
