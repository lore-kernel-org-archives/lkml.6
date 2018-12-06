Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C49C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D0A208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131930;
	bh=MaBBpAWMpYZgpQAWlIKHF2gFMboz1hZdvSLroX5LopU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p5A+0TmwmuDHmo3XRExfwyfLOGKLGjyCj9HFu0w910X89rSrPPWnz2wBq3SOLR9Qd
	 /toMlSKdkjIAOsB8Qkct/ThQ0OtlqtalKIvpaIyWn3SNFPdXJr2npxN6e5QYsq1P9x
	 aeJprvN7Y0RX6OnOdFVAEbT466WQ6SYQEX5oYq4w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D0A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLFVbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:31:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbeLFVbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:31:07 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2D8208E7;
        Thu,  6 Dec 2018 21:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131866;
        bh=MaBBpAWMpYZgpQAWlIKHF2gFMboz1hZdvSLroX5LopU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqQdov7AF0agb/YRuIUZACKOhI/KNIG1SASeIAZzga5DOCh2oQLuE1kv1P7F3/9uc
         7GD0cU3LOnUw7hEkkW23QUe6J7qPCrmVlQ/HljBT7TgmRh6nGBYt3hgK7Y1S3dQobU
         +SUAQ9XcoFBKkr9d6jQ9pevRTpjIIvheO/tvC8f0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-snps-arc@lists.infradead.org,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 71/75] perf annotate: Introduce basic support for ARC
Date:   Thu,  6 Dec 2018 18:25:58 -0300
Message-Id: <20181206212602.20474-72-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Introduce basic 'perf annotate' support for ARC to be able to use
anotation via stdio interface.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <vineet.gupta1@synopsys.com>
Link: http://lkml.kernel.org/r/20181204175118.25232-1-Eugeniy.Paltsev@synopsys.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 5f69fd0b745a..f3824ca7c20b 100644
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
index 51d291b0b81f..ac9805e0bc76 100644
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
2.19.2

