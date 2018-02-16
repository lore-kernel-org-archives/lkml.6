Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753883AbeBPTUR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752240AbeBPTUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:20:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D797217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/41] perf annotate: Scan cpuid for s390 and save machine type
Date: Fri, 16 Feb 2018 16:17:42 -0300
Message-Id: <20180216191746.11095-38-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

Scan the cpuid string and extract the type number for later use.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180213151419.80737-2-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 8c72b44444cb..01df9d8303e1 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -23,12 +23,37 @@ static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *na
 	return ops;
 }
 
+static int s390__cpuid_parse(struct arch *arch, char *cpuid)
+{
+	unsigned int family;
+	char model[16], model_c[16], cpumf_v[16], cpumf_a[16];
+	int ret;
+
+	/*
+	 * cpuid string format:
+	 * "IBM,family,model-capacity,model[,cpum_cf-version,cpum_cf-authorization]"
+	 */
+	ret = sscanf(cpuid, "%*[^,],%u,%[^,],%[^,],%[^,],%s", &family, model_c,
+		     model, cpumf_v, cpumf_a);
+	if (ret >= 2) {
+		arch->family = family;
+		arch->model = 0;
+		return 0;
+	}
+
+	return -1;
+}
+
 static int s390__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
+	int err = 0;
+
 	if (!arch->initialized) {
 		arch->initialized = true;
 		arch->associate_instruction_ops = s390__associate_ins_ops;
+		if (cpuid)
+			err = s390__cpuid_parse(arch, cpuid);
 	}
 
-	return 0;
+	return err;
 }
-- 
2.14.3
