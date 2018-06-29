Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A07C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BDF25199
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BDF25199
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966980AbeF2QVd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:21:33 -0400
Received: from foss.arm.com ([217.140.101.70]:36778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966945AbeF2QVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:21:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2800418A;
        Fri, 29 Jun 2018 09:21:31 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01CA53F266;
        Fri, 29 Jun 2018 09:21:29 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:21:28 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Hendrik =?ISO-8859-1?Q?Br=FCckner?= 
        <brueckner@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf test shell: make perf inet_pton test more
 portable
Message-Id: <20180629112128.8603fb02a51d9a78a59dcfaf@arm.com>
In-Reply-To: <alpine.DEB.2.20.1806262331000.29977@Enrico>
References: <20180619184952.dac6a3a1e39d3b1d255e7119@arm.com>
        <20180620134622.GM20477@kernel.org>
        <20180620194546.364cc109430ac51c5a288739@arm.com>
        <20180621141915.GS20477@kernel.org>
        <20180621151800.GU20477@kernel.org>
        <alpine.DEB.2.20.1806262331000.29977@Enrico>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018 22:36:36 +0200
Michael Petlan <mpetlan@redhat.com> wrote:

> On Thu, 21 Jun 2018, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jun 21, 2018 at 11:19:15AM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Wed, Jun 20, 2018 at 07:45:46PM -0500, Kim Phillips escreveu:
> >>> On Wed, 20 Jun 2018 10:46:22 -0300
> >>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> [...]
> >
> > Would be good if we had some utility that given a two files, one with
> > regexps, could tell if, line by line, those expressions matched, better,
> > one that is present in all these OSes...
> >
> I have struggled with this too [1], [2]. I use perl, not sure if it is
> all-distro-compliant, probably not, but anyway...

Yeah, not so much on embedded distros.

> To have:
>   - regexps generic enough (e.g. to parse "casual perf-script output line")
>   - regexps adjustable to concrete needs
>   - regexps to be understandable as much as possible
>   ---> I have $RE_SOMETHING, e.g. RE_LINE_REPORT_CONTENT, such as in [2],
>   and some primitives which I make the more concrete regexps from, such
>   as $RE_EVENT_ANY, $RE_PATH, etc. going into e.g.:
>      REGEXP_STAT_LINE="^\s+$RE_NUMBER\s+$RE_EVENT_ANY\s*"
> 
>   - various utilities:
>     - all output lines matched some regexp in the file
>     - all regexps in the file were matched by something in the output
>     - at least one of the patterns found in output
>     - none of the patterns found in the output
>     - ...
>     ---> I had to write these and few more scripts to handle the parsing
>     of perf output, as in [1], however it still is not ideal...

I'm going to resend the clearer-to-read POSIX compliant rewrite of the
script for now.

> P.S. Could anyone try whether my suite would work on the dash (or any other
> "non-fedora" environment)? I haven't had problems with this so far, but
> of course I haven't tried many...

See below for the results of cloning and running 'make' on an x86_64
box running Ubuntu 18.04 with today's acme's perf/urgent branch perf
installed.

Any plans to incorporate any of these tests into mainline perf?

Cheers,

Kim

gcc -g -O0 -o run_all run_all.c
./run_all -v
-- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
## [ PASS ] ## perf_report :: setup SUMMARY
-- [ SKIP ] -- perf_report :: test_basic :: help message :: testcase skipped
-- [ FAIL ] -- perf_report :: test_basic :: basic execution (output regexp parsing)
-- [ FAIL ] -- perf_report :: test_basic :: number of samples (output regexp parsing)
-- [ PASS ] -- perf_report :: test_basic :: header
-- [ FAIL ] -- perf_report :: test_basic :: show CPU utilization (output regexp parsing)
-- [ FAIL ] -- perf_report :: test_basic :: pid (output regexp parsing)
-- [ FAIL ] -- perf_report :: test_basic :: non-existing symbol (output regexp parsing)
-- [ FAIL ] -- perf_report :: test_basic :: symbol filter (output regexp parsing)
## [ FAIL ] ## perf_report :: test_basic SUMMARY :: 6 failures found
## [ PASS ] ## perf_report :: cleanup SUMMARY
-- [ PASS ] -- perf_probe :: setup :: building examples
## [ PASS ] ## perf_probe :: setup SUMMARY
-- [ FAIL ] -- perf_probe :: test_adding_blacklisted :: adding blacklisted function perf_event_nmi_handler (output regexp parsing)
-- [ PASS ] -- perf_probe :: test_adding_blacklisted :: listing blacklisted probe (should NOT be listed)
## [ FAIL ] ## perf_probe :: test_adding_blacklisted SUMMARY :: 1 failures found
-- [ PASS ] -- perf_probe :: test_probe_syntax :: custom named probe :: add
-- [ PASS ] -- perf_probe :: test_probe_syntax :: custom named probe :: list
-- [ FAIL ] -- perf_probe :: test_probe_syntax :: custom named probe :: use (output regexp parsing)
-- [ PASS ] -- perf_probe :: test_probe_syntax :: various syntax forms :: vfs_read@fs/read_write.c
-- [ PASS ] -- perf_probe :: test_probe_syntax :: various syntax forms :: vfs_read:11@fs/read_write.c
-- [ PASS ] -- perf_probe :: test_probe_syntax :: various syntax forms :: vfs_read@fs/read_write.c:11
-- [ PASS ] -- perf_probe :: test_probe_syntax :: various syntax forms :: vfs_read%return
-- [ PASS ] -- perf_probe :: test_probe_syntax :: various syntax forms :: test.c:29
-- [ PASS ] -- perf_probe :: test_probe_syntax :: various syntax forms :: func%return $retval
## [ FAIL ] ## perf_probe :: test_probe_syntax SUMMARY :: 1 failures found
-- [ PASS ] -- perf_probe :: test_sdt :: adding SDT tracepoints as probes
-- [ PASS ] -- perf_probe :: test_sdt :: listing added probes
-- [ PASS ] -- perf_probe :: test_sdt :: using probes :: perf stat (N = 13)
-- [ PASS ] -- perf_probe :: test_sdt :: using probes :: perf stat (N = 128)
-- [ PASS ] -- perf_probe :: test_sdt :: using probes :: perf stat (N = 241)
-- [ PASS ] -- perf_probe :: test_sdt :: using probes :: perf record (N = 37)
-- [ PASS ] -- perf_probe :: test_sdt :: using probes :: perf report (N = 37)
-- [ PASS ] -- perf_probe :: test_sdt :: using probes :: perf script (N = 37)
-- [ PASS ] -- perf_probe :: test_sdt :: using probes :: perf record (N = 97)
-- [ PASS ] -- perf_probe :: test_sdt :: using probes :: perf report (N = 97)
-- [ PASS ] -- perf_probe :: test_sdt :: using probes :: perf script (N = 97)
-- [ PASS ] -- perf_probe :: test_sdt :: using probes :: perf record (N = 237)
-- [ PASS ] -- perf_probe :: test_sdt :: using probes :: perf report (N = 237)
-- [ PASS ] -- perf_probe :: test_sdt :: using probes :: perf script (N = 237)
## [ PASS ] ## perf_probe :: test_sdt SUMMARY
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:10
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:0-10
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:2+10
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func@source.c
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func@source.c:1
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1+1
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1-10
-- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:foo
-- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:1-foo
-- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:1+foo
-- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func;lazy\*pattern
## [ PASS ] ## perf_probe :: test_line_semantics SUMMARY
-- [ PASS ] -- perf_probe :: test_advanced :: function argument probing :: add
-- [ PASS ] -- perf_probe :: test_advanced :: function argument probing :: record
-- [ PASS ] -- perf_probe :: test_advanced :: function argument probing :: script
-- [ PASS ] -- perf_probe :: test_advanced :: function retval probing :: add
-- [ PASS ] -- perf_probe :: test_advanced :: function retval probing :: record
-- [ PASS ] -- perf_probe :: test_advanced :: function retval probing :: script
-- [ PASS ] -- perf_probe :: test_advanced :: function string argument probing :: add
-- [ PASS ] -- perf_probe :: test_advanced :: function string argument probing :: record
-- [ PASS ] -- perf_probe :: test_advanced :: function string argument probing :: script
-- [ PASS ] -- perf_probe :: test_advanced :: function string argument kprobing :: add
-- [ PASS ] -- perf_probe :: test_advanced :: function string argument kprobing :: record
-- [ PASS ] -- perf_probe :: test_advanced :: function string argument kprobing :: script
## [ PASS ] ## perf_probe :: test_advanced SUMMARY
-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe vfs_read :: 
-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe vfs_read :: -a
-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe vfs_read :: --add
-- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf list
-- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: using added probe (output regexp parsing)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: deleting added probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: listing removed probe (should NOT be listed)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: dry run :: adding probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: first probe adding
-- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: second probe adding (without force)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: second probe adding (with force)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: using doubled probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
-- [ PASS ] -- perf_probe :: test_adding_kernel :: wildcard adding support
-- [ PASS ] -- perf_probe :: test_adding_kernel :: out-of-text functions
-- [ PASS ] -- perf_probe :: test_adding_kernel :: non-existing variable
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: function with retval :: add (command exitcode + output regexp parsing)
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: function with retval :: record (command exitcode + output regexp parsing)
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: function argument probing :: script (output regexp parsing)
## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 4 failures found
-- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -a
-- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -d
-- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -L
-- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -V
-- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary argument for -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary argument for -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -d xxx
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -L foo
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -V foo
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -L foo
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -V foo
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -V foo -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -V foo -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -l -F
## [ PASS ] ## perf_probe :: test_invalid_options SUMMARY
-- [ PASS ] -- perf_probe :: test_listing :: kernel functions list ( to kallsyms)
-- [ PASS ] -- perf_probe :: test_listing :: userspace functions list
-- [ PASS ] -- perf_probe :: test_listing :: kernel variables list
-- [ PASS ] -- perf_probe :: test_listing :: userspace variables list
-- [ FAIL ] -- perf_probe :: test_listing :: kernel lines list (command exitcode + output regexp parsing)
-- [ FAIL ] -- perf_probe :: test_listing :: kernel source lines list (command exitcode + output regexp parsing)
-- [ PASS ] -- perf_probe :: test_listing :: userspace lines list
-- [ PASS ] -- perf_probe :: test_listing :: userspace source lines list
## [ FAIL ] ## perf_probe :: test_listing SUMMARY :: 2 failures found
-- [ SKIP ] -- perf_probe :: test_basic :: help message :: testcase skipped
-- [ PASS ] -- perf_probe :: test_basic :: usage message
-- [ PASS ] -- perf_probe :: test_basic :: quiet switch
## [ PASS ] ## perf_probe :: test_basic SUMMARY
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -O0 :: add
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -O0 :: record
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -O0 :: script
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -O1 :: add
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -O1 :: record
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -O1 :: script
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -O2 :: add
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -O2 :: record
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -O2 :: script
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -O3 :: add
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -O3 :: record
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -O3 :: script
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -Ofast :: add
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -Ofast :: record
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -Ofast :: script
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -Og :: add
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -Og :: record
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -Og :: script
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -Os :: add
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -Os :: record
-- [ PASS ] -- perf_probe :: test_optimization_levels :: function argument with -Os :: script
## [ PASS ] ## perf_probe :: test_optimization_levels SUMMARY
-- [ PASS ] -- perf_probe :: test_exact_counts :: adding userspace probes
-- [ PASS ] -- perf_probe :: test_exact_counts :: listing added probes
-- [ PASS ] -- perf_probe :: test_exact_counts :: using probes :: perf stat
-- [ PASS ] -- perf_probe :: test_exact_counts :: using probes :: perf record
-- [ PASS ] -- perf_probe :: test_exact_counts :: using probes :: perf report
## [ PASS ] ## perf_probe :: test_exact_counts SUMMARY
## [ PASS ] ## perf_probe :: cleanup SUMMARY
## [ PASS ] ## perf_list :: setup SUMMARY
## [ SKIP ] ## perf_list :: test_powerpc_hv_24x7 :: testcase skipped
-- [ SKIP ] -- perf_list :: test_basic :: help message :: testcase skipped
-- [ FAIL ] -- perf_list :: test_basic :: basic execution (output regexp parsing)
-- [ PASS ] -- perf_list :: test_basic :: list kmem:\*
-- [ PASS ] -- perf_list :: test_basic :: list cache
-- [ PASS ] -- perf_list :: test_basic :: list xfs:\*
-- [ PASS ] -- perf_list :: test_basic :: list syscalls:\*
-- [ PASS ] -- perf_list :: test_basic :: list hw
-- [ PASS ] -- perf_list :: test_basic :: list tracepoint
-- [ PASS ] -- perf_list :: test_basic :: list pmu
-- [ PASS ] -- perf_list :: test_basic :: list sw
-- [ PASS ] -- perf_list :: test_basic :: non-sense argument
## [ FAIL ] ## perf_list :: test_basic SUMMARY :: 1 failures found
## [ PASS ] ## perf_list :: cleanup SUMMARY
-- [ PASS ] -- perf_archive :: setup :: prepare the perf.data file
## [ PASS ] ## perf_archive :: setup SUMMARY
-- [ SKIP ] -- perf_archive :: test_basic :: help message :: testcase skipped
-- [ FAIL ] -- perf_archive :: test_basic :: report (output regexp parsing)
-- [ FAIL ] -- perf_archive :: test_basic :: script (output regexp parsing)
-- [ PASS ] -- perf_archive :: test_basic :: archive creation
-- [ FAIL ] -- perf_archive :: test_basic :: archive sanity (contents) (output regexp parsing)
## [ FAIL ] ## perf_archive :: test_basic SUMMARY :: 3 failures found
## [ PASS ] ## perf_archive :: cleanup SUMMARY
-- [ PASS ] -- perf_diff :: setup :: building the example code
-- [ PASS ] -- perf_diff :: setup :: record data #1
-- [ PASS ] -- perf_diff :: setup :: record data #2
## [ PASS ] ## perf_diff :: setup SUMMARY
-- [ SKIP ] -- perf_diff :: test_basic :: help message :: testcase skipped
-- [ PASS ] -- perf_diff :: test_basic :: basic execution - diff
## [ PASS ] ## perf_diff :: test_basic SUMMARY
## [ PASS ] ## perf_diff :: cleanup SUMMARY
-- [ PASS ] -- perf_mem :: setup :: building the example code
## [ PASS ] ## perf_mem :: setup SUMMARY
-- [ SKIP ] -- perf_mem :: test_basic :: help message :: testcase skipped
-- [ PASS ] -- perf_mem :: test_basic :: loads record
-- [ PASS ] -- perf_mem :: test_basic :: loads event check
-- [ PASS ] -- perf_mem :: test_basic :: loads report
-- [ PASS ] -- perf_mem :: test_basic :: stores record
-- [ PASS ] -- perf_mem :: test_basic :: stores event check
-- [ PASS ] -- perf_mem :: test_basic :: stores report
-- [ PASS ] -- perf_mem :: test_basic :: loads&stores record
-- [ PASS ] -- perf_mem :: test_basic :: loads&stores event check
-- [ PASS ] -- perf_mem :: test_basic :: loads&stores report
## [ PASS ] ## perf_mem :: test_basic SUMMARY
## [ PASS ] ## perf_mem :: cleanup SUMMARY
-- [ PASS ] -- perf_annotate :: setup :: building the example code
-- [ PASS ] -- perf_annotate :: setup :: record data
## [ PASS ] ## perf_annotate :: setup SUMMARY
-- [ SKIP ] -- perf_annotate :: test_basic :: help message :: testcase skipped
-- [ PASS ] -- perf_annotate :: test_basic :: basic execution - annotate
-- [ PASS ] -- perf_annotate :: test_basic :: dso filter
-- [ PASS ] -- perf_annotate :: test_basic :: no-source
-- [ PASS ] -- perf_annotate :: test_basic :: full-paths
-- [ FAIL ] -- perf_annotate :: test_basic :: print-line (output regexp parsing)
-- [ PASS ] -- perf_annotate :: test_basic :: redirected input
-- [ PASS ] -- perf_annotate :: test_basic :: execution without data
## [ FAIL ] ## perf_annotate :: test_basic SUMMARY :: 1 failures found
## [ PASS ] ## perf_annotate :: cleanup SUMMARY
-- [ PASS ] -- perf_stat :: test_intel_uncore :: event uncore_cbox_0/clockticks/
-- [ SKIP ] -- perf_stat :: test_intel_uncore :: event uncore_cbox_1/clockticks/ :: testcase skipped
-- [ SKIP ] -- perf_stat :: test_intel_uncore :: event uncore_cbox_2/clockticks/ :: testcase skipped
-- [ SKIP ] -- perf_stat :: test_intel_uncore :: event uncore_cbox_3/clockticks/ :: testcase skipped
-- [ PASS ] -- perf_stat :: test_intel_uncore :: event uncore_imc/data_reads/
-- [ PASS ] -- perf_stat :: test_intel_uncore :: event uncore_imc/data_writes/
## [ PASS ] ## perf_stat :: test_intel_uncore SUMMARY
-- [ PASS ] -- perf_stat :: test_sw :: event alignment-faults
-- [ PASS ] -- perf_stat :: test_sw :: event bpf-output
-- [ PASS ] -- perf_stat :: test_sw :: event context-switches
-- [ PASS ] -- perf_stat :: test_sw :: event cpu-clock
-- [ PASS ] -- perf_stat :: test_sw :: event cpu-migrations
-- [ PASS ] -- perf_stat :: test_sw :: event dummy
-- [ PASS ] -- perf_stat :: test_sw :: event emulation-faults
-- [ PASS ] -- perf_stat :: test_sw :: event major-faults
-- [ PASS ] -- perf_stat :: test_sw :: event minor-faults
-- [ PASS ] -- perf_stat :: test_sw :: event page-faults
-- [ PASS ] -- perf_stat :: test_sw :: event task-clock
-- [ PASS ] -- perf_stat :: test_sw :: k+u=ku check :: event alignment-faults
-- [ PASS ] -- perf_stat :: test_sw :: k+u=ku check :: event bpf-output
-- [ PASS ] -- perf_stat :: test_sw :: k+u=ku check :: event context-switches
-- [ PASS ] -- perf_stat :: test_sw :: k+u=ku check :: event cpu-migrations
-- [ PASS ] -- perf_stat :: test_sw :: k+u=ku check :: event dummy
-- [ PASS ] -- perf_stat :: test_sw :: k+u=ku check :: event emulation-faults
-- [ PASS ] -- perf_stat :: test_sw :: k+u=ku check :: event major-faults
-- [ PASS ] -- perf_stat :: test_sw :: k+u=ku check :: event minor-faults
-- [ PASS ] -- perf_stat :: test_sw :: k+u=ku check :: event page-faults
## [ PASS ] ## perf_stat :: test_sw SUMMARY
## [ SKIP ] ## perf_stat :: test_tracepoints_definition :: testcase skipped
-- [ PASS ] -- perf_stat :: test_hw_breakpoints :: kspace address execution mem:0xffffffff94074e70:x
-- [ PASS ] -- perf_stat :: test_hw_breakpoints :: kspace address readwrite mem:0xffffffff952fc248:rw
## [ PASS ] ## perf_stat :: test_hw_breakpoints SUMMARY
-- [ PASS ] -- perf_stat :: test_hwcache :: event L1-dcache-load-misses
-- [ PASS ] -- perf_stat :: test_hwcache :: event L1-dcache-loads
-- [ PASS ] -- perf_stat :: test_hwcache :: event L1-dcache-stores
-- [ PASS ] -- perf_stat :: test_hwcache :: event L1-icache-load-misses
-- [ PASS ] -- perf_stat :: test_hwcache :: event LLC-load-misses
-- [ PASS ] -- perf_stat :: test_hwcache :: event LLC-loads
-- [ PASS ] -- perf_stat :: test_hwcache :: event LLC-store-misses
-- [ PASS ] -- perf_stat :: test_hwcache :: event LLC-stores
-- [ PASS ] -- perf_stat :: test_hwcache :: event branch-load-misses
-- [ PASS ] -- perf_stat :: test_hwcache :: event branch-loads
-- [ PASS ] -- perf_stat :: test_hwcache :: event dTLB-load-misses
-- [ PASS ] -- perf_stat :: test_hwcache :: event dTLB-loads
-- [ PASS ] -- perf_stat :: test_hwcache :: event dTLB-store-misses
-- [ PASS ] -- perf_stat :: test_hwcache :: event dTLB-stores
-- [ PASS ] -- perf_stat :: test_hwcache :: event iTLB-load-misses
-- [ PASS ] -- perf_stat :: test_hwcache :: event iTLB-loads
-- [ PASS ] -- perf_stat :: test_hwcache :: event node-load-misses
-- [ PASS ] -- perf_stat :: test_hwcache :: event node-loads
-- [ PASS ] -- perf_stat :: test_hwcache :: event node-store-misses
-- [ PASS ] -- perf_stat :: test_hwcache :: event node-stores
## [ PASS ] ## perf_stat :: test_hwcache SUMMARY
-- [ PASS ] -- perf_stat :: test_record_report :: record
-- [ PASS ] -- perf_stat :: test_record_report :: report
-- [ FAIL ] -- perf_stat :: test_record_report :: diff (output regexp parsing)
## [ FAIL ] ## perf_stat :: test_record_report SUMMARY :: 1 failures found
## [ SKIP ] ## perf_stat :: test_powerpc_hv_24x7 :: testcase skipped
-- [ PASS ] -- perf_stat :: test_hw :: event branch-instructions
-- [ PASS ] -- perf_stat :: test_hw :: event branch-misses
-- [ PASS ] -- perf_stat :: test_hw :: event bus-cycles
-- [ PASS ] -- perf_stat :: test_hw :: event cache-misses
-- [ PASS ] -- perf_stat :: test_hw :: event cache-references
-- [ PASS ] -- perf_stat :: test_hw :: event cpu-cycles
-- [ PASS ] -- perf_stat :: test_hw :: event instructions
-- [ PASS ] -- perf_stat :: test_hw :: event ref-cycles
-- [ PASS ] -- perf_stat :: test_hw :: k+u=ku check :: event branch-instructions
-- [ PASS ] -- perf_stat :: test_hw :: k+u=ku check :: event branch-misses
-- [ PASS ] -- perf_stat :: test_hw :: k+u=ku check :: event bus-cycles
-- [ PASS ] -- perf_stat :: test_hw :: k+u=ku check :: event cache-misses
-- [ PASS ] -- perf_stat :: test_hw :: k+u=ku check :: event cache-references
-- [ PASS ] -- perf_stat :: test_hw :: k+u=ku check :: event cpu-cycles
-- [ PASS ] -- perf_stat :: test_hw :: k+u=ku check :: event instructions
## [ PASS ] ## perf_stat :: test_hw SUMMARY
-- [ PASS ] -- perf_stat :: test_intel_rapl :: event power/energy-cores/
-- [ PASS ] -- perf_stat :: test_intel_rapl :: event power/energy-gpu/
-- [ PASS ] -- perf_stat :: test_intel_rapl :: event power/energy-pkg/
-- [ PASS ] -- perf_stat :: test_intel_rapl :: event power/energy-psys/
-- [ PASS ] -- perf_stat :: test_intel_rapl :: event power/energy-ram/
## [ PASS ] ## perf_stat :: test_intel_rapl SUMMARY
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event branch-instructions full
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event branch-instructions half
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event branch-instructions values OK
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event cpu-cycles full
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event cpu-cycles half
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event cpu-cycles values OK
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event instructions full
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event instructions half
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event instructions values OK
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event cpu-clock full
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event cpu-clock half
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event cpu-clock values OK
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event branch-instructions full
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event branch-instructions half
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event branch-instructions values OK
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event cpu-cycles full
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event cpu-cycles half
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event cpu-cycles values OK
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event instructions full
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event instructions half
-- [ PASS ] -- perf_stat :: test_advanced_options :: delay event instructions values OK
## [ PASS ] ## perf_stat :: test_advanced_options SUMMARY
-- [ SKIP ] -- perf_stat :: test_basic :: help message :: testcase skipped
-- [ PASS ] -- perf_stat :: test_basic :: basic execution
-- [ FAIL ] -- perf_stat :: test_basic :: some options (output regexp parsing)
-- [ PASS ] -- perf_stat :: test_basic :: CSV output
## [ FAIL ] ## perf_stat :: test_basic SUMMARY :: 1 failures found
## [ PASS ] ## perf_stat :: cleanup SUMMARY
-- [ PASS ] -- perf_trace :: setup :: building the example code
## [ PASS ] ## perf_trace :: setup SUMMARY
-- [ PASS ] -- perf_trace :: test_record :: basic execution - record
## [ PASS ] ## perf_trace :: test_record SUMMARY
-- [ FAIL ] -- perf_trace :: test_overhead :: systemwide (output regexp parsing)
## [ FAIL ] ## perf_trace :: test_overhead SUMMARY :: 1 failures found
-- [ SKIP ] -- perf_trace :: test_basic :: help message :: testcase skipped
-- [ PASS ] -- perf_trace :: test_basic :: basic execution
-- [ PASS ] -- perf_trace :: test_basic :: duration threshold
-- [ PASS ] -- perf_trace :: test_basic :: systemwide
-- [ PASS ] -- perf_trace :: test_basic :: full timestamp
-- [ PASS ] -- perf_trace :: test_basic :: summary
-- [ PASS ] -- perf_trace :: test_basic :: attach process
## [ PASS ] ## perf_trace :: test_basic SUMMARY
## [ PASS ] ## perf_trace :: cleanup SUMMARY
-- [ PASS ] -- perf_c2c :: setup :: building the example code
## [ PASS ] ## perf_c2c :: setup SUMMARY
-- [ SKIP ] -- perf_c2c :: test_basic :: help message :: testcase skipped
-- [ PASS ] -- perf_c2c :: test_basic :: ldlat-loads record
-- [ PASS ] -- perf_c2c :: test_basic :: ldlat-loads event check
-- [ PASS ] -- perf_c2c :: test_basic :: ldlat-loads report
-- [ PASS ] -- perf_c2c :: test_basic :: ldlat-stores record
-- [ PASS ] -- perf_c2c :: test_basic :: ldlat-stores event check
-- [ PASS ] -- perf_c2c :: test_basic :: ldlat-stores report
-- [ PASS ] -- perf_c2c :: test_basic :: ldlat-loads&ldlat-stores record
-- [ PASS ] -- perf_c2c :: test_basic :: ldlat-loads&ldlat-stores event check
-- [ PASS ] -- perf_c2c :: test_basic :: ldlat-loads&ldlat-stores report
-- [ PASS ] -- perf_c2c :: test_basic :: ldlat-loads&ldlat-stores verification
## [ PASS ] ## perf_c2c :: test_basic SUMMARY
## [ PASS ] ## perf_c2c :: cleanup SUMMARY
-- [ PASS ] -- perf_record :: setup :: building the example code
## [ PASS ] ## perf_record :: setup SUMMARY
## [ SKIP ] ## perf_record :: test_overhead :: testcase skipped
-- [ SKIP ] -- perf_record :: test_evlist :: help message :: testcase skipped
-- [ PASS ] -- perf_record :: test_evlist :: sample frequency check :: record with 100
-- [ PASS ] -- perf_record :: test_evlist :: sample frequency check :: evlist 100
-- [ PASS ] -- perf_record :: test_evlist :: sample frequency check :: record with 200
-- [ PASS ] -- perf_record :: test_evlist :: sample frequency check :: evlist 200
-- [ PASS ] -- perf_record :: test_evlist :: sample frequency check :: record with 1000
-- [ PASS ] -- perf_record :: test_evlist :: sample frequency check :: evlist 1000
-- [ PASS ] -- perf_record :: test_evlist :: various events :: record branch-instructions
-- [ PASS ] -- perf_record :: test_evlist :: various events :: evlist branch-instructions
-- [ PASS ] -- perf_record :: test_evlist :: various events :: record branch-misses
-- [ PASS ] -- perf_record :: test_evlist :: various events :: evlist branch-misses
-- [ PASS ] -- perf_record :: test_evlist :: various events :: record bus-cycles
-- [ PASS ] -- perf_record :: test_evlist :: various events :: evlist bus-cycles
-- [ PASS ] -- perf_record :: test_evlist :: various events :: record cache-misses
-- [ PASS ] -- perf_record :: test_evlist :: various events :: evlist cache-misses
-- [ PASS ] -- perf_record :: test_evlist :: various events :: record cache-references
-- [ PASS ] -- perf_record :: test_evlist :: various events :: evlist cache-references
-- [ PASS ] -- perf_record :: test_evlist :: various events :: record cpu-cycles
-- [ PASS ] -- perf_record :: test_evlist :: various events :: evlist cpu-cycles
-- [ PASS ] -- perf_record :: test_evlist :: various events :: record instructions
-- [ PASS ] -- perf_record :: test_evlist :: various events :: evlist instructions
-- [ PASS ] -- perf_record :: test_evlist :: various events :: record ref-cycles
-- [ PASS ] -- perf_record :: test_evlist :: various events :: evlist ref-cycles
## [ PASS ] ## perf_record :: test_evlist SUMMARY
-- [ PASS ] -- perf_record :: test_intr_regs :: list
-- [ PASS ] -- perf_record :: test_intr_regs :: basic sampling (AX) :: record
-- [ PASS ] -- perf_record :: test_intr_regs :: basic sampling (AX) :: report
-- [ PASS ] -- perf_record :: test_intr_regs :: basic sampling (AX) :: report values count
-- [ PASS ] -- perf_record :: test_intr_regs :: using all registers :: record
-- [ PASS ] -- perf_record :: test_intr_regs :: using all registers :: report values count
## [ PASS ] ## perf_record :: test_intr_regs SUMMARY
-- [ SKIP ] -- perf_record :: test_basic :: help message :: testcase skipped
-- [ PASS ] -- perf_record :: test_basic :: basic record
-- [ PASS ] -- perf_record :: test_basic :: hwcache + tracepoint :: record
-- [ PASS ] -- perf_record :: test_basic :: hwcache + tracepoint :: evlist
## [ PASS ] ## perf_record :: test_basic SUMMARY
## [ PASS ] ## perf_record :: cleanup SUMMARY
-- [ PASS ] -- perf_buildid :: setup :: creating perf.data and buildid-cache
## [ PASS ] ## perf_buildid :: setup SUMMARY
-- [ SKIP ] -- perf_buildid :: test_buildid-list :: help message :: testcase skipped
-- [ PASS ] -- perf_buildid :: test_buildid-list :: buildids check
-- [ PASS ] -- perf_buildid :: test_buildid-list :: kernel buildid
## [ PASS ] ## perf_buildid :: test_buildid-list SUMMARY
## [ PASS ] ## perf_buildid :: cleanup SUMMARY
======== base_report ========

======== base_probe ========

======== base_list ========

======== base_archive ========

======== base_diff ========

======== base_mem ========

======== base_annotate ========

======== base_stat ========

======== base_trace ========

======== base_c2c ========

======== base_record ========

======== base_buildid ========

Makefile:25: recipe for target 'check' failed
make: *** [check] Error 1
