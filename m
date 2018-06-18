Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F13C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2228420852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2228420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935241AbeFRK4m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:56:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59900 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932665AbeFRK4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:56:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD7AA80D;
        Mon, 18 Jun 2018 03:56:40 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C25CE3F25D;
        Mon, 18 Jun 2018 03:56:39 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 0/6] coresight: Coresight Address Translation Unit support
Date:   Mon, 18 Jun 2018 11:56:13 +0100
Message-Id: <1529319379-17895-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Coresight Address Translation Unit (CATU), which
provides improved scatter-gather functionality for TMC-ETR. The CATU
performs address translation for ETR based on a page table, which
contains address of 4KB sized data pages, but uses a different
format from that of the TMC-ETR SG table. The page table format is
described in the code. See patch

 "coresight: catu: Add support for scatter gather tables"

The CATU devices do not appear on the "software" path for given
trace session, to leave the management of the device to the driving
TMC-ETR, depending on the mode of the buffer. Towards this we
introduce a new class of coresight device_type, helper devices.
These helper devices are managed by the master devices. The
build-path operation takes care of making sure that any helper
device associated with a device is turned on.

Applies on Mathieu's coresight/next-pref-4.18-rc1

This series is, part 2 of the split of the series [0].

Changes since [0] :
 - Remove "restore" buf support and trim down the page table
   populate code to get rid of "range" updates.
 - Do not create a circular table by default.
 - Fix style issues
 - Set DMA mask for CATU based on the address width.
 - Rename :
	coresight_prepare_device => coresight_grab_device
	coresight_release_device => coresight_drop_device
   to avoid confusing with coresight_device_release().

[0] - TMC ETR perf support
 - http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/574875.html


Suzuki K Poulose (6):
  coresight: Cleanup device subtype struct
  coresight: Add helper device type
  coresight: Introduce support for Coresight Address Translation Unit
  dts: bindings: Document device tree binding for CATU
  coresight: catu: Add support for scatter gather tables
  coresight: catu: Plug in CATU as a backend for ETR buffer

 .../devicetree/bindings/arm/coresight.txt          |  53 ++
 drivers/hwtracing/coresight/Kconfig                |  11 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-catu.c       | 575 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-catu.h       | 120 +++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  71 ++-
 drivers/hwtracing/coresight/coresight-tmc.h        |   3 +
 drivers/hwtracing/coresight/coresight.c            |  43 +-
 include/linux/coresight.h                          |  46 +-
 9 files changed, 909 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-catu.c
 create mode 100644 drivers/hwtracing/coresight/coresight-catu.h

-- 
2.7.4

