Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D153C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449F121741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbeL0ILK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 03:11:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbeL0ILJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 03:11:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92A69BAE3;
        Thu, 27 Dec 2018 08:11:09 +0000 (UTC)
Received: from krava (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with SMTP id 75843608DD;
        Thu, 27 Dec 2018 08:11:07 +0000 (UTC)
Date:   Thu, 27 Dec 2018 09:11:06 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 1/5] perf session: Get rid of file_size variable
Message-ID: <20181227081106.GA3033@krava>
References: <20181226135132.29330-1-jolsa@kernel.org>
 <20181226135132.29330-2-jolsa@kernel.org>
 <20181226194342.GA19471@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226194342.GA19471@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 27 Dec 2018 08:11:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 04:43:42PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 26, 2018 at 02:51:28PM +0100, Jiri Olsa escreveu:
> > It's not needed and removing it makes the code little
> > more simple for upcoming changes.
> > 
> > It's safe to replace file_size with data_size, because
> > perf_data__size value is never smaller than data_offset
> > + data_size.
> 
> This is not applying to my perf/core branch, can you check?

hum, I've got clean rebase, pushed in perf/fixes

jirka

> 
> - Arnaldo
>  
> > Link: http://lkml.kernel.org/n/tip-ocz7zwwkkx11v0mkxrtcddih@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/session.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 3972f081a8f4..d6c1d3853f27 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1818,7 +1818,6 @@ static int __perf_session__process_events(struct perf_session *session)
> >  	struct ordered_events *oe = &session->ordered_events;
> >  	struct perf_tool *tool = session->tool;
> >  	int fd = perf_data__fd(session->data);
> > -	u64 file_size = perf_data__size(session->data);
> >  	u64 data_offset = session->header.data_offset;
> >  	u64 data_size = session->header.data_size;
> >  	u64 head, page_offset, file_offset, file_pos, size;
> > @@ -1838,14 +1837,13 @@ static int __perf_session__process_events(struct perf_session *session)
> >  	if (data_size == 0)
> >  		goto out;
> >  
> > -	if (data_offset + data_size < file_size)
> > -		file_size = data_offset + data_size;
> > +	ui_progress__init_size(&prog, data_size, "Processing events...");
> >  
> > -	ui_progress__init_size(&prog, file_size, "Processing events...");
> > +	data_size += data_offset;
> >  
> >  	mmap_size = MMAP_SIZE;
> > -	if (mmap_size > file_size) {
> > -		mmap_size = file_size;
> > +	if (mmap_size > data_size) {
> > +		mmap_size = data_size;
> >  		session->one_mmap = true;
> >  	}
> >  
> > @@ -1910,7 +1908,7 @@ static int __perf_session__process_events(struct perf_session *session)
> >  	if (session_done())
> >  		goto out;
> >  
> > -	if (file_pos < file_size)
> > +	if (file_pos < data_size)
> >  		goto more;
> >  
> >  out:
> > -- 
> > 2.17.2
> 
> -- 
> 
> - Arnaldo
