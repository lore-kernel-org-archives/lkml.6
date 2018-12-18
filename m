Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED75C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0988F218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170956;
	bh=IbxNv6E27w9dDZnV7A1RMizq4jQVQnZPg39OUTBVp7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SGp3hd2xo2TlwkcihZKHpnj+GNWQ8kVabSO1lsBXgGuVQz+jEc5uZ4mFfSiIA/2j5
	 Mp9iBdw/mnhV+bsM6zAaGYkAzuA6vS6PUD0gm23XHZZDE9yfy1nrvV6oVFdW61E7kE
	 ZaFSOpThjFPdhNu0sMbGScHJ0WcNR2qK7jXu8hLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbeLRWJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:09:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbeLRWJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:09:11 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CC4E218AC;
        Tue, 18 Dec 2018 22:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170950;
        bh=IbxNv6E27w9dDZnV7A1RMizq4jQVQnZPg39OUTBVp7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0+6W49S3nix1EABE06r6yTuIvtIDjTDd20+cYU/RAphDPsBQHkr0j0Nyjhk201gG
         eLCRMhIj2VRB9u9sCO33OFgyMr0UO0gkc2n2R5eFLMm6eZWvsSCl/+PJOm2qjdr+2D
         k8/+hQi4F5b4HYtMVtn6j0CK9BlUfMe5yQqrrY6k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 14/63] perf tools: Add missing sigqueue() prototype for systems lacking it
Date:   Tue, 18 Dec 2018 19:06:44 -0300
Message-Id: <20181218220733.15839-15-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
---
 tools/perf/Makefile.config | 1 +
 tools/perf/util/evlist.c   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b66f97a04b12..265a9225e5fc 100644
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
index e90575192209..8c902276d4b4 100644
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
2.19.2

