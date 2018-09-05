Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89465C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4244A20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmXN+G5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4244A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeIFChk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFChj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:39 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D5122073D;
        Wed,  5 Sep 2018 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185127;
        bh=b+szek/s/o/GcvPLNRfe9EqBlEQ6pzSjk0I3bWo3FtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmXN+G5+qLL0v84aFk6uEGvQjVetXWM+/isJVQZWvVeJyGN+/yGCJ84MtpRdawtex
         8NmH23dHemlNrAd2zQEe1/lC8kz4Q6SjZ4Z8YeEtdl9O5ZXzu66y0YWIM0DOppdrCb
         XXf1GV5BfC7xBPakVNdRngBRCjW56EmlkiEte2oM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 13/77] perf bpf: Add linux/socket.h to the headers accessible to bpf proggies
Date:   Wed,  5 Sep 2018 19:03:36 -0300
Message-Id: <20180905220440.20256-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we don't have to define sockaddr_storage in the
augmented_syscalls.c bpf example when hooking into syscalls needing it,
idea is to mimic the system headers. Eventually we probably need to have
sys/socket.h, etc.  Start by having at least linux/socket.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-yhzarcvsjue8pgpvkjhqgioc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf              |  4 +++-
 tools/perf/include/bpf/linux/socket.h | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/include/bpf/linux/socket.h

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5224ade3d5af..92514fb3689f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -779,7 +779,9 @@ endif
 ifndef NO_LIBBPF
 	$(call QUIET_INSTALL, bpf-headers) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
-		$(INSTALL) include/bpf/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf/linux'; \
+		$(INSTALL) include/bpf/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
+		$(INSTALL) include/bpf/linux/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf/linux'
 	$(call QUIET_INSTALL, bpf-examples) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'; \
 		$(INSTALL) examples/bpf/*.c -t '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
diff --git a/tools/perf/include/bpf/linux/socket.h b/tools/perf/include/bpf/linux/socket.h
new file mode 100644
index 000000000000..7f844568dab8
--- /dev/null
+++ b/tools/perf/include/bpf/linux/socket.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_SOCKET_H
+#define _UAPI_LINUX_SOCKET_H
+
+/*
+ * Desired design of maximum size and alignment (see RFC2553)
+ */
+#define _K_SS_MAXSIZE	128	/* Implementation specific max size */
+#define _K_SS_ALIGNSIZE	(__alignof__ (struct sockaddr *))
+				/* Implementation specific desired alignment */
+
+typedef unsigned short __kernel_sa_family_t;
+
+struct __kernel_sockaddr_storage {
+	__kernel_sa_family_t	ss_family;		/* address family */
+	/* Following field(s) are implementation specific */
+	char		__data[_K_SS_MAXSIZE - sizeof(unsigned short)];
+				/* space to achieve desired size, */
+				/* _SS_MAXSIZE value minus size of ss_family */
+} __attribute__ ((aligned(_K_SS_ALIGNSIZE)));	/* force desired alignment */
+
+#define sockaddr_storage __kernel_sockaddr_storage
+
+#endif /* _UAPI_LINUX_SOCKET_H */
-- 
2.14.4

