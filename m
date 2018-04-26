Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeDZCIo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:08:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44148 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeDZCIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:08:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE63560117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=clew@codeaurora.org
From: Chris Lew <clew@codeaurora.org>
To: bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: aneela@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        clew@codeaurora.org
Subject: [PATCH v2 0/6] Add chrdev and name query support for GLINK
Date: Wed, 25 Apr 2018 19:07:46 -0700
Message-Id: <1524708472-18263-1-git-send-email-clew@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the GLINK rpmsg transport to register a rpmsg chrdev.
This will create the rpmsg_ctrl nodes for userspace clients to open 
rpmsg epts. Create a label property that will help userspace clients
distinguish between the different GLINK links. The rpmsg chrdev 
allocation is done by allocating a local channel which also allocates
an ept. We need to add some guards against edge cases for this chrdev
because it will never fully open.

Changes since v1:
- Add explanation to dt-bindings commit message
- Add patch complete_all the open_req/ack variables
- Add patch to prevent null pointer dereference in chrdev channel release
- Change chrdev allocation to use glink channel allocation
- Change glink attr struct to const

Chris Lew (6):
  dt-bindings: soc: qcom: Add label for GLINK bindings
  rpmsg: glink: Store edge name for glink device
  rpmsg: glink: Use complete_all for open states
  rpmsg: Guard against null endpoint ops in destroy
  rpmsg: glink: Add support for rpmsg glink chrdev
  rpmsg: glink: Expose rpmsg name attr for glink

 .../devicetree/bindings/soc/qcom/qcom,glink.txt    |  5 ++
 drivers/rpmsg/qcom_glink_native.c                  | 68 +++++++++++++++++++++-
 drivers/rpmsg/rpmsg_core.c                         |  2 +-
 3 files changed, 71 insertions(+), 4 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
