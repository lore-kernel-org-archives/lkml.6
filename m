Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B21EC46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D3020851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D3020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbeKTWGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:06:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbeKTWGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:06:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 239477F6C7;
        Tue, 20 Nov 2018 11:37:48 +0000 (UTC)
Received: from krava (unknown [10.43.17.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8F31A5D6A9;
        Tue, 20 Nov 2018 11:37:45 +0000 (UTC)
Date:   Tue, 20 Nov 2018 12:37:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>, kernel-team@lge.com
Subject: [PATCHv2 05/12] perf top: Moving lost events warning to helpline
Message-ID: <20181120113744.GF8967@krava>
References: <20181119122016.22423-1-jolsa@kernel.org>
 <20181119122016.22423-6-jolsa@kernel.org>
 <20181120020421.GE20153@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120020421.GE20153@sejong>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 20 Nov 2018 11:37:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:04:21AM +0900, Namhyung Kim wrote:
> On Mon, Nov 19, 2018 at 01:20:09PM +0100, Jiri Olsa wrote:
> > We can't display the UI box saying that we are slow in reader
> > thread. That will make perf top even slower and user even more
> > angry ;-)
> > 
> > Moving the UI box message out of the reader thread into UI thread
> > and changing it into helpline, so there's no 'press any key'
> > necessary.
> > 
> > Link: http://lkml.kernel.org/n/tip-0rpmmt3omlait889ewp1cl61@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-top.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index 047e99de09f3..1d77aa7650da 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -553,8 +553,6 @@ static void perf_top__sort_new_samples(void *arg)
> >  	struct perf_evsel *evsel = t->sym_evsel;
> >  	struct hists *hists;
> >  
> > -	perf_top__reset_sample_counters(t);
> > -
> >  	if (t->evlist->selected != NULL)
> >  		t->sym_evsel = t->evlist->selected;
> >  
> > @@ -571,6 +569,11 @@ static void perf_top__sort_new_samples(void *arg)
> >  
> >  	hists__collapse_resort(hists, NULL);
> >  	perf_evsel__output_resort(evsel, NULL);
> > +
> > +	if (t->lost)
> > +		ui_helpline__fpush("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
> 
> In general, ui_helpline__[f]push() requires corresponding __pop()
> which handles timeout logic (or something can dismiss the message).
> The ui_helpline__show() is to show the message and overwrite the old
> one.
> 
> But we don't use it strictly and I think just pr_err() or pr_warning()
> is ok here (which call ui_helpline__show() internally).

right, v2 attached

there were some small conflicts in follow up patches, I pushed
new version with resolved conflicts in perf/fixes branch

thanks,
jirka


---
We can't display the UI box saying that we are slow in reader
thread. That will make perf top even slower and user even more
angry ;-)

Moving the UI box message out of the reader thread into UI thread
and changing it into helpline, so there's no 'press any key'
necessary.

Link: http://lkml.kernel.org/n/tip-0rpmmt3omlait889ewp1cl61@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 047e99de09f3..d4105ba8510c 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -553,8 +553,6 @@ static void perf_top__sort_new_samples(void *arg)
 	struct perf_evsel *evsel = t->sym_evsel;
 	struct hists *hists;
 
-	perf_top__reset_sample_counters(t);
-
 	if (t->evlist->selected != NULL)
 		t->sym_evsel = t->evlist->selected;
 
@@ -571,6 +569,11 @@ static void perf_top__sort_new_samples(void *arg)
 
 	hists__collapse_resort(hists, NULL);
 	perf_evsel__output_resort(evsel, NULL);
+
+	if (t->lost)
+		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
+
+	perf_top__reset_sample_counters(t);
 }
 
 static void *display_thread_tui(void *arg)
@@ -908,10 +911,8 @@ static void perf_top__mmap_read(struct perf_top *top)
 {
 	bool overwrite = top->record_opts.overwrite;
 	struct perf_evlist *evlist = top->evlist;
-	unsigned long long start, end;
 	int i;
 
-	start = rdclock();
 	if (overwrite)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_DATA_PENDING);
 
@@ -922,13 +923,6 @@ static void perf_top__mmap_read(struct perf_top *top)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
 	}
-	end = rdclock();
-
-	if ((end - start) > (unsigned long long)top->delay_secs * NSEC_PER_SEC)
-		ui__warning("Too slow to read ring buffer.\n"
-			    "Please try increasing the period (-c) or\n"
-			    "decreasing the freq (-F) or\n"
-			    "limiting the number of CPUs (-C)\n");
 }
 
 /*
-- 
2.17.2

