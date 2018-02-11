Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeBKUcc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 15:32:32 -0500
Received: from omr-m016e.mx.aol.com ([204.29.186.16]:37059 "EHLO
        omr-m016e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932160AbeBKUc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 15:32:28 -0500
From: Martin Vuille <jpmv27@aim.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] perf annotate: Don't prepend symfs path to vmlinux path
Date: Sun, 11 Feb 2018 15:32:10 -0500
Message-Id: <20180211203210.12738-2-jpmv27@aim.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180211203210.12738-1-jpmv27@aim.com>
References: <20180211203210.12738-1-jpmv27@aim.com>
x-aol-global-disposition: G
x-aol-sid: 3039ac1d1bce5a80a85a6571
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When selecting the filename to pass to objdump for disassembly, if there is
no entry for vmlinux in the build-id cache then the fallback code prepends
symfs path to vmlinux path. If the vmlinux option was specified, this is
unnecessary and, as a result, vmlinux is not found.

Don't prepend symfs path if DSO is [kernel.kallsyms]

Signed-off-by: Martin Vuille <jpmv27@aim.com>
---
 tools/perf/util/annotate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 425b7f0760ec..0b78cc4fb155 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1412,7 +1412,14 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 		 * cache, or is just a kallsyms file, well, lets hope that this
 		 * DSO is the same as when 'perf record' ran.
 		 */
-		__symbol__join_symfs(filename, filename_size, dso->long_name);
+		if (!strstr(dso->short_name, DSO__NAME_KALLSYMS))
+		{
+			__symbol__join_symfs(filename, filename_size, dso->long_name);
+		}
+		else
+		{
+			scnprintf(filename, filename_size, "%s", dso->long_name);
+		}
 	}
 
 	free(build_id_path);
-- 
2.13.6
