Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51461ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D8120C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D8120C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbeIRXdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:33:52 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37794 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730647AbeIRXdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:33:51 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2KI9-0004Ut-P3; Tue, 18 Sep 2018 12:00:06 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2KHt-000459-Nx; Tue, 18 Sep 2018 12:00:05 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 19:58:48 +0200
Message-Id: <20180918175850.4437-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
X-XM-SPF: eid=1g2KHt-000459-Nx;;;mid=<20180918175850.4437-7-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19YAh9W/NLwpFblBwEYSTLW7Lwq8CmqTGM=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 7/9] signal/poewrpc: Specialize _exception_pkey for handling pkey exceptions
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that _exception no longer calls _exception_pkey it is no longer
necessary to handle any signal with any si_code.  All pkey exceptions
are SIGSEGV with paired with SEGV_PKUERR.  So just handle
that case and remove the now unnecessary parameters from _exception_pkey.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/include/asm/bug.h |  2 +-
 arch/powerpc/kernel/traps.c    | 10 +++++-----
 arch/powerpc/mm/fault.c        |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index fd06dbe7d7d3..fed7e6241349 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -133,7 +133,7 @@ struct pt_regs;
 extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
 extern void _exception(int, struct pt_regs *, int, unsigned long);
-extern void _exception_pkey(int, struct pt_regs *, int, unsigned long, int);
+extern void _exception_pkey(struct pt_regs *, unsigned long, int);
 extern void die(const char *, struct pt_regs *, long);
 extern bool die_will_crash(void);
 extern void panic_flush_kmsg_start(void);
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index c38bec51dd84..e5ea69222459 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -362,20 +362,20 @@ static bool exception_common(int signr, struct pt_regs *regs, int code,
 	return true;
 }
 
-void _exception_pkey(int signr, struct pt_regs *regs, int code, unsigned long addr, int key)
+void _exception_pkey(struct pt_regs *regs, unsigned long addr, int key)
 {
 	siginfo_t info;
 
-	if (!exception_common(signr, regs, code, addr))
+	if (!exception_common(SIGSEGV, regs, SEGV_PKUERR, addr))
 		return;
 
 	clear_siginfo(&info);
-	info.si_signo = signr;
-	info.si_code = code;
+	info.si_signo = SIGSEGV;
+	info.si_code = SEGV_PKUERR;
 	info.si_addr = (void __user *) addr;
 	info.si_pkey = key;
 
-	force_sig_info(signr, &info, current);
+	force_sig_info(info.si_signo, &info, current);
 }
 
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a84d06b7d50d..406d0e0ef096 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -152,7 +152,7 @@ static int bad_key_fault_exception(struct pt_regs *regs, unsigned long address,
 	if (!user_mode(regs))
 		return SIGSEGV;
 
-	_exception_pkey(SIGSEGV, regs, SEGV_PKUERR, address, pkey);
+	_exception_pkey(regs, address, pkey);
 
 	return 0;
 }
-- 
2.17.1

