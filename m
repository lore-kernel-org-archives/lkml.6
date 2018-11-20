Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68962C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9D421479
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9D421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbeKTMbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:31:03 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:45430 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726119AbeKTMbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:31:03 -0500
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 20 Nov 2018 11:04:21 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.125 with ESMTP; 20 Nov 2018 11:04:21 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Tue, 20 Nov 2018 11:04:21 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>, kernel-team@lge.com
Subject: Re: [PATCH 05/12] perf top: Moving lost events warning to helpline
Message-ID: <20181120020421.GE20153@sejong>
References: <20181119122016.22423-1-jolsa@kernel.org>
 <20181119122016.22423-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119122016.22423-6-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:20:09PM +0100, Jiri Olsa wrote:
> We can't display the UI box saying that we are slow in reader
> thread. That will make perf top even slower and user even more
> angry ;-)
> 
> Moving the UI box message out of the reader thread into UI thread
> and changing it into helpline, so there's no 'press any key'
> necessary.
> 
> Link: http://lkml.kernel.org/n/tip-0rpmmt3omlait889ewp1cl61@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-top.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 047e99de09f3..1d77aa7650da 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -553,8 +553,6 @@ static void perf_top__sort_new_samples(void *arg)
>  	struct perf_evsel *evsel = t->sym_evsel;
>  	struct hists *hists;
>  
> -	perf_top__reset_sample_counters(t);
> -
>  	if (t->evlist->selected != NULL)
>  		t->sym_evsel = t->evlist->selected;
>  
> @@ -571,6 +569,11 @@ static void perf_top__sort_new_samples(void *arg)
>  
>  	hists__collapse_resort(hists, NULL);
>  	perf_evsel__output_resort(evsel, NULL);
> +
> +	if (t->lost)
> +		ui_helpline__fpush("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");

In general, ui_helpline__[f]push() requires corresponding __pop()
which handles timeout logic (or something can dismiss the message).
The ui_helpline__show() is to show the message and overwrite the old
one.

But we don't use it strictly and I think just pr_err() or pr_warning()
is ok here (which call ui_helpline__show() internally).

Anyway, I found that tui_helpline__push() should use ui__lock.
Otherwise it could race with display thread and break rendering.
A bug from the beginning but no one reported... :)

Thanks,
Namhyung


From a5c3a0c88b9d13fedc65b61a45d99fc3abef0089 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 20 Nov 2018 10:56:03 +0900
Subject: [PATCH] perf ui/tui: Fix possible UI rendering breakage

The tui_helpline__push() should acquire/release the ui__lock when it
deals with screen setting.  Otherwise it could race with display thread
and screen rendering would not be handled properly.

Fixes: e6e904687949 ("perf ui: Introduce struct ui_helpline")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/tui/helpline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index 4ca799aadb4e..ff38b997f457 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -20,11 +20,13 @@ static void tui_helpline__push(const char *msg)
 {
 	const size_t sz = sizeof(ui_helpline__current);
 
+	pthread_mutex_lock(&ui__lock);
 	SLsmg_gotorc(SLtt_Screen_Rows - 1, 0);
 	SLsmg_set_color(0);
 	SLsmg_write_nstring((char *)msg, SLtt_Screen_Cols);
 	SLsmg_refresh();
 	strncpy(ui_helpline__current, msg, sz)[sz - 1] = '\0';
+	pthread_mutex_unlock(&ui__lock);
 }
 
 static int tui_helpline__show(const char *format, va_list ap)
-- 
2.19.0

