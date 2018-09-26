Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86923C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4829A20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4829A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeIZTE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:04:58 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeIZTE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:04:57 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mdvua-1fWMy40ave-00b02Y; Wed, 26 Sep 2018 14:51:30 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: ov9650: avoid maybe-uninitialized warnings
Date:   Wed, 26 Sep 2018 14:51:01 +0200
Message-Id: <20180926125127.2004280-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:aLqyWE4YSlZkupiUvPcnPMTz/l40VGp1bYyX96fDLKFfNcZn0sS
 WW8JuQFNIN2/KI5itgmpB3fAmklX/iSN+4hV/mBEq6yxdVNoljdqRtiylX9RmRYTOAWMGGG
 Qu9tdNbUCuob+3WT3LpK3yBf3UVsyGfWw1ZD63dpkyvI/47PHdi2adlkBWkezmtnwaSz21Z
 YSjaRRqyb9tpEj3p0uJjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SsXn2tsSk28=:mYsXTNi2a7Gu1jieleh0fW
 eS5jYty7KcpEBXqjVIGsTJOXe7xM89qsEkQsbwIf2sYw427TN0p0LdnGMQANHj4f8qlSNrAkN
 omGKSiray6n/NIsZ8rB+dBfiQUGAaXOCbRBJrIE08Wo4FV1vPPJSgCqKXyuFM52V1pIvS6xh5
 3cuY/38C3D56AQHBlRTi5FiTW1/bLs2SYuz8h+qyZEngIuqLBFF2jBrnv87aeKCkLX3uI5aR0
 i4KrJl5j/nEMtini/jQKYSB0HA/Ny8S9Mq/xgVh1UDITo8f2qG1SgyYY77OaDEPrXHR7hFC65
 dp4pMjbWTcgxrLA7jJazwFTGcNjrWD+YXXZwBXU2gHioH13/Jryp08FTRpmVs1zEGzwW1k0c+
 P5RpxW/HYdY64EtCexjokPoVaUCtqj3iTLe6vlZNqpEJH02sKSTBLxmrLxZ3P86FZn8W49tGI
 QxzZPBjCjxBFBMXF8dmyx7E8dxcsRRauYZKvMCuKSrShkVZXRZimwxSDy+vg97j85l8eWA3PQ
 8lD0kscwzAQP+8bjry5e7jPodXMzB9gSmrKs3PMQiCm12bcbkXOpSocbCMvS707ez4ywBc3m8
 8Eso1TumNIbqcvViEDxA0bJg2oLEdbfTwIMNEIs+HAGw1H6QMAEE8UzKl3CPUXSrOmo0DEHKt
 wRaou4n2v2EJ2TovB46wjfJNjFofqV7r5I/tvbp75rjfxLuWK82j/+JylVWKSR/XkLcY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap change causes multiple warnings like

drivers/media/i2c/ov9650.c: In function 'ov965x_g_volatile_ctrl':
drivers/media/i2c/ov9650.c:889:29: error: 'reg2' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   exposure = ((reg2 & 0x3f) << 10) | (reg1 << 2) |
              ~~~~~~~~~~~~~~~^~~~~~

It is apparently hard for the compiler to see here if ov965x_read()
returned successfully or not. Besides, we have a v4l2_dbg() statement
that prints an uninitialized value if regmap_read() fails.

Adding an 'else' clause avoids the ambiguity.

Fixes: 361f3803adfe ("media: ov9650: use SCCB regmap")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/i2c/ov9650.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov9650.c b/drivers/media/i2c/ov9650.c
index 3c9e6798d14b..77944da31de1 100644
--- a/drivers/media/i2c/ov9650.c
+++ b/drivers/media/i2c/ov9650.c
@@ -433,6 +433,8 @@ static int ov965x_read(struct ov965x *ov965x, u8 addr, u8 *val)
 	ret = regmap_read(ov965x->regmap, addr, &buf);
 	if (!ret)
 		*val = buf;
+        else
+                *val = -1;
 
 	v4l2_dbg(2, debug, &ov965x->sd, "%s: 0x%02x @ 0x%02x. (%d)\n",
 		 __func__, *val, addr, ret);
-- 
2.18.0

