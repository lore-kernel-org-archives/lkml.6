Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC84CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B70521A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B70521A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbeHFPwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38834 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbeHFPwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECC567A9;
        Mon,  6 Aug 2018 06:43:14 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBA783F2EA;
        Mon,  6 Aug 2018 06:43:13 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 00/13] coresight: Implement device claim protocol
Date:   Mon,  6 Aug 2018 14:41:42 +0100
Message-Id: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coresight architecture defines CLAIM tags for a device to negotiate
control of the components (external agent vs self-hosted). Each device
has a pair of registers (CLAIMSET & CLAIMCLR) for managing the CLAIM
tags. However, the protocol for the CLAIM tags is IMPLEMENTATION DEFINED.
PSCI has recommendations for the use of the CLAIM tags to negotiate
controls for external agent vs self-hosted use, as defined in
ARM DEN 0022D, Section "6.8.1 Debug and Trace save and restore".

This series implements the recommended protocol by PSCI.

There were two options for the implementation.
 1) Have the claim/disclaim operations performed from the coresight
    generic driver - This doesn't work unfortunately for ETM devices
    as the need cross-CPU calls to access the CLAIM registers. Also,
    makes it complex for error recovery and reference counting.

 2) Have the claim/disclaim operations performed from the device
    specific drivers. The disadvantage is that the calls are sprinkled
    in each driver, but this makes the operation much simpler.

This series implements the method (2). The first part of the series
prepares different drivers to handle errors from the lower layer
and clean up the state.

Applies on coresight/next:


Suzuki K Poulose (13):
  coresight: tmc-etr: Refactor for handling errors
  coresight: tmc-etr: Handle errors enabling CATU
  coresight: tmc-etb/etf: Prepare to handle errors enabling
  coresight: etm4x: Add support for handling errors
  coresight: etm3: Add support for handling errors
  coresight: etb10: Handle errors enabling the device
  coresight: dynamic-replicator: Handle multiple connections
  coresight: Add support for CLAIM tag protocol
  coresight: etmx: Claim devices before use
  coresight: funnel: Claim devices before use
  coresight: catu: Claim device before use
  coresight: dynamic-replicator: Claim device for use
  coreisght: tmc: Claim device before use

 drivers/hwtracing/coresight/coresight-catu.c       |  6 ++
 .../coresight/coresight-dynamic-replicator.c       | 79 +++++++++++++-----
 drivers/hwtracing/coresight/coresight-etb10.c      | 18 +++--
 drivers/hwtracing/coresight/coresight-etm3x.c      | 58 ++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.c      | 52 ++++++++----
 drivers/hwtracing/coresight/coresight-funnel.c     | 26 ++++--
 drivers/hwtracing/coresight/coresight-priv.h       |  7 ++
 drivers/hwtracing/coresight/coresight-tmc-etf.c    | 93 +++++++++++++++-------
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 80 +++++++++++++------
 drivers/hwtracing/coresight/coresight.c            | 85 ++++++++++++++++++++
 include/linux/coresight.h                          | 20 +++++
 11 files changed, 409 insertions(+), 115 deletions(-)

-- 
2.7.4

