Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C50C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3325208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="CplMJ+Kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3325208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeH0Xgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:36:31 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:43660 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeH0Xgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rmr8r/dvg5zBfzVzBC6i7VTPg85Egzw2u+whUMYD8Oc=; b=CplMJ+Khlytg1LbTN34mcvdbcT
        BJAkMhkOI6oNxHmQdROyMY9ylvZ7Wy6jwdWWlNYI22MhKOQEhxJjBuvw/d78Fr3rZjHAp3XVg1koJ
        FzJ48ZhCeUYHsKWgGS337cLiEwZLEqq1hiz0c54PLcMoecS1efJu2Z9N71rHKwlXFs9Y=;
Received: from p200300ccfbc7a8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbc7:a800:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1fuNUu-0003EA-Qx; Mon, 27 Aug 2018 21:48:24 +0200
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1fuNUu-0005Fu-Fc; Mon, 27 Aug 2018 21:48:24 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     kishon@ti.com, lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        daniel.thompson@linaro.org, wsa@the-dreams.de,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] phy: phy-twl4030-usb: fix denied runtime access
Date:   Mon, 27 Aug 2018 21:48:05 +0200
Message-Id: <20180827194805.20139-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
the counter will be incremented but the resume callback not called,
so enumeration and charging will not start properly.
To avoid that happen, wait and try again later.

Practically this happens when the device is woken up from suspend by
plugging in usb.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/phy/ti/phy-twl4030-usb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
index a44680d64f9b..1f3cf4e48383 100644
--- a/drivers/phy/ti/phy-twl4030-usb.c
+++ b/drivers/phy/ti/phy-twl4030-usb.c
@@ -552,6 +552,15 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 
 	status = twl4030_usb_linkstat(twl);
 
+	/* we might get here too early when runtime is not ready yet
+	 * and we will get an EACCESS later, so try again later
+	 */
+	if (!pm_runtime_enabled(twl->dev)) {
+		cancel_delayed_work(&twl->id_workaround_work);
+		schedule_delayed_work(&twl->id_workaround_work, HZ);
+		return IRQ_HANDLED;
+	}
+
 	mutex_lock(&twl->lock);
 	if (status >= 0 && status != twl->linkstat) {
 		status_changed =
-- 
2.11.0

