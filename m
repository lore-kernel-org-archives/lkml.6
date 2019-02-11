Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D237EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DA020844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895297;
	bh=QqYLDnFkKbCcIisn7oG1nwxHsQvJUaMh11YeTUREB9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j81bvxFnTl8Rx4rCs7NhNC8wqVqKdyUyxpyd3E/VjDvpfY3IBlNUdUmQbNbtnUQgL
	 bov47sEzw9e9uTAwgbGEK7Q8q7uFUx2YId6agYClsq368OlDKli6TLRUWSHUxThysl
	 1F3wNrsYgQjrprK9kE9smJtaHGyDx6c1hxWRU7qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfBKO2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:28:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbfBKO2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:28:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200AF20821;
        Mon, 11 Feb 2019 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895284;
        bh=QqYLDnFkKbCcIisn7oG1nwxHsQvJUaMh11YeTUREB9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdaGbrcT6dC29tecDhqSAQOTQ1cwXQgRfdaUepbXhYH65L4+jpqTtLWlryYjdjSqi
         bDpPArsx/9yInwq7Z4zKzFc2EgsjMYXRsxpjuk6OJ3PH3frlVdx479a1BwwhN0GIJX
         ag3Rk0Gxg/eTaO6HLGYJo6zjn0WFNWJbocIwWRVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 155/352] i2c-axxia: check for error conditions first
Date:   Mon, 11 Feb 2019 15:16:22 +0100
Message-Id: <20190211141856.610062789@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 51d34959709b..fb5bac079e83 100644
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



