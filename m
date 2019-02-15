Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1370C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A960621B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbfBOF7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:59:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34675 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725838AbfBOF7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:59:49 -0500
X-UUID: 8a88d074445a4cbe87fd0e0d23c7ef5f-20190215
X-UUID: 8a88d074445a4cbe87fd0e0d23c7ef5f-20190215
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1260798123; Fri, 15 Feb 2019 13:59:42 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 13:59:40 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Feb 2019 13:59:40 +0800
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v2 1/2] mmc: core: do not retry CMD6 in __mmc_switch()
Date:   Fri, 15 Feb 2019 13:59:34 +0800
Message-ID: <1550210375-32270-2-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
References: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the response type of CMD6 is R1B, when the first CMD6 gets response
CRC error, do retry may get timeout error due to card may still in
busy state, which cause this retry make no sense.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 9054329..c5208fb 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -562,7 +562,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	if (index == EXT_CSD_SANITIZE_START)
 		cmd.sanitize_busy = true;
 
-	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err)
 		goto out;
 
-- 
1.8.1.1.dirty

