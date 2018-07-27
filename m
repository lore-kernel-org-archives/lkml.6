Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49097C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B61208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MUSRnhSe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MUSRnhSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B61208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbeG0Qna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:43:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732752AbeG0Qn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:43:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C64E060AD8; Fri, 27 Jul 2018 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704866;
        bh=6SrS6rAZ06PTIhtyGYLQRD71V/tpYorzi/feg7Fi4n4=;
        h=From:To:Cc:Subject:Date:From;
        b=MUSRnhSebR6a8wvOjpFtM1svE/6uQQcfNf/yknwkkBuX+VOIrMYYsNYiP7nwzKDF4
         XZ+5ytzEHVBT78N3+wU3yq58vp2EbAVK4Mp6ExvDd6esQK+qZ+6g14FSS/8AXnpeie
         GrB1/2HFxrF8ynpeSLDTT3HBEFVZ+YKPYzlSY/Lo=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C70C760500;
        Fri, 27 Jul 2018 15:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704866;
        bh=6SrS6rAZ06PTIhtyGYLQRD71V/tpYorzi/feg7Fi4n4=;
        h=From:To:Cc:Subject:Date:From;
        b=MUSRnhSebR6a8wvOjpFtM1svE/6uQQcfNf/yknwkkBuX+VOIrMYYsNYiP7nwzKDF4
         XZ+5ytzEHVBT78N3+wU3yq58vp2EbAVK4Mp6ExvDd6esQK+qZ+6g14FSS/8AXnpeie
         GrB1/2HFxrF8ynpeSLDTT3HBEFVZ+YKPYzlSY/Lo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C70C760500
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 0/6] Add coredump support for Q6v5 Modem remoteproc
Date:   Fri, 27 Jul 2018 20:49:57 +0530
Message-Id: <20180727152003.11663-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add coredump support for modem on SDM845, MSM8996
and MSM8916 SoCs. Modem requires the mba to be loaded before a
coredump can be performed and this is achieved using a custom per
segment dump function.

V3:
  [bjorn]:replace prepare/unprepare ops with a more generalised per segment
  dump function

V2:
  Introduce prepare/unprepare ops for rproc coredump

Sibi Sankar (6):
  remoteproc: Introduce custom dump function for each remoteproc segment
  remoteproc: Add mechanism for custom dump function assignment
  remoteproc: qcom: q6v5-pil: Refactor mba load/unload sequence
  remoteproc: qcom: q6v5-pil: Add custom dump function for modem
  remoteproc: qcom: q6v5-pil: Register segments/dumpfn for coredump
  remoteproc: qcom: q6v5-pil: Assign the relocated address

 drivers/remoteproc/qcom_q6v5_pil.c   | 307 ++++++++++++++++++---------
 drivers/remoteproc/remoteproc_core.c |  52 ++++-
 include/linux/remoteproc.h           |   8 +
 3 files changed, 264 insertions(+), 103 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

