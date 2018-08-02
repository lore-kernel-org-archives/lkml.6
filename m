Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215DDC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C571420C0C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C571420C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeHBJgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:36:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726702AbeHBJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:36:37 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w727i5Xk081399
        for <linux-kernel@vger.kernel.org>; Thu, 2 Aug 2018 03:46:43 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kktprxqxs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 03:46:42 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Thu, 2 Aug 2018 08:46:41 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 Aug 2018 08:46:38 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w727kbKB42139816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Aug 2018 07:46:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7CC452054;
        Thu,  2 Aug 2018 10:46:47 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6AB4B5204E;
        Thu,  2 Aug 2018 10:46:47 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/3] perf auxtrace: Support for perf report -D for s390
Date:   Thu,  2 Aug 2018 09:46:20 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180802074622.13641-1-tmricht@linux.ibm.com>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080207-0012-0000-0000-00000292A106
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080207-0013-0000-0000-000020C4ACBA
Message-Id: <20180802074622.13641-2-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808020083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for s390 auxiliary traces using the
CPU-Measurement Sampling Facility.

Support and ignore PERF_REPORT_AUXTRACE_INFO records
in the perf data file. Later patches will show the contents
of the auxiliary traces.

Setup the auxtrace queues and data structures for s390.
A raw dump of the perf.data file now does not show
an error when an auxtrace event is encountered.

Output before:
[root@s35lp76 perf]# ./perf report -D -i perf.data.auxtrace
0x128 [0x10]: failed to process type: 70
Error:
failed to process sample

0x128 [0x10]: event: 70
.
. ... raw event: size 16 bytes
.  0000:  00 00 00 46 00 00 00 10 00 00 00 00 00 00 00 00  ...F............

0x128 [0x10]: PERF_RECORD_AUXTRACE_INFO type: 0
[root@s35lp76 perf]#

Output after:
 # ./perf report -D -i perf.data.auxtrace |fgrep PERF_RECORD_AUXTRACE
0 0 0x128 [0x10]: PERF_RECORD_AUXTRACE_INFO type: 5
0 0 0x25a66 [0x30]: PERF_RECORD_AUXTRACE size: 0x40000
	 offset: 0  ref: 0  idx: 4  tid: -1  cpu: 4
....

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/arch/s390/util/auxtrace.c |   1 +
 tools/perf/util/Build                |   1 +
 tools/perf/util/auxtrace.c           |   3 +
 tools/perf/util/auxtrace.h           |   1 +
 tools/perf/util/s390-cpumsf.c        | 123 +++++++++++++++++++++++++++
 tools/perf/util/s390-cpumsf.h        |  21 +++++
 6 files changed, 150 insertions(+)
 create mode 100644 tools/perf/util/s390-cpumsf.c
 create mode 100644 tools/perf/util/s390-cpumsf.h

diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 3afe8256eff2..44c857388897 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -30,6 +30,7 @@ cpumsf_info_fill(struct auxtrace_record *itr __maybe_unused,
 		 struct auxtrace_info_event *auxtrace_info __maybe_unused,
 		 size_t priv_size __maybe_unused)
 {
+	auxtrace_info->type = PERF_AUXTRACE_S390_CPUMSF;
 	return 0;
 }
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b604ef334dc9..7efe15b9618d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -87,6 +87,7 @@ libperf-$(CONFIG_AUXTRACE) += intel-pt.o
 libperf-$(CONFIG_AUXTRACE) += intel-bts.o
 libperf-$(CONFIG_AUXTRACE) += arm-spe.o
 libperf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
+libperf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
 
 ifdef CONFIG_LIBOPENCSD
 libperf-$(CONFIG_AUXTRACE) += cs-etm.o
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index d056447520a2..ae8c37b219c9 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -56,6 +56,7 @@
 #include "intel-pt.h"
 #include "intel-bts.h"
 #include "arm-spe.h"
+#include "s390-cpumsf.h"
 
 #include "sane_ctype.h"
 #include "symbol/kallsyms.h"
@@ -920,6 +921,8 @@ int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
 		return arm_spe_process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_CS_ETM:
 		return cs_etm__process_auxtrace_info(event, session);
+	case PERF_AUXTRACE_S390_CPUMSF:
+		return s390_cpumsf_process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index e731f55da072..71fc3bd74299 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -44,6 +44,7 @@ enum auxtrace_type {
 	PERF_AUXTRACE_INTEL_BTS,
 	PERF_AUXTRACE_CS_ETM,
 	PERF_AUXTRACE_ARM_SPE,
+	PERF_AUXTRACE_S390_CPUMSF,
 };
 
 enum itrace_period_type {
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
new file mode 100644
index 000000000000..e9a5ea21dbbf
--- /dev/null
+++ b/tools/perf/util/s390-cpumsf.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corp. 2018
+ * Auxtrace support for s390 CPU-Measurement Sampling Facility
+ *
+ * Author(s):  Thomas Richter <tmricht@linux.ibm.com>
+ */
+
+#include <endian.h>
+#include <errno.h>
+#include <byteswap.h>
+#include <inttypes.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/log2.h>
+
+#include "cpumap.h"
+#include "color.h"
+#include "evsel.h"
+#include "evlist.h"
+#include "machine.h"
+#include "session.h"
+#include "util.h"
+#include "thread.h"
+#include "debug.h"
+#include "auxtrace.h"
+#include "s390-cpumsf.h"
+
+struct s390_cpumsf {
+	struct auxtrace		auxtrace;
+	struct auxtrace_queues	queues;
+	struct auxtrace_heap	heap;
+	struct perf_session	*session;
+	struct machine		*machine;
+	u32			auxtrace_type;
+	u32			pmu_type;
+};
+
+static int
+s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
+			  union perf_event *event __maybe_unused,
+			  struct perf_sample *sample __maybe_unused,
+			  struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int
+s390_cpumsf_process_auxtrace_event(struct perf_session *session __maybe_unused,
+				   union perf_event *event __maybe_unused,
+				   struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int s390_cpumsf_flush(struct perf_session *session __maybe_unused,
+			     struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void s390_cpumsf_free_events(struct perf_session *session)
+{
+	struct s390_cpumsf *sf = container_of(session->auxtrace,
+					      struct s390_cpumsf,
+					       auxtrace);
+	struct auxtrace_queues *queues = &sf->queues;
+	unsigned int i;
+
+	for (i = 0; i < queues->nr_queues; i++)
+		zfree(&queues->queue_array[i].priv);
+	auxtrace_queues__free(queues);
+}
+
+static void s390_cpumsf_free(struct perf_session *session)
+{
+	struct s390_cpumsf *sf = container_of(session->auxtrace,
+					      struct s390_cpumsf,
+					      auxtrace);
+
+	auxtrace_heap__free(&sf->heap);
+	s390_cpumsf_free_events(session);
+	session->auxtrace = NULL;
+	free(sf);
+}
+
+int s390_cpumsf_process_auxtrace_info(union perf_event *event,
+				      struct perf_session *session)
+{
+	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
+	struct s390_cpumsf *sf;
+	int err;
+
+	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event))
+		return -EINVAL;
+
+	sf = zalloc(sizeof(struct s390_cpumsf));
+	if (sf == NULL)
+		return -ENOMEM;
+
+	err = auxtrace_queues__init(&sf->queues);
+	if (err)
+		goto err_free;
+
+	sf->session = session;
+	sf->machine = &session->machines.host; /* No kvm support */
+	sf->auxtrace_type = auxtrace_info->type;
+	sf->pmu_type = PERF_TYPE_RAW;
+
+	sf->auxtrace.process_event = s390_cpumsf_process_event;
+	sf->auxtrace.process_auxtrace_event = s390_cpumsf_process_auxtrace_event;
+	sf->auxtrace.flush_events = s390_cpumsf_flush;
+	sf->auxtrace.free_events = s390_cpumsf_free_events;
+	sf->auxtrace.free = s390_cpumsf_free;
+	session->auxtrace = &sf->auxtrace;
+
+	return 0;
+
+err_free:
+	free(sf);
+	return err;
+}
diff --git a/tools/perf/util/s390-cpumsf.h b/tools/perf/util/s390-cpumsf.h
new file mode 100644
index 000000000000..fb64d100555c
--- /dev/null
+++ b/tools/perf/util/s390-cpumsf.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright IBM Corp. 2018
+ * Auxtrace support for s390 CPU-Measurement Sampling Facility
+ *
+ * Author(s):  Thomas Richter <tmricht@linux.ibm.com>
+ */
+
+#ifndef INCLUDE__PERF_S390_CPUMSF_H
+#define INCLUDE__PERF_S390_CPUMSF_H
+
+union perf_event;
+struct perf_session;
+struct perf_pmu;
+
+struct auxtrace_record *
+s390_cpumsf_recording_init(int *err, struct perf_pmu *s390_cpumsf_pmu);
+
+int s390_cpumsf_process_auxtrace_info(union perf_event *event,
+				      struct perf_session *session);
+#endif
-- 
2.17.0

