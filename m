Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeERHEq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:04:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752119AbeERHEp (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:04:45 -0400
Date: Fri, 18 May 2018 09:04:41 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v2 2/3] perf report: Use perf_evlist_forced_leader to
 support '--group'
Message-ID: <20180518070441.GB30793@krava>
References: <1526648260-30540-1-git-send-email-yao.jin@linux.intel.com>
 <1526648260-30540-3-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526648260-30540-3-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 08:57:39PM +0800, Jin Yao wrote:
> Since we have created a new function perf_evlist_forced_leader,
> so now remove the old code and use perf_evlist_forced_leader
> instead.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-report.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 4c931af..63fe776 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -202,12 +202,8 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,

there's comment in this place, which no longer applies in here:


/*
 * Events in data file are not collect in groups, but we still want
 * the group display. Set the artificial group and set the leader's
 * forced_leader flag to notify the display code.
 */

could you please move/change/apply it to perf_evlist_forced_leader

thanks,
jirka

>  static void setup_forced_leader(struct report *report,
>  				struct perf_evlist *evlist)

>  {
> -	if (report->group_set && !evlist->nr_groups) {
> -		struct perf_evsel *leader = perf_evlist__first(evlist);
> -
> -		perf_evlist__set_leader(evlist);
> -		leader->forced_leader = true;
> -	}
> +	if (report->group_set)
> +		perf_evlist_forced_leader(evlist);
>  }
>  
>  static int process_feature_event(struct perf_tool *tool,
> -- 
> 2.7.4
> 
