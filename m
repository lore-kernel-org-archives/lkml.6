Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E944FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB14F243FF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB14F243FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933754AbeFVOu1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:50:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54340 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933472AbeFVOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:50:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 066E0288FB8
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 2/2] dmaengine: imx-sdma: request firmware with FW_OPT_NO_WARN
Date:   Fri, 22 Jun 2018 16:49:51 +0200
Message-Id: <20180622144951.17464-3-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622144951.17464-1-sebastian.reichel@collabora.co.uk>
References: <20180622144951.17464-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request firmware with FW_OPT_NO_WARN. The driver works without the
firmware by using the one supplied in ROM. There is already an info
message, that informs about this.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/dma/imx-sdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f077992635c2..415ffe68ff77 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1599,11 +1599,13 @@ static int sdma_event_remap(struct sdma_engine *sdma)
 static int sdma_get_firmware(struct sdma_engine *sdma,
 		const char *fw_name)
 {
+	struct firmware_opts fw_opts = {
+		.optional = true,
+	};
 	int ret;
 
-	ret = request_firmware_nowait(THIS_MODULE,
-			FW_ACTION_HOTPLUG, fw_name, sdma->dev,
-			GFP_KERNEL, sdma, sdma_load_firmware);
+	ret = request_firmware_async(fw_name, &fw_opts, sdma->dev,
+				     sdma, sdma_load_firmware);
 
 	return ret;
 }
-- 
2.17.1

