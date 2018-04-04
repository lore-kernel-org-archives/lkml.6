Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbeDDI2s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:28:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751314AbeDDI2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:28:44 -0400
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, rostedt@goodmis.org
Cc: acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, jolsa@redhat.com,
        kan.liang@intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, fengguang.wu@intel.com, jglisse@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 0/9] trace_uprobe: Support SDT markers having reference count (semaphore)
Date: Wed,  4 Apr 2018 14:01:01 +0530
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18040408-0040-0000-0000-0000042A3EC4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040408-0041-0000-0000-0000262D6F75
Message-Id: <20180404083110.18647-1-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040089
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace Statically Defined Tracepoints[1] are dtrace style markers
inside userspace applications. Applications like PostgreSQL, MySQL,
Pthread, Perl, Python, Java, Ruby, Node.js, libvirt, QEMU, glib etc
have these markers embedded in them. These markers are added by developer
at important places in the code. Each marker source expands to a single
nop instruction in the compiled code but there may be additional
overhead for computing the marker arguments which expands to couple of
instructions. In case the overhead is more, execution of it can be
omitted by runtime if() condition when no one is tracing on the marker:

    if (reference_counter > 0) {
        Execute marker instructions;
    }   

Default value of reference counter is 0. Tracer has to increment the 
reference counter before tracing on a marker and decrement it when
done with the tracing.

Currently, perf tool has limited supports for SDT markers. I.e. it
can not trace markers surrounded by reference counter. Also, it's
not easy to add reference counter logic in userspace tool like perf,
so basic idea for this patchset is to add reference counter logic in
the trace_uprobe infrastructure. Ex,[2]

  # cat tick.c
    ... 
    for (i = 0; i < 100; i++) {
	DTRACE_PROBE1(tick, loop1, i);
        if (TICK_LOOP2_ENABLED()) {
            DTRACE_PROBE1(tick, loop2, i); 
        }
        printf("hi: %d\n", i); 
        sleep(1);
    }   
    ... 

Here tick:loop1 is marker without reference counter where as tick:loop2
is surrounded by reference counter condition.

  # perf buildid-cache --add /tmp/tick
  # perf probe sdt_tick:loop1
  # perf probe sdt_tick:loop2

  # perf stat -e sdt_tick:loop1,sdt_tick:loop2 -- /tmp/tick
  hi: 0
  hi: 1
  hi: 2
  ^C
  Performance counter stats for '/tmp/tick':
             3      sdt_tick:loop1
             0      sdt_tick:loop2
     2.747086086 seconds time elapsed

Perf failed to record data for tick:loop2. Same experiment with this
patch series:

  # ./perf buildid-cache --add /tmp/tick
  # ./perf probe sdt_tick:loop2
  # ./perf stat -e sdt_tick:loop2 /tmp/tick
    hi: 0
    hi: 1
    hi: 2
    ^C  
     Performance counter stats for '/tmp/tick':
                 3      sdt_tick:loop2
       2.561851452 seconds time elapsed


Note:
 - 'reference counter' is called as 'semaphore' in original Dtrace
   (or Systemtap, bcc and even in ELF) documentation and code. But the 
   term 'semaphore' is misleading in this context. This is just a counter
   used to hold number of tracers tracing on a marker. This is not really
   used for any synchronization. So we are referring it as 'reference
   counter' in kernel / perf code.


v2 changes:
 - [PATCH v2 3/9] is new. build_map_info() has a side effect. One has
   to perform mmput() when he is done with the mm. Let free_map_info()
   take care of mmput() so that one does not need to worry about it.
 - [PATCH v2 6/9] sdt_update_ref_ctr(). No need to use memcpy().
   Reference counter can be directly updated using normal assignment.
 - [PATCH v2 6/9] Check valid vma is returned by sdt_find_vma() before
   incrementing / decrementing a reference counter.
 - [PATCH v2 6/9] Introduce utility functions for taking write lock on
   dup_mmap_sem. Use these functions in trace_uprobe to avoide race with
   fork / dup_mmap().
 - [PATCH v2 6/9] Don't check presence of mm in tu->sml at decrement
   time. Purpose of maintaining the list is to ensure increment happen
   only once for each {trace_uprobe,mm} tuple.
 - [PATCH v2 7/9] v1 was not removing mm from tu->sml when process
   exits and tracing is still on. This leads to a problem if same
   address gets used by new mm. Use mmu_notifier to remove such mm
   from the list. This guarantees that all mm which has been added
   to tu->sml will be removed from list either when tracing ends or
   when process goes away.
 - [PATCH v2 7/9] Patch description was misleading. Change it. Add
   more generic python example.
 - [PATCH v2 7/9] Convert sml_rw_sem into mutex sml_lock.
 - [PATCH v2 7/9] Use builtin linked list in sdt_mm_list instead of
   defining it's own pointer chain.
 - Change the order of last two patches.
 - [PATCH v2 9/9] Check availability of ref_ctr_offset support by
   trace_uprobe infrastructure before using it. This ensures newer
   perf tool will still work on older kernels which does not support
   trace_uprobe with reference counter.
 - Other changes as suggested by Masami, Oleg and Steve.

v1 can be found at:
  https://lkml.org/lkml/2018/3/13/432

[1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
[2] https://github.com/iovisor/bcc/issues/327#issuecomment-200576506
[3] https://lkml.org/lkml/2017/12/6/976


Oleg Nesterov (1):
  Uprobe: Move mmput() into free_map_info()

Ravi Bangoria (8):
  Uprobe: Export vaddr <-> offset conversion functions
  mm: Prefix vma_ to vaddr_to_offset() and offset_to_vaddr()
  Uprobe: Rename map_info to uprobe_map_info
  Uprobe: Export uprobe_map_info along with
    uprobe_{build/free}_map_info()
  trace_uprobe: Support SDT markers having reference count (semaphore)
  trace_uprobe/sdt: Fix multiple update of same reference counter
  trace_uprobe/sdt: Document about reference counter
  perf probe: Support SDT markers having reference counter (semaphore)

 Documentation/trace/uprobetracer.txt |  16 ++-
 include/linux/mm.h                   |  12 ++
 include/linux/uprobes.h              |  19 +++
 kernel/events/uprobes.c              |  79 ++++++-----
 kernel/trace/trace.c                 |   2 +-
 kernel/trace/trace_uprobe.c          | 261 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/probe-event.c        |  18 ++-
 tools/perf/util/probe-event.h        |   1 +
 tools/perf/util/probe-file.c         |  34 ++++-
 tools/perf/util/probe-file.h         |   1 +
 tools/perf/util/symbol-elf.c         |  46 ++++--
 tools/perf/util/symbol.h             |   7 +
 12 files changed, 431 insertions(+), 65 deletions(-)

-- 
1.8.3.1
