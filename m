Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeA3JQp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:16:45 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:38318 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeA3JQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:16:40 -0500
X-Google-Smtp-Source: AH8x227mGFyDfxItYP4CtGTIjcAXtPOR5Xu8TZmPof/ZDIRdcjIlYlV1qll/snLruaEql/vlJ/5XVUFqJl2OR6yUvuM=
MIME-Version: 1.0
In-Reply-To: <1517243373-355481-1-git-send-email-kan.liang@linux.intel.com>
References: <1517243373-355481-1-git-send-email-kan.liang@linux.intel.com>
From: Stephane Eranian <eranian@google.com>
Date: Tue, 30 Jan 2018 01:16:39 -0800
Message-ID: <CABPqkBRjQp62ArVZzuH=TRU3mDPkS93D8_cNev6M=eXTCpBLkA@mail.gmail.com>
Subject: Re: [PATCH V3 0/5] bugs fix for large PEBS mmap read and rdpmc read
To: kan.liang@linux.intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 29, 2018 at 8:29 AM, <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> ------
>
> Changes since V2:
>  - Refined the changelog
>  - Introduced specific read function for large PEBS.
>    The previous generic PEBS read function is confusing.
>    Disabled PMU in pmu::read() path for large PEBS.
>    Handled the corner case when reload_times == 0.
>  - Modified the parameter of intel_pmu_save_and_restart_reload()
>    Discarded local64_cmpxchg
>  - Added fixes tag
>  - Added WARN to handle reload_times == 0 || reload_val == 0
>
> Changes since V1:
>  - Check PERF_X86_EVENT_AUTO_RELOAD before call
>    intel_pmu_save_and_restore()

It is not yet clear to me why PERF_SAMPLE_PERIOD is not allowed
with large PEBS. Large PEBS requires fixed period. So the kernel could
make up the period from the event and store it in the sampling buffer.

I tried using large PEBS recently, and despite trying different option
combination of perf record, I was not able to get it to work.

$ perf record  -c 1  -e cpu/event=0xd1,umask=0x10,period=19936/pp
--no-timestamp --no-period -a -C 0

But I was able to make this work with a much older kernel.

Another annoyance I ran into is with perf record requiring -c period
in order not to set
PERF_SAMPLE_PERIOD in the event.

If I do:
perf record  -c 1  -e cpu/event=0xd1,umask=0x10,period=19936/pp
--no-timestamp --no-period -a -C 0

I get

perf_event_attr:
  type                             4
  size                             112
  config                           0x10d1
  { sample_period, sample_freq }   199936
  sample_type                      IP|TID|CPU

But if I do:
perf record  -e cpu/event=0xd1,umask=0x10,period=19936/pp
--no-timestamp --no-period -a -C 0

I get

perf_event_attr:
  type                             4
  size                             112
  config                           0x10d1
  { sample_period, sample_freq }   199936
  sample_type                      IP|TID|CPU|PERIOD

Perf should check if all events have a period=, then it should not
pass PERF_SAMPLE_PERIOD, even
more so when only one event is defined.

Also it does not seem to honor --no-period.

All of this makes it hard to use large PEBS in general.

So I think your series should also address this part.

>  - Introduce a special purpose intel_pmu_save_and_restart()
>    just for AUTO_RELOAD.
>  - New patch to disable userspace RDPMC usage if large PEBS is enabled.
>
> ------
>
> There is a bug when mmap read event->count with large PEBS enabled.
> Here is an example.
>  #./read_count
>  0x71f0
>  0x122c0
>  0x1000000001c54
>  0x100000001257d
>  0x200000000bdc5
>
> The bug is caused by two issues.
> - In x86_perf_event_update, the calculation of event->count does not
>   take the auto-reload values into account.
> - In x86_pmu_read, it doesn't count the undrained values in large PEBS
>   buffers.
>
> The first issue was introduced with the auto-reload mechanism enabled
> since commit 851559e35fd5 ("perf/x86/intel: Use the PEBS auto reload
> mechanism when possible")
>
> Patch 1 fixed the issue in x86_perf_event_update.
>
> The second issue was introduced since commit b8241d20699e
> ("perf/x86/intel: Implement batched PEBS interrupt handling (large PEBS
> interrupt threshold)")
>
> Patch 2-4 fixed the issue in x86_pmu_read.
>
> Besides the two issues, the userspace RDPMC usage is broken for large
> PEBS as well.
> The RDPMC issue was also introduced since commit b8241d20699e
> ("perf/x86/intel: Implement batched PEBS interrupt handling (large PEBS
> interrupt threshold)")
>
> Patch 5 fixed the RDPMC issue.
>
> The source code of read_count is as below.
>
> struct cpu {
>         int fd;
>         struct perf_event_mmap_page *buf;
> };
>
> int perf_open(struct cpu *ctx, int cpu)
> {
>         struct perf_event_attr attr = {
>                 .type = PERF_TYPE_HARDWARE,
>                 .size = sizeof(struct perf_event_attr),
>                 .sample_period = 100000,
>                 .config = 0,
>                 .sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_TID |
>                                 PERF_SAMPLE_TIME | PERF_SAMPLE_CPU,
>                 .precise_ip = 3,
>                 .mmap = 1,
>                 .comm = 1,
>                 .task = 1,
>                 .mmap2 = 1,
>                 .sample_id_all = 1,
>                 .comm_exec = 1,
>         };
>         ctx->buf = NULL;
>         ctx->fd = syscall(__NR_perf_event_open, &attr, -1, cpu, -1, 0);
>         if (ctx->fd < 0) {
>                 perror("perf_event_open");
>                 return -1;
>         }
>         return 0;
> }
>
> void perf_close(struct cpu *ctx)
> {
>         close(ctx->fd);
>         if (ctx->buf)
>                 munmap(ctx->buf, pagesize);
> }
>
> int main(int ac, char **av)
> {
>         struct cpu ctx;
>         u64 count;
>
>         perf_open(&ctx, 0);
>
>         while (1) {
>                 sleep(5);
>
>                 if (read(ctx.fd, &count, 8) != 8) {
>                         perror("counter read");
>                         break;
>                 }
>                 printf("0x%llx\n", count);
>
>         }
>         perf_close(&ctx);
> }
>
> Kan Liang (5):
>   perf/x86/intel: fix event update for auto-reload
>   perf/x86: introduce read function for x86_pmu
>   perf/x86/intel/ds: introduce read function for large pebs
>   perf/x86/intel: introduce read function for intel_pmu
>   perf/x86: fix: disable userspace RDPMC usage for large PEBS
>
>  arch/x86/events/core.c       |  5 ++-
>  arch/x86/events/intel/core.c |  9 +++++
>  arch/x86/events/intel/ds.c   | 85 ++++++++++++++++++++++++++++++++++++++++++--
>  arch/x86/events/perf_event.h |  3 ++
>  4 files changed, 99 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>
