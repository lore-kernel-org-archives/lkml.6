Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1DAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4168A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4168A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeIXPMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:12:53 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37248 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbeIXPMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:12:53 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4MuC-0002uB-Cn; Mon, 24 Sep 2018 03:11:48 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4MuA-0002zU-VP; Mon, 24 Sep 2018 03:11:48 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 11:10:05 +0200
Message-Id: <20180924091015.4458-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
X-XM-SPF: eid=1g4MuA-0002zU-VP;;;mid=<20180924091015.4458-5-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19FvvGmT0/Xm0nQ56XJgkVw7QNo1T8G/aY=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 05/15] signal/arm64: Consolidate the two hwpoison cases in do_page_fault
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two cases are practically the same and use siginfo differently
from the other signals sent from do_page_fault.  So consolidate them
to make future changes easier.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/mm/fault.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 654a861c4bd0..0ddc8c6ba53b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -577,16 +577,16 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 */
 		si.si_signo	= SIGBUS;
 		si.si_code	= BUS_ADRERR;
-	} else if (fault & VM_FAULT_HWPOISON_LARGE) {
-		unsigned int hindex = VM_FAULT_GET_HINDEX(fault);
+	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
+		unsigned int lsb;
+
+		lsb = PAGE_SHIFT;
+		if (fault & VM_FAULT_HWPOISON_LARGE)
+			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
 
 		si.si_signo	= SIGBUS;
 		si.si_code	= BUS_MCEERR_AR;
-		si.si_addr_lsb	= hstate_index_to_shift(hindex);
-	} else if (fault & VM_FAULT_HWPOISON) {
-		si.si_signo	= SIGBUS;
-		si.si_code	= BUS_MCEERR_AR;
-		si.si_addr_lsb	= PAGE_SHIFT;
+		si.si_addr_lsb	= lsb;
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
-- 
2.17.1

