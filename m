Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E420C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594B2208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594B2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeJQARI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:17:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbeJQARI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:17:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 808D19F726;
        Tue, 16 Oct 2018 16:25:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id C11E871CA9;
        Tue, 16 Oct 2018 16:25:55 +0000 (UTC)
Date:   Tue, 16 Oct 2018 18:25:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [BUG] perf stat: hangs with -p and process completes
Message-ID: <20181016162554.GD6631@krava>
References: <CABPqkBTEOwKrq6ZJo3W-rZQi56OWorWo3VcOTwV17QxZBckS0Q@mail.gmail.com>
 <20181016110341.GB18450@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016110341.GB18450@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 16 Oct 2018 16:25:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 01:03:41PM +0200, Jiri Olsa wrote:
> On Fri, Oct 12, 2018 at 02:26:09PM -0700, Stephane Eranian wrote:
> > Hi,
> > 
> > I am running into a perf stat issue with the -p option which allows you
> > to attach to a running process. If that process happens to terminate
> > while under monitoring
> > perf hangs in there and never terminates. The proper behavior would be to stop.
> > I can see the issue in that the attached process is not a child, so
> > wait() would not work.
> > 
> > To reproduce:
> >   $ sleep 10 &
> >   $ perf stat -p $!
> > 
> > doing the same with perf record works, so there is a solution to this problem.
> 
> yea, we don't poll for the event state change in perf stat,
> but we do that in perf record.. also because the perf poll
> code in kernel is originaly meant for tracking the ring
> buffer state
> 
> maybe we could return EPOLLIN for alive events without ring
> buffer.. like below (totaly untested) and add polling for 
> event state into perf stat 
> 
> cc-ing perf folks
> 

on the second thought attached patch works as well
without kernel change

jirka


---
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b86aba1c8028..d1028d7755bb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -409,6 +409,28 @@ static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
 	return leader;
 }
 
+static bool is_target_alive(struct target *_target,
+			    struct thread_map *threads)
+{
+	struct stat st;
+	int i;
+
+	if (!target__has_task(_target))
+		return true;
+
+	for (i = 0; i < threads->nr; i++) {
+		char path[PATH_MAX];
+
+		scnprintf(path, PATH_MAX, "%s/%d", procfs__mountpoint(),
+			  threads->map[i].pid);
+
+		if (!stat(path, &st))
+			return true;
+	}
+
+	return false;
+}
+
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -579,6 +601,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		enable_counters();
 		while (!done) {
 			nanosleep(&ts, NULL);
+			if (!is_target_alive(&target, evsel_list->threads))
+				break;
 			if (timeout)
 				break;
 			if (interval) {
