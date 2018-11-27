Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F04C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCEF2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCEF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbeK0UcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:32:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbeK0UcP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:32:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D0993082A36;
        Tue, 27 Nov 2018 09:34:58 +0000 (UTC)
Received: from krava (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id 87B825C6A6;
        Tue, 27 Nov 2018 09:34:55 +0000 (UTC)
Date:   Tue, 27 Nov 2018 10:34:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH 2/2] perf report: Display average IPC and IPC coverage
 per symbol
Message-ID: <20181127093454.GF8908@krava>
References: <1543225254-5858-1-git-send-email-yao.jin@linux.intel.com>
 <1543225254-5858-3-git-send-email-yao.jin@linux.intel.com>
 <20181126095537.GC18780@krava>
 <bda91905-c08a-87e0-e49c-27eeaf9b711d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda91905-c08a-87e0-e49c-27eeaf9b711d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 27 Nov 2018 09:34:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 11:42:12AM +0800, Jin, Yao wrote:
> 
> 
> On 11/26/2018 5:55 PM, Jiri Olsa wrote:
> > On Mon, Nov 26, 2018 at 05:40:54PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > index f96c005..94f62c8 100644
> > > --- a/tools/perf/util/sort.c
> > > +++ b/tools/perf/util/sort.c
> > > @@ -13,6 +13,7 @@
> > >   #include "strlist.h"
> > >   #include <traceevent/event-parse.h>
> > >   #include "mem-events.h"
> > > +#include "annotate.h"
> > >   #include <linux/kernel.h>
> > >   regex_t		parent_regex;
> > > @@ -422,6 +423,47 @@ struct sort_entry sort_srcline_to = {
> > >   	.se_width_idx	= HISTC_SRCLINE_TO,
> > >   };
> > > +static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
> > > +					size_t size, unsigned int width)
> > > +{
> > > +
> > > +	struct symbol *sym = he->ms.sym;
> > > +	struct map *map = he->ms.map;
> > > +	struct perf_evsel *evsel = hists_to_evsel(he->hists);
> > > +	struct annotation *notes;
> > > +	double ipc = 0.0, coverage = 0.0;
> > > +	char tmp[64];
> > > +
> > > +	if (!sym)
> > > +		return repsep_snprintf(bf, size, "%-*s", width, "-");
> > > +
> > > +	if (!sym->annotated &&
> > > +	    symbol__annotate2(sym, map, evsel, &annotation__default_options,
> > > +			      NULL) < 0) {
> > > +		return 0;
> > > +	}
> > 
> > this seems to make the sorting extra long, would you
> > please consider progress bar update for this?
> > 
> > should be added somewhere around hists sorting code
> > 
> 
> Hi Jiri,
> 
> Sorting doesn't take long time in my test but the session event processing
> takes some time.
> 
> I just think maybe we need a new ops for stdio progress bar like what the
> tui_progress__ops does now. That should be benefit for all stdio usages.
> 
> That may be another separate patch-set.

sure, thanks

jirka
