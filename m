Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6408BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3773920663
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405758AbfBNLYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:24:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389603AbfBNLYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:24:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F3F037F46;
        Thu, 14 Feb 2019 11:24:00 +0000 (UTC)
Received: from krava (unknown [10.43.17.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id BFF0B608AE;
        Thu, 14 Feb 2019 11:23:58 +0000 (UTC)
Date:   Thu, 14 Feb 2019 12:23:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: Fix potential USE_AFTER_FREE  problem
Message-ID: <20190214112357.GB26714@krava>
References: <20190214052356.26884-1-tsu.yubo@gmail.com>
 <20190214083411.GA25842@krava>
 <20190214102238.nobo5vfsvmlyjyhv@yubo-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214102238.nobo5vfsvmlyjyhv@yubo-2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 14 Feb 2019 11:24:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 05:22:39AM -0500, YU Bo wrote:
> Hi,
> On Thu, Feb 14, 2019 at 09:34:11AM +0100, Jiri Olsa wrote:
> > On Thu, Feb 14, 2019 at 12:23:56AM -0500, Bo YU wrote:
> > > From: Bo Yu <tsu.yubo@gmail.com>
> > > 
> > > There is a freed pointer "evsel", so fix it.
> > > 
> > > Detected by CoverityScan, CID#1442595("Memory-illegalaccesses
> > > (USE_AFTER_FREE)")
> > > Fixes: 6ab3bc240ade4("perf trace: Support multiple "vfs_getname" probes")
> > > 
> > > Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
> > > ---
> > >  tools/perf/builtin-trace.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index b36061cd1ab8..4036b20a1067 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -2515,7 +2515,7 @@ static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
> > >  static bool perf_evlist__add_vfs_getname(struct perf_evlist *evlist)
> > >  {
> > >  	bool found = false;
> > > -	struct perf_evsel *evsel, *tmp;
> > > +	struct perf_evsel *evsel = NULL, *tmp;
> > 
> > hum, I can't see how this change could matter,
> > could you pelase explain
> First, this is a warning reported by CoverityScan,but in fact i do not how
> to answer your question :(.

I understand that, however at the same time I think
it's good to have an idea what the patch is doing ;-)

> Second, if i remember right, temporary element of list_for_each_entry_safe
> should be initialized with NULL otherwise it will complain via gcc.
> Please correct me :)

hum, from quick look:

	perf_evlist__add_vfs_getname
		struct perf_evsel *evsel;

		evlist__for_each_entry_safe(evlist, evsel, tmp)
		-> __evlist__for_each_entry_safe(&(evlist)->entries, tmp, evsel)

		__evlist__for_each_entry_safe(list, tmp, evsel) \
		-> list_for_each_entry_safe(evsel, tmp, list, node)

		list_for_each_entry_safe(pos, n, head, member)                  \
		-> for (pos = list_first_entry(head, typeof(*pos), member),        \
			n = list_next_entry(pos, member);                       \
			&pos->member != (head);                                    \
			pos = n, n = list_next_entry(n, member))


unless I'm missing something 'evsel' is being initialized
in the for loop init section with this statement:

  pos = list_first_entry(head, typeof(*pos), member)


jirka
