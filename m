Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7931EC6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 14:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385B620659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 14:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385B620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeJNVsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 17:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbeJNVsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 17:48:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30F3DC059B78;
        Sun, 14 Oct 2018 14:07:02 +0000 (UTC)
Received: from krava (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 322191057FA2;
        Sun, 14 Oct 2018 14:07:00 +0000 (UTC)
Date:   Sun, 14 Oct 2018 16:06:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 3/3]: perf record: extend trace writing to multi AIO
Message-ID: <20181014140659.GA24510@krava>
References: <36159e5e-57cc-9734-501f-1856f59b4913@linux.intel.com>
 <6e4badbc-4c6d-b0f9-75fe-8f897d31b9f6@linux.intel.com>
 <20181012141736.GB30156@krava>
 <2e62d730-df83-19f4-6289-3e67583ea54d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e62d730-df83-19f4-6289-3e67583ea54d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 14 Oct 2018 14:07:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 07:28:23PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 12.10.2018 17:17, Jiri Olsa wrote:
> > On Thu, Oct 11, 2018 at 09:59:19PM +0300, Alexey Budankov wrote:
> > 
> > SNIP
> > 
> >> @@ -1490,6 +1514,13 @@ static int perf_record_config(const char *var, const char *value, void *cb)
> >>  		var = "call-graph.record-mode";
> >>  		return perf_default_config(var, value, cb);
> >>  	}
> >> +#ifdef HAVE_AIO_SUPPORT
> >> +	if (!strcmp(var, "record.aio")) {
> >> +		rec->opts.nr_cblocks = strtol(value, NULL, 0);
> >> +		if (!rec->opts.nr_cblocks)
> >> +			rec->opts.nr_cblocks = 1;
> >> +	}
> >> +#endif
> >>  
> >>  	return 0;
> >>  }
> >> @@ -1882,8 +1913,8 @@ static struct option __record_options[] = {
> >>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
> >>  		    "Parse options then exit"),
> >>  #ifdef HAVE_AIO_SUPPORT
> >> -	OPT_CALLBACK_NOOPT(0, "aio", &record.opts,
> >> -		     NULL, "Enable asynchronous trace writing mode",
> >> +	OPT_CALLBACK(0, "aio", &record.opts,
> >> +		     "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
> >>  		     record__aio_parse),
> > 
> > it stoped work with no argument:
> > 
> > [jolsa@krava perf]$ ./perf record --aio ls
> > Error:
> > You may not have permission to collect system-wide stats.
> 
> This is the fix below. However, perf record --aio -- ls works without it.
> I will resend the whole patch kit.

looks good, thanks

jirka
