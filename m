Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DDA21905
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXJ5xbwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390939AbeLUDny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 22:43:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39643 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388947AbeLUDnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 22:43:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so1845010pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 19:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EeenGLKaDJGDfnE0h9imP70AVCgJx02kmaiOoRX8Yq8=;
        b=NXJ5xbwINOBEtIvteLt8w25MSRkDVMdIfMbXPHKeVspgS3jUOudl5IdiD/DDgcviXg
         1nwCdLRvensWa9OZi0zfD9xvynPEOLYGF4wZsm3r+PsWP77mqtc2cqo3MvShU3VX7/Si
         TzqAr1AfDg0Of/I1kRkZhzbFYTvtDkjK1dlH4BwYbv2OnoKH3MSdYVEBh16Rviiperbp
         VjmqBVVHSe7lA4fV1V787Ph0vMNN3XJFktX/hyo5Yga/8fUHgdrZ0xODz6aMRAxWUh0m
         DZZPNWqAjEwkTkiisaVuVculfmB//vzPfPxakLfMQdG3/zXEmTS3qNO9E0P7780EJz00
         QSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EeenGLKaDJGDfnE0h9imP70AVCgJx02kmaiOoRX8Yq8=;
        b=cY1a2gm+A5f4PN3DGL7fEkBT4EvH4URGjZILTswgiAMOV1pEJmL5r+3tTeXYHeGAYO
         Y6jjAKGfbP1C4mX3zJQJfGL+/xzzoVkCzb7MqWQJtEJ/IRs+4HyjSjUGu7c+DNTjCy2X
         EgNNU0VZIkJncoIjBM7d7KIawy+rP8xvqbrr2wAwqX2nbO1mh68TitsgvuRiLrsp2xu3
         PD9Y/e9/h3XaWeZ/9Z1bwOP4dM87gMGJ/6O+V3UHydTbmkpvL3zMNmnsJc2Sgf5A0Xpw
         Abe0tE2n5rJg3G3tsvV+LVFQ49dZKAOQx96itARtkomXGmzUB/5CtjQS9/IjEmkiO8yv
         U6HQ==
X-Gm-Message-State: AJcUukcSpS8Nu95HyNieKu4DHUOQcNMrV5T/3SR8g4RLVBksjhT4Zmv0
        UBLsi+SXP9xcuaaI4Bfe5xDMkbCn
X-Google-Smtp-Source: ALg8bN6gKJM2LTJIhY0WUDqivdNi0xoVhZ+OpNVwdlQHSdtirO613NMKbU2GL80UB6g7HYNHLN9NIA==
X-Received: by 2002:a17:902:20c8:: with SMTP id v8mr878994plg.319.1545363829570;
        Thu, 20 Dec 2018 19:43:49 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q199sm39749695pfc.97.2018.12.20.19.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 19:43:48 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de
Subject: [PATCH v3 1/2] perf tools: Make find_vdso_map() more modular
Date:   Thu, 20 Dec 2018 19:43:36 -0800
Message-Id: <20181221034337.26663-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221034337.26663-1-f.fainelli@gmail.com>
References: <20181221034337.26663-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for checking that the vectors page on the ARM
architecture, refactor the find_vdso_map() function to accept finding an
arbitrary string and create a dedicated helper function for that under
util/find-map.c and update the filename to find-map.c and all references
to it: perf-read-vdso.c and util/vdso.c.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/perf/Makefile.perf                        | 4 ++--
 tools/perf/perf-read-vdso.c                     | 6 +++---
 tools/perf/util/{find-vdso-map.c => find-map.c} | 7 +++----
 tools/perf/util/vdso.c                          | 6 +++---
 4 files changed, 11 insertions(+), 12 deletions(-)
 rename tools/perf/util/{find-vdso-map.c => find-map.c} (71%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d95655489f7e..04e70a664adb 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -623,12 +623,12 @@ $(OUTPUT)perf-%: %.o $(PERFLIBS)
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
2.17.1

