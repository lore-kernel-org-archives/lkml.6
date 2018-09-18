Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0CCECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B8C20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B8C20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbeIRXdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:33:25 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45586 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbeIRXdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:33:25 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2KHl-0004MT-92; Tue, 18 Sep 2018 11:59:41 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2KHk-000459-6r; Tue, 18 Sep 2018 11:59:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 19:58:46 +0200
Message-Id: <20180918175850.4437-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
X-XM-SPF: eid=1g2KHk-000459-6r;;;mid=<20180918175850.4437-5-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19hgvm6eTuWBsAhxfDqGs9aIjmx5pZj+y8=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 5/9] signal/powerpc: Factor the common exception code into exception_common
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is brittle and wrong to populate si_pkey when there was not a pkey
exception.  The field does not exist for all si_codes and in some
cases another field exists in the same memory location.

So factor out the code that all exceptions handlers must run
into exception_common, leaving the individual exception handlers
to generate the signals themselves.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/kernel/traps.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f651fa91cdc9..f6c778b5144f 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -338,14 +338,12 @@ static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 	show_user_instructions(regs);
 }
 
-void _exception_pkey(int signr, struct pt_regs *regs, int code,
-		     unsigned long addr, int key)
+static bool exception_common(int signr, struct pt_regs *regs, int code,
+			      unsigned long addr)
 {
-	siginfo_t info;
-
 	if (!user_mode(regs)) {
 		die("Exception in kernel mode", regs, signr);
-		return;
+		return false;
 	}
 
 	show_signal_msg(signr, regs, code, addr);
@@ -361,6 +359,16 @@ void _exception_pkey(int signr, struct pt_regs *regs, int code,
 	 */
 	thread_pkey_regs_save(&current->thread);
 
+	return true;
+}
+
+void _exception_pkey(int signr, struct pt_regs *regs, int code, unsigned long addr, int key)
+{
+	siginfo_t info;
+
+	if (!exception_common(signr, regs, code, addr))
+		return;
+
 	clear_siginfo(&info);
 	info.si_signo = signr;
 	info.si_code = code;
-- 
2.17.1

