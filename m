Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C642C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E0120878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4o/dQld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E0120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404423AbeKVOOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404394AbeKVOOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:38 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 308FA2080F;
        Thu, 22 Nov 2018 03:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857833;
        bh=zXX4GzfkKKp2BEKesItFJE5JVvdMlcf7Fq8aeALB2vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4o/dQldmMJvKL6nYhF6vxD+CqEvoulVhNS2WKn8HQzMm5MXJn+El00FDPqAIbU3n
         Poxp/DshzpRth36hQ6p7rochQEw5AbT7ghTn85fMM1KvpihRFRPSohWkHMvYeLEGn9
         cmocOoDOGyp2HN+QuQgmAgAeyJ1FdXLdyR+EKn0M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/28] perf bench: Move HAVE_PTHREAD_ATTR_SETAFFINITY_NP into bench.h
Date:   Thu, 22 Nov 2018 00:36:00 -0300
Message-Id: <20181122033611.15890-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

Both futex and epoll need this call, and can cause build failure on
systems that don't have it pthread_attr_setaffinity_np().

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Link: http://lkml.kernel.org/r/20181109210719.pr7ohayuwqmfp2wl@linux-r8p5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/bench.h | 11 +++++++++++
 tools/perf/bench/futex.h | 12 ------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 6c9fcd757f31..8299c76046cd 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -48,4 +48,15 @@ int bench_futex_lock_pi(int argc, const char **argv);
 extern int bench_format;
 extern unsigned int bench_repeat;
 
+#ifndef HAVE_PTHREAD_ATTR_SETAFFINITY_NP
+#include <pthread.h>
+#include <linux/compiler.h>
+static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
+					      size_t cpusetsize __maybe_unused,
+					      cpu_set_t *cpuset __maybe_unused)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index db4853f209c7..31b53cc7d5bc 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -86,16 +86,4 @@ futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, int nr_wak
 	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
 		 val, opflags);
 }
-
-#ifndef HAVE_PTHREAD_ATTR_SETAFFINITY_NP
-#include <pthread.h>
-#include <linux/compiler.h>
-static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
-					      size_t cpusetsize __maybe_unused,
-					      cpu_set_t *cpuset __maybe_unused)
-{
-	return 0;
-}
-#endif
-
 #endif /* _FUTEX_H */
-- 
2.14.5

