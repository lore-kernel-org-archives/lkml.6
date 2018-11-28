Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C910C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5DD2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5DD2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeK2B34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:29:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45807 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2B34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:29:56 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEQh8x2322891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:26:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEQhZ82322887;
        Wed, 28 Nov 2018 06:26:43 -0800
Date:   Wed, 28 Nov 2018 06:26:43 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-130d6f946f6f2a972ee3ec8540b7243ab99abe97@git.kernel.org>
Cc:     david.c.stewart@intel.com, longman9394@gmail.com,
        casey.schaufler@intel.com, jkosina@suse.cz,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, dwmw@amazon.co.uk, mingo@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        asit.k.mallick@intel.com, ak@linux.intel.com,
        arjan@linux.intel.com, keescook@chromium.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        jpoimboe@redhat.com, dave.hansen@intel.com,
        tim.c.chen@linux.intel.com, jcm@redhat.com, thomas.lendacky@amd.com
Reply-To: tim.c.chen@linux.intel.com, dave.hansen@intel.com,
          jcm@redhat.com, thomas.lendacky@amd.com, aarcange@redhat.com,
          jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
          keescook@chromium.org, luto@kernel.org, ak@linux.intel.com,
          arjan@linux.intel.com, hpa@zytor.com, asit.k.mallick@intel.com,
          mingo@kernel.org, gregkh@linuxfoundation.org, dwmw@amazon.co.uk,
          peterz@infradead.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, jkosina@suse.cz, longman9394@gmail.com,
          casey.schaufler@intel.com, david.c.stewart@intel.com
In-Reply-To: <20181125185004.613357354@linutronix.de>
References: <20181125185004.613357354@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/l1tf: Show actual SMT state
Git-Commit-ID: 130d6f946f6f2a972ee3ec8540b7243ab99abe97
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

Commit-ID:  130d6f946f6f2a972ee3ec8540b7243ab99abe97
Gitweb:     https://git.kernel.org/tip/130d6f946f6f2a972ee3ec8540b7243ab99abe97
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:40 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:08 +0100

x86/l1tf: Show actual SMT state

Use the now exposed real SMT state, not the SMT sysfs control knob
state. This reflects the state of the system when the mitigation status is
queried.

This does not change the warning in the VMX launch code. There the
dependency on the control knob makes sense because siblings could be
brought online anytime after launching the VM.

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
Link: https://lkml.kernel.org/r/20181125185004.613357354@linutronix.de


---
 arch/x86/kernel/cpu/bugs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5625b323ff32..2dc4ee2bedcb 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -832,13 +832,14 @@ static ssize_t l1tf_show_state(char *buf)
 
 	if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_EPT_DISABLED ||
 	    (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_NEVER &&
-	     cpu_smt_control == CPU_SMT_ENABLED))
+	     sched_smt_active())) {
 		return sprintf(buf, "%s; VMX: %s\n", L1TF_DEFAULT_MSG,
 			       l1tf_vmx_states[l1tf_vmx_mitigation]);
+	}
 
 	return sprintf(buf, "%s; VMX: %s, SMT %s\n", L1TF_DEFAULT_MSG,
 		       l1tf_vmx_states[l1tf_vmx_mitigation],
-		       cpu_smt_control == CPU_SMT_ENABLED ? "vulnerable" : "disabled");
+		       sched_smt_active() ? "vulnerable" : "disabled");
 }
 #else
 static ssize_t l1tf_show_state(char *buf)
