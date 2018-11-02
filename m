Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99772C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A4E2084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC+kU64A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A4E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbeKCDtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbeKCDtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:49:40 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A12F720848;
        Fri,  2 Nov 2018 18:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184088;
        bh=83K4bLj193cTvynHQYkzBdlGebxnZteo3f/GjYMQW1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PC+kU64A2neVBKOr2gHuY1p7/YWfUwGJ0ZwtV4Tc5lmHn8C0Hxk/PQooOJMNUjy2n
         POz4ECTyj75SwNZvSEiW3dE5z2uETjsqkTp3zTRv7/DQe3qbElZ5zgHyTq8XbrOa8H
         t/9m5vUbdqMiu8Ddjoj+ZhxiZeXxYqX/YpteHgng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 075/150] libertas: call into generic suspend code before turning off power
Date:   Fri,  2 Nov 2018 19:33:57 +0100
Message-Id: <20181102182908.808342329@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



