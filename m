Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A53FECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7A420C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7A420C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbeIXSOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:14:04 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50626 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731264AbeIXSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:14:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Pin-0006mG-Qc; Mon, 24 Sep 2018 06:12:13 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Pim-0002Pv-8Y; Mon, 24 Sep 2018 06:12:13 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 14:11:27 +0200
Message-Id: <20180924121128.5983-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87pnx32j2p.fsf@xmission.com>
References: <87pnx32j2p.fsf@xmission.com>
X-XM-SPF: eid=1g4Pim-0002Pv-8Y;;;mid=<20180924121128.5983-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18tP2cGVa2xvu6mrxbWE+2vIHadrlBPfcc=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 3/4] signal/arm: Use send_sig_fault where appropriate
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/vfp/vfpmodule.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index dc7e6b50ef67..aa96cc5c9fe9 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -216,13 +216,6 @@ static struct notifier_block vfp_notifier_block = {
  */
 static void vfp_raise_sigfpe(unsigned int sicode, struct pt_regs *regs)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = SIGFPE;
-	info.si_code = sicode;
-	info.si_addr = (void __user *)(instruction_pointer(regs) - 4);
-
 	/*
 	 * This is the same as NWFPE, because it's not clear what
 	 * this is used for
@@ -230,7 +223,9 @@ static void vfp_raise_sigfpe(unsigned int sicode, struct pt_regs *regs)
 	current->thread.error_code = 0;
 	current->thread.trap_no = 6;
 
-	send_sig_info(SIGFPE, &info, current);
+	send_sig_fault(SIGFPE, sicode,
+		       (void __user *)(instruction_pointer(regs) - 4),
+		       current);
 }
 
 static void vfp_panic(char *reason, u32 inst)
-- 
2.17.1

