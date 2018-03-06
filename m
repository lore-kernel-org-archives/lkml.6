Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeCFOcd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:32:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753713AbeCFOcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:32:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5A7206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 6 Mar 2018 11:32:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] perf auxtrace: Prevent decoding when --no-itrace
Message-ID: <20180306143228.GA3382@kernel.org>
References: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
 <1520327598-1317-3-git-send-email-adrian.hunter@intel.com>
 <20180306140624.GE10176@kernel.org>
 <8c596a3a-de1e-1d39-17b4-ae5db7543f7f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c596a3a-de1e-1d39-17b4-ae5db7543f7f@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 06, 2018 at 04:21:32PM +0200, Adrian Hunter escreveu:
> On 06/03/18 16:06, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Mar 06, 2018 at 11:13:13AM +0200, Adrian Hunter escreveu:
> >> Prevent auxtrace_queues__process_index() from queuing AUX area data for
> >> decoding when the --no-itrace option has been used.
> > 
> > So I'm putting this one both on perf/urgent and on perf/core, the rest
> > just on perf/core, ok?
> 
> Yes, thank you!
> 
> Have you got this one also:
> 
> 	https://marc.info/?l=linux-kernel&m=151980982703990

Hadn't, got it now, please next time put the subject line here,
sometimes I am offline and could then process the patches I have in my
local inbox, etc.

Thanks,

- Arnaldo
 
> > 
> > - Arnaldo
> >  
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  tools/perf/util/auxtrace.c | 15 +++++++++------
> >>  1 file changed, 9 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> >> index 9faf3b5367db..6470ea2aa25e 100644
> >> --- a/tools/perf/util/auxtrace.c
> >> +++ b/tools/perf/util/auxtrace.c
> >> @@ -60,6 +60,12 @@
> >>  #include "sane_ctype.h"
> >>  #include "symbol/kallsyms.h"
> >>  
> >> +static bool auxtrace__dont_decode(struct perf_session *session)
> >> +{
> >> +	return !session->itrace_synth_opts ||
> >> +	       session->itrace_synth_opts->dont_decode;
> >> +}
> >> +
> >>  int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
> >>  			struct auxtrace_mmap_params *mp,
> >>  			void *userpg, int fd)
> >> @@ -762,6 +768,9 @@ int auxtrace_queues__process_index(struct auxtrace_queues *queues,
> >>  	size_t i;
> >>  	int err;
> >>  
> >> +	if (auxtrace__dont_decode(session))
> >> +		return 0;
> >> +
> >>  	list_for_each_entry(auxtrace_index, &session->auxtrace_index, list) {
> >>  		for (i = 0; i < auxtrace_index->nr; i++) {
> >>  			ent = &auxtrace_index->entries[i];
> >> @@ -892,12 +901,6 @@ int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
> >>  	return err;
> >>  }
> >>  
> >> -static bool auxtrace__dont_decode(struct perf_session *session)
> >> -{
> >> -	return !session->itrace_synth_opts ||
> >> -	       session->itrace_synth_opts->dont_decode;
> >> -}
> >> -
> >>  int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
> >>  				      union perf_event *event,
> >>  				      struct perf_session *session)
> >> -- 
> >> 1.9.1
> > 
