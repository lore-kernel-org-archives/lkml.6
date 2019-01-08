Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3D6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249DC20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977718;
	bh=XUS7PF6pZ50B8RMHl+TuW+6xE/bctCgX4LVNPTtm69g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AZGAg2vmwT4D9LbmZhRr6O5FnRZWF6R4SiSBLkUyfcAgq65Zp98LBE2iBu+TCgVgh
	 9xXpfN03hd2sa2GojR5PpCgWMo54OvxxpkwCIRD9hOa4JNijRLd928dyeZisqlDoIS
	 POLva2vUyH2mRLKBDg//NsMuHlt4oFTdFPETTI7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfAHUB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfAHT3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C7120645;
        Tue,  8 Jan 2019 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975750;
        bh=XUS7PF6pZ50B8RMHl+TuW+6xE/bctCgX4LVNPTtm69g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0V92El14jxTBZoNiMR89nMkHMGUGTIeAYPf01INW1cCuYWEysX1V8VWonIv+u4fr
         dY2y77wzwaK3BEVMrbzKeWhGAhTIL/TXv4jhW/7mLPIoCuGjYwXzr1b+xxFXQJIlz4
         LL1U46sqUjrV42lY8skXloBSwAEYYcIdDGj8+FqU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 094/117] perf tools: Add missing sigqueue() prototype for systems lacking it
Date:   Tue,  8 Jan 2019 14:26:02 -0500
Message-Id: <20190108192628.121270-94-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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

