Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965224AbeBMPOj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:14:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965054AbeBMPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:14:36 -0500
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 2/4] perf annotate: Scan cpuid for s390 and save machine type
Date: Tue, 13 Feb 2018 16:14:17 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
References: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021315-0040-0000-0000-0000040F4CE8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021315-0041-0000-0000-000026131029
Message-Id: <20180213151419.80737-2-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802130180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scan the cpuid string and extract the type number for later
use.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
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
