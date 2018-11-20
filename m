Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55362C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E377E214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E377E214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeKUGhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:37:48 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:56127 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725977AbeKUGhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:37:48 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from lsun@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 20 Nov 2018 22:12:36 +0200
Received: from bu-lab53.mtbu.labs.mlnx (bu-lab53.mtbu.labs.mlnx [10.15.8.107])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id wAKK6r3h019779;
        Tue, 20 Nov 2018 22:06:53 +0200
Received: from bu-lab53.mtbu.labs.mlnx (localhost [127.0.0.1])
        by bu-lab53.mtbu.labs.mlnx (8.14.7/8.14.7) with ESMTP id wAKK6ra3090011;
        Tue, 20 Nov 2018 15:06:53 -0500
Received: (from lsun@localhost)
        by bu-lab53.mtbu.labs.mlnx (8.14.7/8.14.7/Submit) id wAKK6qjJ090010;
        Tue, 20 Nov 2018 15:06:52 -0500
From:   Liming Sun <lsun@mellanox.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        David Woods <dwoods@mellanox.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] mmc: core: control EXT_CSD_CACHE_CTRL from device tree
Date:   Tue, 20 Nov 2018 15:06:39 -0500
Message-Id: <c0e11e0a23fbb6b9867963c4b143fcb1c60b403c.1542744186.git.lsun@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the EXT_CSD_CACHE_CTRL register is controlled by API
mmc_card_broken_hpi(), which only works for the quirks settings.
This commit enhances it to use card->ext_csd.hpi instead. This
flag works for both the quirks and the broken-hpi configuration
in the device tree.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/mmc/core/mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index bc1bd2c..2f2b65c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1791,8 +1791,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 * If cache size is higher than 0, this indicates
 	 * the existence of cache and it can be turned on.
 	 */
-	if (!mmc_card_broken_hpi(card) &&
-	    card->ext_csd.cache_size > 0) {
+	if (card->ext_csd.hpi && card->ext_csd.cache_size > 0) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				EXT_CSD_CACHE_CTRL, 1,
 				card->ext_csd.generic_cmd6_time);
-- 
1.8.3.1

