Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936028AbeCHRih (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:38:37 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40569 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbeCHRiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:38:19 -0500
X-Google-Smtp-Source: AG47ELv8tXp/iuNdI9L7MDOHttAfBYLLZChbNpYo5BtqHI6pR3CMqc6dhPISkmm78B+HA6JwnvbZiQ==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/3] mfd: rave-sp: Check received frame length before accepting next byte
Date: Thu,  8 Mar 2018 09:37:56 -0800
Message-Id: <20180308173756.13787-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308173756.13787-1-andrew.smirnov@gmail.com>
References: <20180308173756.13787-1-andrew.smirnov@gmail.com>
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
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/mfd/rave-sp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 5c1442fa2308..7db1b32d61e2 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -546,8 +546,6 @@ static int rave_sp_receive_buf(struct serdev_device *serdev,
 			/* FALLTHROUGH */
 
 		case RAVE_SP_EXPECT_ESCAPED_DATA:
-			deframer->data[deframer->length++] = byte;
-
 			if (deframer->length == sizeof(deframer->data)) {
 				dev_warn(dev, "Bad frame: Too long\n");
 				/*
@@ -562,6 +560,8 @@ static int rave_sp_receive_buf(struct serdev_device *serdev,
 				goto reset_framer;
 			}
 
+			deframer->data[deframer->length++] = byte;
+
 			/*
 			 * We've extracted out special byte, now we
 			 * can go back to regular data collecting
-- 
2.14.3
