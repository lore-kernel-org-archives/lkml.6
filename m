Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754037AbeBZPIB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:08:01 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46039 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754322AbeBZPH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:07:56 -0500
X-Google-Smtp-Source: AH8x226iB6/TgkqOcbqj8s2CNZr54XkdweHIoZijnTKVMVhcrX2syPYwwiPy0pRaMsh9M5xMFYlPOA==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/3] mfd: rave-sp: Check received frame length before accepting next byte
Date: Mon, 26 Feb 2018 07:07:39 -0800
Message-Id: <20180226150739.13457-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180226150739.13457-1-andrew.smirnov@gmail.com>
References: <20180226150739.13457-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check received frame length _before_ accepting next byte in order to
avoid incorrectly rejecting payloads that are RAVE_SP_RX_BUFFER_SIZE
long.

Cc: linux-kernel@vger.kernel.org
Cc: cphealy@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/mfd/rave-sp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index cec1e309b31f..76fa32006a1b 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -548,8 +548,6 @@ static int rave_sp_receive_buf(struct serdev_device *serdev,
 			/* FALLTHROUGH */
 
 		case RAVE_SP_EXPECT_ESCAPED_DATA:
-			deframer->data[deframer->length++] = byte;
-
 			if (deframer->length == sizeof(deframer->data)) {
 				dev_warn(dev, "Bad frame: Too long\n");
 				/*
@@ -564,6 +562,8 @@ static int rave_sp_receive_buf(struct serdev_device *serdev,
 				goto reset_framer;
 			}
 
+			deframer->data[deframer->length++] = byte;
+
 			/*
 			 * We've extracted out special byte, now we
 			 * can go back to regular data collecting
-- 
2.14.3
