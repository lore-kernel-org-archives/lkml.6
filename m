Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71155C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A8521480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A8521480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbeIXUYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:24:50 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33669 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbeIXUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:24:50 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Rkp-000678-8G; Mon, 24 Sep 2018 08:22:27 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Rko-000588-2N; Mon, 24 Sep 2018 08:22:26 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 16:21:42 +0200
Message-Id: <20180924142143.21356-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87pnx32j2p.fsf@xmission.com>
References: <87pnx32j2p.fsf@xmission.com>
X-XM-SPF: eid=1g4Rko-000588-2N;;;mid=<20180924142143.21356-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+vJAvvW8IaJOz/dC/jCxfpfVJIC687MI8=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 2/3] signal/ia64: Use the force_sig(SIGSEGV,...) in ia64_rt_sigreturn
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ia64 handling of failure to return from a signal frame has been trying
to set overlapping fields in struct siginfo since 2.3.43.  The si_code
corresponds to the fields that were stomped (not the field that is
actually written), so I can not imagine a piece of userspace code
making sense of the signal frame if it looks closely.

In practice failure to return from a signal frame is a rare event that
almost never happens.  Someone using an alternate signal stack to
recover and looking in detail is even more rare.  So I presume no one
has ever noticed and reported this ia64 nonsense.

Sort this out by causing ia64 to use force_sig(SIGSEGV) like other architectures.

Fixes: 2.3.43
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/ia64/kernel/signal.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/ia64/kernel/signal.c b/arch/ia64/kernel/signal.c
index 01fc133b2e4c..9a960829a01d 100644
--- a/arch/ia64/kernel/signal.c
+++ b/arch/ia64/kernel/signal.c
@@ -110,7 +110,6 @@ ia64_rt_sigreturn (struct sigscratch *scr)
 {
 	extern char ia64_strace_leave_kernel, ia64_leave_kernel;
 	struct sigcontext __user *sc;
-	struct siginfo si;
 	sigset_t set;
 	long retval;
 
@@ -153,14 +152,7 @@ ia64_rt_sigreturn (struct sigscratch *scr)
 	return retval;
 
   give_sigsegv:
-	clear_siginfo(&si);
-	si.si_signo = SIGSEGV;
-	si.si_errno = 0;
-	si.si_code = SI_KERNEL;
-	si.si_pid = task_pid_vnr(current);
-	si.si_uid = from_kuid_munged(current_user_ns(), current_uid());
-	si.si_addr = sc;
-	force_sig_info(SIGSEGV, &si, current);
+	force_sig(SIGSEGV, current);
 	return retval;
 }
 
-- 
2.17.1

