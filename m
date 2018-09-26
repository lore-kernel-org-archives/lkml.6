Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1C7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869FB214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869FB214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeIZShW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:37:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:41088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726602AbeIZShW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:37:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 259A2B0A4;
        Wed, 26 Sep 2018 12:24:36 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Haren Myneni <haren@linux.vnet.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/64s: consolidate MCE counter increment.
Date:   Wed, 26 Sep 2018 14:24:30 +0200
Message-Id: <20180926122430.13924-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The code in machine_check_exception excludes 64s hvmode when
incrementing the MCE counter only to call opal_machine_check to
increment it specifically for this case.

Remove the exclusion and special case.

Fixes: a43c1590426c ("powerpc/pseries: Flush SLB contents on SLB MCE
		errors.")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/traps.c           | 4 +---
 arch/powerpc/platforms/powernv/opal.c | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 6ab66a88db14..e5bc413c7d53 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -741,9 +741,7 @@ void machine_check_exception(struct pt_regs *regs)
 	if (!nested)
 		nmi_enter();
 
-	/* 64s accounts the mce in machine_check_early when in HVMODE */
-	if (!IS_ENABLED(CONFIG_PPC_BOOK3S_64) || !cpu_has_feature(CPU_FTR_HVMODE))
-		__this_cpu_inc(irq_stat.mce_exceptions);
+	__this_cpu_inc(irq_stat.mce_exceptions);
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 62c291e23dbe..38fe4087484a 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -578,8 +578,6 @@ int opal_machine_check(struct pt_regs *regs)
 {
 	struct machine_check_event evt;
 
-	__this_cpu_inc(irq_stat.mce_exceptions);
-
 	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))
 		return 0;
 
-- 
2.13.7

