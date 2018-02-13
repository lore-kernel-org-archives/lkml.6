Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965199AbeBMPOc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:14:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965054AbeBMPOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:14:30 -0500
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 1/4] perf record: Provide detailed information on s390 CPU
Date: Tue, 13 Feb 2018 16:14:16 +0100
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18021315-0040-0000-0000-0000040F4CE2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021315-0041-0000-0000-000026131023
Message-Id: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802130180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf record ... is setup to record data, the s390
cpu information was a fixed string "IBM/S390".

Replace this string with one containing more information
about the machine. The information included in the cpuid is
a comma separated list:
   manufacturer,type,model-capacity,model[,version,authorization]
with

- manufacturer: up to 16 byte name of the manufacturer (IBM).
- type: a four digit number refering to the machine
  generation.
- model-capacitiy: up to 16 characters describing number
  of cpus etc.
- model: up to 16 characters describing model.
- version: the CPU-MF counter facility version number,
  available on LPARs only, omitted on z/VM guests.
- authorization: the CPU-MF counter facility authorization level,
  available on LPARs only, omitted on z/VM guests.

Before:
[root@s8360047 perf]# ./perf record -- sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.001 MB perf.data (4 samples) ]
[root@s8360047 perf]# ./perf report --header | fgrep cpuid
 # cpuid : IBM/S390
[root@s8360047 perf]#

After:
[root@s35lp76 perf]# ./perf report --header|fgrep cpuid
 # cpuid : IBM,3906,704,M03,3.5,002f
[root@s35lp76 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/arch/s390/util/header.c | 126 +++++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 9fa6c3e5782c..3d29ba47edce 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -1,8 +1,9 @@
 /*
  * Implementation of get_cpuid().
  *
- * Copyright 2014 IBM Corp.
+ * Copyright IBM Corp. 2014, 2018
  * Author(s): Alexander Yarygin <yarygin@linux.vnet.ibm.com>
+ *	      Thomas Richter <tmricht@linux.vnet.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License (version 2 only)
@@ -13,16 +14,131 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <string.h>
+#include <ctype.h>
 
 #include "../../util/header.h"
+#include "../../util/util.h"
+
+#define SYSINFO_MANU	"Manufacturer:"
+#define SYSINFO_TYPE	"Type:"
+#define SYSINFO_MODEL	"Model:"
+#define SRVLVL_CPUMF	"CPU-MF:"
+#define SRVLVL_VERSION	"version="
+#define SRVLVL_AUTHORIZATION	"authorization="
+#define SYSINFO		"/proc/sysinfo"
+#define SRVLVL		"/proc/service_levels"
 
 int get_cpuid(char *buffer, size_t sz)
 {
-	const char *cpuid = "IBM/S390";
+	char *cp, *line = NULL, *line2;
+	char type[8], model[33], version[8], manufacturer[32], authorization[8];
+	int read;
+	unsigned long line_sz;
+	size_t nbytes;
+	FILE *sysinfo;
+
+	/*
+	 * Scan /proc/sysinfo line by line and read out values for
+	 * Manufacturer:, Type: and Model:, for example:
+	 * Manufacturer:    IBM
+	 * Type:            2964
+	 * Model:           702              N96
+	 * The first word is the Model Capacity and the second word is
+	 * Model (can be omitted). Both words have a maximum size of 16
+	 * bytes.
+	 */
+	memset(manufacturer, 0, sizeof(manufacturer));
+	memset(type, 0, sizeof(type));
+	memset(model, 0, sizeof(model));
+	memset(version, 0, sizeof(version));
+	memset(authorization, 0, sizeof(authorization));
+
+	sysinfo = fopen(SYSINFO, "r");
+	if (sysinfo == NULL)
+		return -1;
+
+	while ((read = getline(&line, &line_sz, sysinfo)) != -1) {
+		if (!strncmp(line, SYSINFO_MANU, strlen(SYSINFO_MANU))) {
+			line2 = line + strlen(SYSINFO_MANU);
+
+			while ((cp = strtok_r(line2, "\n ", &line2)))
+				strncat(manufacturer, cp, sizeof(manufacturer));
+		}
+
+		if (!strncmp(line, SYSINFO_TYPE, strlen(SYSINFO_TYPE))) {
+			line2 = line + strlen(SYSINFO_TYPE);
+
+			while ((cp = strtok_r(line2, "\n ", &line2)))
+				strncat(type, cp, sizeof(type));
+		}
+
+		if (!strncmp(line, SYSINFO_MODEL, strlen(SYSINFO_MODEL))) {
+			line2 = line + strlen(SYSINFO_MODEL);
+
+			while ((cp = strtok_r(line2, "\n ", &line2))) {
+				if (model[0])
+					strcat(model, ",");
+				if (strlen(model) + strlen(cp) < sizeof(model))
+					strncat(model, cp, strlen(cp));
+			}
+			break;
+		}
+	}
+	fclose(sysinfo);
 
-	if (strlen(cpuid) + 1 > sz)
+	/* Missing manufacturer, type or model information should not happen */
+	if (!manufacturer[0] || !type[0] || !model[0])
 		return -1;
 
-	strcpy(buffer, cpuid);
-	return 0;
+	/*
+	 * Scan /proc/service_levels and return the CPU-MF counter facility
+	 * version number and authorization level.
+	 * Optional, does not exist on z/VM guests.
+	 */
+	sysinfo = fopen(SRVLVL, "r");
+	if (sysinfo == NULL)
+		goto skip_sysinfo;
+	while ((read = getline(&line, &line_sz, sysinfo)) != -1) {
+		if (strncmp(line, SRVLVL_CPUMF, strlen(SRVLVL_CPUMF)))
+			continue;
+
+		line2 = line + strlen(SRVLVL_CPUMF);
+		while ((cp = strtok_r(line2, "\n ", &line2))) {
+			if (!strncmp(cp, SRVLVL_VERSION,
+				     strlen(SRVLVL_VERSION))) {
+				char *sep = strchr(cp, '=');
+
+				strncat(version, sep + 1, sizeof(version));
+			}
+			if (!strncmp(cp, SRVLVL_AUTHORIZATION,
+				     strlen(SRVLVL_AUTHORIZATION))) {
+				char *sep = strchr(cp, '=');
+
+				strncat(authorization, sep + 1,
+					sizeof(authorization));
+			}
+		}
+	}
+	fclose(sysinfo);
+
+skip_sysinfo:
+	free(line);
+
+	if (version[0] && authorization[0] )
+		nbytes = snprintf(buffer, sz, "%s,%s,%s,%s,%s",
+				  manufacturer, type, model, version,
+				  authorization);
+	else
+		nbytes = snprintf(buffer, sz, "%s,%s,%s", manufacturer, type,
+				  model);
+	return (nbytes >= sz) ? -1 : 0;
+}
+
+char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+{
+	char *buf = malloc(128);
+
+	if (buf && get_cpuid(buf, 128) < 0)
+		zfree(&buf);
+	return buf;
 }
-- 
2.14.3
