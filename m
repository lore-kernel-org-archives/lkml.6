Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A82C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104A4218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358999;
	bh=LSpWjKUPIDxHB4LUBKOw+Vp3Ou9ZwSQD0YgLzqCh2cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ycgcLDdD7qMtiXEX1G7GeFFeVlx2sR+WxFFsRup8ft7+bjRTvEQnQBpqeF6SEvD9j
	 DV+IJEDxnSQOHpFDiEB4mSigeGiQTyU6oDayAfCqg9WnagJ8wfCcveWNI30mbh5Mc+
	 V6W7TcRWVcXmnXW/KtmodTz8stlViCLG70waSNg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbfAXTnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:43:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387566AbfAXTnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:43:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1820E20663;
        Thu, 24 Jan 2019 19:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358993;
        bh=LSpWjKUPIDxHB4LUBKOw+Vp3Ou9ZwSQD0YgLzqCh2cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0DYrzgsjz5DOMS+hlPi+y8HVtcpOdhoBEkBa/GDRLbF5uglifmxuFeiD2/irE2uBg
         Lucvvg2TnCOXHf5bqfbKyQ4WguNc+/jzUnArh7xJ19U/pQTtGxdXUROOIvGI+eNrKw
         uXbKJWJS2H4zuTEGLZ5Goo5KYtB9akIntAWpGOwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 098/127] perf tools: Add missing sigqueue() prototype for systems lacking it
Date:   Thu, 24 Jan 2019 20:20:44 +0100
Message-Id: <20190124190216.200467274@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 748fe0889c1ff12d378946bd5326e8ee8eacf5cf ]

There are systems such as the Android NDK API level 24 has the
sigqueue() function but doesn't provide a prototype, adding noise to the
build:

  util/evlist.c: In function 'perf_evlist__prepare_workload':
  util/evlist.c:1494:4: warning: implicit declaration of function 'sigqueue' [-Wimplicit-function-declaration]
      if (sigqueue(getppid(), SIGUSR1, val))
      ^
  util/evlist.c:1494:4: warning: nested extern declaration of 'sigqueue' [-Wnested-externs]

Define a LACKS_SIGQUEUE_PROTOTYPE define so that code needing that can
get a prototype.

Checked in the bionic git repo to be available since level 23:

https://android.googlesource.com/platform/bionic/+/master/libc/include/signal.h#123

  int sigqueue(pid_t __pid, int __signal, const union sigval __value) __INTRODUCED_IN(23);

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lmhpev1uni9kdrv7j29glyov@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.config | 1 +
 tools/perf/util/evlist.c   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a0e8c23f9125..e106e7ce6933 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -294,6 +294,7 @@ ifndef NO_BIONIC
   $(call feature_check,bionic)
   ifeq ($(feature-bionic), 1)
     BIONIC := 1
+    CFLAGS += -DLACKS_SIGQUEUE_PROTOTYPE
     EXTLIBS := $(filter-out -lrt,$(EXTLIBS))
     EXTLIBS := $(filter-out -lpthread,$(EXTLIBS))
   endif
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 668d2a9ef0f4..8a806b0758b0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -34,6 +34,10 @@
 #include <linux/log2.h>
 #include <linux/err.h>
 
+#ifdef LACKS_SIGQUEUE_PROTOTYPE
+int sigqueue(pid_t pid, int sig, const union sigval value);
+#endif
+
 #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
 #define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
 
-- 
2.19.1



