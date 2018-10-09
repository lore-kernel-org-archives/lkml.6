Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF58C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9122075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GaVPuMcv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GaVPuMcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9122075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJIXli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:41:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42040 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIXlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:41:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ADC3E6024C; Tue,  9 Oct 2018 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539102234;
        bh=YF6XxzJK5EOqlmoew/f5gsYBczOdmqtHfP9zTcrkAGE=;
        h=From:To:Cc:Subject:Date:From;
        b=GaVPuMcv1I9iV0fU+VwqWLbbIRqVDivwvqvs91gElNzO4MxYzNZ8Qv04H0USpxTpw
         B2wwyLTA2MpWGSIf2CP28pnFhZAF7FLhFwNZ7PwnzDkknPI+iQv/9D2206MrOpSTsl
         N9odNhoPFPfLUElKuivHFHo0Waf3g6FJKrPPgXtw=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E92B360388;
        Tue,  9 Oct 2018 16:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539102234;
        bh=YF6XxzJK5EOqlmoew/f5gsYBczOdmqtHfP9zTcrkAGE=;
        h=From:To:Cc:Subject:Date:From;
        b=GaVPuMcv1I9iV0fU+VwqWLbbIRqVDivwvqvs91gElNzO4MxYzNZ8Qv04H0USpxTpw
         B2wwyLTA2MpWGSIf2CP28pnFhZAF7FLhFwNZ7PwnzDkknPI+iQv/9D2206MrOpSTsl
         N9odNhoPFPfLUElKuivHFHo0Waf3g6FJKrPPgXtw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E92B360388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        kyan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 0/5] Add coredump support for Q6v5 Modem remoteproc
Date:   Tue,  9 Oct 2018 21:53:34 +0530
Message-Id: <20181009162339.30522-1-sibis@codeaurora.org>
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

 drivers/remoteproc/qcom_q6v5_mss.c   | 307 ++++++++++++++++++---------
 drivers/remoteproc/remoteproc_core.c |  55 ++++-
 include/linux/remoteproc.h           |  11 +
 3 files changed, 268 insertions(+), 105 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

