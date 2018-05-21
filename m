Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeEUIxk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 04:53:40 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:43887 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeEUIxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 04:53:36 -0400
X-Google-Smtp-Source: AB8JxZqVtx+881z9OW6NHzx+OaGznngtTrTyO1/VMaPFTpyawUY1FA655sdg5HtGj9cJ7clpHerYLw==
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tor Jeremiassen <tor@ti.com>,
        mike.leach@linaro.org, kim.phillips@arm.com,
        Robert Walker <Robert.Walker@arm.com>, coresight@lists.linaro.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [RFT v2 0/4] Perf script: Add python script for CoreSight trace disassembler
Date: Mon, 21 May 2018 16:52:24 +0800
Message-Id: <1526892748-326-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to support for using 'perf script' for CoreSight
trace disassembler, for this purpose this patch series adds a new
python script to parse CoreSight tracing event and use command 'objdump'
for disassembled lines, finally this can generate readable program
execution flow for reviewing tracing data.

Patch 0001 is one fixing patch to generate samples for the start packet
and exception packets.

Patch 0002 is the prerequisite to add addr into sample dict, so this
value can be used by python script to analyze instruction range.

Patch 0003 is to add python script for trace disassembler.

Patch 0004 is to add doc to explain python script usage and give
example for it.

This patch series has been rebased on acme git tree [1] with the last
commit 19422a9f2a3b ("perf tools: Fix kernel_start for PTI on x86") and
tested on Hikey (ARM64 octa CA53 cores).

In this version the script has no dependency on ARM64 platform and is
expected to support ARM32 platform, but I am lacking ARM32 platform for
testing on it, so firstly upstream to support ARM64 platform.

This patch series is firstly to support 'per-thread' recording tracing
data, but we also need to verify the script can dump trace disassembler
CPU wide tracing and kernel panic kdump tracing data.  I also verified
this patch series which can work with kernel panic kdump tracing data,
because Mathieu is working on CPU wide tracing related work, so after
this we need to retest for CPU wide tracing and kdump tracing to ensure
the python script can handle well for all cases.

You are very welcome to test the script in this patch series, your
testing result and suggestion are very valuable to perfect this script
to cover more cases.

Changes from v1:
* According to Mike and Rob suggestion, add the fixing to generate samples
  for the start packet and exception packets.
* Simplify the python script to remove the exception prediction algorithm,
  we can rely on the sane exception packets for disassembler.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git


Leo Yan (4):
  perf cs-etm: Generate sample for missed packets
  perf script python: Add addr into perf sample dict
  perf script python: Add script for CoreSight trace disassembler
  coresight: Document for CoreSight trace disassembler

 Documentation/trace/coresight.txt                  |  52 +++++
 tools/perf/scripts/python/arm-cs-trace-disasm.py   | 234 +++++++++++++++++++++
 tools/perf/util/cs-etm.c                           |  35 ++-
 .../util/scripting-engines/trace-event-python.c    |   2 +
 4 files changed, 316 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/scripts/python/arm-cs-trace-disasm.py

-- 
2.7.4
