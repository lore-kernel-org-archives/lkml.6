Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1324EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9B92086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9B92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbeIXV3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:29:05 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44000 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeIXV3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:29:04 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Skf-0006jc-G4; Mon, 24 Sep 2018 09:26:21 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4SkP-00018i-Jc; Mon, 24 Sep 2018 09:26:21 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Guan Xuetao <gxt@pku.edu.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 17:25:35 +0200
Message-Id: <20180924152537.19515-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87lg7q2a2w.fsf@xmission.com>
References: <87lg7q2a2w.fsf@xmission.com>
X-XM-SPF: eid=1g4SkP-00018i-Jc;;;mid=<20180924152537.19515-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19FaO70DWVOhLQeSnawaeCrPtQg5UyAuIk=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 1/3] signal/unicore32: Use send_sig_fault where appropriate
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/unicore32/kernel/fpu-ucf64.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/unicore32/kernel/fpu-ucf64.c b/arch/unicore32/kernel/fpu-ucf64.c
index 8594b168f25e..fc5dad32a982 100644
--- a/arch/unicore32/kernel/fpu-ucf64.c
+++ b/arch/unicore32/kernel/fpu-ucf64.c
@@ -54,14 +54,6 @@
  */
 void ucf64_raise_sigfpe(struct pt_regs *regs)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-
-	info.si_signo = SIGFPE;
-	info.si_code = FPE_FLTUNK;
-	info.si_addr = (void __user *)(instruction_pointer(regs) - 4);
-
 	/*
 	 * This is the same as NWFPE, because it's not clear what
 	 * this is used for
@@ -69,7 +61,9 @@ void ucf64_raise_sigfpe(struct pt_regs *regs)
 	current->thread.error_code = 0;
 	current->thread.trap_no = 6;
 
-	send_sig_info(SIGFPE, &info, current);
+	send_sig_fault(SIGFPE, FPE_FLTUNK,
+		       (void __user *)(instruction_pointer(regs) - 4),
+		       current);
 }
 
 /*
-- 
2.17.1

