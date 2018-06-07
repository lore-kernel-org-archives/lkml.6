Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UDICD7RHGVsKPwAAmS7hNA
	; Thu, 07 Jun 2018 14:56:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2A413607E7; Thu,  7 Jun 2018 14:56:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0E0B7606DD;
	Thu,  7 Jun 2018 14:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E0B7606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753768AbeFGO4t (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:56:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41105 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753663AbeFGO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:56:47 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbo-0005Zi-Ud; Thu, 07 Jun 2018 15:09:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb2-0002rK-D7; Thu, 07 Jun 2018 15:09:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Jonas Bonn" <jonas@southpole.se>,
        "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
        "Stafford Horne" <shorne@gmail.com>, openrisc@lists.librecores.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.856687679@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 125/410] signal/openrisc: Fix do_unaligned_access to
 send the proper signal
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

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 500d58300571b6602341b041f97c082a461ef994 upstream.

While reviewing the signal sending on openrisc the do_unaligned_access
function stood out because it is obviously wrong.  A comment about an
si_code set above when actually si_code is never set.  Leading to a
random si_code being sent to userspace in the event of an unaligned
access.

Looking further SIGBUS BUS_ADRALN is the proper pair of signal and
si_code to send for an unaligned access. That is what other
architectures do and what is required by posix.

Given that do_unaligned_access is broken in a way that no one can be
relying on it on openrisc fix the code to just do the right thing.

Fixes: 769a8a96229e ("OpenRISC: Traps")
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: openrisc@lists.librecores.org
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/openrisc/kernel/traps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -302,12 +302,12 @@ asmlinkage void do_unaligned_access(stru
 	siginfo_t info;
 
 	if (user_mode(regs)) {
-		/* Send a SIGSEGV */
-		info.si_signo = SIGSEGV;
+		/* Send a SIGBUS */
+		info.si_signo = SIGBUS;
 		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void *)address;
-		force_sig_info(SIGSEGV, &info, current);
+		info.si_code = BUS_ADRALN;
+		info.si_addr = (void __user *)address;
+		force_sig_info(SIGBUS, &info, current);
 	} else {
 		printk("KERNEL: Unaligned Access 0x%.8lx\n", address);
 		show_registers(regs);
