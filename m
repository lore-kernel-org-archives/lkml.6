Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C49C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50BF2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfBSNG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:06:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727438AbfBSNG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:06:28 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9EBA5E0EDC91A9EF70E1;
        Tue, 19 Feb 2019 21:06:24 +0800 (CST)
Received: from huawei.com (100.95.165.100) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 21:06:16 +0800
From:   He Kuang <hekuang@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <hekuang@huawei.com>
Subject: [PATCH] perf report: Don't shadow inlined symbol with different addr range
Date:   Tue, 19 Feb 2019 21:05:31 +0800
Message-ID: <20190219130531.15692-1-hekuang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [100.95.165.100]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't assume inlined symbols with the same name are equal, because
their address range may be different. This will cause the symbols with
different addresses be shadowed when adding to the hist entry, and lead
to ERANGE error when checking the symbol address during sample parse, the
addr should be within the range of [sym.start, sym.end].

The error message is like: "0x36aea60 [0x8]: failed to process type: 68".

The second parameter of symbol__new() is the length of the fake symbol for
the inline frame, which is the subtraction of the end and start address of
base_sym.

Signed-off-by: He Kuang <hekuang@huawei.com>
---
 tools/perf/util/sort.c    | 10 ++++++++--
 tools/perf/util/srcline.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 6c1a83768eb0..d0334c33da54 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -230,8 +230,14 @@ static int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
 	if (sym_l == sym_r)
 		return 0;
 
-	if (sym_l->inlined || sym_r->inlined)
-		return strcmp(sym_l->name, sym_r->name);
+	if (sym_l->inlined || sym_r->inlined) {
+		int ret = strcmp(sym_l->name, sym_r->name);
+
+		if (ret)
+			return ret;
+		if ((sym_l->start <= sym_r->end) && (sym_l->end >= sym_r->start))
+			return 0;
+	}
 
 	if (sym_l->start != sym_r->start)
 		return (int64_t)(sym_r->start - sym_l->start);
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index dc86597d0cc4..ccf42c4e83f0 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -104,7 +104,7 @@ static struct symbol *new_inline_sym(struct dso *dso,
 	} else {
 		/* create a fake symbol for the inline frame */
 		inline_sym = symbol__new(base_sym ? base_sym->start : 0,
-					 base_sym ? base_sym->end : 0,
+					 base_sym ? (base_sym->end - base_sym->start) : 0,
 					 base_sym ? base_sym->binding : 0,
 					 base_sym ? base_sym->type : 0,
 					 funcname);
-- 
2.20.1

