Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF7FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238DD20684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238DD20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbeGQRpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:45:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbeGQRpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:45:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C28507A9;
        Tue, 17 Jul 2018 10:12:07 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6AA223F5A0;
        Tue, 17 Jul 2018 10:12:06 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robert.walker@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 00/10] coresight: perf: Support for tmc-etr backed buffers
Date:   Tue, 17 Jul 2018 18:11:31 +0100
Message-Id: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the support for using the tmc-etr in perf mode for
storing the trace to system RAM. The ETR uses a separate buffer (double
buffering) for storing the trace. This is copied back to the ring buffer
when the event is stopped. We try to match the ETR buffer to the larger
of perf ring buffer or the size configured for the ETR via sysfs. This
allows tuning the buffer size to prevent overflows and loosing trace
data, as we don't have overflow interrupt support (yet).

Applies on coresight/next

Changes since v1 :
 - Fix path for each CPU where the event might be recorded.
 - Handle errors in enabling source
 - Remove set_buffer callback to avoid complicating the error handling.
 - Fix a bug in handling sysfs mode specific buffers

Changes since [0] :
 - Drop buffer rotation logic for etr-buf
 - Do not use perf ring buffer. (Add support later)
 - Fix handling of sink, preventing mixed modes of operation.

[0] - TMC ETR perf support
 - http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/574875.html


Suzuki K Poulose (10):
  coresight: Fix handling of sinks
  coresight: perf: Fix per cpu path management
  coresight: perf: Disable trace path upon source error
  coresight: tmc-etr: Handle driver mode specific ETR buffers
  coresight: tmc-etr: Relax collection of trace from sysfs mode
  coresight: Convert driver messages to dev_dbg
  coresight: perf: Remove reset_buffer call back for sinks
  coresight: perf: Add helper to retrieve sink configuration
  coresight: perf: Remove set_buffer call back
  coresight: etm-perf: Add support for ETR backend

 .../coresight/coresight-dynamic-replicator.c       |   4 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |  84 ++----
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  91 +++---
 drivers/hwtracing/coresight/coresight-etm-perf.h   |  26 ++
 drivers/hwtracing/coresight/coresight-etm3x.c      |   4 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |   4 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |   4 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   2 +-
 drivers/hwtracing/coresight/coresight-replicator.c |   4 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  94 +++---
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 327 ++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc.c        |   4 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |   4 +
 drivers/hwtracing/coresight/coresight-tpiu.c       |   6 +-
 drivers/hwtracing/coresight/coresight.c            |  31 +-
 include/linux/coresight.h                          |  12 +-
 17 files changed, 473 insertions(+), 232 deletions(-)

-- 
2.7.4

