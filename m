Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CCCECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7172086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ksb3gIPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7172086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeIQKtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:49:35 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:40190 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbeIQKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rmr8r/dvg5zBfzVzBC6i7VTPg85Egzw2u+whUMYD8Oc=; b=ksb3gIPgbAQi0oL1iCZk+LwADH
        b5jjVmNTUkTp5lzG50Bfu2V7b0+vh03kbeWhHadu/+GZWt6uARMyMP+h3CeIA76dFilf1bj03J/wi
        PEw7BAl51GL0/eVGpiZV0AbpXq60iavoqAN+4B+e1hM8JEm5HNFoSwNcct231e+dbVRM=;
Received: from p200300ccfbca24001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbca:2400:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g1m0g-0006W0-3k; Mon, 17 Sep 2018 07:23:46 +0200
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g1m0f-0003Gz-Rk; Mon, 17 Sep 2018 07:23:45 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     kishon@ti.com, lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        daniel.thompson@linaro.org, wsa@the-dreams.de,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RESEND] phy: phy-twl4030-usb: fix denied runtime access
Date:   Mon, 17 Sep 2018 07:22:54 +0200
Message-Id: <20180917052254.12336-1-andreas@kemnade.info>
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

