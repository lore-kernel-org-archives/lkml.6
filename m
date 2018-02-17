Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeBQLh4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:37:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58361 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeBQLhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:37:54 -0500
Date: Sat, 17 Feb 2018 03:37:42 -0800
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-c59124fa59757fadc80ad881056a21f98c71b146@git.kernel.org>
Cc: hpa@zytor.com, heiko.carstens@de.ibm.com, tmricht@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, mingo@kernel.org,
        brueckner@linux.vnet.ibm.com, acme@redhat.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
        mingo@kernel.org, acme@redhat.com, brueckner@linux.vnet.ibm.com,
        tglx@linutronix.de, hpa@zytor.com, tmricht@linux.vnet.ibm.com,
        heiko.carstens@de.ibm.com
In-Reply-To: <20180213151419.80737-2-tmricht@linux.vnet.ibm.com>
References: <20180213151419.80737-2-tmricht@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Scan cpuid for s390 and save machine
 type
Git-Commit-ID: c59124fa59757fadc80ad881056a21f98c71b146
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

Commit-ID:  c59124fa59757fadc80ad881056a21f98c71b146
Gitweb:     https://git.kernel.org/tip/c59124fa59757fadc80ad881056a21f98c71b146
Author:     Thomas Richter <tmricht@linux.vnet.ibm.com>
AuthorDate: Tue, 13 Feb 2018 16:14:17 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 15:16:57 -0300

perf annotate: Scan cpuid for s390 and save machine type

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
index 8c72b44..01df9d8 100644
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
