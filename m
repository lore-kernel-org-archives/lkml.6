Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeEPSHj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:07:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42953 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeEPSHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:07:38 -0400
Date: Wed, 16 May 2018 11:05:54 -0700
From: tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-psf4xwc09n62al2cb9s33v9h@git.kernel.org>
Cc: hpa@zytor.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, yuehaibing@huawei.com, acme@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, daniel@iogearbox.net
Reply-To: yuehaibing@huawei.com, acme@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
        daniel@iogearbox.net, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Fix NULL return handling in
 bpf__prepare_load()
Git-Commit-ID: 7a36a287de9fbb1ba906e70573d3f2315f7fd609
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7a36a287de9fbb1ba906e70573d3f2315f7fd609
Gitweb:     https://git.kernel.org/tip/7a36a287de9fbb1ba906e70573d3f2315f7fd609
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Fri, 11 May 2018 19:21:42 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 16 May 2018 10:01:55 -0300

perf bpf: Fix NULL return handling in bpf__prepare_load()

bpf_object__open()/bpf_object__open_buffer can return error pointer or
NULL, check the return values with IS_ERR_OR_NULL() in bpf__prepare_load
and bpf__prepare_load_buffer

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: netdev@vger.kernel.org
Link: https://lkml.kernel.org/n/tip-psf4xwc09n62al2cb9s33v9h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index af7ad814b2c3..cee658733e2c 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -66,7 +66,7 @@ bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz, const char *name)
 	}
 
 	obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, name);
-	if (IS_ERR(obj)) {
+	if (IS_ERR_OR_NULL(obj)) {
 		pr_debug("bpf: failed to load buffer\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -102,14 +102,14 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 			pr_debug("bpf: successfull builtin compilation\n");
 		obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, filename);
 
-		if (!IS_ERR(obj) && llvm_param.dump_obj)
+		if (!IS_ERR_OR_NULL(obj) && llvm_param.dump_obj)
 			llvm__dump_obj(filename, obj_buf, obj_buf_sz);
 
 		free(obj_buf);
 	} else
 		obj = bpf_object__open(filename);
 
-	if (IS_ERR(obj)) {
+	if (IS_ERR_OR_NULL(obj)) {
 		pr_debug("bpf: failed to load %s\n", filename);
 		return obj;
 	}
