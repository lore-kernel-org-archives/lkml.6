Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF38EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A69120825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A69120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeKJGtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:49:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:36084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbeKJGtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:49:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1270AE25;
        Fri,  9 Nov 2018 21:07:25 +0000 (UTC)
Date:   Fri, 9 Nov 2018 13:07:19 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     akpm@linux-foundation.org, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] perf-bench: Add epoll parallel epoll_wait benchmark
Message-ID: <20181109210719.pr7ohayuwqmfp2wl@linux-r8p5>
References: <20181106152226.20883-1-dave@stgolabs.net>
 <20181106152226.20883-2-dave@stgolabs.net>
 <20181106182349.thdkpvshkna5vd7o@linux-r8p5>
 <20181106191325.GM7077@kernel.org>
 <20181108134500.GA15568@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181108134500.GA15568@kernel.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Nov 2018, Arnaldo Carvalho de Melo wrote:

>Em Tue, Nov 06, 2018 at 04:13:25PM -0300, Arnaldo Carvalho de Melo escreveu:
>  CC       /tmp/build/perf/bench/futex-lock-pi.o
>  CC       /tmp/build/perf/bench/epoll-wait.o
>bench/epoll-wait.c: In function 'do_threads':
>bench/epoll-wait.c:345:10: error: implicit declaration of function 'pthread_attr_setaffinity_np' [-Werror=implicit-function-declaration]
>    ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);

Ah, yes, how about the following?

-----8<-----------------------------------------------------
perf-bench: Move HAVE_PTHREAD_ATTR_SETAFFINITY_NP into bench.h

Both futex and epoll need this call, and can cause build failure
on systems that don't have it pthread_attr_setaffinity_np().

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/bench.h | 11 +++++++++++
 tools/perf/bench/futex.h | 12 ------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 0e415464931b..fddb3ced9db6 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -51,4 +51,15 @@ int bench_epoll_ctl(int argc, const char **argv);
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
2.16.4
