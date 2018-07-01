Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91301C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2AC24A2B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2AC24A2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934017AbeGAQ7E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:59:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37972 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032453AbeGAQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:44:06 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7314CA73;
        Sun,  1 Jul 2018 16:44:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4.17 165/220] remoteproc: Prevent incorrect rproc state on xfer mem ownership failure
Date:   Sun,  1 Jul 2018 18:23:09 +0200
Message-Id: <20180701160915.163225434@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sibi Sankar <sibis@codeaurora.org>

commit 2724807f7f70a6a3e67b3f6bf921cc77ed39c8a1 upstream.

Any failure in the secure call for transferring mem ownership of mba
region to Q6 would result in reporting that the remoteproc device
is running. This is because the previous q6v5_clk_enable would have
been a success. Prevent this by updating variable 'ret' accordingly.

Cc: stable@vger.kernel.org
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/remoteproc/qcom_q6v5_pil.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -761,13 +761,11 @@ static int q6v5_start(struct rproc *rpro
 	}
 
 	/* Assign MBA image access in DDR to q6 */
-	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true,
-						qproc->mba_phys,
-						qproc->mba_size);
-	if (xfermemop_ret) {
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true,
+				      qproc->mba_phys, qproc->mba_size);
+	if (ret) {
 		dev_err(qproc->dev,
-			"assigning Q6 access to mba memory failed: %d\n",
-			xfermemop_ret);
+			"assigning Q6 access to mba memory failed: %d\n", ret);
 		goto disable_active_clks;
 	}
 


