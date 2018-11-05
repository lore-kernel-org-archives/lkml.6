Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E936EC32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9AC20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9AC20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeKEKHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:07:38 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46686 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeKEKHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:07:38 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4F68C14883D29;
        Sun,  4 Nov 2018 16:50:40 -0800 (PST)
Date:   Sun, 04 Nov 2018 16:50:39 -0800 (PST)
Message-Id: <20181104.165039.878682622135788379.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181104201821.GA22049@krava>
References: <20181031.090816.2117345408719881030.davem@davemloft.net>
        <20181102.233003.1814045087128749000.davem@davemloft.net>
        <20181104201821.GA22049@krava>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 04 Nov 2018 16:50:40 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>
Date: Sun, 4 Nov 2018 21:18:21 +0100

> do you have some code I could check on?

All I have is this patch which parallelizes the mmap readers in perf
top.

It's not complete and you need to add proper locking, particularly around
the machine__resolve() call.

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d21d875..e214225 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -725,7 +725,9 @@ static void perf_event__process_sample(struct perf_tool *tool,
 	if (event->header.misc & PERF_RECORD_MISC_EXACT_IP)
 		top->exact_samples++;
 
-	if (machine__resolve(machine, &al, sample) < 0)
+	err = machine__resolve(machine, &al, sample);
+
+	if (err < 0)
 		return;
 
 	if (!machine->kptr_restrict_warned &&
@@ -877,6 +879,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 	perf_mmap__read_done(md);
 }
 
+#if 0
 static void perf_top__mmap_read(struct perf_top *top)
 {
 	bool overwrite = top->record_opts.overwrite;
@@ -903,6 +906,7 @@ static void perf_top__mmap_read(struct perf_top *top)
 			    "decreasing the freq (-F) or\n"
 			    "limiting the number of CPUs (-C)\n");
 }
+#endif
 
 /*
  * Check per-event overwrite term.
@@ -1063,6 +1067,59 @@ static int callchain_param__setup_sample_type(struct callchain_param *callchain)
 	return 0;
 }
 
+struct mmap_thread_arg {
+	struct perf_top *top;
+	int index;
+};
+
+static void *mmap_thread_worker(void *arg)
+{
+	struct mmap_thread_arg *ap = arg;
+
+	while (!done)
+		perf_top__mmap_read_idx(ap->top, ap->index);
+
+	return NULL;
+}
+
+static pthread_t *mmap_threads;
+
+static int blitzkreig_bop(struct perf_top *top)
+{
+	struct perf_evlist *evlist = top->evlist;
+	int i, nr_threads = evlist->nr_mmaps;
+	struct mmap_thread_arg *ap;
+
+	fprintf(stderr, "Creating %d mmap threads\n", nr_threads);
+	fflush(stderr);
+
+	ap = calloc(sizeof(*ap), nr_threads);
+	if (!ap)
+		return -ENOMEM;
+
+	mmap_threads = calloc(sizeof(pthread_t), nr_threads);
+	if (!mmap_threads) {
+		free(ap);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < nr_threads; i++) {
+		ap[i].top = top;
+		ap[i].index = i;
+	}
+
+	/* Current thread will handle index zero.  */
+	for (i = 1; i < nr_threads; i++) {
+		int err = pthread_create(&mmap_threads[i], NULL,
+					 mmap_thread_worker, &ap[i]);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int __cmd_top(struct perf_top *top)
 {
 	char msg[512];
@@ -1134,11 +1191,6 @@ static int __cmd_top(struct perf_top *top)
         if (!target__none(&opts->target))
                 perf_evlist__enable(top->evlist);
 
-	/* Wait for a minimal set of events before starting the snapshot */
-	perf_evlist__poll(top->evlist, 100);
-
-	perf_top__mmap_read(top);
-
 	ret = -1;
 	if (pthread_create(&thread, NULL, (use_browser > 0 ? display_thread_tui :
 							    display_thread), top)) {
@@ -1156,13 +1208,30 @@ static int __cmd_top(struct perf_top *top)
 		}
 	}
 
+	ret = blitzkreig_bop(top);
+	if (ret)
+		goto out_join;
+
+#if 1
+	perf_top__mmap_read_idx(top, 0);
+#else
+	/* Wait for a minimal set of events before starting the snapshot */
+	perf_evlist__poll(top->evlist, 100);
+	perf_top__mmap_read(top);
+#endif
+
 	while (!done) {
+#if 0
 		u64 hits = top->samples;
+#endif
 
+#if 1
+		perf_top__mmap_read_idx(top, 0);
+#else
 		perf_top__mmap_read(top);
-
 		if (opts->overwrite || (hits == top->samples))
 			ret = perf_evlist__poll(top->evlist, 100);
+#endif
 
 		if (resize) {
 			perf_top__resize(top);
@@ -1257,7 +1326,7 @@ int cmd_top(int argc, const char **argv)
 				.uses_mmap   = true,
 			},
 			.proc_map_timeout    = 500,
-			.overwrite	= 1,
+			.overwrite	= 0,
 		},
 		.max_stack	     = sysctl__max_stack(),
 		.annotation_opts     = annotation__default_options,
