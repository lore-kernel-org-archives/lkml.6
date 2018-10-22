Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76013C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD2020898
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi3TM7n4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD2020898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeJVSi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbeJVSiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:38:55 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D939320658;
        Mon, 22 Oct 2018 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203660;
        bh=ijc9cGwWEDGCIbbD7BBNddoPmpS7yhEs4dNYaSz/TQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gi3TM7n4OTR84vR6l5OffP74dIAfUe5N4D6vNfMIgrqGAN9taCAZJpybma+L9sHLK
         aW4q0JFjwfqhPHhMwnCUrKnrD3RZ+wDMgn9B6LhHrm5NFqTCF4Q9hasoMBJedgNCEt
         4M5xL+A6XzcPjqpO+DSdZ8XOfWMM/5AwzCinV/WI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 13/15] libertas: call into generic suspend code before turning off power
Date:   Mon, 22 Oct 2018 06:20:24 -0400
Message-Id: <20181022102026.40869-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022102026.40869-1-sashal@kernel.org>
References: <20181022102026.40869-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Mack <daniel@zonque.org>

[ Upstream commit 4f666675cdff0b986195413215eb062b7da6586f ]

When powering down a SDIO connected card during suspend, make sure to call
into the generic lbs_suspend() function before pulling the plug. This will
make sure the card is successfully deregistered from the system to avoid
communication to the card starving out.

Fixes: 7444a8092906 ("libertas: fix suspend and resume for SDIO connected cards")
Signed-off-by: Daniel Mack <daniel@zonque.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/libertas/if_sdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c b/drivers/net/wireless/marvell/libertas/if_sdio.c
index 43743c26c071..39bf85d0ade0 100644
--- a/drivers/net/wireless/marvell/libertas/if_sdio.c
+++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
@@ -1317,6 +1317,10 @@ static int if_sdio_suspend(struct device *dev)
 	if (priv->wol_criteria == EHS_REMOVE_WAKEUP) {
 		dev_info(dev, "Suspend without wake params -- powering down card\n");
 		if (priv->fw_ready) {
+			ret = lbs_suspend(priv);
+			if (ret)
+				return ret;
+
 			priv->power_up_on_resume = true;
 			if_sdio_power_off(card);
 		}
-- 
2.17.1

