Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0D8C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF42D20811
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693444;
	bh=5x70yssgkgsPSvlB+PSGv9POOw1WMFLtJzEJn1g5jck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WdLOM4cRwggbaOYBIcQwi/FjYP95YspculNNsv0vQ0KclrgkrgQyo66z8MS8p1o5H
	 Idqd/zGNrlKHGhIEvcODREqlQrqTYEiaaaskSI+GNAjqjTTyKT7pT8pLsruUcIdjDh
	 lNV/d++fju/a+WD0Ef/Oyk96FJWoU5nx42kZgERU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390231AbfA1QhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:37:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389850AbfA1QZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:25:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E063F2171F;
        Mon, 28 Jan 2019 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692705;
        bh=5x70yssgkgsPSvlB+PSGv9POOw1WMFLtJzEJn1g5jck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lA1jkypCXZOAyj5k90gDWY5jaP8oZBu+zKIG9N1D0DHFG7HTBU4+smsCPVh7KOr+L
         88I6ck/+icZ8gkE4Zx30RwADPlkTXdF1pfMgFSL0NIEzMmVSQf+Q5wyd5pzpuWsm25
         r4pb6CjJuiEXQedcs1x+eNZZ8Tj9rO7TumOi3FNg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 39/80] i2c-axxia: check for error conditions first
Date:   Mon, 28 Jan 2019 11:23:20 -0500
Message-Id: <20190128162401.58841-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)" <krzysztof.adamski@nokia.com>

[ Upstream commit 4f5c85fe3a60ace555d09898166af372547f97fc ]

It was observed that when using seqentional mode contrary to the
documentation, the SS bit (which is supposed to only be set if
automatic/sequence command completed normally), is sometimes set
together with NA (NAK in address phase) causing transfer to falsely be
considered successful.

My assumption is that this does not happen during manual mode since the
controller is stopping its work the moment it sets NA/ND bit in status
register. This is not the case in Automatic/Sequentional mode where it
is still working to send STOP condition and the actual status we get
depends on the time when the ISR is run.

This patch changes the order of checking status bits in ISR - error
conditions are checked first and only if none of them occurred, the
transfer may be considered successful. This is required to introduce
using of sequentional mode in next patch.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-axxia.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 9c9fd2e87a4b..1c68b05c8649 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -296,22 +296,7 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 			i2c_int_disable(idev, MST_STATUS_TFL);
 	}
 
-	if (status & MST_STATUS_SCC) {
-		/* Stop completed */
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		complete(&idev->msg_complete);
-	} else if (status & MST_STATUS_SNS) {
-		/* Transfer done */
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
-			axxia_i2c_empty_rx_fifo(idev);
-		complete(&idev->msg_complete);
-	} else if (status & MST_STATUS_TSS) {
-		/* Transfer timeout */
-		idev->msg_err = -ETIMEDOUT;
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		complete(&idev->msg_complete);
-	} else if (unlikely(status & MST_STATUS_ERR)) {
+	if (unlikely(status & MST_STATUS_ERR)) {
 		/* Transfer error */
 		i2c_int_disable(idev, ~0);
 		if (status & MST_STATUS_AL)
@@ -328,6 +313,21 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 			readl(idev->base + MST_TX_BYTES_XFRD),
 			readl(idev->base + MST_TX_XFER));
 		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_SCC) {
+		/* Stop completed */
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_SNS) {
+		/* Transfer done */
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
+			axxia_i2c_empty_rx_fifo(idev);
+		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_TSS) {
+		/* Transfer timeout */
+		idev->msg_err = -ETIMEDOUT;
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		complete(&idev->msg_complete);
 	}
 
 out:
-- 
2.19.1

