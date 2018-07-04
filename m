Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D97AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D9A240C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D9A240C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeGDQFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:05:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38598 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeGDQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:05:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 00E9028765C
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     andresx7@gmail.com, torvalds@linux-foundation.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 2/2] dmaengine: imx-sdma: request firmware with FW_OPT_NO_WARN
Date:   Wed,  4 Jul 2018 18:05:00 +0200
Message-Id: <20180704160500.22699-3-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704160500.22699-1-sebastian.reichel@collabora.co.uk>
References: <20180704160500.22699-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request firmware with FW_OPT_NO_WARN. The driver works without the
firmware by using the one supplied in ROM. There is already an info
message, that informs about this.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/dma/imx-sdma.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f077992635c2..68f7e5a2092f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1599,13 +1599,9 @@ static int sdma_event_remap(struct sdma_engine *sdma)
 static int sdma_get_firmware(struct sdma_engine *sdma,
 		const char *fw_name)
 {
-	int ret;
-
-	ret = request_firmware_nowait(THIS_MODULE,
-			FW_ACTION_HOTPLUG, fw_name, sdma->dev,
-			GFP_KERNEL, sdma, sdma_load_firmware);
-
-	return ret;
+	return request_firmware_nowait_nowarn(THIS_MODULE, FW_ACTION_HOTPLUG,
+					      fw_name, sdma->dev, GFP_KERNEL,
+					      sdma, sdma_load_firmware);
 }
 
 static int sdma_init(struct sdma_engine *sdma)
-- 
2.18.0

