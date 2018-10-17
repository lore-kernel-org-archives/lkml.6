Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730A6C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007CE214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007CE214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeJQLth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:49:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34422 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeJQLtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:49:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 01089133E9F99;
        Tue, 16 Oct 2018 20:55:57 -0700 (PDT)
Date:   Tue, 16 Oct 2018 20:55:55 -0700 (PDT)
Message-Id: <20181016.205555.1070918198627611771.davem@davemloft.net>
To:     acme@redhat.com
CC:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf: Add Sparc annotate support.
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 16 Oct 2018 20:55:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 tools/perf/arch/sparc/annotate/instructions.c | 169 ++++++++++++++++++
 tools/perf/util/annotate.c                    |   8 +
 2 files changed, 177 insertions(+)
 create mode 100644 tools/perf/arch/sparc/annotate/instructions.c

diff --git a/tools/perf/arch/sparc/annotate/instructions.c b/tools/perf/arch/sparc/annotate/instructions.c
new file mode 100644
index 000000000000..2614c010c235
--- /dev/null
+++ b/tools/perf/arch/sparc/annotate/instructions.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+
+static int is_branch_cond(const char *cond)
+{
+	if (cond[0] == '\0')
+		return 1;
+
+	if (cond[0] == 'a' && cond[1] == '\0')
+		return 1;
+
+	if (cond[0] == 'c' &&
+	    (cond[1] == 'c' || cond[1] == 's') &&
+	    cond[2] == '\0')
+		return 1;
+
+	if (cond[0] == 'e' &&
+	    (cond[1] == '\0' ||
+	     (cond[1] == 'q' && cond[2] == '\0')))
+		return 1;
+
+	if (cond[0] == 'g' &&
+	    (cond[1] == '\0' ||
+	     (cond[1] == 't' && cond[2] == '\0') ||
+	     (cond[1] == 'e' && cond[2] == '\0') ||
+	     (cond[1] == 'e' && cond[2] == 'u' && cond[3] == '\0')))
+		return 1;
+
+	if (cond[0] == 'l' &&
+	    (cond[1] == '\0' ||
+	     (cond[1] == 't' && cond[2] == '\0') ||
+	     (cond[1] == 'u' && cond[2] == '\0') ||
+	     (cond[1] == 'e' && cond[2] == '\0') ||
+	     (cond[1] == 'e' && cond[2] == 'u' && cond[3] == '\0')))
+		return 1;
+
+	if (cond[0] == 'n' &&
+	    (cond[1] == '\0' ||
+	     (cond[1] == 'e' && cond[2] == '\0') ||
+	     (cond[1] == 'z' && cond[2] == '\0') ||
+	     (cond[1] == 'e' && cond[2] == 'g' && cond[3] == '\0')))
+		return 1;
+
+	if (cond[0] == 'b' &&
+	    cond[1] == 'p' &&
+	    cond[2] == 'o' &&
+	    cond[3] == 's' &&
+	    cond[4] == '\0')
+		return 1;
+
+	if (cond[0] == 'v' &&
+	    (cond[1] == 'c' || cond[1] == 's') &&
+	    cond[2] == '\0')
+		return 1;
+
+	if (cond[0] == 'b' &&
+	    cond[1] == 'z' &&
+	    cond[2] == '\0')
+		return 1;
+
+	return 0;
+}
+
+static int is_branch_reg_cond(const char *cond)
+{
+	if ((cond[0] == 'n' || cond[0] == 'l') &&
+	    cond[1] == 'z' &&
+	    cond[2] == '\0')
+		return 1;
+
+	if (cond[0] == 'z' &&
+	    cond[1] == '\0')
+		return 1;
+
+	if ((cond[0] == 'g' || cond[0] == 'l') &&
+	    cond[1] == 'e' &&
+	    cond[2] == 'z' &&
+	    cond[3] == '\0')
+		return 1;
+
+	if (cond[0] == 'g' &&
+	    cond[1] == 'z' &&
+	    cond[2] == '\0')
+		return 1;
+
+	return 0;
+}
+
+static int is_branch_float_cond(const char *cond)
+{
+	if (cond[0] == '\0')
+		return 1;
+
+	if ((cond[0] == 'a' || cond[0] == 'e' ||
+	     cond[0] == 'z' || cond[0] == 'g' ||
+	     cond[0] == 'l' || cond[0] == 'n' ||
+	     cond[0] == 'o' || cond[0] == 'u') &&
+	    cond[1] == '\0')
+		return 1;
+
+	if (((cond[0] == 'g' && cond[1] == 'e') ||
+	     (cond[0] == 'l' && (cond[1] == 'e' ||
+				 cond[1] == 'g')) ||
+	     (cond[0] == 'n' && (cond[1] == 'e' ||
+				 cond[1] == 'z')) ||
+	     (cond[0] == 'u' && (cond[1] == 'e' ||
+				 cond[1] == 'g' ||
+				 cond[1] == 'l'))) &&
+	    cond[2] == '\0')
+		return 1;
+
+	if (cond[0] == 'u' &&
+	    (cond[1] == 'g' || cond[1] == 'l') &&
+	    cond[2] == 'e' &&
+	    cond[3] == '\0')
+		return 1;
+
+	return 0;
+}
+
+static struct ins_ops *sparc__associate_instruction_ops(struct arch *arch, const char *name)
+{
+	struct ins_ops *ops = NULL;
+
+	if (!strcmp(name, "call") ||
+	    !strcmp(name, "jmp") ||
+	    !strcmp(name, "jmpl")) {
+		ops = &call_ops;
+	} else if (!strcmp(name, "ret") ||
+		   !strcmp(name, "retl") ||
+		   !strcmp(name, "return")) {
+		ops = &ret_ops;
+	} else if (!strcmp(name, "mov")) {
+		ops = &mov_ops;
+	} else {
+		if (name[0] == 'c' &&
+		    (name[1] == 'w' || name[1] == 'x'))
+			name += 2;
+
+		if (name[0] == 'b') {
+			const char *cond = name + 1;
+
+			if (cond[0] == 'r') {
+				if (is_branch_reg_cond(cond + 1))
+					ops = &jump_ops;
+			} else if (is_branch_cond(cond)) {
+				ops = &jump_ops;
+			}
+		} else if (name[0] == 'f' && name[1] == 'b') {
+			if (is_branch_float_cond(name + 2))
+				ops = &jump_ops;
+		}
+	}
+
+	if (ops)
+		arch__associate_ins_ops(arch, name, ops);
+
+	return ops;
+}
+
+static int sparc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+{
+	if (!arch->initialized) {
+		arch->initialized = true;
+		arch->associate_instruction_ops = sparc__associate_instruction_ops;
+		arch->objdump.comment_char = '#';
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 28cd6a17491b..6936daf89ddd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -139,6 +139,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 #include "arch/x86/annotate/instructions.c"
 #include "arch/powerpc/annotate/instructions.c"
 #include "arch/s390/annotate/instructions.c"
+#include "arch/sparc/annotate/instructions.c"
 
 static struct arch architectures[] = {
 	{
@@ -170,6 +171,13 @@ static struct arch architectures[] = {
 			.comment_char = '#',
 		},
 	},
+	{
+		.name = "sparc",
+		.init = sparc__annotate_init,
+		.objdump = {
+			.comment_char = '#',
+		},
+	},
 };
 
 static void ins__delete(struct ins_operands *ops)
-- 
2.19.1.328.g5a0cc8aca

