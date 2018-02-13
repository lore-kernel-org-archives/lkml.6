Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934710AbeBMJp6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:45:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933860AbeBMJpz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:45:55 -0500
Date: Tue, 13 Feb 2018 10:45:51 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH] perf report: Fix a memory corrupton issue when enabling
 --branch-history
Message-ID: <20180213094551.GA26936@krava>
References: <1518511468-32737-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518511468-32737-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 04:44:28PM +0800, Jin Yao wrote:
> Following command lines will cause perf crash.
> 
> perf record -j call -g -a <application>
> perf report --branch-history
> 
> *** Error in `perf': double free or corruption (!prev): 0x00000000104aa040 ***
> ======= Backtrace: =========
> /lib/x86_64-linux-gnu/libc.so.6(+0x77725)[0x7f6b37254725]
> /lib/x86_64-linux-gnu/libc.so.6(+0x7ff4a)[0x7f6b3725cf4a]
> /lib/x86_64-linux-gnu/libc.so.6(cfree+0x4c)[0x7f6b37260abc]
> perf[0x51b914]
> perf(hist_entry_iter__add+0x1e5)[0x51f305]
> perf[0x43cf01]
> perf[0x4fa3bf]
> perf[0x4fa923]
> perf[0x4fd396]
> perf[0x4f9614]
> perf(perf_session__process_events+0x89e)[0x4fc38e]
> perf(cmd_report+0x15d2)[0x43f202]
> perf[0x4a059f]
> perf(main+0x631)[0x427b71]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf0)[0x7f6b371fd830]
> perf(_start+0x29)[0x427d89]
> 
> The memory corruption happens at:
> 
> iter_add_next_cumulative_entry()
> {
>         ...
>         for (i = 0; i < iter->curr; i++) {
>         ...
> }
> 
> Whatever in iter_next_cumulative_entry() or in iter_add_next_cumulative_entry(),
> they all don't check if iter->curr exceeds the array 'he_cache[]'.
> 
> If there are too many nodes in callchain, it's possible that iter->curr >
> iter->max_stack, then memory corruption occurs.
> 
> This patch will reallocate array 'he_cache[]' in iter_next_cumulative_entry()
> if necessary (the case of too many nodes in callchain).

right, the max_stack does not say how many nodes end up in
callchain_cursor at the end.. good catch, please mention
that also in the changelog

however we know the final count from callchain_cursor itself,
the attached patch might do the same job, right?

also could we now get rid of iter->max_stack?

thanks,
jirka


---
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index b6140950301e..b50b7b70dcca 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -879,7 +879,7 @@ iter_prepare_cumulative_entry(struct hist_entry_iter *iter,
 	 * cumulated only one time to prevent entries more than 100%
 	 * overhead.
 	 */
-	he_cache = malloc(sizeof(*he_cache) * (iter->max_stack + 1));
+	he_cache = malloc(sizeof(*he_cache) * (callchain_cursor.nr + 1));
 	if (he_cache == NULL)
 		return -ENOMEM;
 
