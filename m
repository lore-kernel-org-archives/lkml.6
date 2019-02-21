Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286552147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712385;
	bh=BAwRHPzSeKQ8p79VFmyAROLJGQKsejY7NCCgcgNqqMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Uvdp6z22cbRKqwN3XB+8AkyU846xUdRKtSf4YGmjKS1SGqC522oC+tHMT+tFv7JJ
	 gCydci9tUqIjI+3uJApg/vvKkgNQnl84DO28CScAoeUpnZadwLcN7j+e/ym6FJSb3K
	 TanO9xOKxAi5f91iAcsxe9MPgX8XogZtXKpecdy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfBUB0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:26:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfBUB0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:26:20 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ADE42147A;
        Thu, 21 Feb 2019 01:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712380;
        bh=BAwRHPzSeKQ8p79VFmyAROLJGQKsejY7NCCgcgNqqMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tMKotUQnwZr5TEHQHlCgfYxLUL5KYI5sR3cQT9ZMF4hXViG27CEkxBuLNqzoRV4g2
         fnBV+qhRnzWm1IJjaX26qdGsZfVHeRHlqAKZTkhIztk9RWfgAi7U5Q81yHSoOJkMbT
         JZdMuJLBuP3m+g3beibT8xuWda6ak3KXegPcSa7w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        He Kuang <hekuang@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/17] perf report: Don't shadow inlined symbol with different addr range
Date:   Wed, 20 Feb 2019 22:25:38 -0300
Message-Id: <20190221012549.4069-7-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Kuang <hekuang@huawei.com>

We can't assume inlined symbols with the same name are equal, because
their address range may be different. This will cause the symbols with
different addresses be shadowed when adding to the hist entry, and lead
to ERANGE error when checking the symbol address during sample parse,
the addr should be within the range of [sym.start, sym.end].

The error message is like: "0x36aea60 [0x8]: failed to process type: 68".

The second parameter of symbol__new() is the length of the fake symbol
for the inline frame, which is the subtraction of the end and start
address of base_sym.

Signed-off-by: He Kuang <hekuang@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: aa441895f7b4 ("perf report: Compare symbol name for inlined frames when sorting")
Link: http://lkml.kernel.org/r/20190219130531.15692-1-hekuang@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c    | 10 ++++++++--
 tools/perf/util/srcline.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2b6c1ccb878c..d2299e912e59 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -231,8 +231,14 @@ static int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
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
index 00f215580b5a..10ca1533937e 100644
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
2.19.1

