Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AA8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E793B2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="UnJ2bqte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E793B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeLJOZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:25:49 -0500
Received: from mout01.posteo.de ([185.67.36.65]:58577 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727396AbeLJOZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:25:49 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 58EE4160062
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 15:25:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1544451946; bh=ZbdLLynQFF4YAxEpdc4KubVeNp+GKs+sQWGzNGrKTr0=;
        h=From:To:Cc:Subject:Date:From;
        b=UnJ2bqteHT6GAKQyad+nhF2ClOPeA4nhJ/NiuLdiCVQrA83/YkEGuRhnLZ84OhKE6
         yVS66ylzh21yQiHbBKsSJjEcXMdnclLhqQQoq8Oht5WluOhvTB6Ukaywq4VUXKVvAd
         TgdyLWj/NorToVQqOOz1loeC8QaYHrZ9KFpFiLjy7t0l78stbs279UxHrj8dMoWItQ
         qsl0KtRHAJHTFIcNkLV+v33cRTZxGMi3s5hpg2qt2duh4S6nLAXnOxxTzYmWM+HLOh
         HmQ5sZMg+faBcBSUobWRLPEV7aPFTPRInRNglYtTmeZxqQ6RP44/fbFi3wghxuVrRY
         fRzviDmUMZbrw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43D52w6vsmz6tmK;
        Mon, 10 Dec 2018 15:25:44 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] iio: accel: mma9551_core: prevent using uninitialized variable
Date:   Mon, 10 Dec 2018 15:25:32 +0100
Message-Id: <20181210142532.15315-1-martink@posteo.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mma9551_gpio_config()'s switch statement sets the uninitialized pol_mask
variable but doesn't have default settings. Said function can therefore
be called in a way to use the uninitialized variable (at least in case
enum mma9551_gpio_pin is extended with unhandled values).

While things should be fine now, this initializes pol_mask just to prevent
failure.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/iio/accel/mma9551_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index c34c5ce8123b..2fc79b14888b 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -539,7 +539,8 @@ EXPORT_SYMBOL(mma9551_update_config_bits);
 int mma9551_gpio_config(struct i2c_client *client, enum mma9551_gpio_pin pin,
 			u8 app_id, u8 bitnum, int polarity)
 {
-	u8 reg, pol_mask, pol_val;
+	u8 reg, pol_val;
+	u8 pol_mask = 0;
 	int ret;
 
 	if (pin > mma9551_gpio_max) {
-- 
2.11.0

