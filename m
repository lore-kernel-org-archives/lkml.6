Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5441FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2281E206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896415;
	bh=HWW2Qlin36a+ztaKDzZwp1BoRxSiwU/9hMwqITUpR5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rqZYevBf0jy5AlXVQsmF8358J3rK/ig+0HvUDklOf2goTsw87uR7sWDIEAQ3VLMnp
	 Kegli19BShOe5Qydi/UNF2IJepr3UX0J4KfPOyB4oxtXxHCmy92CpgleZS/2MUtWu7
	 xJzK1Kl0g/UVR0dI4pBKfqu9GbmfiyEO6Wq/zizE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbfBKOqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732327AbfBKOqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:46:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03822206BA;
        Mon, 11 Feb 2019 14:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896412;
        bh=HWW2Qlin36a+ztaKDzZwp1BoRxSiwU/9hMwqITUpR5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zonnUTRaUCR5e1/wWpZG3IQXMl1neqrqG7Pct62JSIJwtnSI/OYm2UR0AxLKeb5AC
         EOlvRM7oc7G0ezEGcVgAnO2jgvf/TNb8uOuRedoRZPl4Kb3Vxn/SNINklSBB4MKBtn
         zCWtoZuIRIhbWu1PeI1jEf9oT+zm1zpsQE3hRD2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 175/313] Bluetooth: hci_bcm: Handle deferred probing for the clock supply
Date:   Mon, 11 Feb 2019 15:17:35 +0100
Message-Id: <20190211141905.075101991@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 28ac03b9ac3f784c2f048a910c8d0a7a87483b66 ]

On some systems that actually have the bluetooth controller wired up
with an extra clock signal, it's possible the bluetooth controller
probes before the clock provider. clk_get would return a defer probe
error, which was not handled by this driver.

Handle this properly, so that these systems can work reliably.

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_bcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbd8c6a0ceb..800132369134 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -907,6 +907,10 @@ static int bcm_get_resources(struct bcm_device *dev)
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
 
+	/* Handle deferred probing */
+	if (dev->clk == ERR_PTR(-EPROBE_DEFER))
+		return PTR_ERR(dev->clk);
+
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
-- 
2.19.1



