Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB1CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7D92081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0/w6Oti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7D92081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeKIVKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:10:55 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37470 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeKIVKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:10:55 -0500
Received: by mail-qk1-f195.google.com with SMTP id 131so917750qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlS5AWWWpD/Zv7MPE6e/bI9tGD+2AhsGTOQaUcenEXU=;
        b=X0/w6OtiiQeqMm13Cd1JKzpHrzR4Ycp60TdmsTEkKOQ9HLRoEoRyxUXb1U3tS7UG81
         1hTo32LSeZh4GUkyyPI+iG38zbr0rxWo/QLSnE3B/GeJtEGRT07qbY255XkSsQUPMmiQ
         P3lDxuVNiJnU7oDSwizINOykbv2gLVVhE/ym0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlS5AWWWpD/Zv7MPE6e/bI9tGD+2AhsGTOQaUcenEXU=;
        b=TP5dFifLV/aA2IEBUr7SZq4UMenrDgqxQDJgk0NXT+W56X4CHtAAMtQ0wP4f4nF8OO
         /6eZDvABuOAz8gDOELreSuLiI69fRHKOypGzHyoe3Tm0DymMjLT2mZF6DDhFUBqK5LlZ
         RuKM9OMTR+oT2njzNpvW7LPU9Wf3tTE1scNAJgwPa0wfctO+RroD3ld+G6Y2BQhafOoJ
         s/qA/Z2AVH2mJyAk4pHzcq22mD1yOajIBczBJ2ExbTCtKNQvSoNoULkx4RcZBrTfvv9W
         UfeJrxGoD4adbXEJ5z4lZzT7B5nLkqtJbfIt093GJth3p/dYY9hQyKdkrPjDGZqvV43O
         HZXg==
X-Gm-Message-State: AGRZ1gI1J3laAS9kSh0L2xQtuLm0iwHVeQDznFdklhYqAaaVgoHyG+5L
        8480c5g0wNcHjybdA+S98qu/RQ==
X-Google-Smtp-Source: AJdET5emaHgc60yNggwbeuBQIKli49THvbPSKnPUPbOSupq9W/Y8dxz12JJIbpdWR2+gRlMKa5BicQ==
X-Received: by 2002:aed:3b25:: with SMTP id p34mr8168968qte.310.1541763041572;
        Fri, 09 Nov 2018 03:30:41 -0800 (PST)
Received: from workstation.celeiro.br ([168.194.163.12])
        by smtp.gmail.com with ESMTPSA id p31sm5172435qkh.86.2018.11.09.03.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 03:30:40 -0800 (PST)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     gorcunov@gmail.com
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, rafael.tinoco@linaro.org,
        shuah@kernel.org
Subject: [PATCH] proc: fix and merge proc-self-map-file tests
Date:   Fri,  9 Nov 2018 09:30:36 -0200
Message-Id: <20181109113036.21512-1-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108111105.GC13195@uranus.lan>
References: <20181108111105.GC13195@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge proc-self-map-files tests into one since this test should focus in
testing readlink in /proc/self/map_files/* only, and not trying to test
mapping virtual address 0.

Lowest virtual address for user space mapping in other architectures,
like arm, is *at least* *(PAGE_SIZE * 2) and NULL hint does not
guarantee that when MAP_FIXED flag, important to this test, is given.
This patch also fixes this issue in remaining test.

Link: https://bugs.linaro.org/show_bug.cgi?id=3782
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 tools/testing/selftests/proc/.gitignore       |  1 -
 tools/testing/selftests/proc/Makefile         |  1 -
 .../selftests/proc/proc-self-map-files-001.c  |  5 +-
 .../selftests/proc/proc-self-map-files-002.c  | 85 -------------------
 4 files changed, 3 insertions(+), 89 deletions(-)
 delete mode 100644 tools/testing/selftests/proc/proc-self-map-files-002.c

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index 82121a81681f..d44ec8755879 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -3,7 +3,6 @@
 /fd-003-kthread
 /proc-loadavg-001
 /proc-self-map-files-001
-/proc-self-map-files-002
 /proc-self-syscall
 /proc-self-wchan
 /proc-uptime-001
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index 1c12c34cf85d..6c17557c2f9a 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -7,7 +7,6 @@ TEST_GEN_PROGS += fd-002-posix-eq
 TEST_GEN_PROGS += fd-003-kthread
 TEST_GEN_PROGS += proc-loadavg-001
 TEST_GEN_PROGS += proc-self-map-files-001
-TEST_GEN_PROGS += proc-self-map-files-002
 TEST_GEN_PROGS += proc-self-syscall
 TEST_GEN_PROGS += proc-self-wchan
 TEST_GEN_PROGS += proc-uptime-001
diff --git a/tools/testing/selftests/proc/proc-self-map-files-001.c b/tools/testing/selftests/proc/proc-self-map-files-001.c
index 4209c64283d6..646d8d3fba3a 100644
--- a/tools/testing/selftests/proc/proc-self-map-files-001.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-001.c
@@ -46,16 +46,17 @@ static void fail(const char *fmt, unsigned long a, unsigned long b)
 
 int main(void)
 {
-	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
 	void *p;
 	int fd;
 	unsigned long a, b;
+	const long PAGE_SIZE = sysconf(_SC_PAGESIZE);
 
 	fd = open("/dev/zero", O_RDONLY);
 	if (fd == -1)
 		return 1;
 
-	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE, fd, 0);
+	p = mmap((void *) (2 * PAGE_SIZE), PAGE_SIZE, PROT_NONE,
+			MAP_PRIVATE|MAP_FILE, fd, 0);
 	if (p == MAP_FAILED)
 		return 1;
 
diff --git a/tools/testing/selftests/proc/proc-self-map-files-002.c b/tools/testing/selftests/proc/proc-self-map-files-002.c
deleted file mode 100644
index 6f1f4a6e1ecb..000000000000
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
- *
- * Permission to use, copy, modify, and distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- */
-/* Test readlink /proc/self/map_files/... with address 0. */
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/mman.h>
-#include <stdlib.h>
-
-static void pass(const char *fmt, unsigned long a, unsigned long b)
-{
-	char name[64];
-	char buf[64];
-
-	snprintf(name, sizeof(name), fmt, a, b);
-	if (readlink(name, buf, sizeof(buf)) == -1)
-		exit(1);
-}
-
-static void fail(const char *fmt, unsigned long a, unsigned long b)
-{
-	char name[64];
-	char buf[64];
-
-	snprintf(name, sizeof(name), fmt, a, b);
-	if (readlink(name, buf, sizeof(buf)) == -1 && errno == ENOENT)
-		return;
-	exit(1);
-}
-
-int main(void)
-{
-	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
-	void *p;
-	int fd;
-	unsigned long a, b;
-
-	fd = open("/dev/zero", O_RDONLY);
-	if (fd == -1)
-		return 1;
-
-	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
-	if (p == MAP_FAILED) {
-		if (errno == EPERM)
-			return 2;
-		return 1;
-	}
-
-	a = (unsigned long)p;
-	b = (unsigned long)p + PAGE_SIZE;
-
-	pass("/proc/self/map_files/%lx-%lx", a, b);
-	fail("/proc/self/map_files/ %lx-%lx", a, b);
-	fail("/proc/self/map_files/%lx -%lx", a, b);
-	fail("/proc/self/map_files/%lx- %lx", a, b);
-	fail("/proc/self/map_files/%lx-%lx ", a, b);
-	fail("/proc/self/map_files/0%lx-%lx", a, b);
-	fail("/proc/self/map_files/%lx-0%lx", a, b);
-	if (sizeof(long) == 4) {
-		fail("/proc/self/map_files/100000000%lx-%lx", a, b);
-		fail("/proc/self/map_files/%lx-100000000%lx", a, b);
-	} else if (sizeof(long) == 8) {
-		fail("/proc/self/map_files/10000000000000000%lx-%lx", a, b);
-		fail("/proc/self/map_files/%lx-10000000000000000%lx", a, b);
-	} else
-		return 1;
-
-	return 0;
-}
-- 
2.19.1

