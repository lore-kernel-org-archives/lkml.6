Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B43BECE567
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CA02145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CA02145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeIXPRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:17:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56609 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeIXPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:17:18 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4MyS-0005nH-08; Mon, 24 Sep 2018 03:16:12 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4MvM-0002zU-0O; Mon, 24 Sep 2018 03:13:01 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 11:10:14 +0200
Message-Id: <20180924091015.4458-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
X-XM-SPF: eid=1g4MvM-0002zU-0O;;;mid=<20180924091015.4458-14-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Umkyu05w235q6RvBMS/LSttCaiWPgWTQ=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 14/15] signal/arm64: Add and use arm64_force_sig_ptrace_errno_trap
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arm64_force_sig_ptrace_errno_trap for consistency with
arm64_force_sig_fault and use it where appropriate.

This adds the show_signal logic to the force_sig_errno_trap case,
where it was apparently overlooked earlier.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/include/asm/traps.h | 1 +
 arch/arm64/kernel/ptrace.c     | 4 +++-
 arch/arm64/kernel/traps.c      | 7 +++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index d32b8bd440af..f9c1aa6167d2 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -39,6 +39,7 @@ void force_signal_inject(int signal, int code, unsigned long address);
 void arm64_notify_segfault(unsigned long addr);
 void arm64_force_sig_fault(int signo, int code, void __user *addr, const char *str);
 void arm64_force_sig_mceerr(int code, void __user *addr, short lsb, const char *str);
+void arm64_force_sig_ptrace_errno_trap(int errno, void __user *addr, const char *str);
 
 /*
  * Move regs->pc to next instruction and do necessary setup before it
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 921267f59d0d..1710a2d01669 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -202,7 +202,9 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 				break;
 			}
 		}
-		force_sig_ptrace_errno_trap(si_errno, (void __user *)bkpt->trigger);
+		arm64_force_sig_ptrace_errno_trap(si_errno,
+						  (void __user *)bkpt->trigger,
+						  desc);
 	}
 #endif
 	arm64_force_sig_fault(SIGTRAP, TRAP_HWBKPT,
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index de67818258cd..856b32aa03d8 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -262,6 +262,13 @@ void arm64_force_sig_mceerr(int code, void __user *addr, short lsb,
 	force_sig_mceerr(code, addr, lsb, current);
 }
 
+void arm64_force_sig_ptrace_errno_trap(int errno, void __user *addr,
+				       const char *str)
+{
+	arm64_show_signal(SIGTRAP, str);
+	force_sig_ptrace_errno_trap(errno, addr);
+}
+
 void arm64_notify_die(const char *str, struct pt_regs *regs,
 		      int signo, int sicode, void __user *addr,
 		      int err)
-- 
2.17.1

