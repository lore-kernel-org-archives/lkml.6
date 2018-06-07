Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RkCLFH5BGVuobgAAmS7hNA
	; Thu, 07 Jun 2018 14:30:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6CBDF607E7; Thu,  7 Jun 2018 14:30:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D37676063F;
	Thu,  7 Jun 2018 14:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D37676063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933790AbeFGOaZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:30:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39409 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933061AbeFGOJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:09 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0005hL-8k; Thu, 07 Jun 2018 15:09:08 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00036E-3m; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Will Deacon" <will.deacon@arm.com>,
        "Michael Weiser" <michael.weiser@gmx.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.88828682@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 269/410] arm64: Remove unimplemented syscall log message
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

From: Michael Weiser <michael.weiser@gmx.de>

commit 1962682d2b2fbe6cfa995a85c53c069fadda473e upstream.

Stop printing a (ratelimited) kernel message for each instance of an
unimplemented syscall being called. Userland making an unimplemented
syscall is not necessarily misbehaviour and to be expected with a
current userland running on an older kernel. Also, the current message
looks scary to users but does not actually indicate a real problem nor
help them narrow down the cause. Just rely on sys_ni_syscall() to return
-ENOSYS.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
[bwh: Backported to 3.16: Deleted code was slightly different]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/kernel/traps.c | 8 --------
 1 file changed, 8 deletions(-)

--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -251,14 +251,6 @@ asmlinkage long do_ni_syscall(struct pt_
 	}
 #endif
 
-	if (show_unhandled_signals && printk_ratelimit()) {
-		pr_info("%s[%d]: syscall %d\n", current->comm,
-			task_pid_nr(current), (int)regs->syscallno);
-		dump_instr("", regs);
-		if (user_mode(regs))
-			__show_regs(regs);
-	}
-
 	return sys_ni_syscall();
 }
 
