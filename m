Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B622EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8394B204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8394B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJBRYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:24:50 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53460 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeJBRYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:24:50 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g7I82-0005XN-DR; Tue, 02 Oct 2018 11:42:10 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1g7I82-0002ld-2q; Tue, 02 Oct 2018 11:42:10 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] regmap: use less #ifdef for LOG_DEVICE
Date:   Tue,  2 Oct 2018 11:42:05 +0100
Message-Id: <20181002104205.10595-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the checking of the LOG_DEVICE into a function to reduce the
number of #ifdefs and  ensure more of the code gets compiled/checked,
and make it easier to change this for internal debugging purposes
(such as checking >1 device).

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/base/regmap/regmap.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0360a90ad6b6..0d9ad7c07d51 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -35,6 +35,16 @@
  */
 #undef LOG_DEVICE
 
+#ifdef LOG_DEVICE
+static inline bool regmap_should_log(struct regmap *map)
+{
+	return (map->dev && strcmp(dev_name(map->dev), LOG_DEVICE) == 0);
+}
+#else
+static inline bool regmap_should_log(struct regmap *map) { return false; }
+#endif
+
+
 static int _regmap_update_bits(struct regmap *map, unsigned int reg,
 			       unsigned int mask, unsigned int val,
 			       bool *change, bool force_write);
@@ -1755,10 +1765,8 @@ int _regmap_write(struct regmap *map, unsigned int reg,
 		}
 	}
 
-#ifdef LOG_DEVICE
-	if (map->dev && strcmp(dev_name(map->dev), LOG_DEVICE) == 0)
+	if (regmap_should_log(map))
 		dev_info(map->dev, "%x <= %x\n", reg, val);
-#endif
 
 	trace_regmap_reg_write(map, reg, val);
 
@@ -2450,10 +2458,8 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
 
 	ret = map->reg_read(context, reg, val);
 	if (ret == 0) {
-#ifdef LOG_DEVICE
-		if (map->dev && strcmp(dev_name(map->dev), LOG_DEVICE) == 0)
+		if (regmap_should_log(map))
 			dev_info(map->dev, "%x => %x\n", reg, *val);
-#endif
 
 		trace_regmap_reg_read(map, reg, *val);
 
-- 
2.19.0

