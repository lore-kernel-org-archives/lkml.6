Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeBWPQ3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:16:29 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39855 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751784AbeBWPO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:14:27 -0500
From: John Garry <john.garry@huawei.com>
To: <jolsa@redhat.com>, <ak@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>
CC: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhangshaokun@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 00/11] perf events patches for improved ARM64 support
Date: Sat, 24 Feb 2018 00:05:21 +0800
Message-ID: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for some perf events features,
targeted at ARM64, implemented in a generic fashion.

The two main features are as follows:
- support for arch/vendor/platform pmu events directory structure
   - to support this, topic subdirectory support needs to be dropped
- support for parsing standard architecture pmu events

On the back of these, the Cavium ThunderX2, ARM Cortex-A53,
and HiSilicon hip08 JSONs are relocated/added/updated.

In addition, there is a patch to drop mutli-mapfile.csv support and
also a bugfix in jevents.c for an error code value.

Differences to v1:
- Address coding issues from Jiri Olsa in adding arch std event
   support (https://lkml.org/lkml/2018/2/6/501)
- add patch to drop topic subdirectory support
- add patch for bug fix in json_events() 
- add review tags from Jiri Olsa

Differences to RFC:
- reworked patch for arch standard events
	- added arch standard event keyword support
	- use some macros to make the code more condense
	- use <linux/list_head.h>
- standardised some function names
- updated README
- for patch to support vendor subdir, add check for
  unknown dirent type
 -add patch to drop mutliple mapfile.csv support
 - dealt with new cortex a53 JSONs


John Garry (11):
  perf vendor events: drop incomplete multiple mapfile support
  perf vendor events: fix error code in json_events()
  perf vendor events: drop support for unused topic directories
  perf vendor events: add support for pmu events vendor subdirectory
  perf vendor events arm64: Relocate ThunderX2 JSON to cavium
    subdirectory
  perf vendor events arm64: Relocate Cortex A53 JSONs to arm
    subdirectory
  perf vendor events: add support for arch standard events
  perf vendor events arm64: add armv8-recommended.json
  perf vendor events arm64: fixup ThunderX2 to use recommended events
  perf vendor events arm64: fixup A53 to use recommended events
  perf vendor events arm64: add HiSilicon hip08 JSON file

 tools/perf/pmu-events/Build                        |   2 +
 tools/perf/pmu-events/README                       |  15 +-
 .../arch/arm64/arm/cortex-a53/branch.json          |  26 ++
 .../pmu-events/arch/arm64/arm/cortex-a53/bus.json  |  10 +
 .../arch/arm64/arm/cortex-a53/cache.json           |  27 ++
 .../arch/arm64/arm/cortex-a53/memory.json          |  12 +
 .../arch/arm64/arm/cortex-a53/other.json           |  30 ++
 .../arch/arm64/arm/cortex-a53/pipeline.json        |  52 +++
 .../pmu-events/arch/arm64/armv8-recommended.json   | 452 +++++++++++++++++++++
 .../arch/arm64/cavium/thunderx2-imp-def.json       |  62 ---
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  |  42 ++
 .../pmu-events/arch/arm64/cortex-a53/branch.json   |  27 --
 .../perf/pmu-events/arch/arm64/cortex-a53/bus.json |  22 -
 .../pmu-events/arch/arm64/cortex-a53/cache.json    |  27 --
 .../pmu-events/arch/arm64/cortex-a53/memory.json   |  22 -
 .../pmu-events/arch/arm64/cortex-a53/other.json    |  32 --
 .../pmu-events/arch/arm64/cortex-a53/pipeline.json |  52 ---
 .../arch/arm64/hisilicon/hip08/core-imp-def.json   | 140 +++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   5 +-
 tools/perf/pmu-events/jevents.c                    | 286 ++++++++++---
 20 files changed, 1045 insertions(+), 298 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/armv8-recommended.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json

-- 
1.9.1
