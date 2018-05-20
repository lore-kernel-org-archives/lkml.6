Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeETP4i (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 11:56:38 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43703 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeETP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 11:56:36 -0400
X-Google-Smtp-Source: AB8JxZqUMeGePHoEOv4OM9Wi/qOpWusWNtuEmuhwVihXvtX+GGgt3b+6PTwEGMzWz9zciCP19ASg6Q==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] net: dsa: b53: Extend platform data to include DSA ports
Date: Sun, 20 May 2018 08:56:30 -0700
Message-Id: <20180520155630.23432-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The b53 driver already defines and internally uses platform data to let the
glue drivers specify parameters such as the chip id.  What we were missing was
a way to tell the core DSA layer about the ports and their type.

Place a dsa_chip_data structure at the beginning of b53_platform_data for
dsa_register_switch() to access it. This does not require modifications to
b53_common.c which will pass platform_data trough.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- update commit message

 include/linux/platform_data/b53.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/platform_data/b53.h b/include/linux/platform_data/b53.h
index 69d279c0da96..8eaef2f2b691 100644
--- a/include/linux/platform_data/b53.h
+++ b/include/linux/platform_data/b53.h
@@ -20,8 +20,12 @@
 #define __B53_H
 
 #include <linux/kernel.h>
+#include <net/dsa.h>
 
 struct b53_platform_data {
+	/* Must be first such that dsa_register_switch() can access it */
+	struct dsa_chip_data cd;
+
 	u32 chip_id;
 	u16 enabled_ports;
 
-- 
2.14.1
