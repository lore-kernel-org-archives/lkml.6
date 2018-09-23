Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21195ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3E621473
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3E621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeIXBn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 21:43:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbeIXBn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 21:43:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA44785362;
        Sun, 23 Sep 2018 19:45:20 +0000 (UTC)
Received: from krava (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8F9A5827AC;
        Sun, 23 Sep 2018 19:45:18 +0000 (UTC)
Date:   Sun, 23 Sep 2018 21:45:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 02/48] perf tools: Remove perf_tool from event_op3
Message-ID: <20180923194517.GJ30923@krava>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-3-jolsa@kernel.org>
 <20180918205609.GB311@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918205609.GB311@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 23 Sep 2018 19:45:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 05:56:09PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 13, 2018 at 02:54:04PM +0200, Jiri Olsa escreveu:
> > Now when we keep perf_tool pointer inside perf_session,
> > there's no need to have perf_tool argument in the
> > event_op3 callback. Removing it.
> > 
> > Link: http://lkml.kernel.org/n/tip-78u9m0jbre3bn16l6guqfyrf@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-inject.c | 6 +++---
> >  tools/perf/util/auxtrace.c  | 7 +++----
> >  tools/perf/util/auxtrace.h  | 5 ++---
> >  tools/perf/util/session.c   | 8 +++-----
> >  tools/perf/util/tool.h      | 4 +---
> >  5 files changed, 12 insertions(+), 18 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index d77ed2aea95a..03fc65da0657 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -131,10 +131,10 @@ static int copy_bytes(struct perf_inject *inject, int fd, off_t size)
> >  	return 0;
> >  }
> >  
> > -static s64 perf_event__repipe_auxtrace(struct perf_tool *tool,
> > -				       union perf_event *event,
> > -				       struct perf_session *session)
> > +static s64 perf_event__repipe_auxtrace(struct perf_session *session,
> > +				       union perf_event *event)
> >  {
> > +	struct perf_tool *tool = session->tool;
> >  	struct perf_inject *inject = container_of(tool, struct perf_inject,
> >  						  tool);
> >  	int ret;
> 
> You forgot the !HAVE_AUXTRACE_SUPPORT case, fixed with:

oops, thanks ;-)

jirka

> 
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 03fc65da0657..b4a29f435b06 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -172,9 +172,8 @@ static s64 perf_event__repipe_auxtrace(struct perf_session *session,
>  #else
>  
>  static s64
> -perf_event__repipe_auxtrace(struct perf_tool *tool __maybe_unused,
> -			    union perf_event *event __maybe_unused,
> -			    struct perf_session *session __maybe_unused)
> +perf_event__repipe_auxtrace(struct perf_session *session __maybe_unused,
> +			    union perf_event *event __maybe_unused)
>  {
>  	pr_err("AUX area tracing not supported\n");
>  	return -EINVAL;
