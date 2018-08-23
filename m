Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D39C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E682C2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E682C2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbeHWMNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:13:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731886AbeHWMLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:11:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8gJfN3189190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:42:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8gJlg3189187;
        Thu, 23 Aug 2018 01:42:19 -0700
Date:   Thu, 23 Aug 2018 01:42:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-2af5247530e073f4146d74ecd96cf64c953c001c@git.kernel.org>
Cc:     mpetlan@redhat.com, mingo@kernel.org, namhyung@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        jolsa@kernel.org, dsahern@gmail.com, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, dsahern@gmail.com, tglx@linutronix.de,
          peterz@infradead.org, acme@redhat.com, mpetlan@redhat.com,
          mingo@kernel.org, hpa@zytor.com, namhyung@kernel.org
In-Reply-To: <20180817094813.15086-8-jolsa@kernel.org>
References: <20180817094813.15086-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Store compression id into struct dso
Git-Commit-ID: 2af5247530e073f4146d74ecd96cf64c953c001c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2af5247530e073f4146d74ecd96cf64c953c001c
Gitweb:     https://git.kernel.org/tip/2af5247530e073f4146d74ecd96cf64c953c001c
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 11:48:07 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf tools: Store compression id into struct dso

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
