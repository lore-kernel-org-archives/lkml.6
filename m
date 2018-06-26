Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A580C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0D0265B4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0D0265B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeFZHBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:01:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37103 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbeFZHBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:01:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q70Mse1592243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 00:00:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q70MFK1592240;
        Tue, 26 Jun 2018 00:00:22 -0700
Date:   Tue, 26 Jun 2018 00:00:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-a3af66f51bd0bca72881ead4bf2bd19cb366582b@git.kernel.org>
Cc:     dsahern@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
        acme@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com,
        namhyung@kernel.org, davidcc@google.com, hpa@zytor.com,
        mingo@kernel.org, jolsa@redhat.com
Reply-To: acme@redhat.com, alexander.shishkin@linux.intel.com,
          ak@linux.intel.com, yao.jin@linux.intel.com, dsahern@gmail.com,
          ravi.bangoria@linux.ibm.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org, jolsa@redhat.com,
          namhyung@kernel.org, davidcc@google.com, hpa@zytor.com
In-Reply-To: <20180625124220.6434-3-ravi.bangoria@linux.ibm.com>
References: <20180625124220.6434-3-ravi.bangoria@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Fix crash because of missing
 evsel->priv
Git-Commit-ID: a3af66f51bd0bca72881ead4bf2bd19cb366582b
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

Commit-ID:  a3af66f51bd0bca72881ead4bf2bd19cb366582b
Gitweb:     https://git.kernel.org/tip/a3af66f51bd0bca72881ead4bf2bd19cb366582b
Author:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate: Mon, 25 Jun 2018 18:12:19 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:37 -0300

perf script: Fix crash because of missing evsel->priv

'perf script' in piped mode is crashing because evsel->priv is not set
properly. Fix it.

Before:

  # perf record -o - -- ls | perf script
  <SNIP 'ls' output>
    Segmentation fault (core dumped)
  #

After:

  # perf record -o - -- ls | perf script
  <SNIP 'ls' output>
  ls 2282 1031.731974:  250000 cpu-clock:uhH:  7effe4b3d29e
  ls 2282 1031.732222:  250000 cpu-clock:uhH:  7effe4b3a650
  #

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: a14390fde64e ("perf script: Allow creating per-event dump files")
Link: http://lkml.kernel.org/r/20180625124220.6434-3-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f3fefbcc4503..ad2ac1300420 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1834,6 +1834,7 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	struct perf_evlist *evlist;
 	struct perf_evsel *evsel, *pos;
 	int err;
+	static struct perf_evsel_script *es;
 
 	err = perf_event__process_attr(tool, event, pevlist);
 	if (err)
@@ -1842,6 +1843,19 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	evlist = *pevlist;
 	evsel = perf_evlist__last(*pevlist);
 
+	if (!evsel->priv) {
+		if (scr->per_event_dump) {
+			evsel->priv = perf_evsel_script__new(evsel,
+						scr->session->data);
+		} else {
+			es = zalloc(sizeof(*es));
+			if (!es)
+				return -ENOMEM;
+			es->fp = stdout;
+			evsel->priv = es;
+		}
+	}
+
 	if (evsel->attr.type >= PERF_TYPE_MAX &&
 	    evsel->attr.type != PERF_TYPE_SYNTH)
 		return 0;
