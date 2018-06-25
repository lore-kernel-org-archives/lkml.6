Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B22C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC3A25F77
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX47KMQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC3A25F77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965107AbeFYRmJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965075AbeFYRmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:42:05 -0400
Received: from jouet.infradead.org (unknown [177.79.80.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A991725F87;
        Mon, 25 Jun 2018 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529948525;
        bh=c9tLMGasGWkzRxsoiqgqVNj7bjy1tIya/8a39xMrDsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tX47KMQCd6mtDO3JJVqIQXY2IiEfzuA6K2Ts2hyXhMWs0Y3eEBCANZahP0FnLUjE0
         64VKfAH8Lhm2hS6v7we60eeCqSgUEcEiiy7ltJVhdOBnFFkM0mGoInJetBFESI4RHM
         7WqOoIZ81/d77LHHCkOOPLY8GqF8igdisd/GYkq4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/19] perf script: Fix crash because of missing evsel->priv
Date:   Mon, 25 Jun 2018 14:40:44 -0300
Message-Id: <20180625174045.25765-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

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
-- 
2.14.3

