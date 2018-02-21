Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937109AbeBUOAN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933118AbeBUOAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:00:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4F320C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 21 Feb 2018 11:00:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] perf, tools, stat: Reset ids counter when retrying
 events
Message-ID: <20180221140002.GB24416@kernel.org>
References: <20171006020029.13339-1-andi@firstfloor.org>
 <20171006020029.13339-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006020029.13339-2-andi@firstfloor.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 05, 2017 at 07:00:29PM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> perf stat can retry opening events. After opening an file descriptor
> it adds the ids to the ecsel. Each event keeps a running
> count of ids.

Ok, and that is done in perf_evlist__id_add() where we also add things
to the evlist->heads hashtable, shouldn't we remove all these before
retrying? I.e. perf_evlist__close() shouldn't be resetting that
hashtable?

I.e. like in the following patch? Jiri? Namhyung?

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7b7d535396f7..e8942456106e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -37,13 +37,18 @@
 #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
 #define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
 
-void perf_evlist__init(struct perf_evlist *evlist, struct cpu_map *cpus,
-		       struct thread_map *threads)
+static void perf_evlist__init_heads(struct perf_evlist *evlist)
 {
 	int i;
 
 	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
 		INIT_HLIST_HEAD(&evlist->heads[i]);
+}
+
+void perf_evlist__init(struct perf_evlist *evlist, struct cpu_map *cpus,
+		       struct thread_map *threads)
+{
+	perf_evlist__init_heads(evlist);
 	INIT_LIST_HEAD(&evlist->entries);
 	perf_evlist__set_maps(evlist, cpus, threads);
 	fdarray__init(&evlist->pollfd, 64);
@@ -1381,8 +1386,11 @@ void perf_evlist__close(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
-	evlist__for_each_entry_reverse(evlist, evsel)
+	evlist__for_each_entry_reverse(evlist, evsel) {
 		perf_evsel__close(evsel);
+	}
+
+	perf_evlist__init_heads(evlist);
 }
 
 static int perf_evlist__create_syswide_maps(struct perf_evlist *evlist)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ef351688b797..fba708bc9d98 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1932,6 +1932,7 @@ void perf_evsel__close(struct perf_evsel *evsel)
 
 	perf_evsel__close_fd(evsel);
 	perf_evsel__free_fd(evsel);
+	evsel->ids = 0;
 }
 
 int perf_evsel__open_per_cpu(struct perf_evsel *evsel,

> When we decide to close an evsel and retry
> with a different configuration this count needs to be reset,
> otherwise it can overflow the buffer.
> 
> Always reset the ids count.
> 
> This fixes the following problem, triggered by a complex perf
> stat configuration.
> 
> ==666== ERROR: AddressSanitizer: heap-buffer-overflow on address 0x600600001500 at pc 0x59dfd7 bp 0x7ffc6b397000 sp 0x7ffc6b396ff8
> WRITE of size 8 at 0x600600001500 thread T0
>     #0 0x59dfd6 in perf_evlist__id_add /home/ak/hle/linux-hle-2.6/tools/perf/util/evlist.c:515
>     #1 0x59e291 in perf_evlist__id_add_fd /home/ak/hle/linux-hle-2.6/tools/perf/util/evlist.c:555
>     #2 0x4865c6 in __store_counter_ids /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:570
>     #3 0x4867d0 in store_counter_ids /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:587
>     #4 0x487521 in __run_perf_stat /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:703
>     #5 0x487d6d in run_perf_stat /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:805
>     #6 0x492914 in cmd_stat /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:2839
>     #7 0x57479a in run_builtin /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:296
>     #8 0x574b5f in handle_internal_command /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:348
>     #9 0x574e3c in run_argv /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:392
>     #10 0x575401 in main /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:536
>     #11 0x7f7597af96e4 in __libc_start_main (/lib64/libc.so.6+0x206e4)
>     #12 0x444598 in _start /home/abuild/rpmbuild/BUILD/glibc-2.22/csu/../sysdeps/x86_64/start.S:118
> 0x600600001500 is located 0 bytes to the right of 32-byte region [0x6006000014e0,0x600600001500)
> allocated by thread T0 here:
>     #0 0x7f759a698ab5 in calloc (/usr/lib64/libasan.so.0+0x15ab5)
>     #1 0x5a6045 in zalloc /home/ak/hle/linux-hle-2.6/tools/perf/util/util.h:22
>     #2 0x5ab51a in perf_evsel__alloc_id /home/ak/hle/linux-hle-2.6/tools/perf/util/evsel.c:1158
>     #3 0x4867ae in store_counter_ids /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:584
>     #4 0x487521 in __run_perf_stat /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:703
>     #5 0x487d6d in run_perf_stat /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:805
>     #6 0x492914 in cmd_stat /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:2839
>     #7 0x57479a in run_builtin /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:296
>     #8 0x574b5f in handle_internal_command /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:348
>     #9 0x574e3c in run_argv /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:392
>     #10 0x575401 in main /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:536
>     #11 0x7f7597af96e4 in __libc_start_main (/lib64/libc.so.6+0x206e4)
> SUMMARY: AddressSanitizer: heap-buffer-overflow /home/ak/hle/linux-hle-2.6/tools/perf/util/evlist.c:515 perf_evlist__id_add
> Shadow bytes around the buggy address:
>   0x0c013fff8250: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c013fff8260: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c013fff8270: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c013fff8280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c013fff8290: fa fa fa fa fa fa fa fa fa fa fa fa 00 00 00 00
> =>0x0c013fff82a0:[fa]fa 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00
>   0x0c013fff82b0: 00 00 fa fa 00 00 00 00 fa fa 00 00 00 00 fa fa
>   0x0c013fff82c0: 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00 00 00
>   0x0c013fff82d0: fa fa 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00
>   0x0c013fff82e0: 00 00 fa fa 00 00 00 00 fa fa 00 00 00 00 fa fa
>   0x0c013fff82f0: 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00 00 00
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:     fa
>   Heap righ redzone:     fb
>   Freed Heap region:     fd
>   Stack left redzone:    f1
>   Stack mid redzone:     f2
>   Stack right redzone:   f3
>   Stack partial redzone: f4
>   Stack after return:    f5
>   Stack use after scope: f8
>   Global redzone:        f9
>   Global init order:     f6
>   Poisoned by user:      f7
>   ASan internal:         fe
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3c697118e44b..b54ec8497f97 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -652,6 +652,7 @@ static int __run_perf_stat(int argc, const char **argv)
>  
>  	evlist__for_each_entry(evsel_list, counter) {
>  try_again:
> +		counter->ids = 0;
>  		if (create_perf_stat_counter(counter) < 0) {
>  
>  			/* Weak group failed. Reset the group. */
> -- 
> 2.13.6
