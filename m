Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13012C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8749208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8749208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeK2B2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:28:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2B2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:28:41 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEOxXd2322672
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:24:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEOxcn2322666;
        Wed, 28 Nov 2018 06:24:59 -0800
Date:   Wed, 28 Nov 2018 06:24:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-dbe733642e01dd108f71436aaea7b328cb28fd87@git.kernel.org>
Cc:     keescook@chromium.org, ak@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, casey.schaufler@intel.com,
        asit.k.mallick@intel.com, jcm@redhat.com, mingo@kernel.org,
        dave.hansen@intel.com, gregkh@linuxfoundation.org, luto@kernel.org,
        aarcange@redhat.com, jkosina@suse.cz,
        torvalds@linux-foundation.org, longman9394@gmail.com,
        dwmw@amazon.co.uk, hpa@zytor.com, david.c.stewart@intel.com,
        arjan@linux.intel.com, jpoimboe@redhat.com, peterz@infradead.org,
        thomas.lendacky@amd.com, tim.c.chen@linux.intel.com
Reply-To: david.c.stewart@intel.com, hpa@zytor.com, dwmw@amazon.co.uk,
          torvalds@linux-foundation.org, longman9394@gmail.com,
          tim.c.chen@linux.intel.com, thomas.lendacky@amd.com,
          peterz@infradead.org, arjan@linux.intel.com, jpoimboe@redhat.com,
          linux-kernel@vger.kernel.org, casey.schaufler@intel.com,
          asit.k.mallick@intel.com, keescook@chromium.org,
          tglx@linutronix.de, ak@linux.intel.com, aarcange@redhat.com,
          jkosina@suse.cz, gregkh@linuxfoundation.org, luto@kernel.org,
          jcm@redhat.com, mingo@kernel.org, dave.hansen@intel.com
In-Reply-To: <20181125185004.337452245@linutronix.de>
References: <20181125185004.337452245@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/Kconfig: Select SCHED_SMT if SMP enabled
Git-Commit-ID: dbe733642e01dd108f71436aaea7b328cb28fd87
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

Commit-ID:  dbe733642e01dd108f71436aaea7b328cb28fd87
Gitweb:     https://git.kernel.org/tip/dbe733642e01dd108f71436aaea7b328cb28fd87
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:37 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:07 +0100

x86/Kconfig: Select SCHED_SMT if SMP enabled

CONFIG_SCHED_SMT is enabled by all distros, so there is not a real point to
have it configurable. The runtime overhead in the core scheduler code is
minimal because the actual SMT scheduling parts are conditional on a static
key.

This allows to expose the scheduler's SMT state static key to the
speculation control code. Alternatively the scheduler's static key could be
made always available when CONFIG_SMP is enabled, but that's just adding an
unused static key to every other architecture for nothing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185004.337452245@linutronix.de


---
 arch/x86/Kconfig | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b5286ad2a982..8689e794a43c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1000,13 +1000,7 @@ config NR_CPUS
 	  to the kernel image.
 
 config SCHED_SMT
-	bool "SMT (Hyperthreading) scheduler support"
-	depends on SMP
-	---help---
-	  SMT scheduler support improves the CPU scheduler's decision making
-	  when dealing with Intel Pentium 4 chips with HyperThreading at a
-	  cost of slightly increased overhead in some places. If unsure say
-	  N here.
+	def_bool y if SMP
 
 config SCHED_MC
 	def_bool y
