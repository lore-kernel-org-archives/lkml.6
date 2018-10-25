Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A4DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E468720840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lue5j4W/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E468720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeJYTnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeJYTnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:43:07 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA8FE20840;
        Thu, 25 Oct 2018 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465849;
        bh=rFr+CU84yvXVQS6QDaz6qjL0HIxfEJefDUgOpki3jwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lue5j4W/cAnNpeLVRNQMHilANDTJorwO6BsuiY+Q2CXBUEi+VuToNHmNGfbbbfxbl
         dOqRngzMogm/sl0Xai7/CO1M/7rQFSIfJCXuSK9zYHep7d9vc+kKM4dIekHOfHhuZq
         0QIKXWIGVqqCP6d47i97O8/hqTGr7DiiiiOm7nVQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/37] perf annotate: Add Sparc support
Date:   Thu, 25 Oct 2018 08:09:56 -0300
Message-Id: <20181025111031.3440-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>

E.g.:

  $ perf annotate --stdio2
  Samples: 7K of event 'cycles:ppp', 4000 Hz, Event count (approx.): 3086733887
  __gettimeofday  /lib32/libc-2.27.so [Percent: local period]
  Percent│
         │
         │
         │    Disassembly of section .text:
         │
         │    000a6fa0 <__gettimeofday@@GLIBC_2.0>:
    0.47 │      save   %sp, -96, %sp
    0.73 │      sethi  %hi(0xe9000), %l7
         │    → call   __frame_state_for@@GLIBC_2.0+0x480
    0.30 │      add    %l7, 0x58, %l7     ! e9058 <nftw64@@GLIBC_2.3.3+0x818>
    1.33 │      mov    %i0, %o0
         │      mov    %i1, %o1
    0.43 │      mov    0x74, %g1
         │      ta     0x10
   88.92 │    ↓ bcc    30
    2.95 │      clr    %g1
         │      neg    %o0
         │      mov    1, %g1
    0.31 │30:   cmp    %g1, 0
         │      bne,pn %icc, a6fe4 <__gettimeofday@@GLIBC_2.0+0x44>
         │      mov    %o0, %i0
    1.96 │    ← return %i7 + 8
    2.62 │      nop
         │      sethi  %hi(0), %g1
         │      neg    %o0, %g2
         │      add    %g1, 0x160, %g1
         │      ld     [ %l7 + %g1 ], %g1
         │      st     %g2, [ %g7 + %g1 ]
         │    ← return %i7 + 8
         │      mov    -1, %o0

Signed-off-by: David S. Miller <davem@davemloft.net>
Link: http://lkml.kernel.org/r/20181016.205555.1070918198627611771.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/sparc/annotate/instructions.c | 169 ++++++++++++++++++++++++++
 tools/perf/util/annotate.c                    |   8 ++
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
2.14.4

