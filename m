Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932311AbeCMPVF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932217AbeCMPVD (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:21:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B32214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 13 Mar 2018 12:20:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/4] perf annotate: Create a new '--tui-dump' option
Message-ID: <20180313152059.GB29837@kernel.org>
References: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 13, 2018 at 10:16:50PM +0800, Jin Yao escreveu:
> There is a requirement to let perf annotate support displaying the IPC/Cycle.
> In previous patch, this is supported in TUI mode. While it's not convenient
> for users since they have to take screen shots and copy/paste data.
> 
> This patch series introduces a new option '--tui-dump' in perf annotate to
> dump the TUI output to stdio.
> 
> User can easily use the command line like:
> 'perf annotate --tui-dump > /tmp/log.txt' 

My first impression is that this pollutes the code with way too many
ifs, I was thinking more of a:

	while (read parsed objdump line) {
		ins__fprintf();
	}

Going from the refresh routine, I started doing the conversion, but haven't
completed it, there are opportunities for more __scnprintf like routines, also
one to find the percent_max, etc then those would be used both in these two for
--stdio2, that eventually would become --stdio with the old one becoming
--stdio1, till we're satisfied with the new default.

static void annotation_line__fprintf(struct annotate_line *al, FILE *fp)
{
	struct browser_line *bl = browser_line(al);
	int i;
	double percent_max = 0.0;
	char bf[256];

	for (i = 0; i < browser->nr_events; i++) {
		if (al->samples[i].percent > percent_max)
			percent_max = al->samples[i].percent;
	}

	/* the following if/else block should be transformed into a __scnprintf routine
	  that formats a buffer and then the TUI and --stdio2 use it */

	if (al->offset != -1 && percent_max != 0.0) {
		for (i = 0; i < ab->nr_events; i++) {
			if (annotate_browser__opts.show_total_period) {
				fprintf(fp, browser, "%11" PRIu64 " ", al->samples[i].he.period);
			} else if (annotate_browser__opts.show_nr_samples) {
				fprintf(fp, browser, "%6" PRIu64 " ", al->samples[i].he.nr_samples);
			} else {
				fprintf(fp, "%6.2f ", al->samples[i].percent);
			}
		}
	} else {
		ui_browser__printf(browser, "%*s", pcnt_width,
				   annotate_browser__opts.show_total_period ? "Period" :
				   annotate_browser__opts.show_nr_samples ? "Samples" : "Percent");
		
	}

	 /* The ab->have_cycles should go to a separate struct, outside
          * annotation_browser, and the rest should go to something that just does scnprintf on a buffer
	  * that then is printed on the TUI or with fprintf */

	if (ab->have_cycles) {
		if (al->ipc)
			fprintf(fp, "%*.2f ", IPC_WIDTH - 1, al->ipc);
		else if (show_title)
			ui_browser__printf(browser, "%*s ", IPC_WIDTH - 1, "IPC");

		if (al->cycles)
			ui_browser__printf(browser, "%*" PRIu64 " ",
					   CYCLES_WIDTH - 1, al->cycles);
		else if (!show_title)
			ui_browser__write_nstring(browser, " ", CYCLES_WIDTH);
		else
			ui_browser__printf(browser, "%*s ", CYCLES_WIDTH - 1, "Cycle");
	}

	SLsmg_write_char(' ');

	/* The scroll bar isn't being used */
	if (!browser->navkeypressed)
		width += 1;

	if (!*al->line)
		fprintf(fp, "\n");
	else if (al->offset == -1) {
		if (al->line_nr && annotate_browser__opts.show_linenr)
			printed = scnprintf(bf, sizeof(bf), "%-*d ",
					ab->addr_width + 1, al->line_nr);
		else
			printed = scnprintf(bf, sizeof(bf), "%*s  ",
				    ab->addr_width, " ");
		fprintf(fp, bf);
		ui_browser__write_nstring(browser, al->line, width - printed - pcnt_width - cycles_width + 1);
	} else {
		u64 addr = al->offset;
		int color = -1;

		if (!annotate_browser__opts.use_offset)
			addr += ab->start;

		if (!annotate_browser__opts.use_offset) {
			printed = scnprintf(bf, sizeof(bf), "%" PRIx64 ": ", addr);
		} else {
			if (bl->jump_sources) {
				if (annotate_browser__opts.show_nr_jumps) {
					int prev;
					printed = scnprintf(bf, sizeof(bf), "%*d ",
							    ab->jumps_width,
							    bl->jump_sources);
					prev = annotate_browser__set_jumps_percent_color(ab, bl->jump_sources,
											 current_entry);
					ui_browser__write_nstring(browser, bf, printed);
					ui_browser__set_color(browser, prev);
				}

				printed = scnprintf(bf, sizeof(bf), "%*" PRIx64 ": ",
						    ab->target_width, addr);
			} else {
				printed = scnprintf(bf, sizeof(bf), "%*s  ",
						    ab->addr_width, " ");
			}
		}

		fprintf(fp, bf);

		disasm_line__write(disasm_line(al), browser, bf, sizeof(bf));

		ui_browser__write_nstring(browser, bf, width - pcnt_width - cycles_width - 3 - printed);
	}
}

unsigned int annotation_lines__fprintf(struct list_head *lines, FILE *fp)
{
        struct list_head *line;
	struct annotation_line *al;

        list_for_each(line, lines) {
		struct annotation_line *al = list_entry(line, struct annotation_line, node);
		annotation_line__fprintf(al, line);
	}

        return row;
}

Then the main code would use the same code that creates the browser->b.entries
and would pass it to annpotation_lines__fprintf().

i.e. we would disentanble the formatting of strings and auxiliary routines to
obtain the max_percent, i.e. nothing of TUI is needed for --stdio2, just the
formatting of strings.

- Arnaldo
  
> For example:
>     $ perf annotate compute_flag --tui-dump
> 
>     Percent  IPC Cycle
> 
>                             Disassembly of section .text:
> 
>                             0000000000400640 <compute_flag>:
>                             compute_flag():
>                             volatile int count;
>                             static unsigned int s_randseed;
> 
>                             __attribute__((noinline))
>                             int compute_flag()
>                             {
>      23.00  1.16              sub    $0x8,%rsp
>                                     int i;
> 
>                                     i = rand() % 2;
>      23.06  1.16     1        callq  rand@plt
> 
>                                     return i;
>      27.01  3.38              mov    %eax,%edx
>                             }
>             3.38              add    $0x8,%rsp
>                             {
>                                     int i;
> 
>                                     i = rand() % 2;
> 
>                                     return i;
>             3.38              shr    $0x1f,%edx
>             3.38              add    %edx,%eax
>             3.38              and    $0x1,%eax
>             3.38              sub    %edx,%eax
>                             }
>      26.93  3.38     2        retq
> 
> The '--stdio' option is still kept now. Maybe in future, we can only
> maintain the TUI routines and drop the lagacy stdio code. But right
> now we'd better keep it until the '--tui-dump' option is good enough.
> 
> Jin Yao (4):
>   perf browser: Add a new 'dump' flag
>   perf browser: bypass ui_init if in tui dump mode
>   perf annotate: Process the new switch flag tui_dump
>   perf annotate: Enable the '--tui-dump' mode
> 
>  tools/perf/Documentation/perf-annotate.txt |  3 +++
>  tools/perf/builtin-annotate.c              | 12 +++++++--
>  tools/perf/builtin-c2c.c                   |  2 +-
>  tools/perf/builtin-report.c                |  2 +-
>  tools/perf/builtin-top.c                   |  2 +-
>  tools/perf/ui/browser.c                    | 38 +++++++++++++++++++++++----
>  tools/perf/ui/browser.h                    |  1 +
>  tools/perf/ui/browsers/annotate.c          | 41 +++++++++++++++++++++---------
>  tools/perf/ui/browsers/hists.c             |  2 +-
>  tools/perf/ui/setup.c                      |  9 +++++--
>  tools/perf/ui/ui.h                         |  2 +-
>  tools/perf/util/annotate.h                 |  6 +++--
>  tools/perf/util/hist.h                     | 11 +++++---
>  13 files changed, 99 insertions(+), 32 deletions(-)
> 
> -- 
> 2.7.4
