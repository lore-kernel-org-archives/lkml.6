Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FECCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80412081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80412081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeKAAhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:37:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbeKAAhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:37:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B79C088308;
        Wed, 31 Oct 2018 15:39:09 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 09DF660851;
        Wed, 31 Oct 2018 15:39:07 +0000 (UTC)
Date:   Wed, 31 Oct 2018 16:39:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181031153907.GA29893@krava>
References: <20181030.220328.833911429549884471.davem@davemloft.net>
 <20181031124306.GA10660@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031124306.GA10660@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 31 Oct 2018 15:39:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 09:43:06AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 30, 2018 at 10:03:28PM -0700, David Miller escreveu:
> > 
> > So when a cpu is overpowered processing samples, most of the time is
> > spent in the histogram code.

it'd be great to make hist processing faster, but is your main target here
to get the load out of the reader thread, so we dont lose events during the
hist processing?

we could queue events directly from reader thread into another thread and
keep it (the reader thread) free of processing, focusing only on event
reading/passing 

jirka

> > 
> > It seems we initialize a ~262 byte structure on the stack to do every
> > histogram entry lookup.
> > 
> > This is a side effect of how the sorting code is shared with the code
> > that does lookups and insertions into the histogram tree(s).
> > 
> > I tried to change this so that lookups use a smaller key, but it gets
> > ugly real fast.
> > 
> > I don't know when I'd be able to work more on this so I'm posting this
> > hoping maybe someone else can move it forward, or maybe even find a
> > better way to do this.
> 
> Added Namhyung to the CC list, that is in vacations right now but said
> he would look into the issues recently raised when he gets back.
> 
> Thanks a lot for all the work you did in this sprint, really
> appreciated, I'm processing the fixes for the fallback to kallsyms and
> the other patch you submitted, will do tests and push to Ingo and
> revisit this after I get ready for Vancouver ;-)
> 
> - Arnaldo
>  
> > The histogram code is really the limiting factor in how well perf can
> > handle high sample rates.
> > 
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index f96c005..f0265e4 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -81,6 +81,12 @@ sort__thread_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return right->thread->tid - left->thread->tid;
> >  }
> >  
> > +static int64_t
> > +sort__thread_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	return key->al->thread->tid - entry->thread->tid;
> > +}
> > +
> >  static int hist_entry__thread_snprintf(struct hist_entry *he, char *bf,
> >  				       size_t size, unsigned int width)
> >  {
> > @@ -104,6 +110,7 @@ static int hist_entry__thread_filter(struct hist_entry *he, int type, const void
> >  struct sort_entry sort_thread = {
> >  	.se_header	= "    Pid:Command",
> >  	.se_cmp		= sort__thread_cmp,
> > +	.se_cmp_key	= sort__thread_cmp_key,
> >  	.se_snprintf	= hist_entry__thread_snprintf,
> >  	.se_filter	= hist_entry__thread_filter,
> >  	.se_width_idx	= HISTC_THREAD,
> > @@ -123,6 +130,13 @@ sort__comm_cmp(struct hist_entry *left, struct hist_entry *right)
> >  }
> >  
> >  static int64_t
> > +sort__comm_cmp_key(struct hist_entry *entry,
> > +	       struct hist_entry_cmp_key *key)
> > +{
> > +	return strcmp(comm__str(key->comm), comm__str(entry->comm));
> > +}
> > +
> > +static int64_t
> >  sort__comm_collapse(struct hist_entry *left, struct hist_entry *right)
> >  {
> >  	return strcmp(comm__str(right->comm), comm__str(left->comm));
> > @@ -143,6 +157,7 @@ static int hist_entry__comm_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_comm = {
> >  	.se_header	= "Command",
> >  	.se_cmp		= sort__comm_cmp,
> > +	.se_cmp_key	= sort__comm_cmp_key,
> >  	.se_collapse	= sort__comm_collapse,
> >  	.se_sort	= sort__comm_sort,
> >  	.se_snprintf	= hist_entry__comm_snprintf,
> > @@ -178,6 +193,12 @@ sort__dso_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return _sort__dso_cmp(right->ms.map, left->ms.map);
> >  }
> >  
> > +static int64_t
> > +sort__dso_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	return _sort__dso_cmp(key->al->map, entry->ms.map);
> > +}
> > +
> >  static int _hist_entry__dso_snprintf(struct map *map, char *bf,
> >  				     size_t size, unsigned int width)
> >  {
> > @@ -209,6 +230,7 @@ static int hist_entry__dso_filter(struct hist_entry *he, int type, const void *a
> >  struct sort_entry sort_dso = {
> >  	.se_header	= "Shared Object",
> >  	.se_cmp		= sort__dso_cmp,
> > +	.se_cmp_key	= sort__dso_cmp_key,
> >  	.se_snprintf	= hist_entry__dso_snprintf,
> >  	.se_filter	= hist_entry__dso_filter,
> >  	.se_width_idx	= HISTC_DSO,
> > @@ -260,6 +282,25 @@ sort__sym_cmp(struct hist_entry *left, struct hist_entry *right)
> >  }
> >  
> >  static int64_t
> > +sort__sym_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	int64_t ret;
> > +
> > +	if (!entry->ms.sym && !key->al->sym)
> > +		return _sort__addr_cmp(entry->ip, key->al->addr);
> > +
> > +	/*
> > +	 * comparing symbol address alone is not enough since it's a
> > +	 * relative address within a dso.
> > +	 */
> > +	ret = sort__dso_cmp_key(entry, key);
> > +	if (ret != 0)
> > +		return ret;
> > +
> > +	return _sort__sym_cmp(entry->ms.sym, key->al->sym);
> > +}
> > +
> > +static int64_t
> >  sort__sym_sort(struct hist_entry *left, struct hist_entry *right)
> >  {
> >  	if (!left->ms.sym || !right->ms.sym)
> > @@ -323,6 +364,7 @@ static int hist_entry__sym_filter(struct hist_entry *he, int type, const void *a
> >  struct sort_entry sort_sym = {
> >  	.se_header	= "Symbol",
> >  	.se_cmp		= sort__sym_cmp,
> > +	.se_cmp_key	= sort__sym_cmp_key,
> >  	.se_sort	= sort__sym_sort,
> >  	.se_snprintf	= hist_entry__sym_snprintf,
> >  	.se_filter	= hist_entry__sym_filter,
> > @@ -347,6 +389,18 @@ sort__srcline_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return strcmp(right->srcline, left->srcline);
> >  }
> >  
> > +static int64_t
> > +sort__srcline_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	if (!entry->srcline)
> > +		entry->srcline = hist_entry__srcline(entry);
> > +	if (!key->al->srcline)
> > +		key->al->srcline =
> > +			map__srcline(key->al->map, key->al->addr, key->al->sym);
> > +
> > +	return strcmp(key->al->srcline, entry->srcline);
> > +}
> > +
> >  static int hist_entry__srcline_snprintf(struct hist_entry *he, char *bf,
> >  					size_t size, unsigned int width)
> >  {
> > @@ -359,6 +413,7 @@ static int hist_entry__srcline_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_srcline = {
> >  	.se_header	= "Source:Line",
> >  	.se_cmp		= sort__srcline_cmp,
> > +	.se_cmp_key	= sort__srcline_cmp_key,
> >  	.se_snprintf	= hist_entry__srcline_snprintf,
> >  	.se_width_idx	= HISTC_SRCLINE,
> >  };
> > @@ -382,6 +437,18 @@ sort__srcline_from_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return strcmp(right->branch_info->srcline_from, left->branch_info->srcline_from);
> >  }
> >  
> > +static int64_t
> > +sort__srcline_from_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	if (!entry->branch_info->srcline_from)
> > +		entry->branch_info->srcline_from = addr_map_symbol__srcline(&entry->branch_info->from);
> > +
> > +	if (!key->bi->srcline_from)
> > +		key->bi->srcline_from = addr_map_symbol__srcline(&key->bi->from);
> > +
> > +	return strcmp(key->bi->srcline_from, entry->branch_info->srcline_from);
> > +}
> > +
> >  static int hist_entry__srcline_from_snprintf(struct hist_entry *he, char *bf,
> >  					size_t size, unsigned int width)
> >  {
> > @@ -391,6 +458,7 @@ static int hist_entry__srcline_from_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_srcline_from = {
> >  	.se_header	= "From Source:Line",
> >  	.se_cmp		= sort__srcline_from_cmp,
> > +	.se_cmp_key	= sort__srcline_from_cmp_key,
> >  	.se_snprintf	= hist_entry__srcline_from_snprintf,
> >  	.se_width_idx	= HISTC_SRCLINE_FROM,
> >  };
> > @@ -409,6 +477,18 @@ sort__srcline_to_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return strcmp(right->branch_info->srcline_to, left->branch_info->srcline_to);
> >  }
> >  
> > +static int64_t
> > +sort__srcline_to_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	if (!entry->branch_info->srcline_to)
> > +		entry->branch_info->srcline_to = addr_map_symbol__srcline(&entry->branch_info->to);
> > +
> > +	if (!key->bi->srcline_to)
> > +		key->bi->srcline_to = addr_map_symbol__srcline(&key->bi->to);
> > +
> > +	return strcmp(key->bi->srcline_to, entry->branch_info->srcline_to);
> > +}
> > +
> >  static int hist_entry__srcline_to_snprintf(struct hist_entry *he, char *bf,
> >  					size_t size, unsigned int width)
> >  {
> > @@ -418,6 +498,7 @@ static int hist_entry__srcline_to_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_srcline_to = {
> >  	.se_header	= "To Source:Line",
> >  	.se_cmp		= sort__srcline_to_cmp,
> > +	.se_cmp_key	= sort__srcline_to_cmp_key,
> >  	.se_snprintf	= hist_entry__srcline_to_snprintf,
> >  	.se_width_idx	= HISTC_SRCLINE_TO,
> >  };
> > @@ -426,16 +507,16 @@ struct sort_entry sort_srcline_to = {
> >  
> >  static char no_srcfile[1];
> >  
> > -static char *hist_entry__get_srcfile(struct hist_entry *e)
> > +static char *__hist_entry__get_srcfile(struct map *map, struct symbol *sym,
> > +				       u64 ip)
> >  {
> >  	char *sf, *p;
> > -	struct map *map = e->ms.map;
> >  
> >  	if (!map)
> >  		return no_srcfile;
> >  
> > -	sf = __get_srcline(map->dso, map__rip_2objdump(map, e->ip),
> > -			 e->ms.sym, false, true, true, e->ip);
> > +	sf = __get_srcline(map->dso, map__rip_2objdump(map, ip),
> > +			 sym, false, true, true, ip);
> >  	if (!strcmp(sf, SRCLINE_UNKNOWN))
> >  		return no_srcfile;
> >  	p = strchr(sf, ':');
> > @@ -447,6 +528,15 @@ static char *hist_entry__get_srcfile(struct hist_entry *e)
> >  	return no_srcfile;
> >  }
> >  
> > +static char *hist_entry__get_srcfile(struct hist_entry *e)
> > +{
> > +	return __hist_entry__get_srcfile(e->ms.map, e->ms.sym, e->ip);
> > +}
> > +
> > +static char *hist_entry_key__get_srcfile(struct hist_entry_cmp_key *key)
> > +{
> > +	return __hist_entry__get_srcfile(key->al->map, key->al->sym, key->al->addr);
> > +}
> >  static int64_t
> >  sort__srcfile_cmp(struct hist_entry *left, struct hist_entry *right)
> >  {
> > @@ -458,6 +548,17 @@ sort__srcfile_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return strcmp(right->srcfile, left->srcfile);
> >  }
> >  
> > +static int64_t
> > +sort__srcfile_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	if (!entry->srcfile)
> > +		entry->srcfile = hist_entry__get_srcfile(entry);
> > +	if (!key->srcfile)
> > +		key->srcfile = hist_entry_key__get_srcfile(key);
> > +
> > +	return strcmp(key->srcfile, entry->srcfile);
> > +}
> > +
> >  static int hist_entry__srcfile_snprintf(struct hist_entry *he, char *bf,
> >  					size_t size, unsigned int width)
> >  {
> > @@ -470,6 +571,7 @@ static int hist_entry__srcfile_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_srcfile = {
> >  	.se_header	= "Source File",
> >  	.se_cmp		= sort__srcfile_cmp,
> > +	.se_cmp_key	= sort__srcfile_cmp_key,
> >  	.se_snprintf	= hist_entry__srcfile_snprintf,
> >  	.se_width_idx	= HISTC_SRCFILE,
> >  };
> > @@ -488,6 +590,18 @@ sort__parent_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return strcmp(sym_r->name, sym_l->name);
> >  }
> >  
> > +static int64_t
> > +sort__parent_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	struct symbol *sym_l = entry->parent;
> > +	struct symbol *sym_r = key->sym_parent;
> > +
> > +	if (!sym_l || !sym_r)
> > +		return cmp_null(sym_l, sym_r);
> > +
> > +	return strcmp(sym_r->name, sym_l->name);
> > +}
> > +
> >  static int hist_entry__parent_snprintf(struct hist_entry *he, char *bf,
> >  				       size_t size, unsigned int width)
> >  {
> > @@ -498,6 +612,7 @@ static int hist_entry__parent_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_parent = {
> >  	.se_header	= "Parent symbol",
> >  	.se_cmp		= sort__parent_cmp,
> > +	.se_cmp_key	= sort__parent_cmp_key,
> >  	.se_snprintf	= hist_entry__parent_snprintf,
> >  	.se_width_idx	= HISTC_PARENT,
> >  };
> > @@ -510,6 +625,12 @@ sort__cpu_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return right->cpu - left->cpu;
> >  }
> >  
> > +static int64_t
> > +sort__cpu_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	return key->al->cpu - entry->cpu;
> > +}
> > +
> >  static int hist_entry__cpu_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -519,6 +640,7 @@ static int hist_entry__cpu_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_cpu = {
> >  	.se_header      = "CPU",
> >  	.se_cmp	        = sort__cpu_cmp,
> > +	.se_cmp_key     = sort__cpu_cmp_key,
> >  	.se_snprintf    = hist_entry__cpu_snprintf,
> >  	.se_width_idx	= HISTC_CPU,
> >  };
> > @@ -548,6 +670,22 @@ sort__cgroup_id_cmp(struct hist_entry *left, struct hist_entry *right)
> >  				       left->cgroup_id.ino);
> >  }
> >  
> > +static int64_t
> > +sort__cgroup_id_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	struct namespaces *ns = thread__namespaces(key->al->thread);
> > +	int64_t ret;
> > +	u64 val;
> > +
> > +	val = ns ? ns->link_info[CGROUP_NS_INDEX].dev : 0;
> > +	ret = _sort__cgroup_dev_cmp(val, entry->cgroup_id.dev);
> > +	if (ret != 0)
> > +		return ret;
> > +
> > +	val = ns ? ns->link_info[CGROUP_NS_INDEX].ino : 0;
> > +	return _sort__cgroup_inode_cmp(val, entry->cgroup_id.ino);
> > +}
> > +
> >  static int hist_entry__cgroup_id_snprintf(struct hist_entry *he,
> >  					  char *bf, size_t size,
> >  					  unsigned int width __maybe_unused)
> > @@ -559,6 +697,7 @@ static int hist_entry__cgroup_id_snprintf(struct hist_entry *he,
> >  struct sort_entry sort_cgroup_id = {
> >  	.se_header      = "cgroup id (dev/inode)",
> >  	.se_cmp	        = sort__cgroup_id_cmp,
> > +	.se_cmp_key     = sort__cgroup_id_cmp_key,
> >  	.se_snprintf    = hist_entry__cgroup_id_snprintf,
> >  	.se_width_idx	= HISTC_CGROUP_ID,
> >  };
> > @@ -571,6 +710,12 @@ sort__socket_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return right->socket - left->socket;
> >  }
> >  
> > +static int64_t
> > +sort__socket_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	return key->al->socket - entry->socket;
> > +}
> > +
> >  static int hist_entry__socket_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -590,6 +735,7 @@ static int hist_entry__socket_filter(struct hist_entry *he, int type, const void
> >  struct sort_entry sort_socket = {
> >  	.se_header      = "Socket",
> >  	.se_cmp	        = sort__socket_cmp,
> > +	.se_cmp_key     = sort__socket_cmp_key,
> >  	.se_snprintf    = hist_entry__socket_snprintf,
> >  	.se_filter      = hist_entry__socket_filter,
> >  	.se_width_idx	= HISTC_SOCKET,
> > @@ -597,20 +743,21 @@ struct sort_entry sort_socket = {
> >  
> >  /* --sort trace */
> >  
> > -static char *get_trace_output(struct hist_entry *he)
> > +static char *__get_trace_output(struct hists *hists, void *raw_data,
> > +				u32 raw_size)
> >  {
> >  	struct trace_seq seq;
> >  	struct perf_evsel *evsel;
> >  	struct tep_record rec = {
> > -		.data = he->raw_data,
> > -		.size = he->raw_size,
> > +		.data = raw_data,
> > +		.size = raw_size,
> >  	};
> >  
> > -	evsel = hists_to_evsel(he->hists);
> > +	evsel = hists_to_evsel(hists);
> >  
> >  	trace_seq_init(&seq);
> >  	if (symbol_conf.raw_trace) {
> > -		tep_print_fields(&seq, he->raw_data, he->raw_size,
> > +		tep_print_fields(&seq, raw_data, raw_size,
> >  				 evsel->tp_format);
> >  	} else {
> >  		tep_event_info(&seq, evsel->tp_format, &rec);
> > @@ -622,6 +769,16 @@ static char *get_trace_output(struct hist_entry *he)
> >  	return realloc(seq.buffer, seq.len + 1);
> >  }
> >  
> > +static char *get_trace_output(struct hist_entry *he)
> > +{
> > +	return __get_trace_output(he->hists, he->raw_data, he->raw_size);
> > +}
> > +
> > +static char *get_trace_output_key(struct hists *hists, struct hist_entry_cmp_key *key)
> > +{
> > +	return __get_trace_output(hists, key->sample->raw_data, key->sample->raw_size);
> > +}
> > +
> >  static int64_t
> >  sort__trace_cmp(struct hist_entry *left, struct hist_entry *right)
> >  {
> > @@ -639,6 +796,23 @@ sort__trace_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return strcmp(right->trace_output, left->trace_output);
> >  }
> >  
> > +static int64_t
> > +sort__trace_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	struct perf_evsel *evsel;
> > +
> > +	evsel = hists_to_evsel(entry->hists);
> > +	if (evsel->attr.type != PERF_TYPE_TRACEPOINT)
> > +		return 0;
> > +
> > +	if (entry->trace_output == NULL)
> > +		entry->trace_output = get_trace_output(entry);
> > +	if (key->trace_output == NULL)
> > +		key->trace_output = get_trace_output_key(entry->hists, key);
> > +
> > +	return strcmp(key->trace_output, entry->trace_output);
> > +}
> > +
> >  static int hist_entry__trace_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -656,6 +830,7 @@ static int hist_entry__trace_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_trace = {
> >  	.se_header      = "Trace output",
> >  	.se_cmp	        = sort__trace_cmp,
> > +	.se_cmp_key     = sort__trace_cmp_key,
> >  	.se_snprintf    = hist_entry__trace_snprintf,
> >  	.se_width_idx	= HISTC_TRACE,
> >  };
> > @@ -672,6 +847,16 @@ sort__dso_from_cmp(struct hist_entry *left, struct hist_entry *right)
> >  			      right->branch_info->from.map);
> >  }
> >  
> > +static int64_t
> > +sort__dso_from_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	if (!entry->branch_info || !key->bi)
> > +		return cmp_null(entry->branch_info, key->bi);
> > +
> > +	return _sort__dso_cmp(entry->branch_info->from.map,
> > +			      key->bi->from.map);
> > +}
> > +
> >  static int hist_entry__dso_from_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -704,6 +889,16 @@ sort__dso_to_cmp(struct hist_entry *left, struct hist_entry *right)
> >  			      right->branch_info->to.map);
> >  }
> >  
> > +static int64_t
> > +sort__dso_to_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	if (!entry->branch_info || !key->bi)
> > +		return cmp_null(entry->branch_info, key->bi);
> > +
> > +	return _sort__dso_cmp(entry->branch_info->to.map,
> > +			      key->bi->to.map);
> > +}
> > +
> >  static int hist_entry__dso_to_snprintf(struct hist_entry *he, char *bf,
> >  				       size_t size, unsigned int width)
> >  {
> > @@ -745,6 +940,24 @@ sort__sym_from_cmp(struct hist_entry *left, struct hist_entry *right)
> >  }
> >  
> >  static int64_t
> > +sort__sym_from_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	struct addr_map_symbol *from_l = &entry->branch_info->from;
> > +	struct addr_map_symbol *from_r = &key->bi->from;
> > +
> > +	if (!entry->branch_info || !key->bi)
> > +		return cmp_null(entry->branch_info, key->bi);
> > +
> > +	from_l = &entry->branch_info->from;
> > +	from_r = &key->bi->from;
> > +
> > +	if (!from_l->sym && !from_r->sym)
> > +		return _sort__addr_cmp(from_l->addr, from_r->addr);
> > +
> > +	return _sort__sym_cmp(from_l->sym, from_r->sym);
> > +}
> > +
> > +static int64_t
> >  sort__sym_to_cmp(struct hist_entry *left, struct hist_entry *right)
> >  {
> >  	struct addr_map_symbol *to_l, *to_r;
> > @@ -761,6 +974,23 @@ sort__sym_to_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return _sort__sym_cmp(to_l->sym, to_r->sym);
> >  }
> >  
> > +static int64_t
> > +sort__sym_to_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	struct addr_map_symbol *to_l, *to_r;
> > +
> > +	if (!entry->branch_info || !key->bi)
> > +		return cmp_null(entry->branch_info, key->bi);
> > +
> > +	to_l = &entry->branch_info->to;
> > +	to_r = &key->bi->to;
> > +
> > +	if (!to_l->sym && !to_r->sym)
> > +		return _sort__addr_cmp(to_l->addr, to_r->addr);
> > +
> > +	return _sort__sym_cmp(to_l->sym, to_r->sym);
> > +}
> > +
> >  static int hist_entry__sym_from_snprintf(struct hist_entry *he, char *bf,
> >  					 size_t size, unsigned int width)
> >  {
> > @@ -814,6 +1044,7 @@ static int hist_entry__sym_to_filter(struct hist_entry *he, int type,
> >  struct sort_entry sort_dso_from = {
> >  	.se_header	= "Source Shared Object",
> >  	.se_cmp		= sort__dso_from_cmp,
> > +	.se_cmp_key	= sort__dso_from_cmp_key,
> >  	.se_snprintf	= hist_entry__dso_from_snprintf,
> >  	.se_filter	= hist_entry__dso_from_filter,
> >  	.se_width_idx	= HISTC_DSO_FROM,
> > @@ -822,6 +1053,7 @@ struct sort_entry sort_dso_from = {
> >  struct sort_entry sort_dso_to = {
> >  	.se_header	= "Target Shared Object",
> >  	.se_cmp		= sort__dso_to_cmp,
> > +	.se_cmp_key	= sort__dso_to_cmp_key,
> >  	.se_snprintf	= hist_entry__dso_to_snprintf,
> >  	.se_filter	= hist_entry__dso_to_filter,
> >  	.se_width_idx	= HISTC_DSO_TO,
> > @@ -830,6 +1062,7 @@ struct sort_entry sort_dso_to = {
> >  struct sort_entry sort_sym_from = {
> >  	.se_header	= "Source Symbol",
> >  	.se_cmp		= sort__sym_from_cmp,
> > +	.se_cmp_key	= sort__sym_from_cmp_key,
> >  	.se_snprintf	= hist_entry__sym_from_snprintf,
> >  	.se_filter	= hist_entry__sym_from_filter,
> >  	.se_width_idx	= HISTC_SYMBOL_FROM,
> > @@ -838,6 +1071,7 @@ struct sort_entry sort_sym_from = {
> >  struct sort_entry sort_sym_to = {
> >  	.se_header	= "Target Symbol",
> >  	.se_cmp		= sort__sym_to_cmp,
> > +	.se_cmp_key	= sort__sym_to_cmp_key,
> >  	.se_snprintf	= hist_entry__sym_to_snprintf,
> >  	.se_filter	= hist_entry__sym_to_filter,
> >  	.se_width_idx	= HISTC_SYMBOL_TO,
> > @@ -856,6 +1090,19 @@ sort__mispredict_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return mp || p;
> >  }
> >  
> > +static int64_t
> > +sort__mispredict_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	unsigned char mp, p;
> > +
> > +	if (!entry->branch_info || !key->bi)
> > +		return cmp_null(entry->branch_info, key->bi);
> > +
> > +	mp = entry->branch_info->flags.mispred != key->bi->flags.mispred;
> > +	p  = entry->branch_info->flags.predicted != key->bi->flags.predicted;
> > +	return mp || p;
> > +}
> > +
> >  static int hist_entry__mispredict_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width){
> >  	static const char *out = "N/A";
> > @@ -880,6 +1127,16 @@ sort__cycles_cmp(struct hist_entry *left, struct hist_entry *right)
> >  		right->branch_info->flags.cycles;
> >  }
> >  
> > +static int64_t
> > +sort__cycles_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	if (!entry->branch_info || !key->bi)
> > +		return cmp_null(entry->branch_info, key->bi);
> > +
> > +	return entry->branch_info->flags.cycles -
> > +		key->bi->flags.cycles;
> > +}
> > +
> >  static int hist_entry__cycles_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -894,6 +1151,7 @@ static int hist_entry__cycles_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_cycles = {
> >  	.se_header	= "Basic Block Cycles",
> >  	.se_cmp		= sort__cycles_cmp,
> > +	.se_cmp_key	= sort__cycles_cmp_key,
> >  	.se_snprintf	= hist_entry__cycles_snprintf,
> >  	.se_width_idx	= HISTC_CYCLES,
> >  };
> > @@ -912,6 +1170,19 @@ sort__daddr_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return (int64_t)(r - l);
> >  }
> >  
> > +static int64_t
> > +sort__daddr_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	uint64_t l = 0, r = 0;
> > +
> > +	if (entry->mem_info)
> > +		l = entry->mem_info->daddr.addr;
> > +	if (key->mem_info)
> > +		r = key->mem_info->daddr.addr;
> > +
> > +	return (int64_t)(r - l);
> > +}
> > +
> >  static int hist_entry__daddr_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -941,6 +1212,19 @@ sort__iaddr_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return (int64_t)(r - l);
> >  }
> >  
> > +static int64_t
> > +sort__iaddr_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	uint64_t l = 0, r = 0;
> > +
> > +	if (entry->mem_info)
> > +		l = entry->mem_info->iaddr.addr;
> > +	if (key->mem_info)
> > +		r = key->mem_info->iaddr.addr;
> > +
> > +	return (int64_t)(r - l);
> > +}
> > +
> >  static int hist_entry__iaddr_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -971,6 +1255,20 @@ sort__dso_daddr_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return _sort__dso_cmp(map_l, map_r);
> >  }
> >  
> > +static int64_t
> > +sort__dso_daddr_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	struct map *map_l = NULL;
> > +	struct map *map_r = NULL;
> > +
> > +	if (entry->mem_info)
> > +		map_l = entry->mem_info->daddr.map;
> > +	if (key->mem_info)
> > +		map_r = key->mem_info->daddr.map;
> > +
> > +	return _sort__dso_cmp(map_l, map_r);
> > +}
> > +
> >  static int hist_entry__dso_daddr_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -1001,6 +1299,25 @@ sort__locked_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return (int64_t)(data_src_r.mem_lock - data_src_l.mem_lock);
> >  }
> >  
> > +static int64_t
> > +sort__locked_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	union perf_mem_data_src data_src_l;
> > +	union perf_mem_data_src data_src_r;
> > +
> > +	if (entry->mem_info)
> > +		data_src_l = entry->mem_info->data_src;
> > +	else
> > +		data_src_l.mem_lock = PERF_MEM_LOCK_NA;
> > +
> > +	if (key->mem_info)
> > +		data_src_r = key->mem_info->data_src;
> > +	else
> > +		data_src_r.mem_lock = PERF_MEM_LOCK_NA;
> > +
> > +	return (int64_t)(data_src_r.mem_lock - data_src_l.mem_lock);
> > +}
> > +
> >  static int hist_entry__locked_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -1029,6 +1346,25 @@ sort__tlb_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return (int64_t)(data_src_r.mem_dtlb - data_src_l.mem_dtlb);
> >  }
> >  
> > +static int64_t
> > +sort__tlb_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	union perf_mem_data_src data_src_l;
> > +	union perf_mem_data_src data_src_r;
> > +
> > +	if (entry->mem_info)
> > +		data_src_l = entry->mem_info->data_src;
> > +	else
> > +		data_src_l.mem_dtlb = PERF_MEM_TLB_NA;
> > +
> > +	if (key->mem_info)
> > +		data_src_r = key->mem_info->data_src;
> > +	else
> > +		data_src_r.mem_dtlb = PERF_MEM_TLB_NA;
> > +
> > +	return (int64_t)(data_src_r.mem_dtlb - data_src_l.mem_dtlb);
> > +}
> > +
> >  static int hist_entry__tlb_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -1057,6 +1393,25 @@ sort__lvl_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return (int64_t)(data_src_r.mem_lvl - data_src_l.mem_lvl);
> >  }
> >  
> > +static int64_t
> > +sort__lvl_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	union perf_mem_data_src data_src_l;
> > +	union perf_mem_data_src data_src_r;
> > +
> > +	if (entry->mem_info)
> > +		data_src_l = entry->mem_info->data_src;
> > +	else
> > +		data_src_l.mem_lvl = PERF_MEM_LVL_NA;
> > +
> > +	if (key->mem_info)
> > +		data_src_r = key->mem_info->data_src;
> > +	else
> > +		data_src_r.mem_lvl = PERF_MEM_LVL_NA;
> > +
> > +	return (int64_t)(data_src_r.mem_lvl - data_src_l.mem_lvl);
> > +}
> > +
> >  static int hist_entry__lvl_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -1085,6 +1440,25 @@ sort__snoop_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return (int64_t)(data_src_r.mem_snoop - data_src_l.mem_snoop);
> >  }
> >  
> > +static int64_t
> > +sort__snoop_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	union perf_mem_data_src data_src_l;
> > +	union perf_mem_data_src data_src_r;
> > +
> > +	if (entry->mem_info)
> > +		data_src_l = entry->mem_info->data_src;
> > +	else
> > +		data_src_l.mem_snoop = PERF_MEM_SNOOP_NA;
> > +
> > +	if (key->mem_info)
> > +		data_src_r = key->mem_info->data_src;
> > +	else
> > +		data_src_r.mem_snoop = PERF_MEM_SNOOP_NA;
> > +
> > +	return (int64_t)(data_src_r.mem_snoop - data_src_l.mem_snoop);
> > +}
> > +
> >  static int hist_entry__snoop_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -1158,6 +1532,70 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return 0;
> >  }
> >  
> > +static int64_t
> > +sort__dcacheline_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	u64 l, r;
> > +	struct map *l_map, *r_map;
> > +
> > +	if (!entry->mem_info)  return -1;
> > +	if (!key->mem_info) return 1;
> > +
> > +	/* group event types together */
> > +	if (entry->cpumode > key->al->cpumode) return -1;
> > +	if (entry->cpumode < key->al->cpumode) return 1;
> > +
> > +	l_map = entry->mem_info->daddr.map;
> > +	r_map = key->mem_info->daddr.map;
> > +
> > +	/* if both are NULL, jump to sort on al_addr instead */
> > +	if (!l_map && !r_map)
> > +		goto addr;
> > +
> > +	if (!l_map) return -1;
> > +	if (!r_map) return 1;
> > +
> > +	if (l_map->maj > r_map->maj) return -1;
> > +	if (l_map->maj < r_map->maj) return 1;
> > +
> > +	if (l_map->min > r_map->min) return -1;
> > +	if (l_map->min < r_map->min) return 1;
> > +
> > +	if (l_map->ino > r_map->ino) return -1;
> > +	if (l_map->ino < r_map->ino) return 1;
> > +
> > +	if (l_map->ino_generation > r_map->ino_generation) return -1;
> > +	if (l_map->ino_generation < r_map->ino_generation) return 1;
> > +
> > +	/*
> > +	 * Addresses with no major/minor numbers are assumed to be
> > +	 * anonymous in userspace.  Sort those on pid then address.
> > +	 *
> > +	 * The kernel and non-zero major/minor mapped areas are
> > +	 * assumed to be unity mapped.  Sort those on address.
> > +	 */
> > +
> > +	if ((entry->cpumode != PERF_RECORD_MISC_KERNEL) &&
> > +	    (!(l_map->flags & MAP_SHARED)) &&
> > +	    !l_map->maj && !l_map->min && !l_map->ino &&
> > +	    !l_map->ino_generation) {
> > +		/* userspace anonymous */
> > +
> > +		if (entry->thread->pid_ > key->al->thread->pid_) return -1;
> > +		if (entry->thread->pid_ < key->al->thread->pid_) return 1;
> > +	}
> > +
> > +addr:
> > +	/* al_addr does all the right addr - start + offset calculations */
> > +	l = cl_address(entry->mem_info->daddr.al_addr);
> > +	r = cl_address(key->mem_info->daddr.al_addr);
> > +
> > +	if (l > r) return -1;
> > +	if (l < r) return 1;
> > +
> > +	return 0;
> > +}
> > +
> >  static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
> >  					  size_t size, unsigned int width)
> >  {
> > @@ -1189,6 +1627,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_mispredict = {
> >  	.se_header	= "Branch Mispredicted",
> >  	.se_cmp		= sort__mispredict_cmp,
> > +	.se_cmp_key	= sort__mispredict_cmp_key,
> >  	.se_snprintf	= hist_entry__mispredict_snprintf,
> >  	.se_width_idx	= HISTC_MISPREDICT,
> >  };
> > @@ -1198,12 +1637,24 @@ static u64 he_weight(struct hist_entry *he)
> >  	return he->stat.nr_events ? he->stat.weight / he->stat.nr_events : 0;
> >  }
> >  
> > +static u64 key_weight(struct hist_entry_cmp_key *key)
> > +{
> > +	return key->sample->weight;
> > +}
> > +
> >  static int64_t
> >  sort__local_weight_cmp(struct hist_entry *left, struct hist_entry *right)
> >  {
> >  	return he_weight(left) - he_weight(right);
> >  }
> >  
> > +static int64_t
> > +sort__local_weight_cmp_key(struct hist_entry *entry,
> > +			   struct hist_entry_cmp_key *key)
> > +{
> > +	return he_weight(entry) - key_weight(key);
> > +}
> > +
> >  static int hist_entry__local_weight_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -1213,6 +1664,7 @@ static int hist_entry__local_weight_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_local_weight = {
> >  	.se_header	= "Local Weight",
> >  	.se_cmp		= sort__local_weight_cmp,
> > +	.se_cmp_key	= sort__local_weight_cmp_key,
> >  	.se_snprintf	= hist_entry__local_weight_snprintf,
> >  	.se_width_idx	= HISTC_LOCAL_WEIGHT,
> >  };
> > @@ -1223,6 +1675,13 @@ sort__global_weight_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return left->stat.weight - right->stat.weight;
> >  }
> >  
> > +static int64_t
> > +sort__global_weight_cmp_key(struct hist_entry *entry,
> > +			    struct hist_entry_cmp_key *key __maybe_unused)
> > +{
> > +	return entry->stat.weight - key->sample->weight;
> > +}
> > +
> >  static int hist_entry__global_weight_snprintf(struct hist_entry *he, char *bf,
> >  					      size_t size, unsigned int width)
> >  {
> > @@ -1232,6 +1691,7 @@ static int hist_entry__global_weight_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_global_weight = {
> >  	.se_header	= "Weight",
> >  	.se_cmp		= sort__global_weight_cmp,
> > +	.se_cmp_key	= sort__global_weight_cmp_key,
> >  	.se_snprintf	= hist_entry__global_weight_snprintf,
> >  	.se_width_idx	= HISTC_GLOBAL_WEIGHT,
> >  };
> > @@ -1239,6 +1699,7 @@ struct sort_entry sort_global_weight = {
> >  struct sort_entry sort_mem_daddr_sym = {
> >  	.se_header	= "Data Symbol",
> >  	.se_cmp		= sort__daddr_cmp,
> > +	.se_cmp_key	= sort__daddr_cmp_key,
> >  	.se_snprintf	= hist_entry__daddr_snprintf,
> >  	.se_width_idx	= HISTC_MEM_DADDR_SYMBOL,
> >  };
> > @@ -1246,6 +1707,7 @@ struct sort_entry sort_mem_daddr_sym = {
> >  struct sort_entry sort_mem_iaddr_sym = {
> >  	.se_header	= "Code Symbol",
> >  	.se_cmp		= sort__iaddr_cmp,
> > +	.se_cmp_key	= sort__iaddr_cmp_key,
> >  	.se_snprintf	= hist_entry__iaddr_snprintf,
> >  	.se_width_idx	= HISTC_MEM_IADDR_SYMBOL,
> >  };
> > @@ -1253,6 +1715,7 @@ struct sort_entry sort_mem_iaddr_sym = {
> >  struct sort_entry sort_mem_daddr_dso = {
> >  	.se_header	= "Data Object",
> >  	.se_cmp		= sort__dso_daddr_cmp,
> > +	.se_cmp_key	= sort__dso_daddr_cmp_key,
> >  	.se_snprintf	= hist_entry__dso_daddr_snprintf,
> >  	.se_width_idx	= HISTC_MEM_DADDR_DSO,
> >  };
> > @@ -1260,6 +1723,7 @@ struct sort_entry sort_mem_daddr_dso = {
> >  struct sort_entry sort_mem_locked = {
> >  	.se_header	= "Locked",
> >  	.se_cmp		= sort__locked_cmp,
> > +	.se_cmp_key	= sort__locked_cmp_key,
> >  	.se_snprintf	= hist_entry__locked_snprintf,
> >  	.se_width_idx	= HISTC_MEM_LOCKED,
> >  };
> > @@ -1267,6 +1731,7 @@ struct sort_entry sort_mem_locked = {
> >  struct sort_entry sort_mem_tlb = {
> >  	.se_header	= "TLB access",
> >  	.se_cmp		= sort__tlb_cmp,
> > +	.se_cmp_key	= sort__tlb_cmp_key,
> >  	.se_snprintf	= hist_entry__tlb_snprintf,
> >  	.se_width_idx	= HISTC_MEM_TLB,
> >  };
> > @@ -1274,6 +1739,7 @@ struct sort_entry sort_mem_tlb = {
> >  struct sort_entry sort_mem_lvl = {
> >  	.se_header	= "Memory access",
> >  	.se_cmp		= sort__lvl_cmp,
> > +	.se_cmp_key	= sort__lvl_cmp_key,
> >  	.se_snprintf	= hist_entry__lvl_snprintf,
> >  	.se_width_idx	= HISTC_MEM_LVL,
> >  };
> > @@ -1281,6 +1747,7 @@ struct sort_entry sort_mem_lvl = {
> >  struct sort_entry sort_mem_snoop = {
> >  	.se_header	= "Snoop",
> >  	.se_cmp		= sort__snoop_cmp,
> > +	.se_cmp_key	= sort__snoop_cmp_key,
> >  	.se_snprintf	= hist_entry__snoop_snprintf,
> >  	.se_width_idx	= HISTC_MEM_SNOOP,
> >  };
> > @@ -1288,6 +1755,7 @@ struct sort_entry sort_mem_snoop = {
> >  struct sort_entry sort_mem_dcacheline = {
> >  	.se_header	= "Data Cacheline",
> >  	.se_cmp		= sort__dcacheline_cmp,
> > +	.se_cmp_key	= sort__dcacheline_cmp_key,
> >  	.se_snprintf	= hist_entry__dcacheline_snprintf,
> >  	.se_width_idx	= HISTC_MEM_DCACHELINE,
> >  };
> > @@ -1305,6 +1773,19 @@ sort__phys_daddr_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return (int64_t)(r - l);
> >  }
> >  
> > +static int64_t
> > +sort__phys_daddr_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	uint64_t l = 0, r = 0;
> > +
> > +	if (entry->mem_info)
> > +		l = entry->mem_info->daddr.phys_addr;
> > +	if (key->mem_info)
> > +		r = key->mem_info->daddr.phys_addr;
> > +
> > +	return (int64_t)(r - l);
> > +}
> > +
> >  static int hist_entry__phys_daddr_snprintf(struct hist_entry *he, char *bf,
> >  					   size_t size, unsigned int width)
> >  {
> > @@ -1329,6 +1810,7 @@ static int hist_entry__phys_daddr_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_mem_phys_daddr = {
> >  	.se_header	= "Data Physical Address",
> >  	.se_cmp		= sort__phys_daddr_cmp,
> > +	.se_cmp_key	= sort__phys_daddr_cmp_key,
> >  	.se_snprintf	= hist_entry__phys_daddr_snprintf,
> >  	.se_width_idx	= HISTC_MEM_PHYS_DADDR,
> >  };
> > @@ -1343,6 +1825,16 @@ sort__abort_cmp(struct hist_entry *left, struct hist_entry *right)
> >  		right->branch_info->flags.abort;
> >  }
> >  
> > +static int64_t
> > +sort__abort_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	if (!entry->branch_info || !key->bi)
> > +		return cmp_null(entry->branch_info, key->bi);
> > +
> > +	return entry->branch_info->flags.abort !=
> > +		key->bi->flags.abort;
> > +}
> > +
> >  static int hist_entry__abort_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -1361,6 +1853,7 @@ static int hist_entry__abort_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_abort = {
> >  	.se_header	= "Transaction abort",
> >  	.se_cmp		= sort__abort_cmp,
> > +	.se_cmp_key	= sort__abort_cmp_key,
> >  	.se_snprintf	= hist_entry__abort_snprintf,
> >  	.se_width_idx	= HISTC_ABORT,
> >  };
> > @@ -1375,6 +1868,16 @@ sort__in_tx_cmp(struct hist_entry *left, struct hist_entry *right)
> >  		right->branch_info->flags.in_tx;
> >  }
> >  
> > +static int64_t
> > +sort__in_tx_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	if (!entry->branch_info || !key->bi)
> > +		return cmp_null(entry->branch_info, key->bi);
> > +
> > +	return entry->branch_info->flags.in_tx !=
> > +		key->bi->flags.in_tx;
> > +}
> > +
> >  static int hist_entry__in_tx_snprintf(struct hist_entry *he, char *bf,
> >  				    size_t size, unsigned int width)
> >  {
> > @@ -1393,6 +1896,7 @@ static int hist_entry__in_tx_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_in_tx = {
> >  	.se_header	= "Branch in transaction",
> >  	.se_cmp		= sort__in_tx_cmp,
> > +	.se_cmp_key	= sort__in_tx_cmp_key,
> >  	.se_snprintf	= hist_entry__in_tx_snprintf,
> >  	.se_width_idx	= HISTC_IN_TX,
> >  };
> > @@ -1403,6 +1907,12 @@ sort__transaction_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return left->transaction - right->transaction;
> >  }
> >  
> > +static int64_t
> > +sort__transaction_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	return entry->transaction - key->sample->transaction;
> > +}
> > +
> >  static inline char *add_str(char *p, const char *str)
> >  {
> >  	strcpy(p, str);
> > @@ -1465,6 +1975,7 @@ static int hist_entry__transaction_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_transaction = {
> >  	.se_header	= "Transaction                ",
> >  	.se_cmp		= sort__transaction_cmp,
> > +	.se_cmp_key	= sort__transaction_cmp_key,
> >  	.se_snprintf	= hist_entry__transaction_snprintf,
> >  	.se_width_idx	= HISTC_TRANSACTION,
> >  };
> > @@ -1486,6 +1997,12 @@ sort__sym_size_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return _sort__sym_size_cmp(right->ms.sym, left->ms.sym);
> >  }
> >  
> > +static int64_t
> > +sort__sym_size_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	return _sort__sym_size_cmp(key->al->sym, entry->ms.sym);
> > +}
> > +
> >  static int _hist_entry__sym_size_snprintf(struct symbol *sym, char *bf,
> >  					  size_t bf_size, unsigned int width)
> >  {
> > @@ -1504,6 +2021,7 @@ static int hist_entry__sym_size_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_sym_size = {
> >  	.se_header	= "Symbol size",
> >  	.se_cmp		= sort__sym_size_cmp,
> > +	.se_cmp_key	= sort__sym_size_cmp_key,
> >  	.se_snprintf	= hist_entry__sym_size_snprintf,
> >  	.se_width_idx	= HISTC_SYM_SIZE,
> >  };
> > @@ -1525,6 +2043,12 @@ sort__dso_size_cmp(struct hist_entry *left, struct hist_entry *right)
> >  	return _sort__dso_size_cmp(right->ms.map, left->ms.map);
> >  }
> >  
> > +static int64_t
> > +sort__dso_size_cmp_key(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	return _sort__dso_size_cmp(key->al->map, entry->ms.map);
> > +}
> > +
> >  static int _hist_entry__dso_size_snprintf(struct map *map, char *bf,
> >  					  size_t bf_size, unsigned int width)
> >  {
> > @@ -1544,6 +2068,7 @@ static int hist_entry__dso_size_snprintf(struct hist_entry *he, char *bf,
> >  struct sort_entry sort_dso_size = {
> >  	.se_header	= "DSO size",
> >  	.se_cmp		= sort__dso_size_cmp,
> > +	.se_cmp_key	= sort__dso_size_cmp_key,
> >  	.se_snprintf	= hist_entry__dso_size_snprintf,
> >  	.se_width_idx	= HISTC_DSO_SIZE,
> >  };
> > @@ -1693,12 +2218,13 @@ static int __sort__hpp_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> >  }
> >  
> >  static int64_t __sort__hpp_cmp(struct perf_hpp_fmt *fmt,
> > -			       struct hist_entry *a, struct hist_entry *b)
> > +			       struct hist_entry *entry,
> > +			       struct hist_entry_cmp_key *key)
> >  {
> >  	struct hpp_sort_entry *hse;
> >  
> >  	hse = container_of(fmt, struct hpp_sort_entry, hpp);
> > -	return hse->se->se_cmp(a, b);
> > +	return hse->se->se_cmp_key(entry, key);
> >  }
> >  
> >  static int64_t __sort__hpp_collapse(struct perf_hpp_fmt *fmt,
> > @@ -2089,9 +2615,37 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
> >  	return memcmp(a->raw_data + offset, b->raw_data + offset, size);
> >  }
> >  
> > +static int64_t __sort__hde_cmp_key(struct perf_hpp_fmt *fmt,
> > +				   struct hist_entry *a,
> > +				   struct hist_entry_cmp_key *key)
> > +{
> > +	struct hpp_dynamic_entry *hde;
> > +	struct tep_format_field *field;
> > +	unsigned offset, size;
> > +
> > +	hde = container_of(fmt, struct hpp_dynamic_entry, hpp);
> > +	field = hde->field;
> > +	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> > +		unsigned long long dyn;
> > +
> > +		tep_read_number_field(field, a->raw_data, &dyn);
> > +		offset = dyn & 0xffff;
> > +		size = (dyn >> 16) & 0xffff;
> > +
> > +		/* record max width for output */
> > +		if (size > hde->dynamic_len)
> > +			hde->dynamic_len = size;
> > +	} else {
> > +		offset = field->offset;
> > +		size = field->size;
> > +	}
> > +
> > +	return memcmp(a->raw_data + offset, key->sample->raw_data + offset, size);
> > +}
> > +
> >  bool perf_hpp__is_dynamic_entry(struct perf_hpp_fmt *fmt)
> >  {
> > -	return fmt->cmp == __sort__hde_cmp;
> > +	return fmt->cmp == __sort__hde_cmp_key;
> >  }
> >  
> >  static bool __sort__hde_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> > @@ -2138,7 +2692,7 @@ __alloc_dynamic_entry(struct perf_evsel *evsel, struct tep_format_field *field,
> >  	hde->hpp.entry  = __sort__hde_entry;
> >  	hde->hpp.color  = NULL;
> >  
> > -	hde->hpp.cmp = __sort__hde_cmp;
> > +	hde->hpp.cmp = __sort__hde_cmp_key;
> >  	hde->hpp.collapse = __sort__hde_cmp;
> >  	hde->hpp.sort = __sort__hde_cmp;
> >  	hde->hpp.equal = __sort__hde_equal;
> > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > index a97cf8e..da85224 100644
> > --- a/tools/perf/util/sort.h
> > +++ b/tools/perf/util/sort.h
> > @@ -264,6 +264,7 @@ struct sort_entry {
> >  	const char *se_header;
> >  
> >  	int64_t (*se_cmp)(struct hist_entry *, struct hist_entry *);
> > +	int64_t (*se_cmp_key)(struct hist_entry *, struct hist_entry_cmp_key *);
> >  	int64_t (*se_collapse)(struct hist_entry *, struct hist_entry *);
> >  	int64_t	(*se_sort)(struct hist_entry *, struct hist_entry *);
> >  	int	(*se_snprintf)(struct hist_entry *he, char *bf, size_t size,
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index 3badd7f..78df16b 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -150,7 +150,6 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
> >  struct perf_hpp;
> >  struct perf_hpp_fmt;
> >  
> > -int64_t hist_entry__cmp(struct hist_entry *left, struct hist_entry *right);
> >  int64_t hist_entry__collapse(struct hist_entry *left, struct hist_entry *right);
> >  int hist_entry__transaction_len(void);
> >  int hist_entry__sort_snprintf(struct hist_entry *he, char *bf, size_t size,
> > @@ -238,6 +237,18 @@ struct perf_hpp {
> >  	void *ptr;
> >  };
> >  
> > +struct hist_entry_cmp_key {
> > +	struct addr_location *al;
> > +	struct comm *comm;
> > +	struct branch_info *bi;
> > +	struct symbol *sym_parent;
> > +	struct perf_sample *sample;
> > +	struct mem_info *mem_info;
> > +	char *srcfile;
> > +	char *trace_output;
> > +};
> > +
> > +struct comm;
> >  struct perf_hpp_fmt {
> >  	const char *name;
> >  	int (*header)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> > @@ -249,7 +260,8 @@ struct perf_hpp_fmt {
> >  	int (*entry)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> >  		     struct hist_entry *he);
> >  	int64_t (*cmp)(struct perf_hpp_fmt *fmt,
> > -		       struct hist_entry *a, struct hist_entry *b);
> > +		       struct hist_entry *entry,
> > +		       struct hist_entry_cmp_key *key);
> >  	int64_t (*collapse)(struct perf_hpp_fmt *fmt,
> >  			    struct hist_entry *a, struct hist_entry *b);
> >  	int64_t (*sort)(struct perf_hpp_fmt *fmt,
> > @@ -525,4 +537,8 @@ static inline int hists__scnprintf_title(struct hists *hists, char *bf, size_t s
> >  	return __hists__scnprintf_title(hists, bf, size, true);
> >  }
> >  
> > +extern unsigned long hist_lookups;
> > +extern unsigned long hist_hits;
> > +extern unsigned long hist_misses;
> > +
> >  #endif	/* __PERF_HIST_H */
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 828cb97..a4deb5d 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -364,16 +364,49 @@ void hists__delete_entries(struct hists *hists)
> >  	}
> >  }
> >  
> > +static u8 symbol__parent_filter(const struct symbol *parent)
> > +{
> > +	if (symbol_conf.exclude_other && parent == NULL)
> > +		return 1 << HIST_FILTER__PARENT;
> > +	return 0;
> > +}
> > +
> >  /*
> >   * histogram, sorted on item, collects periods
> >   */
> >  
> >  static int hist_entry__init(struct hist_entry *he,
> > -			    struct hist_entry *template,
> > +			    struct hist_entry_cmp_key *key,
> > +			    struct hists *hists,
> >  			    bool sample_self,
> >  			    size_t callchain_size)
> >  {
> > -	*he = *template;
> > +	struct namespaces *ns = thread__namespaces(key->al->thread);
> > +
> > +	he->thread = key->al->thread;
> > +	he->comm = thread__comm(he->thread);
> > +	he->cgroup_id.dev = ns ? ns->link_info[CGROUP_NS_INDEX].dev : 0;
> > +	he->cgroup_id.ino = ns ? ns->link_info[CGROUP_NS_INDEX].ino : 0;
> > +	he->ms.map = key->al->map;
> > +	he->ms.sym = key->al->sym;
> > +	he->srcline = key->al->srcline ? strdup(key->al->srcline) : NULL;
> > +	he->socket	 = key->al->socket;
> > +	he->cpu	 = key->al->cpu;
> > +	he->cpumode = key->al->cpumode;
> > +	he->ip	 = key->al->addr;
> > +	he->level	 = key->al->level;
> > +	he->stat.nr_events = 1;
> > +	he->stat.period = key->sample->period;
> > +	he->stat.weight = key->sample->weight;
> > +	he->parent = key->sym_parent;
> > +	he->filtered = symbol__parent_filter(key->sym_parent) | key->al->filtered;
> > +	he->hists = hists;
> > +	he->branch_info = key->bi;
> > +	he->mem_info = key->mem_info;
> > +	he->transaction = key->sample->transaction;
> > +	he->raw_data = key->sample->raw_data;
> > +	he->raw_size = key->sample->raw_size;
> > +
> >  	he->callchain_size = callchain_size;
> >  
> >  	if (symbol_conf.cumulate_callchain) {
> > @@ -400,7 +433,7 @@ static int hist_entry__init(struct hist_entry *he,
> >  			return -ENOMEM;
> >  		}
> >  
> > -		memcpy(he->branch_info, template->branch_info,
> > +		memcpy(he->branch_info, key->bi,
> >  		       sizeof(*he->branch_info));
> >  
> >  		map__get(he->branch_info->from.map);
> > @@ -459,23 +492,25 @@ static struct hist_entry_ops default_ops = {
> >  	.free	= hist_entry__free,
> >  };
> >  
> > -static struct hist_entry *hist_entry__new(struct hist_entry *template,
> > +static struct hist_entry *hist_entry__new(struct hist_entry_cmp_key *key,
> > +					  struct hists *hists,
> > +					  struct hist_entry_ops *ops,
> >  					  bool sample_self)
> >  {
> > -	struct hist_entry_ops *ops = template->ops;
> >  	size_t callchain_size = 0;
> >  	struct hist_entry *he;
> >  	int err = 0;
> >  
> >  	if (!ops)
> > -		ops = template->ops = &default_ops;
> > +		ops = &default_ops;
> >  
> >  	if (symbol_conf.use_callchain)
> >  		callchain_size = sizeof(struct callchain_root);
> >  
> >  	he = ops->new(callchain_size);
> >  	if (he) {
> > -		err = hist_entry__init(he, template, sample_self, callchain_size);
> > +		he->ops = ops;
> > +		err = hist_entry__init(he, key, hists, sample_self, callchain_size);
> >  		if (err) {
> >  			ops->free(he);
> >  			he = NULL;
> > @@ -485,13 +520,6 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
> >  	return he;
> >  }
> >  
> > -static u8 symbol__parent_filter(const struct symbol *parent)
> > -{
> > -	if (symbol_conf.exclude_other && parent == NULL)
> > -		return 1 << HIST_FILTER__PARENT;
> > -	return 0;
> > -}
> > -
> >  static void hist_entry__add_callchain_period(struct hist_entry *he, u64 period)
> >  {
> >  	if (!hist_entry__has_callchains(he) || !symbol_conf.use_callchain)
> > @@ -502,17 +530,43 @@ static void hist_entry__add_callchain_period(struct hist_entry *he, u64 period)
> >  		he->hists->callchain_non_filtered_period += period;
> >  }
> >  
> > +static int64_t
> > +hist_entry__cmp(struct hist_entry *entry, struct hist_entry_cmp_key *key)
> > +{
> > +	struct hists *hists = entry->hists;
> > +	struct perf_hpp_fmt *fmt;
> > +	int64_t cmp = 0;
> > +
> > +	hists__for_each_sort_list(hists, fmt) {
> > +		if (perf_hpp__is_dynamic_entry(fmt) &&
> > +		    !perf_hpp__defined_dynamic_entry(fmt, hists))
> > +			continue;
> > +
> > +		cmp = fmt->cmp(fmt, entry, key);
> > +		if (cmp)
> > +			break;
> > +	}
> > +
> > +	return cmp;
> > +}
> > +
> > +unsigned long hist_lookups;
> > +unsigned long hist_hits;
> > +unsigned long hist_misses;
> > +
> >  static struct hist_entry *hists__findnew_entry(struct hists *hists,
> > -					       struct hist_entry *entry,
> > -					       struct addr_location *al,
> > +					       struct hist_entry_cmp_key *key,
> > +					       struct hist_entry_ops *ops,
> >  					       bool sample_self)
> >  {
> >  	struct rb_node **p;
> >  	struct rb_node *parent = NULL;
> >  	struct hist_entry *he;
> >  	int64_t cmp;
> > -	u64 period = entry->stat.period;
> > -	u64 weight = entry->stat.weight;
> > +	u64 period = key->sample->period;
> > +	u64 weight = key->sample->weight;
> > +
> > +	hist_lookups++;
> >  
> >  	p = &hists->entries_in->rb_node;
> >  
> > @@ -526,7 +580,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
> >  		 * function when searching an entry regardless which sort
> >  		 * keys were used.
> >  		 */
> > -		cmp = hist_entry__cmp(he, entry);
> > +		cmp = hist_entry__cmp(he, key);
> >  
> >  		if (!cmp) {
> >  			if (sample_self) {
> > @@ -540,7 +594,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
> >  			 * This mem info was allocated from sample__resolve_mem
> >  			 * and will not be used anymore.
> >  			 */
> > -			mem_info__zput(entry->mem_info);
> > +			mem_info__zput(key->mem_info);
> >  
> >  			/* If the map of an existing hist_entry has
> >  			 * become out-of-date due to an exec() or
> > @@ -548,10 +602,11 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
> >  			 * mis-adjust symbol addresses when computing
> >  			 * the history counter to increment.
> >  			 */
> > -			if (he->ms.map != entry->ms.map) {
> > +			if (he->ms.map != key->al->map) {
> >  				map__put(he->ms.map);
> > -				he->ms.map = map__get(entry->ms.map);
> > +				he->ms.map = map__get(key->al->map);
> >  			}
> > +			hist_hits++;
> >  			goto out;
> >  		}
> >  
> > @@ -561,7 +616,8 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
> >  			p = &(*p)->rb_right;
> >  	}
> >  
> > -	he = hist_entry__new(entry, sample_self);
> > +	hist_misses++;
> > +	he = hist_entry__new(key, hists, ops, sample_self);
> >  	if (!he)
> >  		return NULL;
> >  
> > @@ -573,9 +629,9 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
> >  	rb_insert_color(&he->rb_node_in, hists->entries_in);
> >  out:
> >  	if (sample_self)
> > -		he_stat__add_cpumode_period(&he->stat, al->cpumode, period);
> > +		he_stat__add_cpumode_period(&he->stat, key->al->cpumode, period);
> >  	if (symbol_conf.cumulate_callchain)
> > -		he_stat__add_cpumode_period(he->stat_acc, al->cpumode, period);
> > +		he_stat__add_cpumode_period(he->stat_acc, key->al->cpumode, period);
> >  	return he;
> >  }
> >  
> > @@ -589,39 +645,19 @@ __hists__add_entry(struct hists *hists,
> >  		   bool sample_self,
> >  		   struct hist_entry_ops *ops)
> >  {
> > -	struct namespaces *ns = thread__namespaces(al->thread);
> > -	struct hist_entry entry = {
> > -		.thread	= al->thread,
> > -		.comm = thread__comm(al->thread),
> > -		.cgroup_id = {
> > -			.dev = ns ? ns->link_info[CGROUP_NS_INDEX].dev : 0,
> > -			.ino = ns ? ns->link_info[CGROUP_NS_INDEX].ino : 0,
> > -		},
> > -		.ms = {
> > -			.map	= al->map,
> > -			.sym	= al->sym,
> > -		},
> > -		.srcline = al->srcline ? strdup(al->srcline) : NULL,
> > -		.socket	 = al->socket,
> > -		.cpu	 = al->cpu,
> > -		.cpumode = al->cpumode,
> > -		.ip	 = al->addr,
> > -		.level	 = al->level,
> > -		.stat = {
> > -			.nr_events = 1,
> > -			.period	= sample->period,
> > -			.weight = sample->weight,
> > -		},
> > -		.parent = sym_parent,
> > -		.filtered = symbol__parent_filter(sym_parent) | al->filtered,
> > -		.hists	= hists,
> > -		.branch_info = bi,
> > -		.mem_info = mi,
> > -		.transaction = sample->transaction,
> > -		.raw_data = sample->raw_data,
> > -		.raw_size = sample->raw_size,
> > -		.ops = ops,
> > -	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
> > +	struct hist_entry_cmp_key key;
> > +	struct hist_entry *he;
> > +
> > +	key.al = al;
> > +	key.comm = thread__comm(al->thread);
> > +	key.bi = bi;
> > +	key.sym_parent = sym_parent;
> > +	key.sample = sample;
> > +	key.mem_info = mi;
> > +	key.srcfile = NULL;
> > +	key.trace_output = NULL;
> > +
> > +	he = hists__findnew_entry(hists, &key, ops, sample_self);
> >  
> >  	if (!hists->has_callchains && he && he->callchain_size != 0)
> >  		hists->has_callchains = true;
> > @@ -947,7 +983,9 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
> >  	struct perf_evsel *evsel = iter->evsel;
> >  	struct perf_sample *sample = iter->sample;
> >  	struct hist_entry **he_cache = iter->priv;
> > +	struct hist_entry_cmp_key key;
> >  	struct hist_entry *he;
> > +#if 0
> >  	struct hist_entry he_tmp = {
> >  		.hists = evsel__hists(evsel),
> >  		.cpu = al->cpu,
> > @@ -963,6 +1001,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
> >  		.raw_data = sample->raw_data,
> >  		.raw_size = sample->raw_size,
> >  	};
> > +#endif
> >  	int i;
> >  	struct callchain_cursor cursor;
> >  
> > @@ -974,8 +1013,16 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
> >  	 * Check if there's duplicate entries in the callchain.
> >  	 * It's possible that it has cycles or recursive calls.
> >  	 */
> > +	key.al = al;
> > +	key.comm = thread__comm(al->thread);
> > +	key.bi = NULL;
> > +	key.sym_parent = iter->parent;
> > +	key.sample = sample;
> > +	key.mem_info = NULL;
> > +	key.srcfile = NULL;
> > +	key.trace_output = NULL;
> >  	for (i = 0; i < iter->curr; i++) {
> > -		if (hist_entry__cmp(he_cache[i], &he_tmp) == 0) {
> > +		if (hist_entry__cmp(he_cache[i], &key) == 0) {
> >  			/* to avoid calling callback function */
> >  			iter->he = NULL;
> >  			return 0;
> > @@ -1088,26 +1135,6 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
> >  }
> >  
> >  int64_t
> > -hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
> > -{
> > -	struct hists *hists = left->hists;
> > -	struct perf_hpp_fmt *fmt;
> > -	int64_t cmp = 0;
> > -
> > -	hists__for_each_sort_list(hists, fmt) {
> > -		if (perf_hpp__is_dynamic_entry(fmt) &&
> > -		    !perf_hpp__defined_dynamic_entry(fmt, hists))
> > -			continue;
> > -
> > -		cmp = fmt->cmp(fmt, left, right);
> > -		if (cmp)
> > -			break;
> > -	}
> > -
> > -	return cmp;
> > -}
> > -
> > -int64_t
> >  hist_entry__collapse(struct hist_entry *left, struct hist_entry *right)
> >  {
> >  	struct hists *hists = left->hists;
> > @@ -1312,7 +1339,11 @@ static struct hist_entry *hierarchy_insert_entry(struct hists *hists,
> >  			p = &parent->rb_right;
> >  	}
> >  
> > -	new = hist_entry__new(he, true);
> > +#if 1
> > +	new = NULL;
> > +#else
> > +	new = hist_entry__new(he, true); /* XXX fix XXX */
> > +#endif
> >  	if (new == NULL)
> >  		return NULL;
> >  
> > @@ -2168,7 +2199,11 @@ static struct hist_entry *hists__add_dummy_entry(struct hists *hists,
> >  			p = &(*p)->rb_right;
> >  	}
> >  
> > -	he = hist_entry__new(pair, true);
> > +#if 1
> > +	he = NULL;
> > +#else
> > +	he = hist_entry__new(pair, true); /* XXX fix XXX */
> > +#endif
> >  	if (he) {
> >  		memset(&he->stat, 0, sizeof(he->stat));
> >  		he->hists = hists;
> > @@ -2213,7 +2248,11 @@ static struct hist_entry *add_dummy_hierarchy_entry(struct hists *hists,
> >  			p = &parent->rb_right;
> >  	}
> >  
> > -	he = hist_entry__new(pair, true);
> > +#if 1
> > +	he = NULL;
> > +#else
> > +	he = hist_entry__new(pair, true); /* XXX fix XXX */
> > +#endif
> >  	if (he) {
> >  		rb_link_node(&he->rb_node_in, parent, p);
> >  		rb_insert_color(&he->rb_node_in, root);
> > diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> > index fe3dfaa..a3d66e1 100644
> > --- a/tools/perf/ui/hist.c
> > +++ b/tools/perf/ui/hist.c
> > @@ -372,8 +372,15 @@ HPP_RAW_FNS(samples, nr_events)
> >  HPP_RAW_FNS(period, period)
> >  
> >  static int64_t hpp__nop_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> > -			    struct hist_entry *a __maybe_unused,
> > -			    struct hist_entry *b __maybe_unused)
> > +			    struct hist_entry *entry __maybe_unused,
> > +			    struct hist_entry_cmp_key *key __maybe_unused)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int64_t hpp__nop_collapse(struct perf_hpp_fmt *fmt __maybe_unused,
> > +				 struct hist_entry *a __maybe_unused,
> > +				 struct hist_entry *b __maybe_unused)
> >  {
> >  	return 0;
> >  }
> > @@ -399,7 +406,7 @@ static bool hpp__equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> >  		.color	= hpp__color_ ## _fn,		\
> >  		.entry	= hpp__entry_ ## _fn,		\
> >  		.cmp	= hpp__nop_cmp,			\
> > -		.collapse = hpp__nop_cmp,		\
> > +		.collapse = hpp__nop_collapse,		\
> >  		.sort	= hpp__sort_ ## _fn,		\
> >  		.idx	= PERF_HPP__ ## _idx,		\
> >  		.equal	= hpp__equal,			\
> > @@ -413,7 +420,7 @@ static bool hpp__equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> >  		.color	= hpp__color_ ## _fn,		\
> >  		.entry	= hpp__entry_ ## _fn,		\
> >  		.cmp	= hpp__nop_cmp,			\
> > -		.collapse = hpp__nop_cmp,		\
> > +		.collapse = hpp__nop_collapse,		\
> >  		.sort	= hpp__sort_ ## _fn,		\
> >  		.idx	= PERF_HPP__ ## _idx,		\
> >  		.equal	= hpp__equal,			\
> > @@ -426,7 +433,7 @@ static bool hpp__equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> >  		.width	= hpp__width_fn,		\
> >  		.entry	= hpp__entry_ ## _fn,		\
> >  		.cmp	= hpp__nop_cmp,			\
> > -		.collapse = hpp__nop_cmp,		\
> > +		.collapse = hpp__nop_collapse,		\
> >  		.sort	= hpp__sort_ ## _fn,		\
> >  		.idx	= PERF_HPP__ ## _idx,		\
> >  		.equal	= hpp__equal,			\
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index f3aa9d0..190f5eb 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -1717,12 +1717,13 @@ static int c2c_se_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> >  }
> >  
> >  static int64_t c2c_se_cmp(struct perf_hpp_fmt *fmt,
> > -			  struct hist_entry *a, struct hist_entry *b)
> > +			  struct hist_entry *entry,
> > +			  struct hist_entry_cmp_key *key)
> >  {
> >  	struct c2c_fmt *c2c_fmt = container_of(fmt, struct c2c_fmt, fmt);
> >  	struct c2c_dimension *dim = c2c_fmt->dim;
> >  
> > -	return dim->se->se_cmp(a, b);
> > +	return dim->se->se_cmp_key(entry, key);
> >  }
> >  
> >  static int64_t c2c_se_collapse(struct perf_hpp_fmt *fmt,
> > @@ -1755,8 +1756,13 @@ static struct c2c_fmt *get_format(const char *name)
> >  	INIT_LIST_HEAD(&fmt->list);
> >  	INIT_LIST_HEAD(&fmt->sort_list);
> >  
> > +#if 1
> > +	fmt->cmp	= c2c_se_cmp;
> > +	fmt->sort	= dim->cmp;
> > +#else
> >  	fmt->cmp	= dim->se ? c2c_se_cmp   : dim->cmp;
> >  	fmt->sort	= dim->se ? c2c_se_cmp   : dim->cmp;
> > +#endif
> >  	fmt->color	= dim->se ? NULL	 : dim->color;
> >  	fmt->entry	= dim->se ? c2c_se_entry : dim->entry;
> >  	fmt->header	= c2c_header;
> > diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> > index 39db2ee..2684efa 100644
> > --- a/tools/perf/builtin-diff.c
> > +++ b/tools/perf/builtin-diff.c
> > @@ -604,8 +604,16 @@ hist_entry__cmp_compute_idx(struct hist_entry *left, struct hist_entry *right,
> >  
> >  static int64_t
> >  hist_entry__cmp_nop(struct perf_hpp_fmt *fmt __maybe_unused,
> > -		    struct hist_entry *left __maybe_unused,
> > -		    struct hist_entry *right __maybe_unused)
> > +		    struct hist_entry *entry __maybe_unused,
> > +		    struct hist_entry_cmp_key *key __maybe_unused)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int64_t
> > +hist_entry__collapse_nop(struct perf_hpp_fmt *fmt __maybe_unused,
> > +			 struct hist_entry *a __maybe_unused,
> > +			 struct hist_entry *b __maybe_unused)
> >  {
> >  	return 0;
> >  }
> > @@ -1141,7 +1149,7 @@ static void data__hpp_register(struct data__file *d, int idx)
> >  	fmt->width  = hpp__width;
> >  	fmt->entry  = hpp__entry_global;
> >  	fmt->cmp    = hist_entry__cmp_nop;
> > -	fmt->collapse = hist_entry__cmp_nop;
> > +	fmt->collapse = hist_entry__collapse_nop;
> >  
> >  	/* TODO more colors */
> >  	switch (idx) {
> > @@ -1166,7 +1174,7 @@ static void data__hpp_register(struct data__file *d, int idx)
> >  		fmt->sort  = hist_entry__cmp_delta_abs;
> >  		break;
> >  	default:
> > -		fmt->sort  = hist_entry__cmp_nop;
> > +		fmt->sort  = hist_entry__collapse_nop;
> >  		break;
> >  	}
> >  
> > @@ -1230,7 +1238,7 @@ static int ui_init(void)
> >  	}
> >  
> >  	fmt->cmp      = hist_entry__cmp_nop;
> > -	fmt->collapse = hist_entry__cmp_nop;
> > +	fmt->collapse = hist_entry__collapse_nop;
> >  
> >  	switch (compute) {
> >  	case COMPUTE_DELTA:
