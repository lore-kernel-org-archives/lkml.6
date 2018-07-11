Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11198C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3CC208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3CC208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbeGKOV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:21:28 -0400
Received: from foss.arm.com ([217.140.101.70]:36860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbeGKOV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:21:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15B437A9;
        Wed, 11 Jul 2018 07:16:54 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B54D73F5B1;
        Wed, 11 Jul 2018 07:16:52 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, robert.walker@arm.com,
        mike.leach@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 0/6] coresight: perf: Support for tmc-etr backed buffers
Date:   Wed, 11 Jul 2018 15:16:33 +0100
Message-Id: <1531318599-8840-1-git-send-email-suzuki.poulose@arm.com>
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

Changes since [0] :
 - Drop buffer rotation logic for etr-buf
 - Do not use perf ring buffer. (Add support later)
 - Fix handling of sink, preventing mixed modes of operation.

[0] - TMC ETR perf support
 - http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/574875.html

Suzuki K Poulose (6):
  coresight: Fix handling of sinks
  coresight: tmc-etr: Handle driver mode specific ETR buffers
  coresight: tmc-etr: Relax collection of trace from sysfs mode
  coresight: Convert driver messages to dev_dbg
  coresight: perf: Remove reset_buffer call back for sinks
  coresight: etm-perf: Add support for ETR backend

 .../coresight/coresight-dynamic-replicator.c       |   4 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |  62 +---
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   9 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |   4 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |   4 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |   4 +-
 drivers/hwtracing/coresight/coresight-replicator.c |   4 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  66 +---
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 337 +++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.c        |   4 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |   4 +
 drivers/hwtracing/coresight/coresight-tpiu.c       |   4 +-
 drivers/hwtracing/coresight/coresight.c            |  22 +-
 include/linux/coresight.h                          |   5 +-
 15 files changed, 375 insertions(+), 162 deletions(-)

-- 
2.7.4

