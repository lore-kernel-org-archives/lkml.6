Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF2FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525B320831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525B320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJYK5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:57:11 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:43141 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726344AbeJYK5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:57:11 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9P2Q13m070247;
        Thu, 25 Oct 2018 10:26:01 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 25 Oct 2018
 10:24:35 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <ebiederm@xmission.com>,
        <gregkh@linuxfoundation.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <pombredanne@nexb.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <zong@andestech.com>,
        <alankao@andestech.com>, <deanbo422@gmail.com>
CC:     Nick Hu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH v4 0/4] nds32: Perf support
Date:   Thu, 25 Oct 2018 10:24:13 +0800
Message-ID: <cover.1540430861.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9P2Q13m070247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Changes in V4:
	Move 'Documentation/devicetree/bindings/nds32/pmu.txt'
to 'Documentation/devicetree/bindings/perf/nds32v3-pmu.txt'.

Nickhu (4):
  nds32: Fix bug in bitfield.h
  nds32: Perf porting
  nds32: Add perf call-graph support.
  nds32: Add document for NDS32 PMU.

 .../devicetree/bindings/perf/nds32v3-pmu.txt  |   17 +
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
 create mode 100644 Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
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

