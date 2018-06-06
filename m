Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA96B6084F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932519AbeFFIeD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:34:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932398AbeFFIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:34:02 -0400
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 0/7] Uprobes: Support SDT markers having reference count (semaphore)
Date: Wed,  6 Jun 2018 14:03:37 +0530
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18060608-4275-0000-0000-0000028AA924
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060608-4276-0000-0000-00003791B121
Message-Id: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060098
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why RFC again:

This series is different from earlier versions[1]. Earlier series
implemented this feature in trace_uprobe while this has implemented
the logic in core uprobe. Few reasons for this:
 1. One of the major reason was the deadlock between uprobe_lock and
 mm->mmap inside trace_uprobe_mmap(). That deadlock was not easy to fix
 because mm->mmap is not in control of trace_uprobe_mmap() and it has
 to take uprobe_lock to loop over trace_uprobe list. More details can
 be found at[2]. With this new approach, there are no deadlocks found
 so far.
 2. Many of the core uprobe function and data-structures needs to be
 exported to make earlier implementation simple. With this new approach,
 reference counter logic is been implemented in core uprobe and thus
 no need to export anything.

Description:

Userspace Statically Defined Tracepoints[3] are dtrace style markers
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
the trace_uprobe infrastructure. Ex,[4]

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
 - This patches still has one issue. If there are multiple instances of
   same application running and user wants to trace any particular
   instance, trace_uprobe is updating reference counter in all instances.
   This is not a problem on user side because instruction is not replaced
   with trap/int3 and thus user will only see samples from his interested
   process. But still this is more of a correctness issue. I'm working on
   a fix for this.

[1] https://lkml.org/lkml/2018/4/17/23
[2] https://lkml.org/lkml/2018/5/25/111
[3] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
[4] https://github.com/iovisor/bcc/issues/327#issuecomment-200576506

Ravi Bangoria (7):
  Uprobes: Simplify uprobe_register() body
  Uprobes: Support SDT markers having reference count (semaphore)
  Uprobes/sdt: Fix multiple update of same reference counter
  trace_uprobe/sdt: Prevent multiple reference counter for same uprobe
  Uprobes/sdt: Prevent multiple reference counter for same uprobe
  Uprobes/sdt: Document about reference counter
  perf probe: Support SDT markers having reference counter (semaphore)

 Documentation/trace/uprobetracer.rst |  16 +-
 include/linux/uprobes.h              |   5 +
 kernel/events/uprobes.c              | 502 +++++++++++++++++++++++++++++++----
 kernel/trace/trace.c                 |   2 +-
 kernel/trace/trace_uprobe.c          |  74 +++++-
 tools/perf/util/probe-event.c        |  39 ++-
 tools/perf/util/probe-event.h        |   1 +
 tools/perf/util/probe-file.c         |  34 ++-
 tools/perf/util/probe-file.h         |   1 +
 tools/perf/util/symbol-elf.c         |  46 +++-
 tools/perf/util/symbol.h             |   7 +
 11 files changed, 643 insertions(+), 84 deletions(-)

-- 
1.8.3.1
