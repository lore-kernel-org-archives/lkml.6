Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6256BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281052145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0U1dYyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281052145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbeK3BaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbeK3BaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F54C2145D;
        Thu, 29 Nov 2018 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501491;
        bh=R333l4Et05IJgk4K1RIQIbxBNB0GseHMBoPL4fnZrl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0U1dYyu4DSkIKe4ewOaw0yn4zSu6otyGj+xn2e4JP9C2w7wkCQsPPL7F26uYYad2
         2cTzfSPG6l35Dl+0/BHCyz7Ja2xTar46awFNfT7J0B/+amA9kd4xMafyKCUuJcqF1D
         82gy6GEodjDx7fA0INb6TsoJZvyu8q3SGK65gXrU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Renninger <trenn@suse.de>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.14 020/100] tools/power/cpupower: fix compilation with STATIC=true
Date:   Thu, 29 Nov 2018 15:11:50 +0100
Message-Id: <20181129140100.544789877@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

commit 9de9aa45e9bd67232e000cca42ceb134b8ae51b6 upstream.

Rename duplicate sysfs_read_file into cpupower_read_sysfs and fix linking.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Thomas Renninger <trenn@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/power/cpupower/bench/Makefile        |    2 +-
 tools/power/cpupower/lib/cpufreq.c         |    2 +-
 tools/power/cpupower/lib/cpuidle.c         |    2 +-
 tools/power/cpupower/lib/cpupower.c        |    4 ++--
 tools/power/cpupower/lib/cpupower_intern.h |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

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
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -28,7 +28,7 @@ static unsigned int sysfs_cpufreq_read_f
 
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/cpufreq/%s",
 			 cpu, fname);
-	return sysfs_read_file(path, buf, buflen);
+	return cpupower_read_sysfs(path, buf, buflen);
 }
 
 /* helper function to write a new value to a /sys file */
--- a/tools/power/cpupower/lib/cpuidle.c
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -319,7 +319,7 @@ static unsigned int sysfs_cpuidle_read_f
 
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpuidle/%s", fname);
 
-	return sysfs_read_file(path, buf, buflen);
+	return cpupower_read_sysfs(path, buf, buflen);
 }
 
 
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
@@ -95,7 +95,7 @@ static int sysfs_topology_read_file(unsi
 
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/topology/%s",
 			 cpu, fname);
-	if (sysfs_read_file(path, linebuf, MAX_LINE_LEN) == 0)
+	if (cpupower_read_sysfs(path, linebuf, MAX_LINE_LEN) == 0)
 		return -1;
 	*result = strtol(linebuf, &endp, 0);
 	if (endp == linebuf || errno == ERANGE)
--- a/tools/power/cpupower/lib/cpupower_intern.h
+++ b/tools/power/cpupower/lib/cpupower_intern.h
@@ -3,4 +3,4 @@
 #define MAX_LINE_LEN 4096
 #define SYSFS_PATH_MAX 255
 
-unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen);
+unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen);


