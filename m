Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CECC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF194208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MHYZT5v6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M8TVr6gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF194208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbeJAVDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:03:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36016 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJAVDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:03:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1390C60C87; Mon,  1 Oct 2018 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538403914;
        bh=Hm3QyFLIKnIfgzKeWJUsdHvzcKKxgPn0UEHE8nJYm+g=;
        h=From:To:Cc:Subject:Date:From;
        b=MHYZT5v6BTWqEL7RynJKeZPN3XvBADioCOec/PvXFF38ACfTmyNi+jo03uP5WUVX1
         1Z+DupGQzd9pDzQAOO7AQjsXMyHXGOx5IWZlV/OFHbUobm2vggxvQxt4AkXwLselOf
         vwqp/7acDN8SsitE1e8mC00SvdSPWVTsLP1UhNrw=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9F3760C1D;
        Mon,  1 Oct 2018 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538403912;
        bh=Hm3QyFLIKnIfgzKeWJUsdHvzcKKxgPn0UEHE8nJYm+g=;
        h=From:To:Cc:Subject:Date:From;
        b=M8TVr6gwDxkgtE9eIHSOAW0M+KNGR7DYaYjpBwMAXF13fhbvcb0uSToIFziZ0/PJ/
         4kpxmvSEzQZGTVymlHZeFeSvYUzh6WvFRFQ/iyjIBCbcHVuZ1UZzUwCUwsdxv7QIIU
         AwHJ/4vtOvLMjY3lZCeV5R4xkqss/E/ZdDFPoXFc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9F3760C1D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] remoteproc: qcom: q6v5: Fix a race condition on fatal crash
Date:   Mon,  1 Oct 2018 19:55:00 +0530
Message-Id: <20181001142500.25457-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently with GLINK_SSR enabled each fatal crash results in servicing
a crash from wdog as well. This is due to a race that occurs in setting
the running flag in the shutdown path. Fix this by moving the running
flag to the end of fatal interrupt handler.

Crash Logs:
qcom-q6v5-pil 4080000.remoteproc: fatal error without message
remoteproc remoteproc0: crash detected in 4080000.remoteproc: type fatal
	error
remoteproc remoteproc0: handling crash #1 in 4080000.remoteproc
remoteproc remoteproc0: recovering 4080000.remoteproc
qcom-q6v5-pil 4080000.remoteproc: watchdog without message
remoteproc remoteproc0: crash detected in 4080000.remoteproc: type watchdog
remoteproc:glink-edge: intent request timed out
qcom_glink_ssr remoteproc:glink-edge.glink_ssr.-1.-1: failed to send
	cleanup message
qcom_glink_ssr remoteproc:glink-edge.glink_ssr.-1.-1: timeout waiting
	for cleanup done message
qcom-q6v5-pil 4080000.remoteproc: timed out on wait
qcom-q6v5-pil 4080000.remoteproc: port failed halt
remoteproc remoteproc0: stopped remote processor 4080000.remoteproc
qcom-q6v5-pil 4080000.remoteproc: MBA booted, loading mpss
remoteproc remoteproc0: remote processor 4080000.remoteproc is now up
remoteproc remoteproc0: handling crash #2 in 4080000.remoteproc
remoteproc remoteproc0: recovering 4080000.remoteproc
qcom-q6v5-pil 4080000.remoteproc: port failed halt
remoteproc remoteproc0: stopped remote processor 4080000.remoteproc
qcom-q6v5-pil 4080000.remoteproc: MBA booted, loading mpss
remoteproc remoteproc0: remote processor 4080000.remoteproc is now up

[bjorn: move running flag to the end of fatal interrupt handler]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index e9ab90c19304..edeb2e43209e 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -84,6 +84,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 	else
 		dev_err(q6v5->dev, "fatal error without message\n");
 
+	q6v5->running = false;
 	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
 
 	return IRQ_HANDLED;
@@ -150,8 +151,6 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5)
 {
 	int ret;
 
-	q6v5->running = false;
-
 	qcom_smem_state_update_bits(q6v5->state,
 				    BIT(q6v5->stop_bit), BIT(q6v5->stop_bit));
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

