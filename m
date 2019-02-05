Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2079AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2775207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfBENmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:42:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfBENmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:42:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECA1481DE3;
        Tue,  5 Feb 2019 13:42:37 +0000 (UTC)
Received: from krava (unknown [10.43.17.224])
        by smtp.corp.redhat.com (Postfix) with SMTP id B54BC189A4;
        Tue,  5 Feb 2019 13:42:35 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:42:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 06/14] perf data: Add perf_data__(create_dir|free_dir)
 functions
Message-ID: <20190205134234.GH4794@krava>
References: <20190203153018.9650-1-jolsa@kernel.org>
 <20190203153018.9650-7-jolsa@kernel.org>
 <19a2d4fd-11b4-dc80-2d0a-c4bccd95736c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19a2d4fd-11b4-dc80-2d0a-c4bccd95736c@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 05 Feb 2019 13:42:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 02:52:58PM +0300, Alexey Budankov wrote:
> 
> On 03.02.2019 18:30, Jiri Olsa wrote:
> > Adding perf_data__create_dir to create nr files inside
> > struct perf_data path directory:
> >   int perf_data__create_dir(struct perf_data *data, int nr);
> > 
> > and function to free that data:
> >   void perf_data__free_dir(struct perf_data *data);
> > 
> > Link: http://lkml.kernel.org/n/tip-kl4s1f13cg6wycrg367p85qm@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/data.c | 47 ++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/data.h |  8 +++++++
> >  2 files changed, 55 insertions(+)
> > 
> > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > index 0a3051cc0ea0..ff1d9e5bd68d 100644
> > --- a/tools/perf/util/data.c
> > +++ b/tools/perf/util/data.c
> > @@ -7,11 +7,58 @@
> >  #include <fcntl.h>
> >  #include <unistd.h>
> >  #include <string.h>
> > +#include <asm/bug.h>
> >  
> >  #include "data.h"
> >  #include "util.h"
> >  #include "debug.h"
> >  
> > +static void free_dir(struct perf_data_file *files, int nr)
> > +{
> > +	while (--nr >= 1) {
> > +		close(files[nr].fd);
> > +		free(files[nr].path);
> > +	}
> > +	free(files);
> 
> It implements closing of created files and frees corresponding memory.
> However it doesn't delete the files what looks like the proper rollback
> from perf_data__create_dir() in case of some open() failure.

we don't di rollback event for the single file:

	[jolsa@krava perf]$ ./perf record -b ls
	Error:
	You may not have permission to collect stats.

	Consider tweaking /proc/sys/kernel/perf_event_paranoid,
	which controls use of the performance events system by
	unprivileged users (without CAP_SYS_ADMIN).

	The current value is 2:

	  -1: Allow use of (almost) all events by all users
	      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
	>= 0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN
	      Disallow raw tracepoint access by users without CAP_SYS_ADMIN
	>= 1: Disallow CPU event access by users without CAP_SYS_ADMIN
	>= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN

	To make this setting permanent, edit /etc/sysctl.conf too, e.g.:

		kernel.perf_event_paranoid = -1

	[jolsa@krava perf]$ ll perf.data
	-rw-------. 1 jolsa jolsa 0 Feb  5 14:40 perf.data

there're multiple points where we could fail during the processing
and fail record command with unfinished perf.data, but yes, I think
we should address that and have some cleanup, I'll check

thanks,
jirka
