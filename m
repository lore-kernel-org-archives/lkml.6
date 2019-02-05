Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80677C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5902720844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfBENi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:38:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbfBENi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:38:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED57E19CBF3;
        Tue,  5 Feb 2019 13:38:56 +0000 (UTC)
Received: from krava (unknown [10.43.17.224])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9D1F783B85;
        Tue,  5 Feb 2019 13:38:54 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:38:53 +0100
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
Subject: Re: [PATCH 01/14] perf tools: Make rm_rf to remove single file
Message-ID: <20190205133853.GG4794@krava>
References: <20190203153018.9650-1-jolsa@kernel.org>
 <20190203153018.9650-2-jolsa@kernel.org>
 <6c505cd6-9b49-5c47-8e8d-5b1fa68d1a69@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c505cd6-9b49-5c47-8e8d-5b1fa68d1a69@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 05 Feb 2019 13:38:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 02:33:06PM +0300, Alexey Budankov wrote:
> 
> On 03.02.2019 18:30, Jiri Olsa wrote:
> > Let rm_rf remove file if it's provided by path.
> > 
> > Link: http://lkml.kernel.org/n/tip-whhp3ej5795l9dc86xfyyp74@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/util.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> > index 320b0fef249a..58b8d6a8bfbc 100644
> > --- a/tools/perf/util/util.c
> > +++ b/tools/perf/util/util.c
> > @@ -125,8 +125,14 @@ int rm_rf(const char *path)
> >  	char namebuf[PATH_MAX];
> >  
> >  	dir = opendir(path);
> > -	if (dir == NULL)
> > -		return 0;
> > +	if (dir == NULL) {
> > +		/*
> > +		 * The path does not exist or is not directory,
> > +		 * so there's no harm to try remove it. This way
> > +		 * rm_rf will work over single file.
> > +		 */
> 
> This can also happen due to lack of fds or memory.
> Not sure file still has to be deleted in these cases.

ok, will do proper error check

thanks,
jirka

> 
> - Alexey
> 
> > +		return unlink(path);
> > +	}
> >  
> >  	while ((d = readdir(dir)) != NULL && !ret) {
> >  		struct stat statbuf;
> > 
