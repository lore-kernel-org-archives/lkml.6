Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B89BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4407021E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXY9Sd10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4407021E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbeHIRYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbeHIRYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:24:52 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C9A52183D;
        Thu,  9 Aug 2018 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826775;
        bh=gGRwGOxgtaTK4EOMsYNhqi7F8TMQy9aKyXQ+VgLKbv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXY9Sd10+FwFqg9LI3pBa9KGltLXTsEeDmW7Bu0Za4cj6qhSkKR7RZjYUqL6zJ8de
         9l17YTKCWYUNabMM8l8/bFB3O2wbh2bJLT/zEWNWMj/qXyD9ESDURYMFyK0d6vEC/S
         dRRy32AWUmQpqIcMbWxym4IAlBYf+hUfzWgnqciI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 12/44] perf bpf: Add 'syscall_enter' probe helper for syscall enter tracepoints
Date:   Thu,  9 Aug 2018 11:57:50 -0300
Message-Id: <20180809145822.21391-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Allowing one to hook into the syscalls:sys_enter_NAME tracepoints,
an example is provided that hooks into the 'openat' syscall.

Using it with the probe:vfs_getname probe into getname_flags to get the
filename args as it is copied from userspace:

  # perf probe -l
  probe:vfs_getname    (on getname_flags:73@acme/git/linux/fs/namei.c with pathname)
  # perf trace -e probe:*getname,tools/perf/examples/bpf/sys_enter_openat.c cat /etc/passwd > /dev/null
     0.000 probe:vfs_getname:(ffffffffbd2a8983) pathname="/etc/ld.so.preload"
     0.022 syscalls:sys_enter_openat:dfd: CWD, filename: 0xafbe8da8, flags: CLOEXEC
     0.027 probe:vfs_getname:(ffffffffbd2a8983) pathname="/etc/ld.so.cache"
     0.054 syscalls:sys_enter_openat:dfd: CWD, filename: 0xafdf0ce0, flags: CLOEXEC
     0.057 probe:vfs_getname:(ffffffffbd2a8983) pathname="/lib64/libc.so.6"
     0.316 probe:vfs_getname:(ffffffffbd2a8983) pathname="/usr/lib/locale/locale-archive"
     0.375 syscalls:sys_enter_openat:dfd: CWD, filename: 0xe2b2b0b4
     0.379 probe:vfs_getname:(ffffffffbd2a8983) pathname="/etc/passwd"
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2po9jcqv1qgj0koxlg8kkg30@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/sys_enter_openat.c | 33 ++++++++++++++++++++++++++++++
 tools/perf/include/bpf/bpf.h               |  3 +++
 2 files changed, 36 insertions(+)
 create mode 100644 tools/perf/examples/bpf/sys_enter_openat.c

diff --git a/tools/perf/examples/bpf/sys_enter_openat.c b/tools/perf/examples/bpf/sys_enter_openat.c
new file mode 100644
index 000000000000..9cd124b09392
--- /dev/null
+++ b/tools/perf/examples/bpf/sys_enter_openat.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hook into 'openat' syscall entry tracepoint
+ *
+ * Test it with:
+ *
+ * perf trace -e tools/perf/examples/bpf/sys_enter_openat.c cat /etc/passwd > /dev/null
+ *
+ * It'll catch some openat syscalls related to the dynamic linked and
+ * the last one should be the one for '/etc/passwd'.
+ *
+ * The syscall_enter_openat_args can be used to get the syscall fields
+ * and use them for filtering calls, i.e. use in expressions for
+ * the return value.
+ */
+
+#include <bpf.h>
+
+struct syscall_enter_openat_args {
+	unsigned long long unused;
+	long		   syscall_nr;
+	long		   dfd;
+	char		   *filename_ptr;
+	long		   flags;
+	long		   mode;
+};
+
+int syscall_enter(openat)(struct syscall_enter_openat_args *args)
+{
+	return 1;
+}
+
+license(GPL);
diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index a63aa6241b7f..2873cdde293f 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -9,6 +9,9 @@
 #define probe(function, vars) \
 	SEC(#function "=" #function " " #vars) function
 
+#define syscall_enter(name) \
+	SEC("syscalls:sys_enter_" #name) syscall_enter_ ## name
+
 #define license(name) \
 char _license[] SEC("license") = #name; \
 int _version SEC("version") = LINUX_VERSION_CODE;
-- 
2.14.4

