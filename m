Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EAEC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C7120842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I7lWPjdZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I7lWPjdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C7120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbeGLRUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:20:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeGLRUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:20:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D68ED60B73; Thu, 12 Jul 2018 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531415396;
        bh=+RljXHj3dJiSeg75ZL1rZv1KnNH/1p/gLRkYBCREPbs=;
        h=From:To:Cc:Subject:Date:From;
        b=I7lWPjdZX3scArhUmljqfGP4TjA1IGSFbk1u2t8JobRcCTlDiYJ+Esc0HO6Ll7PAR
         +qElyAxIWplOL/EAeH0vQ97aBUGliN34gX4LSbhwYhcA92gq77HcB9AKb+p8sYpkvT
         JRdC1BANGn9ejbhiBWrN+b2p0PDSkKF2nCgJNZjI=
Received: from anischal-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anischal@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8B6E60213;
        Thu, 12 Jul 2018 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531415396;
        bh=+RljXHj3dJiSeg75ZL1rZv1KnNH/1p/gLRkYBCREPbs=;
        h=From:To:Cc:Subject:Date:From;
        b=I7lWPjdZX3scArhUmljqfGP4TjA1IGSFbk1u2t8JobRcCTlDiYJ+Esc0HO6Ll7PAR
         +qElyAxIWplOL/EAeH0vQ97aBUGliN34gX4LSbhwYhcA92gq77HcB9AKb+p8sYpkvT
         JRdC1BANGn9ejbhiBWrN+b2p0PDSkKF2nCgJNZjI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8B6E60213
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v2 0/4] Add QCOM graphics clock controller driver for SDM845
Date:   Thu, 12 Jul 2018 22:39:37 +0530
Message-Id: <1531415381-16885-1-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
Addressed review comments given by Stephen: https://lkml.org/lkml/2018/6/6/294
* Introduce clk_rcg2_gfx3d_determine_rate ops to return the best parent
  as 'gpucc_pll0_even' and best parent rate as twice of the requested rate
  always. This will eliminate the need of frequency table as source and
  div-2 are fixed for gfx3d_clk_src.
  Also modified the clk_rcg2_set_rate ops to configure the fixed source and
  div.
* Add support to check if requested rate falls within allowed set_rate range.
  This will not let the source gpucc_pll0 to go out of the supported range
  and also client can request the rate within the range.
* Fixed comment text in probe function and added module description for GPUCC
  driver.

The graphics clock driver depends upon the below change.
	https://lkml.org/lkml/2018/6/23/108

Changes in v1:
This patch series adds support for graphics clock controller for SDM845.
Below is the brief description for each change:

1. For some of the GDSCs, there is requirement to enable/disable the
   few clocks before turning on/off the gdsc power domain. This patch
   will add support to enable/disable the clock associated with the
   gdsc along with power domain on/off callbacks.

2. To turn on the gpu_gx_gdsc, there is a hardware requirement to
   turn on the root clock (GFX3D RCG) first which would be the turn
   on signal for the gdsc along with the SW_COLLAPSE. As per the
   current implementation of clk_rcg2_shared_ops, it clears the
   root_enable bit in the enable() clock ops. But due to the above
   said requirement for GFX3D shared RCG, root_enable bit would be
   already set by gdsc driver and rcg2_shared_ops should not clear
   the root unless the disable() is called.

   This patch add support for the same by reusing the existing
   clk_rcg2_shared_ops and deriving "clk_rcg2_gfx3d_ops" clk_ops
   for GFX3D clock to take care of the root set/clear requirement.

3. Add device tree bindings for graphics clock controller for SDM845.

4. Add graphics clock controller (GPUCC) driver for SDM845.

[v1] : https://lkml.org/lkml/2018/6/6/294

Amit Nischal (4):
  clk: qcom: gdsc: Add support to enable/disable the clocks with GDSC
  clk: qcom: Add clk_rcg2_gfx3d_ops for SDM845
  dt-bindings: clock: Introduce QCOM Graphics clock bindings
  clk: qcom: Add graphics clock controller driver for SDM845

 .../devicetree/bindings/clock/qcom,gpucc.txt       |  18 +
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-rcg.h                         |   1 +
 drivers/clk/qcom/clk-rcg2.c                        |  87 +++-
 drivers/clk/qcom/gdsc.c                            |  44 +++
 drivers/clk/qcom/gdsc.h                            |   5 +
 drivers/clk/qcom/gpucc-sdm845.c                    | 438 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,gpucc-sdm845.h      |  38 ++
 9 files changed, 639 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.txt
 create mode 100644 drivers/clk/qcom/gpucc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sdm845.h

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

