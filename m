Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD092ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16692086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16692086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbeIXV3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:29:12 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33460 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeIXV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:29:12 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Skn-0001sP-Ol; Mon, 24 Sep 2018 09:26:29 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Skm-00018i-Me; Mon, 24 Sep 2018 09:26:29 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Guan Xuetao <gxt@pku.edu.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 17:25:37 +0200
Message-Id: <20180924152537.19515-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87lg7q2a2w.fsf@xmission.com>
References: <87lg7q2a2w.fsf@xmission.com>
X-XM-SPF: eid=1g4Skm-00018i-Me;;;mid=<20180924152537.19515-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1//iqEvcyQjEopgY/2wIzqKKQ4cCU9wr5I=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 3/3] signal/unicore32: Use force_sig_fault where appropriate
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/unicore32/mm/fault.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index a942776110a0..b9a3a50644c1 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -120,17 +120,10 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		unsigned int fsr, unsigned int sig, int code,
 		struct pt_regs *regs)
 {
-	struct siginfo si;
-
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
-	clear_siginfo(&si);
-	si.si_signo = sig;
-	si.si_errno = 0;
-	si.si_code = code;
-	si.si_addr = (void __user *)addr;
-	force_sig_info(sig, &si, tsk);
+	force_sig_fault(sig, code, (void __user *)addr, tsk);
 }
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
-- 
2.17.1

