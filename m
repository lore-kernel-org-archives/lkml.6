Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B670C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7E820895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7E820895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbeG0LLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:11:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0LLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:11:19 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7B094AF8;
        Fri, 27 Jul 2018 09:50:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.17 65/66] can: m_can: Fix runtime resume call
Date:   Fri, 27 Jul 2018 11:45:58 +0200
Message-Id: <20180727093816.339942023@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
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

From: Faiz Abbas <faiz_abbas@ti.com>

commit 1675bee3e732c2449e792feed9caff804f3bd42c upstream.

pm_runtime_get_sync() returns a 1 if the state of the device is already
'active'. This is not a failure case and should return a success.

Therefore fix error handling for pm_runtime_get_sync() call such that
it returns success when the value is 1.

Also cleanup the TODO for using runtime PM for sleep mode as that is
implemented.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Cc: <stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/m_can/m_can.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -634,10 +634,12 @@ static int m_can_clk_start(struct m_can_
 	int err;
 
 	err = pm_runtime_get_sync(priv->device);
-	if (err)
+	if (err < 0) {
 		pm_runtime_put_noidle(priv->device);
+		return err;
+	}
 
-	return err;
+	return 0;
 }
 
 static void m_can_clk_stop(struct m_can_priv *priv)
@@ -1687,8 +1689,6 @@ failed_ret:
 	return ret;
 }
 
-/* TODO: runtime PM with power down or sleep mode  */
-
 static __maybe_unused int m_can_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);


