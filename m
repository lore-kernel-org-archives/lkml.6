Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE67DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7281820850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y9sY34iV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7281820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeLDRva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:51:30 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:35012 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeLDRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:51:30 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 601E810C0752;
        Tue,  4 Dec 2018 09:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543945889; bh=fmcoTSpyjVjlC+ZNuckSF5P/38d+2o5sC0i0xx6smWk=;
        h=From:To:Cc:Subject:Date:From;
        b=Y9sY34iVyrfh7DLNGgi5k/3I+dPSbqA2o+5gxDq7OvM20tji0YK4l6JYG8ki98Y6y
         WeQ1JzJkGJYp5i0y8rZ1K5E8pUZEsvwDmorxFR9VjleLK4Zv02Yz7q55kvL++U5OWx
         CjAvfr4F9Daan+0zGLEyRDWzQmdw6UM691ARlAUdDqAfjVdQIjaH9hcRhaWiVW2nRo
         LWhRkD1OmJHDrpRo2F39NgC3lHMkkbEn5VTA4CU24QE2HrHrurRlBH3LunAhI890vw
         Rd2HmWQUByrLJ15RApwY8m8qW//pOdT7n9W6aN5WyWYGcADI0jb0n/JTZshJbk0Mch
         xrZboJ+wValMQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id C1FD93822;
        Tue,  4 Dec 2018 09:51:24 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: introduce basic 'perf annotate' support for ARC
Date:   Tue,  4 Dec 2018 20:51:18 +0300
Message-Id: <20181204175118.25232-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce basic 'perf annotate' support for ARC to be able
to use anotation via stdio interface.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 tools/perf/arch/arc/annotate/instructions.c |  9 +++++++++
 tools/perf/arch/common.c                    | 11 ++++++++++-
 tools/perf/util/annotate.c                  |  5 +++++
 3 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/arc/annotate/instructions.c

diff --git a/tools/perf/arch/arc/annotate/instructions.c b/tools/perf/arch/arc/annotate/instructions.c
new file mode 100644
index 000000000000..2f00e995c7e3
--- /dev/null
+++ b/tools/perf/arch/arc/annotate/instructions.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+
+static int arc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+{
+	arch->initialized = true;
+	arch->objdump.comment_char = ';';
+	return 0;
+}
diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 82657c01a3b8..f7cb57c424d1 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -5,6 +5,13 @@
 #include "../util/util.h"
 #include "../util/debug.h"
 
+const char *const arc_triplets[] = {
+	"arc-linux-",
+	"arc-snps-linux-uclibc-",
+	"arc-snps-linux-gnu-",
+	NULL
+};
+
 const char *const arm_triplets[] = {
 	"arm-eabi-",
 	"arm-linux-androideabi-",
@@ -147,7 +154,9 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		zfree(&buf);
 	}
 
-	if (!strcmp(arch, "arm"))
+	if (!strcmp(arch, "arc"))
+		path_list = arc_triplets;
+	else if (!strcmp(arch, "arm"))
 		path_list = arm_triplets;
 	else if (!strcmp(arch, "arm64"))
 		path_list = arm64_triplets;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 6936daf89ddd..66066fb4d644 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -134,6 +134,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 	return 0;
 }
 
+#include "arch/arc/annotate/instructions.c"
 #include "arch/arm/annotate/instructions.c"
 #include "arch/arm64/annotate/instructions.c"
 #include "arch/x86/annotate/instructions.c"
@@ -142,6 +143,10 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 #include "arch/sparc/annotate/instructions.c"
 
 static struct arch architectures[] = {
+	{
+		.name = "arc",
+		.init = arc__annotate_init,
+	},
 	{
 		.name = "arm",
 		.init = arm__annotate_init,
-- 
2.14.5

