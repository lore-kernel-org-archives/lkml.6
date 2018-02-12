Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932760AbeBLWVx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:21:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:64295 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932713AbeBLWVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:21:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,504,1511856000";
   d="scan'208";a="29490595"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 0/5] bugs fix for auto-reload mmap read and rdpmc read
Date: Mon, 12 Feb 2018 14:20:30 -0800
Message-Id: <1518474035-21006-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

------

Changes since V3:
 - Apply Peter's patch to fix event update for auto-reload event
 - Based on Peter's patch, specially handle case A.
 - Introduce specific read function for auto-reload event, not just
   large PEBS.

Changes since V2:
 - Refined the changelog
 - Introduced specific read function for large PEBS.
   The previous generic PEBS read function is confusing.
   Disabled PMU in pmu::read() path for large PEBS.
   Handled the corner case when reload_times == 0.
 - Modified the parameter of intel_pmu_save_and_restart_reload()
   Discarded local64_cmpxchg
 - Added fixes tag
 - Added WARN to handle reload_times == 0 || reload_val == 0

Changes since V1:
 - Check PERF_X86_EVENT_AUTO_RELOAD before call
   intel_pmu_save_and_restore()
 - Introduce a special purpose intel_pmu_save_and_restart()
   just for AUTO_RELOAD.
 - New patch to disable userspace RDPMC usage if large PEBS is enabled.

------

There is a bug when mmap read event->count with large PEBS enabled.
Here is an example.
 #./read_count
 0x71f0
 0x122c0
 0x1000000001c54
 0x100000001257d
 0x200000000bdc5

The bug is caused by two issues.
- In x86_perf_event_update, the calculation of event->count does not
  take the auto-reload values into account.
- In x86_pmu_read, it doesn't count the undrained values in large PEBS
  buffers.

The first issue was introduced with the auto-reload mechanism enabled
since commit 851559e35fd5 ("perf/x86/intel: Use the PEBS auto reload
mechanism when possible")

Patch 1 fixed the issue in x86_perf_event_update.

The second issue was introduced since commit b8241d20699e
("perf/x86/intel: Implement batched PEBS interrupt handling (large PEBS
interrupt threshold)")

Patch 2-4 fixed the issue in x86_pmu_read.

Besides the two issues, the userspace RDPMC usage is broken for large
PEBS as well.
The RDPMC issue was also introduced since commit b8241d20699e
("perf/x86/intel: Implement batched PEBS interrupt handling (large PEBS
interrupt threshold)")

Patch 5 fixed the RDPMC issue.

The source code of read_count is as below.

struct cpu {
        int fd;
        struct perf_event_mmap_page *buf;
};

int perf_open(struct cpu *ctx, int cpu)
{
        struct perf_event_attr attr = {
                .type = PERF_TYPE_HARDWARE,
                .size = sizeof(struct perf_event_attr),
                .sample_period = 100000,
                .config = 0,
                .sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_TID |
                                PERF_SAMPLE_TIME | PERF_SAMPLE_CPU,
                .precise_ip = 3,
                .mmap = 1,
                .comm = 1,
                .task = 1,
                .mmap2 = 1,
                .sample_id_all = 1,
                .comm_exec = 1,
        };
        ctx->buf = NULL;
        ctx->fd = syscall(__NR_perf_event_open, &attr, -1, cpu, -1, 0);
        if (ctx->fd < 0) {
                perror("perf_event_open");
                return -1;
        }
        return 0;
}

void perf_close(struct cpu *ctx)
{
        close(ctx->fd);
        if (ctx->buf)
                munmap(ctx->buf, pagesize);
}

int main(int ac, char **av)
{
        struct cpu ctx;
        u64 count;

        perf_open(&ctx, 0);

        while (1) {
                sleep(5);

                if (read(ctx.fd, &count, 8) != 8) {
                        perror("counter read");
                        break;
                }
                printf("0x%llx\n", count);

        }
        perf_close(&ctx);
}


Kan Liang (5):
  perf/x86/intel: Fix event update for auto-reload
  perf/x86: Introduce read function for x86_pmu
  perf/x86/intel/ds: Introduce read function for auto-reload event
  perf/x86/intel: Fix pmu read for auto-reload
  perf/x86: Fix: disable userspace RDPMC usage for large PEBS

 arch/x86/events/core.c       | 20 ++++-----
 arch/x86/events/intel/core.c |  9 +++++
 arch/x86/events/intel/ds.c   | 96 ++++++++++++++++++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h |  3 ++
 4 files changed, 115 insertions(+), 13 deletions(-)

-- 
2.7.4
