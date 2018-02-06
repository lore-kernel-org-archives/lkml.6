Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeBFRAY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:00:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51562 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753088AbeBFQ4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:56:02 -0500
From: John Garry <john.garry@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>, <wcohen@redhat.com>,
        <will.deacon@arm.com>, <ganapatrao.kulkarni@cavium.com>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linux-arm-kernel@lists.infradead.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 0/9] perf events patches for improved ARM64 support
Date: Wed, 7 Feb 2018 01:44:55 +0800
Message-ID: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
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
- support for parsing standard architecture pmu events

On the back of these, the Cavium ThunderX2, ARM Cortex-A53,
and HiSilicon hip08 JSONs are relocated/added/updated.

In addition, there are a patch to drop mutli-mapfile.csv support.

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

John Garry (9):
  perf vendor events: drop incomplete multiple mapfile support
  perf utils: add support for pmu events vendor sub-directory
  perf vendor events arm64: Relocate ThunderX2 JSON
  perf vendor events arm64: Relocate Cortex A53 JSONs
  perf utils: add support for arch standard events
  perf utils: add armv8-recommended.json
  perf utils: fixup Cavium ThunderX2 JSON to use ARMv8 recommended
    events
  perf utils: fixup ARM Cortex A53 JSONs to use ARMv8 recommended events
  perf utils: add HiSilicon hip08 JSON file

 tools/perf/pmu-events/Build                        |   1 +
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
 tools/perf/pmu-events/jevents.c                    | 265 +++++++++++-
 20 files changed, 1050 insertions(+), 271 deletions(-)
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
