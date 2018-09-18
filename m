Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF26EECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CC52150C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CC52150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbeIRXdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:33:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37624 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbeIRXdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:33:20 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2KHg-0004OQ-2D; Tue, 18 Sep 2018 11:59:36 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2KHe-000459-Mg; Tue, 18 Sep 2018 11:59:35 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 19:58:45 +0200
Message-Id: <20180918175850.4437-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
X-XM-SPF: eid=1g2KHe-000459-Mg;;;mid=<20180918175850.4437-4-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/HxUtof/DDGRK9ZllL7rC4qgXcf8OMO+U=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 4/9] signal/powerpc: Remove pkey parameter from __bad_area_nosemaphore
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that bad_key_fault_exception no longer calls __bad_area_nosemaphore
there is no reason for __bad_area_nosemaphore to handle pkeys.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 5afc1ee55043..a84d06b7d50d 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -103,8 +103,7 @@ static bool store_updates_sp(unsigned int inst)
  */
 
 static int
-__bad_area_nosemaphore(struct pt_regs *regs, unsigned long address, int si_code,
-		int pkey)
+__bad_area_nosemaphore(struct pt_regs *regs, unsigned long address, int si_code)
 {
 	/*
 	 * If we are in kernel mode, bail out with a SEGV, this will
@@ -114,14 +113,14 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long address, int si_code,
 	if (!user_mode(regs))
 		return SIGSEGV;
 
-	_exception_pkey(SIGSEGV, regs, si_code, address, pkey);
+	_exception(SIGSEGV, regs, si_code, address);
 
 	return 0;
 }
 
 static noinline int bad_area_nosemaphore(struct pt_regs *regs, unsigned long address)
 {
-	return __bad_area_nosemaphore(regs, address, SEGV_MAPERR, 0);
+	return __bad_area_nosemaphore(regs, address, SEGV_MAPERR);
 }
 
 static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code)
@@ -134,7 +133,7 @@ static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code)
 	 */
 	up_read(&mm->mmap_sem);
 
-	return __bad_area_nosemaphore(regs, address, si_code, 0);
+	return __bad_area_nosemaphore(regs, address, si_code);
 }
 
 static noinline int bad_area(struct pt_regs *regs, unsigned long address)
-- 
2.17.1

