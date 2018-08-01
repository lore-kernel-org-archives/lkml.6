Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2913C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DA82083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DA82083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404302AbeHATDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:03:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404192AbeHATDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EBF82FA7;
        Wed,  1 Aug 2018 16:57:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eyal Reizer <eyalr@ti.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 099/336] wlcore: sdio: check for valid platform device data before suspend
Date:   Wed,  1 Aug 2018 18:47:14 +0200
Message-Id: <20180801165032.956034936@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Eyal Reizer <eyalreizer@gmail.com>

[ Upstream commit 6e91d48371e79862ea2c05867aaebe4afe55a865 ]

the wl pointer can be null In case only wlcore_sdio is probed while
no WiLink module is successfully probed, as in the case of mounting a
wl12xx module while using a device tree file configured with wl18xx
related settings.
In this case the system was crashing in wl1271_suspend() as platform
device data is not set.
Make sure wl the pointer is valid before using it.

Signed-off-by: Eyal Reizer <eyalr@ti.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ti/wlcore/sdio.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -406,6 +406,11 @@ static int wl1271_suspend(struct device
 	mmc_pm_flag_t sdio_flags;
 	int ret = 0;
 
+	if (!wl) {
+		dev_err(dev, "no wilink module was probed\n");
+		goto out;
+	}
+
 	dev_dbg(dev, "wl1271 suspend. wow_enabled: %d\n",
 		wl->wow_enabled);
 


