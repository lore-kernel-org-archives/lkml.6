Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D4FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23FA217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfAGOQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:16:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:54670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727119AbfAGOQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:16:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EAEA5AC4E;
        Mon,  7 Jan 2019 14:16:36 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, anup@brainfault.org,
        jeremy.linton@arm.com, sudeep.holla@arm.com
Subject: [PATCH] RISC-V: fix bad use of of_node_put
References: <1542755270-10433-1-git-send-email-atish.patra@wdc.com>
X-Yow:  I will establish the first SHOPPING MALL in NUTLEY, New Jersey...
Date:   Mon, 07 Jan 2019 15:16:35 +0100
In-Reply-To: <1542755270-10433-1-git-send-email-atish.patra@wdc.com> (Atish
        Patra's message of "Tue, 20 Nov 2018 15:07:50 -0800")
Message-ID: <mvm8szwwo1o.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_type already calls of_node_put, don't call it again.

Fixes: 94f9bf118f ("RISC-V: Fix of_node_* refcount")
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 arch/riscv/kernel/smpboot.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index fc185ecabb..18cda0e8cf 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -57,15 +57,12 @@ void __init setup_smp(void)
 
 	while ((dn = of_find_node_by_type(dn, "cpu"))) {
 		hart = riscv_of_processor_hartid(dn);
-		if (hart < 0) {
-			of_node_put(dn);
+		if (hart < 0)
 			continue;
-		}
 
 		if (hart == cpuid_to_hartid_map(0)) {
 			BUG_ON(found_boot_cpu);
 			found_boot_cpu = 1;
-			of_node_put(dn);
 			continue;
 		}
 
@@ -73,7 +70,6 @@ void __init setup_smp(void)
 		set_cpu_possible(cpuid, true);
 		set_cpu_present(cpuid, true);
 		cpuid++;
-		of_node_put(dn);
 	}
 
 	BUG_ON(!found_boot_cpu);
-- 
2.20.1

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
