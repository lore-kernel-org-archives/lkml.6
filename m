Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E92C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9087B2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FOmwv1nS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FOmwv1nS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9087B2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeIFAqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:46:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34346 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeIFAqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:46:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9C3AA606FC; Wed,  5 Sep 2018 20:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536178486;
        bh=0O+UG6vyMTK6EY1EPAi4revW4idJ/XWFYgnMxSjAz/A=;
        h=From:To:Cc:Subject:Date:From;
        b=FOmwv1nSeJJVJ40n8SV/0HxTA9G932Fho55HPswIpSVCo8HNrXX/moc7vnYHc3TiM
         kFsL8NLsJ9cvtQPu7jA+CDYdHXup3akuKk8XZbmg2SPtBnQvBUxS8UNpus9rUstzaM
         9Qfr+CesL52V5ZZKbj9PrZg5GMcmKZDjCTinNwQ8=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4082D60242;
        Wed,  5 Sep 2018 20:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536178486;
        bh=0O+UG6vyMTK6EY1EPAi4revW4idJ/XWFYgnMxSjAz/A=;
        h=From:To:Cc:Subject:Date:From;
        b=FOmwv1nSeJJVJ40n8SV/0HxTA9G932Fho55HPswIpSVCo8HNrXX/moc7vnYHc3TiM
         kFsL8NLsJ9cvtQPu7jA+CDYdHXup3akuKk8XZbmg2SPtBnQvBUxS8UNpus9rUstzaM
         9Qfr+CesL52V5ZZKbj9PrZg5GMcmKZDjCTinNwQ8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4082D60242
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     bjorn.andersson@linaro.org, sboyd@kernel.org, evgreen@chromium.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] drivers: qcom: rpmh-rsc: clear wait_for_compl after use
Date:   Wed,  5 Sep 2018 14:14:38 -0600
Message-Id: <20180905201438.15124-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wait_for_compl register ensures the request sequence is maintained
when sending requests from the TCS. Clear the register after sending
active request and during invalidate of the sleep and wake TCS.

Reported-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
This is based on https://lore.kernel.org/patchwork/cover/968169/
---
 drivers/soc/qcom/rpmh-rsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 397a2cc653f5..0e90d91af253 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -126,6 +126,7 @@ static int tcs_invalidate(struct rsc_drv *drv, int type)
 			return -EAGAIN;
 		}
 		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0);
+		write_tcs_reg_sync(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0);
 	}
 	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
 	spin_unlock(&tcs->lock);
@@ -295,6 +296,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 skip:
 		/* Reclaim the TCS */
 		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
+		write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, i, 0);
 		write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, BIT(i));
 		spin_lock(&drv->lock);
 		clear_bit(i, drv->tcs_in_use);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

