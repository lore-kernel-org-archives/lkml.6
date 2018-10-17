Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A375ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB5321527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JUsBy9Iq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ln9LGXNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB5321527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJQVvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:51:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42752 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQVvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:51:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1CE1A6028C; Wed, 17 Oct 2018 13:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539784544;
        bh=fhuZa8mJTijbBerYUSlX3ADFDvHOhVlQPdNV+K/89J8=;
        h=From:To:Cc:Subject:Date:From;
        b=JUsBy9IqbyqDLcIBIPyboHLvprB+weeacrPDZaOl2Aox1dIn69aPZbf2NZ+iT0zAF
         83PdajMU07ed02nZmt2Jnr8z7IWLKJ5IHC6zucnzYc1v83UkGW3YUfrhX+aWsfpZlV
         QdGa+MmxsCwOf0hkJpn4SxP7UNVpVW5Q79mkT6Iw=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32CE16028C;
        Wed, 17 Oct 2018 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539784543;
        bh=fhuZa8mJTijbBerYUSlX3ADFDvHOhVlQPdNV+K/89J8=;
        h=From:To:Cc:Subject:Date:From;
        b=Ln9LGXNs+l+3BgPzWMh30IA2fBsaMotdEiMLO6OP+hAW+JRHf55W/pA+ersM8LGpe
         UNK1XH5cpQT6yF+eqptLACx5Ox9QE2/u5lWhnOQQ/kqNAQKRJUF8xf29Eq/MDWOfJx
         GInBQmNPDKM+l41au4oo4zPLRlm2dLnO/n6Z2lHk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32CE16028C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        kyan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v5 0/5] Add coredump support for Q6v5 Modem remoteproc
Date:   Wed, 17 Oct 2018 19:25:22 +0530
Message-Id: <20181017135527.30592-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add coredump support for modem on SDM845, MSM8996
and MSM8916 SoCs. Modem requires the mba to be loaded before a
coredump can be performed and this is achieved using a custom per
segment dump function.

V5:
  Add software bypass to avoid high MX current in mpss_load error path.
  Remove the proxy votes of clk/regs only after the active/reset clks/regs.
  Reclaim MBA memory after mpss_load failure in mba_reclaim func.
  Revert to dump_fn to as done with v3 with a mask based approach.

V4:
  Addressed Bjorn's comments.

V3:
  [bjorn]:replace prepare/unprepare ops with a more generalised per segment
  dump function

V2:
  Introduce prepare/unprepare ops for rproc coredump

Sibi Sankar (5):
  remoteproc: Introduce custom dump function for each remoteproc segment
  remoteproc: Add mechanism for custom dump function assignment
  remoteproc: qcom: q6v5-mss: Refactor mba load/unload sequence
  remoteproc: qcom: q6v5-mss: Add custom dump function for modem
  remoteproc: qcom: q6v5-mss: Register segments/dumpfn for coredump

 drivers/remoteproc/qcom_q6v5_mss.c   | 379 +++++++++++++++++----------
 drivers/remoteproc/remoteproc_core.c |  55 +++-
 include/linux/remoteproc.h           |  11 +
 3 files changed, 303 insertions(+), 142 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

