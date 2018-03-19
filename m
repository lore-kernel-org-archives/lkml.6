Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968573AbeCSSJC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:09:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:62511 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968521AbeCSSIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330580"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com,
        "Markus T . Metzger" <markus.t.metzgar@intel.com>
Subject: [PATCH 07/15] x86/fsgsbase/64: putregs() in a reverse order
Date: Mon, 19 Mar 2018 10:49:19 -0700
Message-Id: <1521481767-22113-8-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a walk of user_regs_struct reversely. Main
reason for doing this is to put FS/GS base setting after
the selector.

Each element is independently set now. When FS/GS base is
(only) updated, its index is reset to zero. In putregs(),
it does not reset when both FS/GS base and selector are
covered.

When FSGSBASE is enabled, an arbitrary base value is possible
anyways, so it is going to be reasonable to write base lastly.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Markus T. Metzger <markus.t.metzgar@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/ptrace.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 9c09bf0..ee37e28 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -426,14 +426,56 @@ static int putregs(struct task_struct *child,
 		   unsigned int count,
 		   const unsigned long *values)
 {
-	const unsigned long *v = values;
+	const unsigned long *v = values + count / sizeof(unsigned long);
 	int ret = 0;
+#ifdef CONFIG_X86_64
+	bool fs_fully_covered = (offset <= USER_REGS_OFFSET(fs_base)) &&
+			((offset + count) >= USER_REGS_OFFSET(fs));
+	bool gs_fully_covered = (offset <= USER_REGS_OFFSET(gs_base)) &&
+			((offset + count) >= USER_REGS_OFFSET(gs));
+
+	offset += count - sizeof(*v);
+
+	while (count >= sizeof(*v) && !ret) {
+		v--;
+		switch (offset) {
+		case USER_REGS_OFFSET(fs_base):
+			if (fs_fully_covered) {
+				if (unlikely(*v >= TASK_SIZE_MAX))
+					return -EIO;
+				/*
+				 * When changing both %fs (index) and %fsbase
+				 * write_task_fsbase() tends to overwrite
+				 * task's %fs. Simply setting base only here.
+				 */
+				if (child->thread.fsbase != *v)
+					child->thread.fsbase = *v;
+				break;
+			}
+		case USER_REGS_OFFSET(gs_base):
+			if (gs_fully_covered) {
+				if (unlikely(*v >= TASK_SIZE_MAX))
+					return -EIO;
+				/* Same here as the %fs handling above */
+				if (child->thread.gsbase != *v)
+					child->thread.gsbase = *v;
+				break;
+			}
+		default:
+			ret = putreg(child, offset, *v);
+		}
+		count -= sizeof(*v);
+		offset -= sizeof(*v);
+	}
+#else
 
+	offset += count - sizeof(*v);
 	while (count >= sizeof(*v) && !ret) {
-		ret = putreg(child, offset, *v++);
+		ret = putreg(child, offset, *(--v));
 		count -= sizeof(*v);
-		offset += sizeof(*v);
+		offset -= sizeof(*v);
 	}
+#endif /* CONFIG_X86_64 */
 	return ret;
 }
 
-- 
2.7.4
