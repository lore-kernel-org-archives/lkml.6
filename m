Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD9AC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F207206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F207206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeJXMAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:00:21 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:34437 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725896AbeJXMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:00:21 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9O3YOcU099551;
        Wed, 24 Oct 2018 11:34:24 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 24 Oct 2018
 11:32:56 +0800
From:   Nickhu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <deanbo422@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <ebiederm@xmission.com>,
        <pombredanne@nexb.com>, <tglx@linutronix.de>,
        <kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
        <john.garry@huawei.com>, <devicetree@vger.kernel.org>,
        <zong@andestech.com>, <alankao@andestech.com>
CC:     Nickhu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH v3 0/4] nds32: Perf Support
Date:   Wed, 24 Oct 2018 11:32:36 +0800
Message-ID: <cover.1540350887.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9O3YOcU099551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sorry everyone, I forgot to add the version number
of the patch set I just sent.

These four commits are perf supporting for nds32.
There are three perfomance counters in nds32, and
each of them can counts different events. You can
use 'perf list' to show the available events that
can be used.

Changes in V2:
	1. Change the definition 'PFM_CTL_xxx' to
array form.

	2. Simplify the PMU driver.

	3. Stop all counters when handling irq
caused by performance counters overflow.

	4. Rename the compatible string in
devicetree.
	
Changes in V3:
	Fix the typo in Documentation/devicetree/
bindings/nds32/pmu.txt.

Nickhu (4):
  nds32: Fix bug in bitfield.h
  nds32: Perf porting
  nds32: Add perf call-graph support.
  nds32: Add document for NDS32 PMU.

 .../devicetree/bindings/nds32/pmu.txt         |   17 +
 arch/nds32/Kconfig                            |    1 +
 arch/nds32/boot/dts/ae3xx.dts                 |    5 +
 arch/nds32/include/asm/Kbuild                 |    1 +
 arch/nds32/include/asm/bitfield.h             |    4 +-
 arch/nds32/include/asm/perf_event.h           |   16 +
 arch/nds32/include/asm/pmu.h                  |  386 +++++
 arch/nds32/include/asm/stacktrace.h           |   39 +
 arch/nds32/kernel/Makefile                    |    3 +-
 arch/nds32/kernel/perf_event_cpu.c            | 1522 +++++++++++++++++
 arch/nds32/mm/fault.c                         |   13 +-
 tools/include/asm/barrier.h                   |    2 +
 tools/perf/arch/nds32/Build                   |    1 +
 tools/perf/arch/nds32/util/Build              |    1 +
 tools/perf/arch/nds32/util/header.c           |   29 +
 tools/perf/pmu-events/arch/nds32/mapfile.csv  |   15 +
 .../pmu-events/arch/nds32/n13/atcpmu.json     |  290 ++++
 17 files changed, 2337 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nds32/pmu.txt
 create mode 100644 arch/nds32/include/asm/perf_event.h
 create mode 100644 arch/nds32/include/asm/pmu.h
 create mode 100644 arch/nds32/include/asm/stacktrace.h
 create mode 100644 arch/nds32/kernel/perf_event_cpu.c
 create mode 100644 tools/perf/arch/nds32/Build
 create mode 100644 tools/perf/arch/nds32/util/Build
 create mode 100644 tools/perf/arch/nds32/util/header.c
 create mode 100644 tools/perf/pmu-events/arch/nds32/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/nds32/n13/atcpmu.json

-- 
2.17.0

