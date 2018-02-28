Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeB1Hvt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:51:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751646AbeB1Hvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:51:47 -0500
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        oleg@redhat.com
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC 0/4] trace_uprobe: Support SDT markers having semaphore
Date: Wed, 28 Feb 2018 13:23:41 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18022807-0012-0000-0000-000005B64D57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022807-0013-0000-0000-000019325B28
Message-Id: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280094
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace Statically Defined Tracepoints[1] are dtrace style markers
inside userspace applications. These markers are added by developer at
important places in the code. Each marker source expands to a single
nop instruction in the compiled code but there may be additional
overhead for computing the marker arguments which expands to couple of
instructions. If this computaion is quite more, execution of it can be
ommited by runtime if() condition when no one is tracing on the marker:

    if (semaphore > 0) {
        Execute marker instructions;
    }

Default value of semaphore is 0. Tracer has to increment the semaphore
before recording on a marker and decrement it at the end of tracing.

Currently, perf tool has limited supports for SDT markers. I.e. it
can not trace markers surrounded by semaphore. Also, it's not easy
to add semaphore flip logic in userspace tool like perf, so basic
idea for this patchset is to add semaphore flip logic in the
trace_uprobe infrastructure. Ex,[2]

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

Here tick:loop1 is marker without semaphore where as tick:loop2 is
surrounded by semaphore.


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


  # readelf -n ./tick
  Provider: tick
  Name: loop2
  ... Semaphore: 0x0000000010020036

  # readelf -SW ./tick | grep probes
  [25] .probes           PROGBITS        0000000010020034 010034


Semaphore offset is 0x10036. I don't have educated 'perf probe'
about semaphore. So instead of using 'perf probe' command, I'm
manually adding entry in the <tracefs>/uprobe_events file.
Special char * denotes semaphore offset.


  # echo "p:sdt_tick/loop2 /tmp/tick:0x6e4 *0x10036" > uprobe_events

  # perf stat -e sdt_tick:loop2 -- /tmp/tick
  hi: 0
  hi: 1
  hi: 2
  hi: 3
  ^C
  Performance counter stats for '/tmp/tick':
              4      sdt_tick:loop2                                              
     3.359047827 seconds time elapsed


Feedback?

TODO:
 - Educate perf tool about semaphore.
 - perf_event_open() now suppoers {k,u}probe event creation[3]. If we
   can supply semaphore offset in perf_event_attr, perf_event_open()
   can be educated to probe SDT marker having semaphore. Though, both
   config1 and config2 are already being used for uprobe and I don't
   see any other attribute which I can use for semaphore offset. Can
   we introduce one more config there? config3?

[1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
[2] https://github.com/iovisor/bcc/issues/327#issuecomment-200576506
[3] https://lkml.org/lkml/2017/12/6/976


Ravi Bangoria (4):
  Uprobe: Rename map_info to uprobe_map_info
  Uprobe: Export few functions / data structures
  trace_uprobe: Support SDT markers having semaphore
  trace_uprobe: Fix multiple update of same semaphores

 include/linux/uprobes.h     |  25 +++++
 kernel/events/uprobes.c     |  43 ++++----
 kernel/trace/trace_uprobe.c | 244 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+), 22 deletions(-)

-- 
1.8.3.1
