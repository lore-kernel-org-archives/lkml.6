Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756456AbeDXIJr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:09:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42795 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeDXIJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:09:40 -0400
Date: Tue, 24 Apr 2018 01:08:37 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-26d35ca6c3776784f8156e1d6f80cc60d9a2a915@git.kernel.org>
Cc: vbabka@suse.cz, torvalds@linux-foundation.org, jgross@suse.com,
        tglx@linutronix.de, peterz@infradead.org, hughd@google.com,
        aarcange@redhat.com, dan.j.williams@intel.com, jpoimboe@redhat.com,
        namit@vmware.com, gregkh@linuxfoundation.org, dwmw2@infradead.org,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        dave.hansen@linux.intel.com, mingo@kernel.org, keescook@google.com,
        bp@alien8.de, hpa@zytor.com
Reply-To: jgross@suse.com, vbabka@suse.cz, torvalds@linux-foundation.org,
        peterz@infradead.org, hughd@google.com, tglx@linutronix.de,
        dan.j.williams@intel.com, aarcange@redhat.com, namit@vmware.com,
        jpoimboe@redhat.com, arjan@linux.intel.com, gregkh@linuxfoundation.org,
        dwmw2@infradead.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com, keescook@google.com,
        bp@alien8.de, mingo@kernel.org
In-Reply-To: <20180420222026.D0B4AAC9@viggo.jf.intel.com>
References: <20180420222026.D0B4AAC9@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Disallow global kernel text with RANDSTRUCT
Git-Commit-ID: 26d35ca6c3776784f8156e1d6f80cc60d9a2a915
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  26d35ca6c3776784f8156e1d6f80cc60d9a2a915
Gitweb:     https://git.kernel.org/tip/26d35ca6c3776784f8156e1d6f80cc60d9a2a915
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 20 Apr 2018 15:20:26 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 24 Apr 2018 09:50:54 +0200

x86/pti: Disallow global kernel text with RANDSTRUCT

RANDSTRUCT derives its hardening benefits from the attacker's lack of
knowledge about the layout of kernel data structures.  Keep the kernel
image non-global in cases where RANDSTRUCT is in use to help keep the
layout a secret.

Fixes: 8c06c7740 (x86/pti: Leave kernel text global for !PCID)
Reported-by: Kees Cook <keescook@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Link: https://lkml.kernel.org/r/20180420222026.D0B4AAC9@viggo.jf.intel.com

---
 arch/x86/mm/pti.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ae3eb4f5d53b..4d418e705878 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -421,6 +421,16 @@ static inline bool pti_kernel_image_global_ok(void)
 	if (boot_cpu_has(X86_FEATURE_K8))
 		return false;
 
+	/*
+	 * RANDSTRUCT derives its hardening benefits from the
+	 * attacker's lack of knowledge about the layout of kernel
+	 * data structures.  Keep the kernel image non-global in
+	 * cases where RANDSTRUCT is in use to help keep the layout a
+	 * secret.
+	 */
+	if (IS_ENABLED(CONFIG_GCC_PLUGIN_RANDSTRUCT))
+		return false;
+
 	return true;
 }
 
