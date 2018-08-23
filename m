Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF27C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AC92150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3AC92150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeHXA4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:56:12 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:53168 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeHXA4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:56:12 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id SlQd1y0013XaVaC06lQdPb; Thu, 23 Aug 2018 23:24:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fsx5p-0005i0-0E; Thu, 23 Aug 2018 23:24:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fsx5o-0004Xu-Um; Thu, 23 Aug 2018 23:24:36 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] iio: light: isl29501: Simplify code to kill compiler warning
Date:   Thu, 23 Aug 2018 23:24:35 +0200
Message-Id: <20180823212436.17423-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 4.1.2:

    drivers/iio/proximity/isl29501.c: In function ‘isl29501_register_write’:
    drivers/iio/proximity/isl29501.c:235: warning: ‘msb’ may be used uninitialized in this function

While this is a false positive, it can easily be avoided by removing the
"msb" intermediate variable.
Remove the "lsb" intermediate variable for consistency.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 drivers/iio/proximity/isl29501.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index e5e94540f404dd2c..5ae549075b27c50d 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -232,7 +232,6 @@ static u32 isl29501_register_write(struct isl29501_private *isl29501,
 				   u32 value)
 {
 	const struct isl29501_register_desc *reg = &isl29501_registers[name];
-	u8 msb, lsb;
 	int ret;
 
 	if (!reg->msb && value > U8_MAX)
@@ -241,22 +240,15 @@ static u32 isl29501_register_write(struct isl29501_private *isl29501,
 	if (value > U16_MAX)
 		return -ERANGE;
 
-	if (!reg->msb) {
-		lsb = value & 0xFF;
-	} else {
-		msb = (value >> 8) & 0xFF;
-		lsb = value & 0xFF;
-	}
-
 	mutex_lock(&isl29501->lock);
 	if (reg->msb) {
 		ret = i2c_smbus_write_byte_data(isl29501->client,
-						reg->msb, msb);
+						reg->msb, value >> 8);
 		if (ret < 0)
 			goto err;
 	}
 
-	ret = i2c_smbus_write_byte_data(isl29501->client, reg->lsb, lsb);
+	ret = i2c_smbus_write_byte_data(isl29501->client, reg->lsb, value);
 
 err:
 	mutex_unlock(&isl29501->lock);
-- 
2.17.1

