Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935861AbeCHNM2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:12:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935769AbeCHNM1 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:12:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550672133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 8 Mar 2018 10:12:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf annotate: Support to display the IPC/Cycle in
 tui mode
Message-ID: <20180308131223.GD3701@kernel.org>
References: <1519724327-7773-1-git-send-email-yao.jin@linux.intel.com>
 <13267feb-fb71-cb7e-26c8-9285d256a332@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13267feb-fb71-cb7e-26c8-9285d256a332@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 08, 2018 at 01:22:15PM +0800, Jin, Yao escreveu:
> Hi,
> 
> Could this patch be accepted?
 
> I'm working on the supporting for stdio mode. I just wish to post the patch
> series after this patch being merged.

merged, please proceed.

- Arnaldo
 
> Thanks
> Jin Yao
> 
> On 2/27/2018 5:38 PM, Jin Yao wrote:
> > Unlike the perf report interactive annotate mode, the perf annotate
> > doesn't display the IPC/Cycle even if branch info is recorded in perf
> > data file.
> > 
> > perf record -b ...
> > perf annotate function
> > 
> > It should show IPC/cycle, but it doesn't.
> > 
> > This patch lets perf annotate support the displaying of IPC/Cycle if
> > branch info is in perf data.
> > 
> > For example,
> > 
> > perf annotate compute_flag
> > 
> > Percent│ IPC Cycle
> >         │
> >         │
> >         │                Disassembly of section .text:
> >         │
> >         │                0000000000400640 <compute_flag>:
> >         │                compute_flag():
> >         │                volatile int count;
> >         │                static unsigned int s_randseed;
> >         │
> >         │                __attribute__((noinline))
> >         │                int compute_flag()
> >         │                {
> >   22.96 │1.18   584        sub    $0x8,%rsp
> >         │                        int i;
> >         │
> >         │                        i = rand() % 2;
> >   23.02 │1.18     1      → callq  rand@plt
> >         │
> >         │                        return i;
> >   27.05 │3.37              mov    %eax,%edx
> >         │                }
> >         │3.37              add    $0x8,%rsp
> >         │                {
> >         │                        int i;
> >         │
> >         │                        i = rand() % 2;
> >         │
> >         │                        return i;
> >         │3.37              shr    $0x1f,%edx
> >         │3.37              add    %edx,%eax
> >         │3.37              and    $0x1,%eax
> >         │3.37              sub    %edx,%eax
> >         │                }
> >   26.97 │3.37     2      ← retq
> > 
> > Note that, this patch only supports tui mode. For stdio,
> > now it just keeps original behavior. Will support it in a
> > follow-up patch.
> > 
> > perf annotate compute_flag --stdio
> > 
> >   Percent |      Source code & Disassembly of div for cycles:ppp (7993 samples)
> > ------------------------------------------------------------------------------
> >           :
> >           :
> >           :
> >           :            Disassembly of section .text:
> >           :
> >           :            0000000000400640 <compute_flag>:
> >           :            compute_flag():
> >           :            volatile int count;
> >           :            static unsigned int s_randseed;
> >           :
> >           :            __attribute__((noinline))
> >           :            int compute_flag()
> >           :            {
> >      0.29 :   400640:       sub    $0x8,%rsp     # +100.00%
> >           :                    int i;
> >           :
> >           :                    i = rand() % 2;
> >     42.93 :   400644:       callq  400490 <rand@plt>     # -100.00% (p:100.00%)
> >           :
> >           :                    return i;
> >      0.10 :   400649:       mov    %eax,%edx     # +100.00%
> >           :            }
> >      0.94 :   40064b:       add    $0x8,%rsp
> >           :            {
> >           :                    int i;
> >           :
> >           :                    i = rand() % 2;
> >           :
> >           :                    return i;
> >     27.02 :   40064f:       shr    $0x1f,%edx
> >      0.15 :   400652:       add    %edx,%eax
> >      1.24 :   400654:       and    $0x1,%eax
> >      2.08 :   400657:       sub    %edx,%eax
> >           :            }
> >     25.26 :   400659:       retq # -100.00% (p:100.00%)
> > 
> > Change-log:
> > -----------
> > v2:
> > ---
> > No code change. Just change the patch description to make it more clear.
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > ---
> >   tools/perf/builtin-annotate.c | 88 ++++++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 82 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index f15731a..ead6ae4 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -44,6 +44,7 @@ struct perf_annotate {
> >   	bool	   full_paths;
> >   	bool	   print_line;
> >   	bool	   skip_missing;
> > +	bool	   has_br_stack;
> >   	const char *sym_hist_filter;
> >   	const char *cpu_list;
> >   	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> > @@ -146,16 +147,73 @@ static void process_branch_stack(struct branch_stack *bs, struct addr_location *
> >   	free(bi);
> >   }
> > +static int hist_iter__branch_callback(struct hist_entry_iter *iter,
> > +				      struct addr_location *al __maybe_unused,
> > +				      bool single __maybe_unused,
> > +				      void *arg __maybe_unused)
> > +{
> > +	struct hist_entry *he = iter->he;
> > +	struct branch_info *bi;
> > +	struct perf_sample *sample = iter->sample;
> > +	struct perf_evsel *evsel = iter->evsel;
> > +	int err;
> > +
> > +	hist__account_cycles(sample->branch_stack, al, sample, false);
> > +
> > +	bi = he->branch_info;
> > +	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel->idx);
> > +
> > +	if (err)
> > +		goto out;
> > +
> > +	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel->idx);
> > +
> > +out:
> > +	return err;
> > +}
> > +
> > +static int process_branch_callback(struct perf_evsel *evsel,
> > +				   struct perf_sample *sample,
> > +				   struct addr_location *al __maybe_unused,
> > +				   struct perf_annotate *ann,
> > +				   struct machine *machine)
> > +{
> > +	struct hist_entry_iter iter = {
> > +		.evsel		= evsel,
> > +		.sample		= sample,
> > +		.add_entry_cb	= hist_iter__branch_callback,
> > +		.hide_unresolved	= symbol_conf.hide_unresolved,
> > +		.ops		= &hist_iter_branch,
> > +	};
> > +
> > +	struct addr_location a;
> > +	int ret;
> > +
> > +	if (machine__resolve(machine, &a, sample) < 0)
> > +		return -1;
> > +
> > +	if (a.sym == NULL)
> > +		return 0;
> > +
> > +	if (a.map != NULL)
> > +		a.map->dso->hit = 1;
> > +
> > +	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
> > +	return ret;
> > +}
> > +
> >   static int perf_evsel__add_sample(struct perf_evsel *evsel,
> >   				  struct perf_sample *sample,
> >   				  struct addr_location *al,
> > -				  struct perf_annotate *ann)
> > +				  struct perf_annotate *ann,
> > +				  struct machine *machine)
> >   {
> >   	struct hists *hists = evsel__hists(evsel);
> >   	struct hist_entry *he;
> >   	int ret;
> > -	if (ann->sym_hist_filter != NULL &&
> > +	if ((!ann->has_br_stack || !ui__has_annotation()) &&
> > +	    ann->sym_hist_filter != NULL &&
> >   	    (al->sym == NULL ||
> >   	     strcmp(ann->sym_hist_filter, al->sym->name) != 0)) {
> >   		/* We're only interested in a symbol named sym_hist_filter */
> > @@ -178,6 +236,9 @@ static int perf_evsel__add_sample(struct perf_evsel *evsel,
> >   	 */
> >   	process_branch_stack(sample->branch_stack, al, sample);
> > +	if (ann->has_br_stack && ui__has_annotation())
> > +		return process_branch_callback(evsel, sample, al, ann, machine);
> > +
> >   	he = hists__add_entry(hists, al, NULL, NULL, NULL, sample, true);
> >   	if (he == NULL)
> >   		return -ENOMEM;
> > @@ -206,7 +267,8 @@ static int process_sample_event(struct perf_tool *tool,
> >   	if (ann->cpu_list && !test_bit(sample->cpu, ann->cpu_bitmap))
> >   		goto out_put;
> > -	if (!al.filtered && perf_evsel__add_sample(evsel, sample, &al, ann)) {
> > +	if (!al.filtered &&
> > +	    perf_evsel__add_sample(evsel, sample, &al, ann, machine)) {
> >   		pr_warning("problem incrementing symbol count, "
> >   			   "skipping event\n");
> >   		ret = -1;
> > @@ -238,6 +300,10 @@ static void hists__find_annotations(struct hists *hists,
> >   		if (he->ms.sym == NULL || he->ms.map->dso->annotate_warned)
> >   			goto find_next;
> > +		if (ann->sym_hist_filter &&
> > +		    (strcmp(he->ms.sym->name, ann->sym_hist_filter) != 0))
> > +			goto find_next;
> > +
> >   		notes = symbol__annotation(he->ms.sym);
> >   		if (notes->src == NULL) {
> >   find_next:
> > @@ -269,6 +335,7 @@ static void hists__find_annotations(struct hists *hists,
> >   			nd = rb_next(nd);
> >   		} else if (use_browser == 1) {
> >   			key = hist_entry__tui_annotate(he, evsel, NULL);
> > +
> >   			switch (key) {
> >   			case -1:
> >   				if (!ann->skip_missing)
> > @@ -489,6 +556,9 @@ int cmd_annotate(int argc, const char **argv)
> >   	if (annotate.session == NULL)
> >   		return -1;
> > +	annotate.has_br_stack = perf_header__has_feat(&annotate.session->header,
> > +						      HEADER_BRANCH_STACK);
> > +
> >   	ret = symbol__annotation_init();
> >   	if (ret < 0)
> >   		goto out_delete;
> > @@ -499,9 +569,6 @@ int cmd_annotate(int argc, const char **argv)
> >   	if (ret < 0)
> >   		goto out_delete;
> > -	if (setup_sorting(NULL) < 0)
> > -		usage_with_options(annotate_usage, options);
> > -
> >   	if (annotate.use_stdio)
> >   		use_browser = 0;
> >   	else if (annotate.use_tui)
> > @@ -511,6 +578,15 @@ int cmd_annotate(int argc, const char **argv)
> >   	setup_browser(true);
> > +	if (use_browser == 1 && annotate.has_br_stack) {
> > +		sort__mode = SORT_MODE__BRANCH;
> > +		if (setup_sorting(annotate.session->evlist) < 0)
> > +			usage_with_options(annotate_usage, options);
> > +	} else {
> > +		if (setup_sorting(NULL) < 0)
> > +			usage_with_options(annotate_usage, options);
> > +	}
> > +
> >   	ret = __cmd_annotate(&annotate);
> >   out_delete:
> > 
