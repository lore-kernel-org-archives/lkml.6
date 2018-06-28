Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BD0C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D965824882
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nJbZkH3Z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nJbZkH3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D965824882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbeF1BU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:20:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeF1BU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:20:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 41E3460B1E; Thu, 28 Jun 2018 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530148826;
        bh=1ae52/X0XZBW+hxISQWqv5aoUmrAd4TFJOUTk7Q9F9A=;
        h=From:To:Cc:Subject:Date:From;
        b=nJbZkH3ZKVyXl3YCbEdWPYVht+b3Qf2hHH2R7zfr0fPzGv/w0dswamHdQnRBcLvXX
         BUNiFlI6/VWcck95pCcUGMcnhwjG415ssEjGXjndS5nO25kpfRVHio9UANw/em1X/L
         TaZShnbRzmF6tmxyW//TPSM/f/Q03qo3fV4rfIvE=
Received: from clew-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clew@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA23F6071C;
        Thu, 28 Jun 2018 01:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530148826;
        bh=1ae52/X0XZBW+hxISQWqv5aoUmrAd4TFJOUTk7Q9F9A=;
        h=From:To:Cc:Subject:Date:From;
        b=nJbZkH3ZKVyXl3YCbEdWPYVht+b3Qf2hHH2R7zfr0fPzGv/w0dswamHdQnRBcLvXX
         BUNiFlI6/VWcck95pCcUGMcnhwjG415ssEjGXjndS5nO25kpfRVHio9UANw/em1X/L
         TaZShnbRzmF6tmxyW//TPSM/f/Q03qo3fV4rfIvE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA23F6071C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=clew@codeaurora.org
From:   Chris Lew <clew@codeaurora.org>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     aneela@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clew@codeaurora.org
Subject: [PATCH] rpmsg: glink: Set tail pointer to 0 at end of FIFO
Date:   Wed, 27 Jun 2018 18:19:57 -0700
Message-Id: <1530148797-31904-1-git-send-email-clew@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When wrapping around the FIFO, the remote expects the tail pointer to
be reset to 0 on the edge case where the tail equals the FIFO length.

Signed-off-by: Chris Lew <clew@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index 2b5cf2790954..7a276be598d6 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -109,7 +109,7 @@ static void glink_smem_rx_advance(struct qcom_glink_pipe *np,
 	tail = le32_to_cpu(*pipe->tail);
 
 	tail += count;
-	if (tail > pipe->native.length)
+	if (tail >= pipe->native.length)
 		tail -= pipe->native.length;
 
 	*pipe->tail = cpu_to_le32(tail);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

