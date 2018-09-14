Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3322CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF41320833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF41320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeIOAP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeIOAP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:15:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2904A3002C75;
        Fri, 14 Sep 2018 19:00:10 +0000 (UTC)
Received: from krava (ovpn-204-109.brq.redhat.com [10.40.204.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5845F600C6;
        Fri, 14 Sep 2018 19:00:07 +0000 (UTC)
Date:   Fri, 14 Sep 2018 21:00:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 29/48] perf callchain: Maintain libunwind's address space
 in map_groups
Message-ID: <20180914190006.GA18677@krava>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-30-jolsa@kernel.org>
 <20180914181547.GB25154@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914181547.GB25154@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 14 Sep 2018 19:00:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 03:15:47PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 13, 2018 at 02:54:31PM +0200, Jiri Olsa escreveu:
> > Currently the address_space was kept in thread struct but it's more
> > appropriate to keep it in map_groups as it's maintained throughout
> > exec's with timestamps.  Also we should not flush the address space
> > after exec since it still can be accessed when used with an indexed
> > data file.
> > 
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Link: http://lkml.kernel.org/n/tip-hjryh6x2yfnrz8g0djhez24z@git.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/map.h                    |  5 ++++-
> >  tools/perf/util/thread.h                 |  1 -
> >  tools/perf/util/unwind-libunwind-local.c | 28 ++++++++++++++----------
> >  tools/perf/util/unwind-libunwind.c       |  9 ++++----
> >  tools/perf/util/unwind.h                 |  7 +++---
> >  5 files changed, 29 insertions(+), 21 deletions(-)
> > 
> > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > index 02c6f6962eb1..b1efe57b8563 100644
> > --- a/tools/perf/util/map.h
> > +++ b/tools/perf/util/map.h
> > @@ -65,10 +65,13 @@ struct maps {
> >  
> >  struct map_groups {
> >  	struct maps	 maps;
> > -	struct machine	 *machine;
> > +	struct machine	*machine;
> >  	refcount_t	 refcnt;
> >  	u64		 timestamp;
> >  	struct list_head list;
> 
> Hey, avoid these distractions, this doesn't change anything and besides

it bothers me.. ;-)

jirka
