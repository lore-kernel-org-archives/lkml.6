Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968561AbeCSSI6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:08:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:62509 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968518AbeCSSIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330576"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH 06/15] x86/fsgsbase/64: Add putregs() to handle multiple elements' setting
Date: Mon, 19 Mar 2018 10:49:18 -0700
Message-Id: <1521481767-22113-7-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

putregs() can be used to handle multiple elements flexibly.

It is useful when inter-dependency lies in updating a
group of context entries. There will be a case with FSGSBASE.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Markus T. Metzger <markus.t.metzger@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/ptrace.c | 51 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index d8a1e1b..9c09bf0 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -421,6 +421,22 @@ static int putreg(struct task_struct *child,
 	return 0;
 }
 
+static int putregs(struct task_struct *child,
+		   unsigned int offset,
+		   unsigned int count,
+		   const unsigned long *values)
+{
+	const unsigned long *v = values;
+	int ret = 0;
+
+	while (count >= sizeof(*v) && !ret) {
+		ret = putreg(child, offset, *v++);
+		count -= sizeof(*v);
+		offset += sizeof(*v);
+	}
+	return ret;
+}
+
 static unsigned long getreg(struct task_struct *task, unsigned long offset)
 {
 	switch (offset) {
@@ -477,24 +493,37 @@ static int genregs_set(struct task_struct *target,
 		       const void *kbuf, const void __user *ubuf)
 {
 	int ret = 0;
+
 	if (kbuf) {
-		const unsigned long *k = kbuf;
-		while (count >= sizeof(*k) && !ret) {
-			ret = putreg(target, pos, *k++);
-			count -= sizeof(*k);
-			pos += sizeof(*k);
-		}
+		ret = putregs(target, pos, count, kbuf);
 	} else {
 		const unsigned long  __user *u = ubuf;
-		while (count >= sizeof(*u) && !ret) {
+		const unsigned long *genregs = NULL;
+		unsigned long *buf = NULL;
+		unsigned int remains = 0;
+
+		buf = kmalloc(count, GFP_KERNEL);
+
+		if (unlikely(!buf))
+			return -ENOMEM;
+
+		genregs = buf;
+		remains = count;
+
+		while (remains >= sizeof(*u) && !ret) {
 			unsigned long word;
+
 			ret = __get_user(word, u++);
-			if (ret)
+			if (unlikely(ret))
 				break;
-			ret = putreg(target, pos, word);
-			count -= sizeof(*u);
-			pos += sizeof(*u);
+			memcpy(buf++, &word, sizeof(*u));
+			remains -= sizeof(*u);
 		}
+
+		if (likely(!ret))
+			/* Allows to handle multiple elements accordingly. */
+			ret = putregs(target, pos, count, genregs);
+		kfree(genregs);
 	}
 	return ret;
 }
-- 
2.7.4
