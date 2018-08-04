Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31EFC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C0F217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C0F217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbeHDLHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:07:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49460 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeHDLHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:07:50 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DCC49BB3;
        Sat,  4 Aug 2018 09:07:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eyal Reizer <eyalr@ti.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 032/124] wlcore: sdio: check for valid platform device data before suspend
Date:   Sat,  4 Aug 2018 11:00:21 +0200
Message-Id: <20180804082703.639219270@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -388,6 +388,11 @@ static int wl1271_suspend(struct device
 	mmc_pm_flag_t sdio_flags;
 	int ret = 0;
 
+	if (!wl) {
+		dev_err(dev, "no wilink module was probed\n");
+		goto out;
+	}
+
 	dev_dbg(dev, "wl1271 suspend. wow_enabled: %d\n",
 		wl->wow_enabled);
 


