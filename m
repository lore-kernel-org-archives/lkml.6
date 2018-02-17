Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeBQLhj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:37:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51295 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeBQLhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:37:21 -0500
Date: Sat, 17 Feb 2018 03:37:10 -0800
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-eca0fa28cd0df7369701dbee0e30ddce19c039b8@git.kernel.org>
Cc: hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
        tmricht@linux.vnet.ibm.com, tglx@linutronix.de, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, tglx@linutronix.de,
        tmricht@linux.vnet.ibm.com, mingo@kernel.org, acme@redhat.com,
        hpa@zytor.com
In-Reply-To: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
References: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Provide detailed information on s390
 CPU
Git-Commit-ID: eca0fa28cd0df7369701dbee0e30ddce19c039b8
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

Commit-ID:  eca0fa28cd0df7369701dbee0e30ddce19c039b8
Gitweb:     https://git.kernel.org/tip/eca0fa28cd0df7369701dbee0e30ddce19c039b8
Author:     Thomas Richter <tmricht@linux.vnet.ibm.com>
AuthorDate: Tue, 13 Feb 2018 16:14:16 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 15:15:23 -0300

perf record: Provide detailed information on s390 CPU

When perf record ... is setup to record data, the s390 cpu information
was a fixed string "IBM/S390".

Replace this string with one containing more information about the
machine. The information included in the cpuid is a comma separated
list:

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
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180213151419.80737-1-tmricht@linux.vnet.ibm.com
[ Use scnprintf instead of strncat to fix build errors on gcc GNU C99 5.4.0 20160609 -march=zEC12 -m64 -mzarch -ggdb3 -O6 -std=gnu99 -fPIC -fno-omit-frame-pointer -funwind-tables -fstack-protector-all ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/header.c | 130 +++++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 9fa6c3e..a78064c 100644
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
@@ -13,16 +14,135 @@
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
+	int tpsize = 0, mdsize = 0, vssize = 0, mfsize = 0, atsize = 0;
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
+			while ((cp = strtok_r(line2, "\n ", &line2))) {
+				mfsize += scnprintf(manufacturer + mfsize,
+						    sizeof(manufacturer) - mfsize, "%s", cp);
+			}
+		}
+
+		if (!strncmp(line, SYSINFO_TYPE, strlen(SYSINFO_TYPE))) {
+			line2 = line + strlen(SYSINFO_TYPE);
+
+			while ((cp = strtok_r(line2, "\n ", &line2))) {
+				tpsize += scnprintf(type + tpsize,
+						    sizeof(type) - tpsize, "%s", cp);
+			}
+		}
+
+		if (!strncmp(line, SYSINFO_MODEL, strlen(SYSINFO_MODEL))) {
+			line2 = line + strlen(SYSINFO_MODEL);
+
+			while ((cp = strtok_r(line2, "\n ", &line2))) {
+				mdsize += scnprintf(model + mdsize, sizeof(type) - mdsize,
+						    "%s%s", model[0] ? "," : "", cp);
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
+				vssize += scnprintf(version + vssize,
+						    sizeof(version) - vssize, "%s", sep + 1);
+			}
+			if (!strncmp(cp, SRVLVL_AUTHORIZATION,
+				     strlen(SRVLVL_AUTHORIZATION))) {
+				char *sep = strchr(cp, '=');
+
+				atsize += scnprintf(authorization + atsize,
+						    sizeof(authorization) - atsize, "%s", sep + 1);
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
