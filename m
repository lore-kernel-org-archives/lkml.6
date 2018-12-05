Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E5DC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8802084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544025937;
	bh=o48pzkt/4xF8cFm8Nx30igUkMILu8n6cNEW2dYOan7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yFFAJkJ9b+PFKEhC9y3K+POkv4F5Zf9LCwZPChcezRBW+XZoNc+UdZEpunApI9/2Y
	 O7VOTR3h0+Sf0SUzyekfs1s0x1rxQsMlA6SDEZ2rM2wXlzETZqGEVaGic6bjn4PkoL
	 5Ar+5hPRTf3UITNM7rzsJX9YvQThxTvH8AAEJxec=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8802084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeLEQFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:05:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbeLEQFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:05:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3402689AC8;
        Wed,  5 Dec 2018 16:05:33 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2E9C5C5FE;
        Wed,  5 Dec 2018 16:05:30 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH 7/8] perf trace: Move event delivery to deliver_event function
Date:   Wed,  5 Dec 2018 17:05:08 +0100
Message-Id: <20181205160509.1168-8-jolsa@kernel.org>
In-Reply-To: <20181205160509.1168-1-jolsa@kernel.org>
References: <20181205160509.1168-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 05 Dec 2018 16:05:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving event delivery code to deliver_event function,
so it's easier to add conditional ordered delivery
coming in following patches.

Link: http://lkml.kernel.org/n/tip-qz9wzti2cw6q7swja0h2x4sf@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-trace.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a663ec346a8e..b4b1dafe882a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2641,6 +2641,21 @@ static int trace__set_filter_pids(struct trace *trace)
 	return err;
 }
 
+static int deliver_event(struct trace *trace, union perf_event *event)
+{
+	struct perf_evlist *evlist = trace->evlist;
+	struct perf_sample sample;
+	int err;
+
+	err = perf_evlist__parse_sample(evlist, event, &sample);
+	if (err)
+		fprintf(trace->output, "Can't parse sample, err = %d, skipping...\n", err);
+	else
+		trace__handle_event(trace, event, &sample);
+
+	return 0;
+}
+
 static int trace__run(struct trace *trace, int argc, const char **argv)
 {
 	struct perf_evlist *evlist = trace->evlist;
@@ -2806,18 +2821,10 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
-			struct perf_sample sample;
-
 			++trace->nr_events;
 
-			err = perf_evlist__parse_sample(evlist, event, &sample);
-			if (err) {
-				fprintf(trace->output, "Can't parse sample, err = %d, skipping...\n", err);
-				goto next_event;
-			}
+			deliver_event(trace, event);
 
-			trace__handle_event(trace, event, &sample);
-next_event:
 			perf_mmap__consume(md);
 
 			if (interrupted)
-- 
2.17.2

