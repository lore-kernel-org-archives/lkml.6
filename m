Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B6C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9582173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yertr6hN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9582173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeHTTdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:33:05 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D5992170E;
        Mon, 20 Aug 2018 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781809;
        bh=Oj4GYUZRKhFKEckCbgj30wHYbV6J6QAWW1kkdKJiduo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yertr6hNCHwhssy5qAjWatM5wt9SI2zDAukLFP4hiKvWcpZxaez5ByIEpBeyxzQRR
         byj7KifqrKBvgKJ/M5J83BNbTevXHeBCi8j3oiiX94kk/Q/JnB8jO5V6X5Hv/A2fjx
         mqZpyxNY+svJUsCqBi5pcv+t5om1thAkr2ZEPBBM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/21] perf tools: Store compression id into struct dso
Date:   Mon, 20 Aug 2018 13:15:52 -0300
Message-Id: <20180820161602.6830-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add comp to 'struct dso' to hold the compression index.  It will be used
in the following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c     | 5 ++++-
 tools/perf/util/dso.h     | 1 +
 tools/perf/util/machine.c | 4 +++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d34e47bb09d9..d875e6956a3e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -417,8 +417,10 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
 		dso->symtab_type = DSO_BINARY_TYPE__GUEST_KMODULE;
 
 	/* _KMODULE_COMP should be next to _KMODULE */
-	if (m->kmod && m->comp)
+	if (m->kmod && m->comp) {
 		dso->symtab_type++;
+		dso->comp = m->comp;
+	}
 
 	dso__set_short_name(dso, strdup(m->name), true);
 }
@@ -1224,6 +1226,7 @@ struct dso *dso__new(const char *name)
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
2.14.4

