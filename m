Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F226CC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD3A2184C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfAFIiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:38:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:57230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726529AbfAFIiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:38:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74E53AD17;
        Sun,  6 Jan 2019 08:38:04 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH lora-next 06/11] net: lora: sx130x: Force regmap field write before sleep
Date:   Sun,  6 Jan 2019 09:37:49 +0100
Message-Id: <20190106083754.6004-7-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190106083754.6004-1-afaerber@suse.de>
References: <20190106083754.6004-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure timing is as expected by forcing a register write before waiting on
its outcome.

Cc: Ben Whitten <ben.whitten@gmail.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/sx130x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 457f2396d9ee..bc2d4b1165d8 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -692,7 +692,7 @@ int sx130x_probe(struct device *dev)
 		return ret;
 	}
 
-	ret = sx130x_field_write(priv, F_RADIO_B_EN, 1);
+	ret = sx130x_field_force_write(priv, F_RADIO_B_EN, 1);
 	if (ret) {
 		dev_err(dev, "radio B enable failed (%d)\n", ret);
 		return ret;
-- 
2.16.4

