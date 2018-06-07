Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id i1EsIUBAGVtjYAAAmS7hNA
	; Thu, 07 Jun 2018 14:25:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C703A6089E; Thu,  7 Jun 2018 14:25:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D399D6063F;
	Thu,  7 Jun 2018 14:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D399D6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933310AbeFGOV4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:21:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39435 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933071AbeFGOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:10 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0005hO-8K; Thu, 07 Jun 2018 15:09:08 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00036J-5Q; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "NCSC Security" <security@ncsc.gov.uk>,
        "Will Deacon" <will.deacon@arm.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.245798275@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 270/410] arm64: __show_regs: Only resolve kernel
 symbols when running at EL1
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit a06f818a70de21b4b3b4186816094208fc7accf9 upstream.

__show_regs pretty prints PC and LR by attempting to map them to kernel
function names to improve the utility of crash reports. Unfortunately,
this mapping is applied even when the pt_regs corresponds to user mode,
resulting in a KASLR oracle.

Avoid this issue by only looking up the function symbols when the register
state indicates that we're actually running at EL1.

Reported-by: NCSC Security <security@ncsc.gov.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/kernel/process.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -197,8 +197,15 @@ void __show_regs(struct pt_regs *regs)
 	}
 
 	show_regs_print_info(KERN_DEFAULT);
-	printk("pc : %pS\n", (void *)regs->pc);
-	printk("lr : %pS\n", (void *)lr);
+
+	if (!user_mode(regs)) {
+		printk("pc : %pS\n", (void *)regs->pc);
+		printk("lr : %pS\n", (void *)lr);
+	} else {
+		printk("pc : %016llx\n", regs->pc);
+		printk("lr : %016llx\n", lr);
+	}
+
 	printk("sp : %016llx pstate : %08llx\n", sp, regs->pstate);
 	for (i = top_reg; i >= 0; i--) {
 		printk("x%-2d: %016llx ", i, regs->regs[i]);
