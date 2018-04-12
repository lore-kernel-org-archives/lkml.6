Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeDLQ5E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:57:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52737 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbeDLQ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:57:01 -0400
X-Google-Smtp-Source: AIpwx49CwEGE+2Us77Z94zRYn5KXynfxx6MT8HTt4rv3wZcHd7yUJOyOhXFLZGZPqCG+8AOg2cLMjg==
From: Andrey Konovalov <andreyknvl@google.com>
To: Samuel Ortiz <sameo@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] NFC: fix attrs checks in netlink interface
Date: Thu, 12 Apr 2018 18:56:56 +0200
Message-Id: <75ce3040b4086ffa2d2e088ad7f24f5e4a87be56.1523552145.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nfc_genl_deactivate_target() relies on the NFC_ATTR_TARGET_INDEX
attribute being present, but doesn't check whether it is actually
provided by the user. Same goes for nfc_genl_fw_download() and
NFC_ATTR_FIRMWARE_NAME.

This patch adds appropriate checks.

Found with syzkaller.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 net/nfc/netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index f018eafc2a0d..58adfb0c90f6 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -936,7 +936,8 @@ static int nfc_genl_deactivate_target(struct sk_buff *skb,
 	u32 device_idx, target_idx;
 	int rc;
 
-	if (!info->attrs[NFC_ATTR_DEVICE_INDEX])
+	if (!info->attrs[NFC_ATTR_DEVICE_INDEX] ||
+	    !info->attrs[NFC_ATTR_TARGET_INDEX])
 		return -EINVAL;
 
 	device_idx = nla_get_u32(info->attrs[NFC_ATTR_DEVICE_INDEX]);
@@ -1245,7 +1246,8 @@ static int nfc_genl_fw_download(struct sk_buff *skb, struct genl_info *info)
 	u32 idx;
 	char firmware_name[NFC_FIRMWARE_NAME_MAXSIZE + 1];
 
-	if (!info->attrs[NFC_ATTR_DEVICE_INDEX])
+	if (!info->attrs[NFC_ATTR_DEVICE_INDEX] ||
+	    !info->attrs[NFC_ATTR_FIRMWARE_NAME])
 		return -EINVAL;
 
 	idx = nla_get_u32(info->attrs[NFC_ATTR_DEVICE_INDEX]);
-- 
2.17.0.484.g0c8726318c-goog
