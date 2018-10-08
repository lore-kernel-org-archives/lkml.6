Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3EEC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E11F2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E11F2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJHUMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:12:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:41884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbeJHUMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:12:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71414ACFB;
        Mon,  8 Oct 2018 13:01:14 +0000 (UTC)
Date:   Mon, 8 Oct 2018 15:01:06 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>, hpa@zytor.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, m.mizuma@jp.fujitsu.com,
        open list <linux-kernel@vger.kernel.org>, bhe@redhat.com,
        Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org, lkft-triage@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [tip:x86/boot] x86/kaslr, ACPI/NUMA: Fix KASLR build error
Message-ID: <20181008130106.GE6490@zn.tnic>
References: <20181003123402.GA15494@hirez.programming.kicks-ass.net>
 <tip-3a387c6d96e69f1710a3804eb68e1253263298f2@git.kernel.org>
 <CA+G9fYuLJH6XVsS14xjhSqJsUGZ9NXdyytseT2Pr0hoxOeWfAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuLJH6XVsS14xjhSqJsUGZ9NXdyytseT2Pr0hoxOeWfAg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 04:33:29PM +0530, Naresh Kamboju wrote:
> Linux next build for arm64 failed due to
> numa.c:34:10: fatal error: asm/kaslr.h: No such file or directory

Thanks for letting me know, I guess we could fix that with a weak
function:

---
 arch/x86/include/asm/kaslr.h | 2 --
 drivers/acpi/numa.c          | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kaslr.h b/arch/x86/include/asm/kaslr.h
index 95ef3fc01d12..db7ba2feb947 100644
--- a/arch/x86/include/asm/kaslr.h
+++ b/arch/x86/include/asm/kaslr.h
@@ -6,10 +6,8 @@ unsigned long kaslr_get_random_long(const char *purpose);
 
 #ifdef CONFIG_RANDOMIZE_MEMORY
 void kernel_randomize_memory(void);
-void kaslr_check_padding(void);
 #else
 static inline void kernel_randomize_memory(void) { }
-static inline void kaslr_check_padding(void) { }
 #endif /* CONFIG_RANDOMIZE_MEMORY */
 
 #endif
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 4408e37600ef..ba62004f4d86 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -32,7 +32,6 @@
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
-#include <asm/kaslr.h>
 
 static nodemask_t nodes_found_map = NODE_MASK_NONE;
 
@@ -433,6 +432,9 @@ acpi_table_parse_srat(enum acpi_srat_type id,
 					    handler, max_entries);
 }
 
+/* To be overridden by architectures */
+void __init __weak kaslr_check_padding(void) { }
+
 int __init acpi_numa_init(void)
 {
 	int cnt = 0;
-- 
2.19.0.271.gfe8321ec057f

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
