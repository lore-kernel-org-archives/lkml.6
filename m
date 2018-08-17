Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D22218EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D22218EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeHQMvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:51:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbeHQMvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:51:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB04F26377;
        Fri, 17 Aug 2018 09:48:27 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EEB11746E;
        Fri, 17 Aug 2018 09:48:26 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 07/13] perf tools: Store compression id into struct dso
Date:   Fri, 17 Aug 2018 11:48:07 +0200
Message-Id: <20180817094813.15086-8-jolsa@kernel.org>
In-Reply-To: <20180817094813.15086-1-jolsa@kernel.org>
References: <20180817094813.15086-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 17 Aug 2018 09:48:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 17 Aug 2018 09:48:28 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding comp into struct dso to hold the compression index.
It will be used in following patches.

Link: http://lkml.kernel.org/n/tip-84cxf8bbc0etndwzrzqxxi2d@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/dso.c     | 5 ++++-
 tools/perf/util/dso.h     | 1 +
 tools/perf/util/machine.c | 4 +++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index f5f8babea17c..f0e4cc43c97e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -418,8 +418,10 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
 		dso->symtab_type = DSO_BINARY_TYPE__GUEST_KMODULE;
 
 	/* _KMODULE_COMP should be next to _KMODULE */
-	if (m->kmod && m->comp)
+	if (m->kmod && m->comp) {
 		dso->symtab_type++;
+		dso->comp = m->comp;
+	}
 
 	dso__set_short_name(dso, strdup(m->name), true);
 }
@@ -1225,6 +1227,7 @@ struct dso *dso__new(const char *name)
 		dso->a2l_fails = 1;
 		dso->kernel = DSO_TYPE_USER;
 		dso->needs_swap = DSO_SWAP__UNSET;
+		dso->comp = COMP_ID__NONE;
 		RB_CLEAR_NODE(&dso->rb_node);
 		dso->root = NULL;
 		INIT_LIST_HEAD(&dso->node);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 7bde23f6e5a9..a6c7af52115f 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -175,6 +175,7 @@ struct dso {
 	u16		 short_name_len;
 	void		*dwfl;			/* DWARF debug info */
 	struct auxtrace_cache *auxtrace_cache;
+	int		 comp;
 
 	/* dso data file */
 	struct {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b300a3973448..c4acd2001db0 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1212,8 +1212,10 @@ static int map_groups__set_module_path(struct map_groups *mg, const char *path,
 	 * Full name could reveal us kmod compression, so
 	 * we need to update the symtab_type if needed.
 	 */
-	if (m->comp && is_kmod_dso(map->dso))
+	if (m->comp && is_kmod_dso(map->dso)) {
 		map->dso->symtab_type++;
+		map->dso->comp = m->comp;
+	}
 
 	return 0;
 }
-- 
2.17.1

