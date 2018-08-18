Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6684C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111F32188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111F32188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeHROu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:50:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57105 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:50:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBgwd41288041
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:42:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBgwbj1288038;
        Sat, 18 Aug 2018 04:42:58 -0700
Date:   Sat, 18 Aug 2018 04:42:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-354b064b8ebc1e1ede58550ca9e08bfa81e6af43@git.kernel.org>
Cc:     sandipan@linux.ibm.com, tglx@linutronix.de,
        ravi.bangoria@linux.ibm.com, hpa@zytor.com, jolsa@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, acme@redhat.com, mingo@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, acme@redhat.com,
          aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          naveen.n.rao@linux.vnet.ibm.com, sandipan@linux.ibm.com,
          jolsa@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          ravi.bangoria@linux.ibm.com
In-Reply-To: <20180809161929.35058-1-sandipan@linux.ibm.com>
References: <20180809161929.35058-1-sandipan@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf probe powerpc: Fix trace event
 post-processing
Git-Commit-ID: 354b064b8ebc1e1ede58550ca9e08bfa81e6af43
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  354b064b8ebc1e1ede58550ca9e08bfa81e6af43
Gitweb:     https://git.kernel.org/tip/354b064b8ebc1e1ede58550ca9e08bfa81e6af43
Author:     Sandipan Das <sandipan@linux.ibm.com>
AuthorDate: Thu, 9 Aug 2018 21:49:29 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 9 Aug 2018 14:40:11 -0300

perf probe powerpc: Fix trace event post-processing

In some cases, a symbol may have multiple aliases. Attempting to add an
entry probe for such symbols results in a probe being added at an
incorrect location while it fails altogether for return probes. This is
only applicable for binaries with debug information.

During the arch-dependent post-processing, the offset from the start of
the symbol at which the probe is to be attached is determined and added
to the start address of the symbol to get the probe's location.  In case
there are multiple aliases, this offset gets added multiple times for
each alias of the symbol and we end up with an incorrect probe location.

This can be verified on a powerpc64le system as shown below.

  $ nm /lib/modules/$(uname -r)/build/vmlinux | grep "sys_open$"
  ...
  c000000000414290 T __se_sys_open
  c000000000414290 T sys_open

  $ objdump -d /lib/modules/$(uname -r)/build/vmlinux | grep -A 10 "<__se_sys_open>:"

  c000000000414290 <__se_sys_open>:
  c000000000414290:       19 01 4c 3c     addis   r2,r12,281
  c000000000414294:       70 c4 42 38     addi    r2,r2,-15248
  c000000000414298:       a6 02 08 7c     mflr    r0
  c00000000041429c:       e8 ff a1 fb     std     r29,-24(r1)
  c0000000004142a0:       f0 ff c1 fb     std     r30,-16(r1)
  c0000000004142a4:       f8 ff e1 fb     std     r31,-8(r1)
  c0000000004142a8:       10 00 01 f8     std     r0,16(r1)
  c0000000004142ac:       c1 ff 21 f8     stdu    r1,-64(r1)
  c0000000004142b0:       78 23 9f 7c     mr      r31,r4
  c0000000004142b4:       78 1b 7e 7c     mr      r30,r3

  For both the entry probe and the return probe, the probe location
  should be _text+4276888 (0xc000000000414298). Since another alias
  exists for 'sys_open', the post-processing code will end up adding
  the offset (8 for powerpc64le) twice and perf will attempt to add
  the probe at _text+4276896 (0xc0000000004142a0) instead.

Before:

  # perf probe -v -a sys_open

  probe-definition(0): sys_open
  symbol:sys_open file:(null) line:0 offset:0 return:0 lazy:(null)
  0 arguments
  Looking at the vmlinux_path (8 entries long)
  Using /lib/modules/4.18.0-rc8+/build/vmlinux for symbols
  Open Debuginfo file: /lib/modules/4.18.0-rc8+/build/vmlinux
  Try to find probe point from debuginfo.
  Symbol sys_open address found : c000000000414290
  Matched function: __se_sys_open [2ad03a0]
  Probe point found: __se_sys_open+0
  Found 1 probe_trace_events.
  Opening /sys/kernel/debug/tracing/kprobe_events write=1
  Writing event: p:probe/sys_open _text+4276896
  Added new event:
    probe:sys_open       (on sys_open)
  ...

  # perf probe -v -a sys_open%return $retval

  probe-definition(0): sys_open%return
  symbol:sys_open file:(null) line:0 offset:0 return:1 lazy:(null)
  0 arguments
  Looking at the vmlinux_path (8 entries long)
  Using /lib/modules/4.18.0-rc8+/build/vmlinux for symbols
  Open Debuginfo file: /lib/modules/4.18.0-rc8+/build/vmlinux
  Try to find probe point from debuginfo.
  Symbol sys_open address found : c000000000414290
  Matched function: __se_sys_open [2ad03a0]
  Probe point found: __se_sys_open+0
  Found 1 probe_trace_events.
  Opening /sys/kernel/debug/tracing/README write=0
  Opening /sys/kernel/debug/tracing/kprobe_events write=1
  Parsing probe_events: p:probe/sys_open _text+4276896
  Group:probe Event:sys_open probe:p
  Writing event: r:probe/sys_open__return _text+4276896
  Failed to write event: Invalid argument
    Error: Failed to add events. Reason: Invalid argument (Code: -22)

After:

  # perf probe -v -a sys_open

  probe-definition(0): sys_open
  symbol:sys_open file:(null) line:0 offset:0 return:0 lazy:(null)
  0 arguments
  Looking at the vmlinux_path (8 entries long)
  Using /lib/modules/4.18.0-rc8+/build/vmlinux for symbols
  Open Debuginfo file: /lib/modules/4.18.0-rc8+/build/vmlinux
  Try to find probe point from debuginfo.
  Symbol sys_open address found : c000000000414290
  Matched function: __se_sys_open [2ad03a0]
  Probe point found: __se_sys_open+0
  Found 1 probe_trace_events.
  Opening /sys/kernel/debug/tracing/kprobe_events write=1
  Writing event: p:probe/sys_open _text+4276888
  Added new event:
    probe:sys_open       (on sys_open)
  ...

  # perf probe -v -a sys_open%return $retval

  probe-definition(0): sys_open%return
  symbol:sys_open file:(null) line:0 offset:0 return:1 lazy:(null)
  0 arguments
  Looking at the vmlinux_path (8 entries long)
  Using /lib/modules/4.18.0-rc8+/build/vmlinux for symbols
  Open Debuginfo file: /lib/modules/4.18.0-rc8+/build/vmlinux
  Try to find probe point from debuginfo.
  Symbol sys_open address found : c000000000414290
  Matched function: __se_sys_open [2ad03a0]
  Probe point found: __se_sys_open+0
  Found 1 probe_trace_events.
  Opening /sys/kernel/debug/tracing/README write=0
  Opening /sys/kernel/debug/tracing/kprobe_events write=1
  Parsing probe_events: p:probe/sys_open _text+4276888
  Group:probe Event:sys_open probe:p
  Writing event: r:probe/sys_open__return _text+4276888
  Added new event:
    probe:sys_open__return (on sys_open%return)
  ...

Reported-by: Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Fixes: 99e608b5954c ("perf probe ppc64le: Fix probe location when using DWARF")
Link: http://lkml.kernel.org/r/20180809161929.35058-1-sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 53d83d7e6a09..20e7d74d86cd 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -141,8 +141,10 @@ void arch__post_process_probe_trace_events(struct perf_probe_event *pev,
 	for (i = 0; i < ntevs; i++) {
 		tev = &pev->tevs[i];
 		map__for_each_symbol(map, sym, tmp) {
-			if (map->unmap_ip(map, sym->start) == tev->point.address)
+			if (map->unmap_ip(map, sym->start) == tev->point.address) {
 				arch__fix_tev_from_maps(pev, tev, map, sym);
+				break;
+			}
 		}
 	}
 }
