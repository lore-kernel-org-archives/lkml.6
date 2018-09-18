Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE830ECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CC2214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CC2214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeIRFhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:37:43 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46319 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeIRFhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:37:43 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Yb-0004SN-Qz; Mon, 17 Sep 2018 18:07:57 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Ya-0002Qk-CS; Mon, 17 Sep 2018 18:07:57 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:36 +0200
Message-Id: <20180918000546.12552-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23Ya-0002Qk-CS;;;mid=<20180918000546.12552-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+l1svm400BczbCko0MbZRtkO07jLedhaA=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 10/20] signal/x86/traps: Use force_sig instead of open coding it.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function "force_sig(sig, tsk)" is equivalent to "
force_sig_info(sig, SEND_SIG_PRIV, tsk)".  Using the siginfo variants can
be error prone so use the simpler old fashioned force_sig variant,
and with luck the force_sig_info variant can go away.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9f7b3831fb7e..3e4a3172d711 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -582,7 +582,7 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 	show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 
-	force_sig_info(SIGSEGV, SEND_SIG_PRIV, tsk);
+	force_sig(SIGSEGV, tsk);
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-- 
2.17.1

