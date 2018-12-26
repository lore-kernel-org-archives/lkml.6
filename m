Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A607218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeLZVLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:11:09 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.130]:22864 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728189AbeLZVLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:11:09 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 6DD3F108EE3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 15:11:08 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id cGSKghUNjiQercGSKglcIF; Wed, 26 Dec 2018 15:11:08 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.104] (port=54028 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gcGSJ-003Bzu-I8; Wed, 26 Dec 2018 15:11:07 -0600
Date:   Wed, 26 Dec 2018 15:11:06 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: xlnx: fix error handling in xlnx_formatter_pcm_probe
Message-ID: <20181226211106.GA16692@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.104
X-Source-L: No
X-Exim-ID: 1gcGSJ-003Bzu-I8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.104]:54028
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if platform_get_irq_byname() fails, the returned error
turns into a huge value, once it is being store into a variable
of type unsigned int, hence never actually reporting any error
and causing unexpected behavior when using the values stored
in aud_drv_data->s2mm_irq and aud_drv_data->mm2s_irq.

Fix this by changing the type of variables s2mm_irq and mm2s_irq in
structure xlnx_pcm_drv_data from unsigned int to int.

Addresses-Coverity-ID: 1476096 ("Unsigned compared against 0")
Fixes: 796175a94a7f ("ASoC: xlnx: add pcm formatter platform driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/xilinx/xlnx_formatter_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index f7235f7664d7..d2194da928e7 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -76,8 +76,8 @@ struct xlnx_pcm_drv_data {
 	void __iomem *mmio;
 	bool s2mm_presence;
 	bool mm2s_presence;
-	unsigned int s2mm_irq;
-	unsigned int mm2s_irq;
+	int s2mm_irq;
+	int mm2s_irq;
 	struct snd_pcm_substream *play_stream;
 	struct snd_pcm_substream *capture_stream;
 	struct clk *axi_clk;
-- 
2.20.1

