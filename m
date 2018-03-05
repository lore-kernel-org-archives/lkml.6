Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935076AbeCENDn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:03:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934919AbeCENDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:03:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD4420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 5 Mar 2018 10:03:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: kan.liang@linux.intel.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com
Subject: Re: [PATCH 02/14] perf trace: Apply new perf_mmap__read_event()
 interface
Message-ID: <20180305130339.GE30054@kernel.org>
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
 <1519945751-37786-2-git-send-email-kan.liang@linux.intel.com>
 <20180302233022.GB8970@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302233022.GB8970@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 03, 2018 at 12:30:22AM +0100, Jiri Olsa escreveu:
> On Thu, Mar 01, 2018 at 06:08:59PM -0500, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > The perf trace still use the legacy interface.
> > 
> > Apply the new perf_mmap__read_event() interface for perf trace.
> > 
> > No functional change.
> > 
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> >  tools/perf/builtin-trace.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index e7f1b18..a46644f 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2472,8 +2472,14 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >  
> >  	for (i = 0; i < evlist->nr_mmaps; i++) {
> >  		union perf_event *event;
> > +		struct perf_mmap *md;
> > +		u64 end, start;
> >  
> > -		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
> > +		md = &evlist->mmap[i];
> > +		if (perf_mmap__read_init(md, 0, &start, &end) < 0)
> > +			continue;
> > +
> > +		while ((event = perf_mmap__read_event(md, 0, &start, end)) != NULL) {
> >  			struct perf_sample sample;
> >  
> >  			++trace->nr_events;
> > @@ -2486,7 +2492,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> >  
> >  			trace__handle_event(trace, event, &sample);
> >  next_event:
> > -			perf_evlist__mmap_consume(evlist, i);
> > +			perf_mmap__consume(md, 0);
> 
> could you call this with 'false' instead of 0, it's 'bool overwrite'
> applies also to the rest of the patchset

I'm doing this, the argument is 'bool', so the value should be false or
true, even '0' being way shorter...

- Arnaldo
