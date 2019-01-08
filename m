Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF777C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B88217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977576;
	bh=p3w1h77NVZ+RgMJ/K6mUHvknz55aaq/hKqyhsvA2g1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Doff1hQzsmK8Aq6fu5O8bd7h2Q8OHNv8PG2BFk5U735wd8MN2ElPpc2ylSuu9ETW9
	 chQg1iiZQYadrFF/vnnZ6SaQ/T5uFojnxNGCBTr8ZZmpJEki59+A5dQPAD2KdroWes
	 2VyilrdlvHhaMLEG/DdmyJWIEmHLNL4OS2vx8YAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfAHT7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730544AbfAHT7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:59:33 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA48214C6;
        Tue,  8 Jan 2019 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977572;
        bh=p3w1h77NVZ+RgMJ/K6mUHvknz55aaq/hKqyhsvA2g1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/o0RxOakxdP6HE2zFNwCirw4rWP/wpaYZnhRt9OWtzZYo2qXXib9SQPLAWfovc2H
         TEcj/WRlCQn9xk56S0wVBgdmgG+Kvbb1Iu33ngCJlLqdlphDEkwyvAlINy8pUOBa+U
         6WmqOp1+W4l0CIcHY76evPZJgoJnPLm07Kjvp44s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Chris Healy <cphealy@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/16] perf tools: Make find_vdso_map() more modular
Date:   Tue,  8 Jan 2019 16:58:57 -0300
Message-Id: <20190108195910.17726-4-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

In preparation for checking that the vectors page on the ARM
architecture, refactor the find_vdso_map() function to accept finding an
arbitrary string and create a dedicated helper function for that under
util/find-map.c and update the filename to find-map.c and all references
to it: perf-read-vdso.c and util/vdso.c.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20181221034337.26663-2-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                        | 4 ++--
 tools/perf/perf-read-vdso.c                     | 6 +++---
 tools/perf/util/{find-vdso-map.c => find-map.c} | 7 +++----
 tools/perf/util/vdso.c                          | 6 +++---
 4 files changed, 11 insertions(+), 12 deletions(-)
 rename tools/perf/util/{find-vdso-map.c => find-map.c} (71%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2921f829a0f4..0ee6795d82cc 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -662,12 +662,12 @@ $(OUTPUT)perf-%: %.o $(PERFLIBS)
 	$(QUIET_LINK)$(CC) $(CFLAGS) -o $@ $(LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 ifndef NO_PERF_READ_VDSO32
-$(OUTPUT)perf-read-vdso32: perf-read-vdso.c util/find-vdso-map.c
+$(OUTPUT)perf-read-vdso32: perf-read-vdso.c util/find-map.c
 	$(QUIET_CC)$(CC) -m32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
 endif
 
 ifndef NO_PERF_READ_VDSOX32
-$(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-vdso-map.c
+$(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
 	$(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
 endif
 
diff --git a/tools/perf/perf-read-vdso.c b/tools/perf/perf-read-vdso.c
index 8c0ca0cc428f..aaa5210ea84a 100644
--- a/tools/perf/perf-read-vdso.c
+++ b/tools/perf/perf-read-vdso.c
@@ -5,17 +5,17 @@
 #define VDSO__MAP_NAME "[vdso]"
 
 /*
- * Include definition of find_vdso_map() also used in util/vdso.c for
+ * Include definition of find_map() also used in util/vdso.c for
  * building perf.
  */
-#include "util/find-vdso-map.c"
+#include "util/find-map.c"
 
 int main(void)
 {
 	void *start, *end;
 	size_t size, written;
 
-	if (find_vdso_map(&start, &end))
+	if (find_map(&start, &end, VDSO__MAP_NAME))
 		return 1;
 
 	size = end - start;
diff --git a/tools/perf/util/find-vdso-map.c b/tools/perf/util/find-map.c
similarity index 71%
rename from tools/perf/util/find-vdso-map.c
rename to tools/perf/util/find-map.c
index d7823e3508fc..7b2300588ece 100644
--- a/tools/perf/util/find-vdso-map.c
+++ b/tools/perf/util/find-map.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-static int find_vdso_map(void **start, void **end)
+static int find_map(void **start, void **end, const char *name)
 {
 	FILE *maps;
 	char line[128];
@@ -7,7 +7,7 @@ static int find_vdso_map(void **start, void **end)
 
 	maps = fopen("/proc/self/maps", "r");
 	if (!maps) {
-		fprintf(stderr, "vdso: cannot open maps\n");
+		fprintf(stderr, "cannot open maps\n");
 		return -1;
 	}
 
@@ -21,8 +21,7 @@ static int find_vdso_map(void **start, void **end)
 		if (m < 0)
 			continue;
 
-		if (!strncmp(&line[m], VDSO__MAP_NAME,
-			     sizeof(VDSO__MAP_NAME) - 1))
+		if (!strncmp(&line[m], name, strlen(name)))
 			found = 1;
 	}
 
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 741af209b19d..3702cba11d7d 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -18,10 +18,10 @@
 #include "debug.h"
 
 /*
- * Include definition of find_vdso_map() also used in perf-read-vdso.c for
+ * Include definition of find_map() also used in perf-read-vdso.c for
  * building perf-read-vdso32 and perf-read-vdsox32.
  */
-#include "find-vdso-map.c"
+#include "find-map.c"
 
 #define VDSO__TEMP_FILE_NAME "/tmp/perf-vdso.so-XXXXXX"
 
@@ -76,7 +76,7 @@ static char *get_file(struct vdso_file *vdso_file)
 	if (vdso_file->found)
 		return vdso_file->temp_file_name;
 
-	if (vdso_file->error || find_vdso_map(&start, &end))
+	if (vdso_file->error || find_map(&start, &end, VDSO__MAP_NAME))
 		return NULL;
 
 	size = end - start;
-- 
2.20.1

