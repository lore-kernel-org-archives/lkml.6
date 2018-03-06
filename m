Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbeCFORL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:17:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeCFORJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:17:09 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E54320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 6 Mar 2018 11:17:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: changbin.du@intel.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf sched map: re-annotate shortname if thread
 comm changed
Message-ID: <20180306141707.GG10176@kernel.org>
References: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
 <20180306075302.GA19895@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306075302.GA19895@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 06, 2018 at 08:53:02AM +0100, Jiri Olsa escreveu:
> On Tue, Mar 06, 2018 at 11:37:35AM +0800, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > v2:
> >   o add a patch to move thread::shortname to thread_runtime
> >   o add function perf_sched__process_comm() to process PERF_RECORD_COMM event.
> > 
> > Changbin Du (2):
> >   perf sched: move thread::shortname to thread_runtime
> >   perf sched map: re-annotate shortname if thread comm changed
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied both, the final layout for 'struct thread_runtime':

[root@jouet perf]# pahole -C thread_runtime ~/bin/perf
struct thread_runtime {
	u64                        last_time;            /*     0     8 */
	u64                        dt_run;               /*     8     8 */
	u64                        dt_sleep;             /*    16     8 */
	u64                        dt_iowait;            /*    24     8 */
	u64                        dt_preempt;           /*    32     8 */
	u64                        dt_delay;             /*    40     8 */
	u64                        ready_to_run;         /*    48     8 */
	struct stats               run_stats;            /*    56    40 */
	/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
	u64                        total_run_time;       /*    96     8 */
	u64                        total_sleep_time;     /*   104     8 */
	u64                        total_iowait_time;    /*   112     8 */
	u64                        total_preempt_time;   /*   120     8 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	u64                        total_delay_time;     /*   128     8 */
	int                        last_state;           /*   136     4 */
	char                       shortname[3];         /*   140     3 */
	_Bool                      comm_changed;         /*   143     1 */
	u64                        migrations;           /*   144     8 */

	/* size: 152, cachelines: 3, members: 17 */
	/* last cacheline: 24 bytes */
};
[root@jouet perf]#
