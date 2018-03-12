Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeCLJnb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:43:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752600AbeCLJn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:28 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 07/13] libbpf: Make bpf_program__next skip .text section
Date: Mon, 12 Mar 2018 10:43:07 +0100
Message-Id: <20180312094313.18738-8-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip .text section in bpf_program__next, so it iterates
only throught the probes code. We are about to add .text
code support, so the .text section needs to get separated
from probes.

Link: http://lkml.kernel.org/n/tip-lcftc9k0fby5b5g2o0lhum8x@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6b9df10470e8..07a6d8f5e5ab 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1705,22 +1705,34 @@ void *bpf_object__priv(struct bpf_object *obj)
 struct bpf_program *
 bpf_program__next(struct bpf_program *prev, struct bpf_object *obj)
 {
+	struct bpf_program *prog;
 	size_t idx;
 
 	if (!obj->programs)
 		return NULL;
+
 	/* First handler */
 	if (prev == NULL)
-		return &obj->programs[0];
+		idx = 0;
+	else
+		idx = (prev - obj->programs) + 1;
 
-	if (prev->obj != obj) {
+	if (prev && (prev->obj != obj)) {
 		pr_warning("error: program handler doesn't match object\n");
 		return NULL;
 	}
 
-	idx = (prev - obj->programs) + 1;
 	if (idx >= obj->nr_programs)
 		return NULL;
+
+	prog = &obj->programs[idx];
+
+	if (prog->idx == obj->efile.text_shndx)
+		idx++;
+
+	if (idx >= obj->nr_programs)
+		return NULL;
+
 	return &obj->programs[idx];
 }
 
-- 
2.13.6
