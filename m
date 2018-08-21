Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1419CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EE1217C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EE1217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeHUSXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:23:16 -0400
Received: from sauhun.de ([88.99.104.3]:42422 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbeHUSXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:23:16 -0400
Received: from localhost (p54B3375F.dip0.t-ipconnect.de [84.179.55.95])
        by pokefinder.org (Postfix) with ESMTPSA id 97D972D8F93;
        Tue, 21 Aug 2018 17:02:43 +0200 (CEST)
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] macintosh: therm_windtunnel: drop using attach_adapter
Date:   Tue, 21 Aug 2018 17:02:39 +0200
Message-Id: <20180821150240.19964-2-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180821150240.19964-1-wsa@the-dreams.de>
References: <20180821150240.19964-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we now have deferred probing, we can use a custom mechanism and
finally get rid of the legacy interface from the i2c core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/macintosh/therm_windtunnel.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 68dcbcb4fc5b..8c744578122a 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -432,7 +432,6 @@ static struct i2c_driver g4fan_driver = {
 	.driver = {
 		.name	= "therm_windtunnel",
 	},
-	.attach_adapter = do_attach,
 	.probe		= do_probe,
 	.remove		= do_remove,
 	.id_table	= therm_windtunnel_id,
@@ -445,7 +444,29 @@ static struct i2c_driver g4fan_driver = {
 
 static int therm_of_probe(struct platform_device *dev)
 {
-	return i2c_add_driver( &g4fan_driver );
+	struct i2c_adapter *adap;
+	int ret, i = 0;
+
+	adap = i2c_get_adapter(0);
+	if (!adap)
+		return -EPROBE_DEFER;
+
+	ret = i2c_add_driver(&g4fan_driver);
+	if (ret) {
+		i2c_put_adapter(adap);
+		return ret;
+	}
+
+	/* We assume Macs have consecutive I2C bus numbers starting at 0 */
+	while (adap) {
+		do_attach(adap);
+		if (x.running)
+			return 0;
+		i2c_put_adapter(adap);
+		adap = i2c_get_adapter(++i);
+	}
+
+	return -ENODEV;
 }
 
 static int
-- 
2.11.0

