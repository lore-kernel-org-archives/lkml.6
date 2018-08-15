Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED85AC04AB9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E720A214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9KGwhxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E720A214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbeHOR7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbeHOR7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:59:36 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60EAF214AB;
        Wed, 15 Aug 2018 15:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534345622;
        bh=aeydPS9VWIyr7BqEPHk07/OIotxkO2VWU+ODgdo2UYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9KGwhxL0qqFW7VJpD5JZG46jZlnf0aCgg1Rh96M2FCMfDCJNlKdch2dOKs1uWRJq
         PsrwOM1c49sLpImWgajaNKV09D736NjjMjEKPjicFo8xHhJvjVIw/aemPNvxJuCdWs
         xFG+/gVC8l7Fx0W0M7Uz6Jhm87022n2De6m1iBJw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/35] perf probe powerpc: Fix trace event post-processing
Date:   Wed, 15 Aug 2018 12:05:37 -0300
Message-Id: <20180815150611.32080-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

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
-- 
2.14.4

