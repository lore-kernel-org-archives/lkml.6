Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeENKrP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:47:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbeENKrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:47:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F8AC60209
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: bjorn.andersson@linaro.org, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sibis@codeaurora.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V6 0/5] Add support for Hexagon q6v5-wcss integrated core
Date: Mon, 14 May 2018 16:16:47 +0530
Message-Id: <1526294812-23390-1-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 has an integrated Hexagon dsp core Q6v5 and a wireless lan
(Lithium) IP. This series adds the remoteproc driver to reset, load
and boot Q6 firmware.

The first patch is to make the mdt_loader authenticate
the firmware only if required, so that the code can be reused for
self-authenticating firmware like the Q6v5 core in IPQ8074. The second
patch exports the elf header's get_boot_addr helper to reuse it.
The next couple of patches arranges the code in the original q6v5-mpss
rproc to add q6v5-wcss later. The last couple of patches add the relevant
bits for the q6v5-wcss core.

This is done on top of Avaneesh's msm8996 rproc support [1]

[1] https://lkml.org/lkml/2017/10/24/771

V6:
   Rebased on top of,
   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1674300.html

   Dropped remoteproc: Export rproc_elf_get_boot_addr, as it is already merged
   by a different patch from Bjorn.

   Minor change to the q6 power down sequence.

v5:
    No change. Just updated tags in PATCH #5

V4:
    Fixed Bjorn's comment in PATCH#1 and added his acked-by
    Rebased on top of Avinash's latest rproc for msm8996 q6 support.

V3:
    Rebased on top of latest remoteproc next

V2:
    Last time introduced this a new rproc driver, but there is lot
    of code that can be shared if it is added to the q6v5-mpss pil
    driver.

Sricharan R (5):
  remoteproc: qcom: mdt_loader: Make the firmware authentication
    optional
  remoteproc: qcom: Push reset ops, rproc ops in to of_match data
  remoteproc: qcom: Split the head and tail of the q5v5-pil rproc reset
    function
  remoteproc: qcom: Add support for q6v5-wcss pil
  remoteproc: qcom: Add q6v5-wcss rproc ops

 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |   7 +-
 drivers/remoteproc/Kconfig                         |   1 +
 drivers/remoteproc/qcom_q6v5_pil.c                 | 468 +++++++++++++++++----
 drivers/soc/qcom/mdt_loader.c                      |  87 ++--
 include/linux/soc/qcom/mdt_loader.h                |   4 +
 5 files changed, 450 insertions(+), 117 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
