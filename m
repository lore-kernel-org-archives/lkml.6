Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3721C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63324205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63324205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeIFRPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:15:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57187 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeIFRPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:15:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86CeQv6295349
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 05:40:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86CePdu295346;
        Thu, 6 Sep 2018 05:40:25 -0700
Date:   Thu, 6 Sep 2018 05:40:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-b7a5eb6aafa95fce45fc4dcbc195cb232fa1b76d@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jgross@suse.com
Reply-To: linux-kernel@vger.kernel.org, jgross@suse.com,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20180905053720.13710-1-jgross@suse.com>
References: <20180905053720.13710-1-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Prevent redefinition of SAVE_FLAGS
 macro
Git-Commit-ID: b7a5eb6aafa95fce45fc4dcbc195cb232fa1b76d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b7a5eb6aafa95fce45fc4dcbc195cb232fa1b76d
Gitweb:     https://git.kernel.org/tip/b7a5eb6aafa95fce45fc4dcbc195cb232fa1b76d
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Wed, 5 Sep 2018 07:37:20 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 6 Sep 2018 14:37:37 +0200

x86/paravirt: Prevent redefinition of SAVE_FLAGS macro

The PARAVIRT_XXL changes introduced a redefinition of SAVE_FLAGS under
certain configurations. Cure it

Fixes: 6da63eb241a0 ("x86/paravirt: Move the pv_irq_ops under the PARAVIRT_XXL umbrella").
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180905053720.13710-1-jgross@suse.com

---
 arch/x86/include/asm/paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 969343c72a9b..4bf42f9e4eea 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -914,7 +914,6 @@ extern void default_banner(void);
 	PARA_SITE(PARA_PATCH(PV_CPU_usergs_sysret64),			\
 		  ANNOTATE_RETPOLINE_SAFE;				\
 		  jmp PARA_INDIRECT(pv_ops+PV_CPU_usergs_sysret64);)
-#endif
 
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
@@ -924,6 +923,7 @@ extern void default_banner(void);
 		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);	    \
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 #endif
+#endif
 
 #endif	/* CONFIG_X86_32 */
 
