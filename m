Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id o9EJLN5HGVs9QQAAmS7hNA
	; Thu, 07 Jun 2018 14:59:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CDB29608C9; Thu,  7 Jun 2018 14:59:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3D3C36074D;
	Thu,  7 Jun 2018 14:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D3C36074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935657AbeFGO7X (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:59:23 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41259 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935646AbeFGO7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:59:18 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbv-0005hK-Bx; Thu, 07 Jun 2018 15:09:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaz-0002lL-Ot; Thu, 07 Jun 2018 15:08:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Ahern" <dsahern@gmail.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Jiri Olsa" <jolsa@redhat.com>, "Wang Nan" <wangnan0@huawei.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.460932226@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 065/410] perf evlist: Introduce perf_evlist__new_dummy
 constructor
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 5bae0250237f7a5ec4355f9920701de247b8db91 upstream.

For case where all we need is an evlist with just an "dummy" evsel,
like in some 'perf test' entries.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-q52le0pblm2k3ncvyilelr9z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/perf/util/evlist.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  3 +++
 2 files changed, 31 insertions(+)

--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -62,6 +62,18 @@ struct perf_evlist *perf_evlist__new_def
 	return evlist;
 }
 
+struct perf_evlist *perf_evlist__new_dummy(void)
+{
+	struct perf_evlist *evlist = perf_evlist__new();
+
+	if (evlist && perf_evlist__add_dummy(evlist)) {
+		perf_evlist__delete(evlist);
+		evlist = NULL;
+	}
+
+	return evlist;
+}
+
 /**
  * perf_evlist__set_id_pos - set the positions of event ids.
  * @evlist: selected event list
@@ -188,6 +200,22 @@ error:
 	return -ENOMEM;
 }
 
+int perf_evlist__add_dummy(struct perf_evlist *evlist)
+{
+	struct perf_event_attr attr = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config = PERF_COUNT_SW_DUMMY,
+		.size	= sizeof(attr), /* to capture ABI version */
+	};
+	struct perf_evsel *evsel = perf_evsel__new(&attr);
+
+	if (evsel == NULL)
+		return -ENOMEM;
+
+	perf_evlist__add(evlist, evsel);
+	return 0;
+}
+
 static int perf_evlist__add_attrs(struct perf_evlist *evlist,
 				  struct perf_event_attr *attrs, size_t nr_attrs)
 {
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -54,6 +54,7 @@ struct perf_evsel_str_handler {
 
 struct perf_evlist *perf_evlist__new(void);
 struct perf_evlist *perf_evlist__new_default(void);
+struct perf_evlist *perf_evlist__new_dummy(void);
 void perf_evlist__init(struct perf_evlist *evlist, struct cpu_map *cpus,
 		       struct thread_map *threads);
 void perf_evlist__exit(struct perf_evlist *evlist);
@@ -67,6 +68,8 @@ int __perf_evlist__add_default_attrs(str
 #define perf_evlist__add_default_attrs(evlist, array) \
 	__perf_evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
 
+int perf_evlist__add_dummy(struct perf_evlist *evlist);
+
 int perf_evlist__add_newtp(struct perf_evlist *evlist,
 			   const char *sys, const char *name, void *handler);
 
