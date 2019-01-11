Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8157FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0E120878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfAKW4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:56:06 -0500
Received: from inva021.nxp.com ([92.121.34.21]:51520 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfAKW4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:56:05 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B441A20016B;
        Fri, 11 Jan 2019 23:56:03 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C7DF20004F;
        Fri, 11 Jan 2019 23:56:03 +0100 (CET)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.33.49])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id B9B0D40CD6;
        Fri, 11 Jan 2019 15:56:02 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL v2] updates to soc/fsl drivers for v5.1
Date:   Fri, 11 Jan 2019 16:56:00 -0600
Message-Id: <20190111225600.16160-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

This is an updated pull request to replace one problematic patch
regarding to guts driver.  Please ignore the last pull request.


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.1-2

for you to fetch changes up to 3c0d64e867ed78a782a8a00d3b519396d9c5a2db:

  soc: fsl: guts: reuse machine name from device tree (2019-01-11 16:08:43 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.1

DPIO driver
- Clean up the remove path in the dpio driver so that successive
  bind/unbind commands behave properly
- Add the ability to automatically create a device link between a
  consumer device on the fsl-mc bus and a supplier one
- Add prefetch to dpio dequeue to improve performance
- Update the type of dpio APIs to align with buffer pool id register
  field

guts driver
- Prevent allocation failure by reuse the machine type data from device
  tree directly

----------------------------------------------------------------
Ioana Ciocoi Radulescu (2):
      soc: fsl: dpio: Add prefetch instruction
      soc: fsl: dpio: Change bpid type to u16

Ioana Ciornei (6):
      soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
      soc: fsl: dpio: use a cpumask to identify which cpus are unused
      soc: fsl: dpio: keep a per dpio device MC portal
      soc: fsl: dpio: store a backpointer to the device backing the dpaa2_io
      soc: fsl: dpio: add a device_link at dpaa2_io_service_register
      bus: fsl-mc: automatically add a device_link on fsl_mc_[portal,object]_allocate

Li Yang (1):
      soc: fsl: guts: reuse machine name from device tree

Roy Pledge (1):
      soc: fsl: dpio: perform DPIO Reset on Probe

 drivers/bus/fsl-mc/fsl-mc-allocator.c            | 11 ++++++
 drivers/bus/fsl-mc/mc-io.c                       | 13 +++++++
 drivers/crypto/caam/caamalg_qi2.c                |  6 ++--
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |  9 ++---
 drivers/soc/fsl/dpio/dpio-cmd.h                  |  1 +
 drivers/soc/fsl/dpio/dpio-driver.c               | 41 ++++++++++++---------
 drivers/soc/fsl/dpio/dpio-service.c              | 46 +++++++++++++++++++++---
 drivers/soc/fsl/dpio/dpio.c                      | 23 ++++++++++++
 drivers/soc/fsl/dpio/dpio.h                      |  4 +++
 drivers/soc/fsl/guts.c                           |  7 ++--
 include/linux/fsl/mc.h                           |  1 +
 include/soc/fsl/dpaa2-io.h                       | 15 +++++---
 12 files changed, 140 insertions(+), 37 deletions(-)
