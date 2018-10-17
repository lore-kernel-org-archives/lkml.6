Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D0DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173402148E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173402148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeJRCam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:30:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:29659 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbeJRC3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:29:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 11:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="82003901"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2018 11:32:57 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [Patch v3 07/13] x86/process Add arch_set_dumpable
Date:   Wed, 17 Oct 2018 10:59:35 -0700
Message-Id: <6c8538c428d6335efae926c1e6a6fd26a3f9a1b8.1539798901.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1539798901.git.tim.c.chen@linux.intel.com>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1539798901.git.tim.c.chen@linux.intel.com>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arch_set_dumpable for setting architecture specific security
modifications on processes according to its dumpable properties.
Non dumpable processes are security sensitive and they can be modified
to gain architecture specific security defenses via arch_set_dumpable.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 fs/exec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index e204830..6f329fc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1940,6 +1940,11 @@ void set_binfmt(struct linux_binfmt *new)
 }
 EXPORT_SYMBOL(set_binfmt);
 
+void __weak arch_set_dumpable(struct task_struct *tsk, unsigned int value)
+{
+	return;
+}
+
 /*
  * set_dumpable stores three-value SUID_DUMP_* into mm->flags.
  */
@@ -1956,6 +1961,7 @@ void set_dumpable(struct task_struct *tsk, unsigned int value)
 		old = READ_ONCE(tsk->mm->flags);
 		new = (old & ~MMF_DUMPABLE_MASK) | value;
 	} while (cmpxchg(&tsk->mm->flags, old, new) != old);
+	arch_set_dumpable(tsk, value);
 }
 
 SYSCALL_DEFINE3(execve,
-- 
2.9.4

