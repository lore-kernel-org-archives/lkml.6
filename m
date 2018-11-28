Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E42BC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD1B20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD1B20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeK2BYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:24:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50533 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeK2BYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:24:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEM3UN2320896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:22:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEM20E2320893;
        Wed, 28 Nov 2018 06:22:02 -0800
Date:   Wed, 28 Nov 2018 06:22:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tim Chen <tipbot@zytor.com>
Message-ID: <tip-a8f76ae41cd633ac00be1b3019b1eb4741be3828@git.kernel.org>
Cc:     thomas.lendacky@amd.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        david.c.stewart@intel.com, luto@kernel.org, dave.hansen@intel.com,
        gregkh@linuxfoundation.org, longman9394@gmail.com,
        jpoimboe@redhat.com, casey.schaufler@intel.com,
        peterz@infradead.org, arjan@linux.intel.com,
        asit.k.mallick@intel.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, hpa@zytor.com, jkosina@suse.cz,
        aarcange@redhat.com, jcm@redhat.com, tim.c.chen@linux.intel.com,
        keescook@chromium.org, ak@linux.intel.com
Reply-To: asit.k.mallick@intel.com, torvalds@linux-foundation.org,
          hpa@zytor.com, tglx@linutronix.de, casey.schaufler@intel.com,
          peterz@infradead.org, arjan@linux.intel.com, jcm@redhat.com,
          tim.c.chen@linux.intel.com, keescook@chromium.org,
          ak@linux.intel.com, jkosina@suse.cz, aarcange@redhat.com,
          dwmw@amazon.co.uk, linux-kernel@vger.kernel.org,
          mingo@kernel.org, david.c.stewart@intel.com,
          thomas.lendacky@amd.com, luto@kernel.org, dave.hansen@intel.com,
          longman9394@gmail.com, gregkh@linuxfoundation.org,
          jpoimboe@redhat.com
In-Reply-To: <20181125185003.874479208@linutronix.de>
References: <20181125185003.874479208@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Move STIPB/IBPB string conditionals
 out of cpu_show_common()
Git-Commit-ID: a8f76ae41cd633ac00be1b3019b1eb4741be3828
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

Commit-ID:  a8f76ae41cd633ac00be1b3019b1eb4741be3828
Gitweb:     https://git.kernel.org/tip/a8f76ae41cd633ac00be1b3019b1eb4741be3828
Author:     Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate: Sun, 25 Nov 2018 19:33:32 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:05 +0100

x86/speculation: Move STIPB/IBPB string conditionals out of cpu_show_common()

The Spectre V2 printout in cpu_show_common() handles conditionals for the
various mitigation methods directly in the sprintf() argument list. That's
hard to read and will become unreadable if more complex decisions need to
be made for a particular method.

Move the conditionals for STIBP and IBPB string selection into helper
functions, so they can be extended later on.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
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
Link: https://lkml.kernel.org/r/20181125185003.874479208@linutronix.de


---
 arch/x86/kernel/cpu/bugs.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b52a48966e01..a1502bce9eb8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -844,6 +844,22 @@ static ssize_t l1tf_show_state(char *buf)
 }
 #endif
 
+static char *stibp_state(void)
+{
+	if (x86_spec_ctrl_base & SPEC_CTRL_STIBP)
+		return ", STIBP";
+	else
+		return "";
+}
+
+static char *ibpb_state(void)
+{
+	if (boot_cpu_has(X86_FEATURE_USE_IBPB))
+		return ", IBPB";
+	else
+		return "";
+}
+
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			       char *buf, unsigned int bug)
 {
@@ -865,9 +881,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 
 	case X86_BUG_SPECTRE_V2:
 		return sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
-			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
+			       ibpb_state(),
 			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
-			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
+			       stibp_state(),
 			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
 			       spectre_v2_module_string());
 
