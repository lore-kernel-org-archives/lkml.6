Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A8EECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03453208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="du0OOoAp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GlkgCNAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03453208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeGPRzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:55:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPRzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:55:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7C54960116; Mon, 16 Jul 2018 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531762027;
        bh=QJdZpNi8qMydP1Xd4hWIpXPaqLS4X1aS6qoZoXYYlCg=;
        h=From:To:Cc:Subject:Date:From;
        b=du0OOoApiDUuLb5RWu0y8VWX3Jf+Ha/n1yT3/kVVZm3W6hYGTfycs6rdGddbHk+Ez
         4y/6nP/+8SuB5v4JychQPQpl53W0ukjQOtxhuQCLztwt2MbdR8z0Ous6TOBtcLosuG
         pudQuZa4d6/7UN7lKHQ7ZXMi0498cDh1EISTFtXU=
Received: from thunderhorn.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tbaicar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F230060274;
        Mon, 16 Jul 2018 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531762026;
        bh=QJdZpNi8qMydP1Xd4hWIpXPaqLS4X1aS6qoZoXYYlCg=;
        h=From:To:Cc:Subject:Date:From;
        b=GlkgCNAMY3cnTRSSncJIX4Lqi4BC+Bmd7UAop9uns6tPvwcc+CxG98ilhCSXIUDFV
         3fAccbJIKr1mrVBB70h5EYktfw7cpthJKPjHOHqpA8/zsIjCYhktjYuOhXRW6Ed9mV
         IRxG+PdpQu+E4q8VQtg3STguFvYwckygLtZ0ePHQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F230060274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tbaicar@codeaurora.org
From:   Tyler Baicar <tbaicar@codeaurora.org>
To:     mchehab@kernel.org, bp@alien8.de, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tyler Baicar <tbaicar@codeaurora.org>
Subject: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
Date:   Mon, 16 Jul 2018 13:26:49 -0400
Message-Id: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable per-layer error reporting for ARM systems so that the error
counters are incremented per-DIMM.

On ARM systems that use firmware first error handling it is understood
that card=channel and module=DIMM on that channel. Populate that
information and enable per layer error reporting for ARM systems so that
the EDAC error counters are incremented based on DIMM number as per the
SMBIOS table rather than just incrementing the noinfo counters on the
memory controller.

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/edac/ghes_edac.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 473aeec..e4c8b6e 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -213,9 +213,18 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	strcpy(e->label, "unknown label");
 	e->msg = pvt->msg;
 	e->other_detail = pvt->other_detail;
-	e->top_layer = -1;
-	e->mid_layer = -1;
-	e->low_layer = -1;
+	if ((IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64))
+	    && (mem_err->validation_bits & CPER_MEM_VALID_CARD)
+	    && (mem_err->validation_bits & CPER_MEM_VALID_MODULE)) {
+		e->top_layer = mem_err->card;
+		e->mid_layer = mem_err->module;
+		e->low_layer = -1;
+		e->enable_per_layer_report = true;
+	} else {
+		e->top_layer = -1;
+		e->mid_layer = -1;
+		e->low_layer = -1;
+	}
 	*pvt->other_detail = '\0';
 	*pvt->msg = '\0';
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

