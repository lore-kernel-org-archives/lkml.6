Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeBVFLr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:11:47 -0500
Received: from tama50.ecl.ntt.co.jp ([129.60.39.147]:45718 "EHLO
        tama50.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeBVFLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:11:46 -0500
From: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Subject: uprobes/perf: KASAN: use-after-free in uprobe_perf_close
Message-ID: <4da123ee-1ad1-fbd3-d5c0-bd9f5ed26434@lab.ntt.co.jp>
Date: Thu, 22 Feb 2018 14:08:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CC-Mail-RelayStamp: 1
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I encountered following BUG caught by KASAN with recent kernels when 
trying out [BCC project] bcc/testing/python/test_usdt2.py
Tried with v4.12, it was reproducible.

--- KASAN log ---
BUG: KASAN: use-after-free in uprobe_perf_close+0x118/0x1a0
Read of size 4 at addr ffff8800bb2db4cc by task test_usdt2.py/1265

CPU: 2 PID: 1265 Comm: test_usdt2.py Not tainted 
4.16.0-rc2-next-20180220+ #38
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
1.10.2-1.fc26 04/01/2014
Call Trace:
  dump_stack+0x5c/0x80
  print_address_description+0x73/0x290
  kasan_report+0x257/0x380
  ? uprobe_perf_close+0x118/0x1a0
  uprobe_perf_close+0x118/0x1a0
  perf_uprobe_destroy+0x54/0x90
  _free_event+0x1a5/0x5c0
  perf_event_release_kernel+0x35e/0x620
  ? put_event+0x20/0x20
  perf_release+0x1c/0x20
  __fput+0x182/0x360
  task_work_run+0x9c/0xc0
  exit_to_usermode_loop+0xc2/0xd0
  do_syscall_64+0x244/0x250
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[...]
Allocated by task 1265:
  kasan_kmalloc+0xa0/0xd0
  kmem_cache_alloc_node+0x123/0x210
  copy_process.part.32+0xb9d/0x3050
  _do_fork+0x178/0x630
  do_syscall_64+0xe7/0x250
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Freed by task 1265:
  __kasan_slab_free+0x135/0x180
  kmem_cache_free+0xaf/0x230
  rcu_process_callbacks+0x559/0xd90
  __do_softirq+0x125/0x3a2

The buggy address belongs to the object at ffff8800bb2db480
  which belongs to the cache task_struct of size 12928
-----------------


After debugging, found that uprobe_perf_close() is called after task has 
been terminated and uprobe_perf_close() tries to access task_struct of 
the terminated process.

As fix I came up with following changes. Basically it gets a refcount on 
task_struct in uprobe_perf_open() and releases in uprobe_perf_close(). 
If this is a correct fix, I will submit a proper patch.


Signed-off-by: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
---
  kernel/trace/trace_uprobe.c | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2014f4351ae0..b81e0a88136a 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1039,6 +1039,7 @@ uprobe_filter_event(struct trace_uprobe *tu, 
struct perf_event *event)

  static int uprobe_perf_close(struct trace_uprobe *tu, struct 
perf_event *event)
  {
+    int err = 0;
      bool done;

      write_lock(&tu->filter.rwlock);
@@ -1054,9 +1055,12 @@ static int uprobe_perf_close(struct trace_uprobe 
*tu, struct perf_event *event)
      write_unlock(&tu->filter.rwlock);

      if (!done)
-        return uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
+        err =  uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);

-    return 0;
+    if (event->hw.target)
+        put_task_struct(event->hw.target);
+
+    return err;
  }

  static int uprobe_perf_open(struct trace_uprobe *tu, struct perf_event 
*event)
@@ -1077,6 +1081,7 @@ static int uprobe_perf_open(struct trace_uprobe 
*tu, struct perf_event *event)
          done = tu->filter.nr_systemwide ||
              event->parent || event->attr.enable_on_exec ||
              uprobe_filter_event(tu, event);
+        get_task_struct(event->hw.target);
          list_add(&event->hw.tp_list, &tu->filter.perf_events);
      } else {
          done = tu->filter.nr_systemwide;
-- 
2.14.3


-Prashant
