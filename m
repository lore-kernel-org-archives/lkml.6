Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44035C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82E020C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82E020C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeIRXcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:32:50 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45474 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeIRXcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:32:50 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2KHB-0004Hg-FY; Tue, 18 Sep 2018 11:59:05 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2KH9-000459-Ve; Tue, 18 Sep 2018 11:59:05 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 19:58:42 +0200
Message-Id: <20180918175850.4437-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
X-XM-SPF: eid=1g2KH9-000459-Ve;;;mid=<20180918175850.4437-1-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+K+59l2DAT5QPEFkH7W1rRn4JCL8LTWfQ=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 1/9] signal/powerpc: Use force_sig_mceerr as appropriate
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In do_sigbus isolate the mceerr signaling code and call
force_sig_mceerr instead of falling through to the force_sig_info that
works for all of the other signals.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/mm/fault.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index d51cf5f4e45e..22d7f8748cd7 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -158,7 +158,6 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 		     vm_fault_t fault)
 {
 	siginfo_t info;
-	unsigned int lsb = 0;
 
 	if (!user_mode(regs))
 		return SIGBUS;
@@ -171,17 +170,22 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 	info.si_addr = (void __user *)address;
 #ifdef CONFIG_MEMORY_FAILURE
 	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
+		unsigned int lsb = 0; /* shutup gcc */
+
 		pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
 			current->comm, current->pid, address);
-		info.si_code = BUS_MCEERR_AR;
+
+		if (fault & VM_FAULT_HWPOISON_LARGE)
+			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
+		if (fault & VM_FAULT_HWPOISON)
+			lsb = PAGE_SHIFT;
+
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb,
+				 current);
+		return 0;
 	}
 
-	if (fault & VM_FAULT_HWPOISON_LARGE)
-		lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
-	if (fault & VM_FAULT_HWPOISON)
-		lsb = PAGE_SHIFT;
 #endif
-	info.si_addr_lsb = lsb;
 	force_sig_info(SIGBUS, &info, current);
 	return 0;
 }
-- 
2.17.1

