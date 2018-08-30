Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2607C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680F120835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JaMcNExf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680F120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeHaCAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:00:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40884 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeHaCAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:00:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id a13-v6so1788210pgt.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tK2RoHy+bNp5WpzedluyMhr/Pjp/ubfWGOtvCPwzdM8=;
        b=JaMcNExfzR3a3B5/j6veY2KNZfQQzGlsQC+edr+oSGklZafSKaQDbcH/Q2d1hBFpai
         YThbyNgIgqkSTh5f6gtNkePh7l8Z5nlZ20niM49ZWgBiINgaYyXvsi8SNNs9wgdbR6zQ
         bKHdl5g77z67mynTFoTdxPug0m6Y/8TbrpmQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tK2RoHy+bNp5WpzedluyMhr/Pjp/ubfWGOtvCPwzdM8=;
        b=ICNEUWfZX7dWanhs2ihZjJz+UR3ClIl7aln3ph6hf/b/9tMRTxKqM/0/FbbcsiNvzU
         dnaHTIKIoaJt0l5f73hYHG3ImkIZd0VpupPnNtQOT1A2ma9o7Od0h3aBROiuOAybmkuU
         HmyoeLP793VtE283AbDczddCIiGD5r86+iXjLoehKSLmcg9EHm4r82mfICIzxS3KMWHA
         BN/jA36BtIdKRSsjLPKr/S2Fm8nDNQ1mDHkbfUxzWLA/G5zan0Td8311ij6rqJf5O2m1
         eiINZVadco7QOYehdrOUxN/XmHUI/LDNTyTPOlhzBjiDyKO07WpOOZ2NdKzNMe/7dysr
         0zOQ==
X-Gm-Message-State: APzg51AEYmU5ZogFnB/H7zNRipI4Il5a1M+B30IOOkWxzDi/YdAF++MT
        yZFZaDVaTE6R0iC/p9BB+xjkCQ==
X-Google-Smtp-Source: ANB0VdZzZ/3YCj9OmeIh8VBlM+TsByTe2zlPdoJEFqYelQq8BG9V2hZad7PLvR0o62q0Ckl19kiiPA==
X-Received: by 2002:a62:4e56:: with SMTP id c83-v6mr12618749pfb.240.1535666190411;
        Thu, 30 Aug 2018 14:56:30 -0700 (PDT)
Received: from kolhar.mtv.corp.google.com ([2620:15c:202:201:356a:9de2:526a:5bc])
        by smtp.gmail.com with ESMTPSA id h132-v6sm13516828pfc.100.2018.08.30.14.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:56:29 -0700 (PDT)
From:   Harry Cutts <hcutts@chromium.org>
To:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jiri.kosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Harry Cutts <hcutts@chromium.org>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH v2 3/5] Add function to enable HID++ 1.0 "scrolling acceleration"
Date:   Thu, 30 Aug 2018 14:56:20 -0700
Message-Id: <20180830215622.47550-4-hcutts@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <20180830215622.47550-1-hcutts@chromium.org>
References: <20180830215622.47550-1-hcutts@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Scrolling acceleration" is a bit of a misnomer: it doesn't deal with
acceleration at all. However, that's the name used in Logitech's spec,
so I used it here.

Signed-off-by: Harry Cutts <hcutts@chromium.org>
---

Changes in v2: None

 drivers/hid/hid-logitech-hidpp.c | 47 +++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 19cc980eebce..7f8218f6ff56 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -400,32 +400,53 @@ static void hidpp_prefix_name(char **name, int name_length)
 #define HIDPP_SET_LONG_REGISTER				0x82
 #define HIDPP_GET_LONG_REGISTER				0x83
 
-#define HIDPP_REG_GENERAL				0x00
-
-static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
+/**
+ * hidpp10_set_register_bit() - Sets a single bit in a HID++ 1.0 register.
+ * @hidpp_dev: the device to set the register on.
+ * @register_address: the address of the register to modify.
+ * @byte: the byte of the register to modify. Should be less than 3.
+ * Return: 0 if successful, otherwise a negative error code.
+ */
+static int hidpp10_set_register_bit(struct hidpp_device *hidpp_dev,
+	u8 register_address, u8 byte, u8 bit)
 {
 	struct hidpp_report response;
 	int ret;
 	u8 params[3] = { 0 };
 
 	ret = hidpp_send_rap_command_sync(hidpp_dev,
-					REPORT_ID_HIDPP_SHORT,
-					HIDPP_GET_REGISTER,
-					HIDPP_REG_GENERAL,
-					NULL, 0, &response);
+					  REPORT_ID_HIDPP_SHORT,
+					  HIDPP_GET_REGISTER,
+					  register_address,
+					  NULL, 0, &response);
 	if (ret)
 		return ret;
 
 	memcpy(params, response.rap.params, 3);
 
-	/* Set the battery bit */
-	params[0] |= BIT(4);
+	params[byte] |= BIT(bit);
 
 	return hidpp_send_rap_command_sync(hidpp_dev,
-					REPORT_ID_HIDPP_SHORT,
-					HIDPP_SET_REGISTER,
-					HIDPP_REG_GENERAL,
-					params, 3, &response);
+					   REPORT_ID_HIDPP_SHORT,
+					   HIDPP_SET_REGISTER,
+					   register_address,
+					   params, 3, &response);
+}
+
+
+#define HIDPP_REG_GENERAL				0x00
+
+static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
+{
+	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_GENERAL, 0, 4);
+}
+
+#define HIDPP_REG_FEATURES				0x01
+
+/* On HID++ 1.0 devices, high-res scroll was called "scrolling acceleration". */
+static int hidpp10_enable_scrolling_acceleration(struct hidpp_device *hidpp_dev)
+{
+	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_FEATURES, 0, 6);
 }
 
 #define HIDPP_REG_BATTERY_STATUS			0x07
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

