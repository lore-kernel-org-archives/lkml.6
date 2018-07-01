Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4825C6778D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCC525028
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCC525028
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeGALJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 07:09:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:47842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752292AbeGALJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 07:09:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA72CAF54;
        Sun,  1 Jul 2018 11:08:59 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     netdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC net-next 09/15] net: lora: Prepare EUI helpers
Date:   Sun,  1 Jul 2018 13:07:58 +0200
Message-Id: <20180701110804.32415-10-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be used by the RN2483 and other LoRaWAN capable modules.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 include/linux/lora/dev.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/lora/dev.h b/include/linux/lora/dev.h
index 531e68f0c9a6..153f9b2992ca 100644
--- a/include/linux/lora/dev.h
+++ b/include/linux/lora/dev.h
@@ -9,6 +9,27 @@
 
 #include <linux/netdevice.h>
 
+typedef u8 lora_eui[8];
+
+#define PRIxLORAEUI "%02x%02x%02x%02x%02x%02x%02x%02x"
+#define PRIXLORAEUI "%02X%02X%02X%02X%02X%02X%02X%02X"
+#define LORA_EUI(x) x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7]
+
+static inline int lora_strtoeui(const char *str, lora_eui *val)
+{
+        char buf[3];
+        int i, ret;
+
+        for (i = 0; i < 8; i++) {
+                strncpy(buf, str + i * 2, 2);
+                buf[2] = 0;
+                ret = kstrtou8(buf, 16, &(*val)[i]);
+                if (ret)
+                        return ret;
+        }
+        return 0;
+}
+
 struct net_device *alloc_loradev(int sizeof_priv);
 void free_loradev(struct net_device *dev);
 int register_loradev(struct net_device *dev);
-- 
2.16.4

