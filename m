Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0BDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BA321905
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY9pc8Nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390951AbeLUDnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 22:43:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41509 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390930AbeLUDnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 22:43:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so1842521plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 19:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9mhHGO13bVohChjIAZJCbUoJwXKO5hCdLnoJYxQkBt4=;
        b=gY9pc8NrEY2ez0EwC3oTovmvZl45qh9Bow/av7Hhbdxi1AvwxCcrihQAJfVZ8hARx9
         n1MKK1yF7HJw96O35uzWli9Q4yJYD3ketoDhIEaghfMUDNj0pdVc0dmrUzqEF3eoFd5Y
         NgpMN7FgLnUrakaWna9Mn52q56HUoB5mBudEY8C0M3PV8e9F3CMNE1aUKEj9G42A3t03
         Jps0tS8DZfcH4cBoqghjPk1XrtUU6JTh6a/yg3pfUSKh0JOAOFJxAncQnVwLW7s7K1bw
         dkOb4oWfBaIkbKb9XVj5TYUQoH8peTRaXh166kt5JQeH61LG0dOKW0QDAXfkpWvKieye
         OGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9mhHGO13bVohChjIAZJCbUoJwXKO5hCdLnoJYxQkBt4=;
        b=smmGq3IxJTcI/YufR0j2gk/4Xc8xm08T8dm5hxZB/gCoN0qazqbkaUwAPnKK2AjGSn
         quqgXCDvq6iXOgQ8UVGDEqXfe3Fknnh8jwjoRlC1AUFLIf6yaf+0+XfurCZq+nbRClRH
         oDA2CyJN2+h6awVuclgot4X2fshbuhS1kwVfnUNQl8klr7DTYiQAV7CAzdJ+vQL2ji/6
         YMbna8UfKNy7NI64RCOJVeUeUcXysoU0Jd1q7xxiGYQj9N+D0p9HRbEZvesclK8A9vf7
         2I6TwBtHazZvzLc8rmHMZ2uSfxy5uLwd9d6zO3m2ZABVPiqYL+QoNt721JjJzOqPlqxA
         Y/1A==
X-Gm-Message-State: AJcUukfrzMyHYm8cWOUiPW/2hT2DStESozfWwYYPWFbQOMMuPElOE0UE
        2lHv25imjDqA222Ot3TonalMJH4h
X-Google-Smtp-Source: ALg8bN7KIcJ4277OOXDG68Hvw1rPa4aghzJR88ltHfVhc4SJTCGx4q7CTONkEP4ReWtHNmj1RujUMQ==
X-Received: by 2002:a17:902:145:: with SMTP id 63mr899003plb.256.1545363831247;
        Thu, 20 Dec 2018 19:43:51 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q199sm39749695pfc.97.2018.12.20.19.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 19:43:50 -0800 (PST)
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
Subject: [PATCH v3 2/2] perf tests: Add a test for the ARM 32-bit [vectors] page
Date:   Thu, 20 Dec 2018 19:43:37 -0800
Message-Id: <20181221034337.26663-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221034337.26663-1-f.fainelli@gmail.com>
References: <20181221034337.26663-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf on ARM requires CONFIG_KUSER_HELPERS to be turned on to allow some
independance with respect to the ARM CPU being used. Add a test which
tries to locate the [vectors] page, created when CONFIG_KUSER_HELPERS is
turned on to help asses the system's health.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/perf/arch/arm/tests/Build          |  1 +
 tools/perf/arch/arm/tests/arch-tests.c   |  4 ++++
 tools/perf/arch/arm/tests/vectors-page.c | 24 ++++++++++++++++++++++++
 tools/perf/tests/tests.h                 |  5 +++++
 4 files changed, 34 insertions(+)
 create mode 100644 tools/perf/arch/arm/tests/vectors-page.c

diff --git a/tools/perf/arch/arm/tests/Build b/tools/perf/arch/arm/tests/Build
index 883c57ff0c08..d9ae2733f9cc 100644
--- a/tools/perf/arch/arm/tests/Build
+++ b/tools/perf/arch/arm/tests/Build
@@ -1,4 +1,5 @@
 libperf-y += regs_load.o
 libperf-y += dwarf-unwind.o
+libperf-y += vectors-page.o
 
 libperf-y += arch-tests.o
diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
index 5b1543c98022..6848101a855f 100644
--- a/tools/perf/arch/arm/tests/arch-tests.c
+++ b/tools/perf/arch/arm/tests/arch-tests.c
@@ -10,6 +10,10 @@ struct test arch_tests[] = {
 		.func = test__dwarf_unwind,
 	},
 #endif
+	{
+		.desc = "Vectors page",
+		.func = test__vectors_page,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/arch/arm/tests/vectors-page.c b/tools/perf/arch/arm/tests/vectors-page.c
new file mode 100644
index 000000000000..7ffdd79971c8
--- /dev/null
+++ b/tools/perf/arch/arm/tests/vectors-page.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <linux/compiler.h>
+
+#include "debug.h"
+#include "tests/tests.h"
+#include "util/find-map.c"
+
+#define VECTORS__MAP_NAME "[vectors]"
+
+int test__vectors_page(struct test *test __maybe_unused,
+		       int subtest __maybe_unused)
+{
+	void *start, *end;
+
+	if (find_map(&start, &end, VECTORS__MAP_NAME)) {
+		pr_err("%s not found, is CONFIG_KUSER_HELPERS enabled?\n",
+		       VECTORS__MAP_NAME);
+		return TEST_FAIL;
+	}
+
+	return TEST_OK;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index b82f55fcc294..399f18ca71a3 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -119,4 +119,9 @@ int test__arch_unwind_sample(struct perf_sample *sample,
 			     struct thread *thread);
 #endif
 #endif
+
+#if defined(__arm__)
+int test__vectors_page(struct test *test, int subtest);
+#endif
+
 #endif /* TESTS_H */
-- 
2.17.1

