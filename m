Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBBCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F69A2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Id+AqvGa";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Id+AqvGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F69A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeJPQp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:45:59 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:38336 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727215AbeJPQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:45:59 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 43CA020EFD;
        Tue, 16 Oct 2018 11:56:32 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id hfma3fkdW4-uWlSvdxL;
        Tue, 16 Oct 2018 11:56:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1539680192; bh=7yN+wyS7jMomKNQ+MBX+HUSLgc8hcBR14WLOwszMjq8=;
        h=Subject:From:To:Date:Message-ID;
        b=Id+AqvGam059fZV9loLh0prQe/rhZsTdDv7hLM/f+3g/ZJYR+gU2ijaDgadSNYRxn
         CjPfwIX12gtoKnzNp/IJnneoePbtHy5QeI8ciMFUJYL4BZbIutANrSpqrZC+E03uuL
         fo0zxY7sUxySaQSEJPyhdjhnuw3KmCM5Txa0TPcM=
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b010:d005::1:29])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id dkKkvPzBzE-uVFqNw8g;
        Tue, 16 Oct 2018 11:56:31 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1539680192; bh=7yN+wyS7jMomKNQ+MBX+HUSLgc8hcBR14WLOwszMjq8=;
        h=Subject:From:To:Date:Message-ID;
        b=Id+AqvGam059fZV9loLh0prQe/rhZsTdDv7hLM/f+3g/ZJYR+gU2ijaDgadSNYRxn
         CjPfwIX12gtoKnzNp/IJnneoePbtHy5QeI8ciMFUJYL4BZbIutANrSpqrZC+E03uuL
         fo0zxY7sUxySaQSEJPyhdjhnuw3KmCM5Txa0TPcM=
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] tools/power/cpupower: fix compilation with STATIC=true
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org
Date:   Tue, 16 Oct 2018 11:56:26 +0300
Message-ID: <153968018626.397151.17942194042449956995.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename duplicate sysfs_read_file into cpupower_read_sysfs and fix linking.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 tools/power/cpupower/bench/Makefile        |    2 +-
 tools/power/cpupower/lib/cpufreq.c         |    2 +-
 tools/power/cpupower/lib/cpuidle.c         |    2 +-
 tools/power/cpupower/lib/cpupower.c        |    4 ++--
 tools/power/cpupower/lib/cpupower_intern.h |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index d79ab161cc75..f68b4bc55273 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -9,7 +9,7 @@ endif
 ifeq ($(strip $(STATIC)),true)
 LIBS = -L../ -L$(OUTPUT) -lm
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o \
-       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/sysfs.o
+       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/cpupower.o
 else
 LIBS = -L../ -L$(OUTPUT) -lm -lcpupower
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o
diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 1b993fe1ce23..0c0f3e3f0d80 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -28,7 +28,7 @@ static unsigned int sysfs_cpufreq_read_file(unsigned int cpu, const char *fname,
 
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/cpufreq/%s",
 			 cpu, fname);
-	return sysfs_read_file(path, buf, buflen);
+	return cpupower_read_sysfs(path, buf, buflen);
 }
 
 /* helper function to write a new value to a /sys file */
diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/cpuidle.c
index 9bd4c7655fdb..852d25462388 100644
--- a/tools/power/cpupower/lib/cpuidle.c
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -319,7 +319,7 @@ static unsigned int sysfs_cpuidle_read_file(const char *fname, char *buf,
 
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpuidle/%s", fname);
 
-	return sysfs_read_file(path, buf, buflen);
+	return cpupower_read_sysfs(path, buf, buflen);
 }
 
 
diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index 9c395ec924de..9711d628b0f4 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -15,7 +15,7 @@
 #include "cpupower.h"
 #include "cpupower_intern.h"
 
-unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen)
+unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen)
 {
 	int fd;
 	ssize_t numread;
@@ -95,7 +95,7 @@ static int sysfs_topology_read_file(unsigned int cpu, const char *fname, int *re
 
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/topology/%s",
 			 cpu, fname);
-	if (sysfs_read_file(path, linebuf, MAX_LINE_LEN) == 0)
+	if (cpupower_read_sysfs(path, linebuf, MAX_LINE_LEN) == 0)
 		return -1;
 	*result = strtol(linebuf, &endp, 0);
 	if (endp == linebuf || errno == ERANGE)
diff --git a/tools/power/cpupower/lib/cpupower_intern.h b/tools/power/cpupower/lib/cpupower_intern.h
index 92affdfbe417..4887c76d23f8 100644
--- a/tools/power/cpupower/lib/cpupower_intern.h
+++ b/tools/power/cpupower/lib/cpupower_intern.h
@@ -3,4 +3,4 @@
 #define MAX_LINE_LEN 4096
 #define SYSFS_PATH_MAX 255
 
-unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen);
+unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen);

