Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D643BECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F16214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F16214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeIRFmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:42:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33883 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeIRFmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:42:31 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23dD-0007oU-RX; Mon, 17 Sep 2018 18:12:43 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23ZW-0002Qk-7L; Mon, 17 Sep 2018 18:08:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:42 +0200
Message-Id: <20180918000546.12552-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23ZW-0002Qk-7L;;;mid=<20180918000546.12552-16-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/SQGK74cWsbgJ0S/6bIy3uepTZa9Nt3Fo=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 16/20] signal/x86: Pass pkey not vma into __bad_area
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one caller of __bad_area that passes in PKUERR and thus
will generate a siginfo with si_pkey set.  Therefore simplify the
logic and hoist reading of vma_pkey up into that caller, and just
pass *pkey into __bad_area.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/fault.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f82106578364..11a93f14a674 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -904,22 +904,16 @@ bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 
 static void
 __bad_area(struct pt_regs *regs, unsigned long error_code,
-	   unsigned long address,  struct vm_area_struct *vma, int si_code)
+	   unsigned long address, u32 *pkey, int si_code)
 {
 	struct mm_struct *mm = current->mm;
-	u32 pkey;
-
-	if (vma)
-		pkey = vma_pkey(vma);
-
 	/*
 	 * Something tried to access memory that isn't in our memory map..
 	 * Fix it, but check if it's kernel or user first..
 	 */
 	up_read(&mm->mmap_sem);
 
-	__bad_area_nosemaphore(regs, error_code, address,
-			       (vma) ? &pkey : NULL, si_code);
+	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code);
 }
 
 static noinline void
@@ -954,10 +948,12 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
 	 * But, doing it this way allows compiler optimizations
 	 * if pkeys are compiled out.
 	 */
-	if (bad_area_access_from_pkeys(error_code, vma))
-		__bad_area(regs, error_code, address, vma, SEGV_PKUERR);
+	if (bad_area_access_from_pkeys(error_code, vma)) {
+		u32 pkey = vma_pkey(vma);
+		__bad_area(regs, error_code, address, &pkey, SEGV_PKUERR);
+	}
 	else
-		__bad_area(regs, error_code, address, vma, SEGV_ACCERR);
+		__bad_area(regs, error_code, address, NULL, SEGV_ACCERR);
 }
 
 static void
-- 
2.17.1

