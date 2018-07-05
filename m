Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1106EC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD21F240BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zj/KeAMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD21F240BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754033AbeGELjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:39:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38071 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753737AbeGELjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:39:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so10259425wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O9kG0fGGqvYa7x2/m/4KfdxoY9HZuUZWGw5LDIJGZII=;
        b=Zj/KeAMPui2iL6JhlCsFEOa1o/LitmD8pFQ9slrhw4dLrj9BWROA65iZbohxgQymjj
         x4fC6+bUQ16bwZu2jVxkZh6sUUxwXbJkMUsTCAM1CMoqq+HZBa94qlIt7UVbet1DD6jt
         xmy5iJIM14h87sTa0mOcax5i+k2FMteS4PjY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O9kG0fGGqvYa7x2/m/4KfdxoY9HZuUZWGw5LDIJGZII=;
        b=BFN6wVbCRKR6by+NPoDoFaN7yt+rmm8N9VkHH//rl6Gl42DUeqgXhjtBjxJt7PiFDy
         o43TPoCUewo4q6NeUkCvWW2l0iUv7b6emAwo38UUZAjuhOqxo1O7pCtWG12YVXOlZcsj
         F/ggLf57fR8ClgZCZXHKKrHziak3FOoKMPk+DhP3xJlB6T97ramkOGVHO8nEkQHJb147
         FeYncvuOZ9vUEv3Z7yd8qPGOmY2Bcv9k2ExJguC2/UzL2j+Y1QnqXuotDysdPIaS0QI4
         QZ7537XiydghrLSO1LWitBOnNOCC8I0GnNfOyqWkF80Rw4GR7YtJRTiIt+1Erd+/QG7D
         N2Jg==
X-Gm-Message-State: APt69E2ORWstenQta/gNMp3yLhnseYAq+4mA1eHg+I6JByyBlrS16UEf
        VwGhv1QB7KUuhMfdH5g3iU2qhA==
X-Google-Smtp-Source: AAOMgpfTQ8zd1+D3oGjGNkWFYfDmZEqY4Z2gDT8xDwNscxQ3zzPcdSHdrBuQ3c5sjzwhi18N0OjuNA==
X-Received: by 2002:a1c:cc08:: with SMTP id h8-v6mr3656758wmb.82.1530790743615;
        Thu, 05 Jul 2018 04:39:03 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x11-v6sm5731677wrm.78.2018.07.05.04.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 04:39:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] regmap: slimbus: add support to raw read/writes
Date:   Thu,  5 Jul 2018 12:37:00 +0100
Message-Id: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLIMbus supports upto 16 bytes in value management messages,
so add support to raw read/writes upto 16 bytes.

Also useful for paged register access on SLIMbus interfaced codecs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/base/regmap/regmap-slimbus.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
index 91d501eda8a9..fc07518666b2 100644
--- a/drivers/base/regmap/regmap-slimbus.c
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -31,11 +31,30 @@ static int regmap_slimbus_byte_reg_write(void *context, unsigned int reg,
 	return slim_writeb(sdev, reg, val);
 }
 
+static int regmap_slimbus_write(void *context, const void *data, size_t count)
+{
+	struct slim_device *sdev = context;
+
+	return slim_write(sdev, *(u16 *)data, count - 2, (u8 *)data + 2);
+}
+
+static int regmap_slimbus_read(void *context, const void *reg, size_t reg_size,
+			       void *val, size_t val_size)
+{
+	struct slim_device *sdev = context;
+
+	return slim_read(sdev, *(u16 *)reg, val_size, val);
+}
+
 static struct regmap_bus regmap_slimbus_bus = {
 	.reg_write = regmap_slimbus_byte_reg_write,
 	.reg_read = regmap_slimbus_byte_reg_read,
-	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
-	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.max_raw_write	= 16,
+	.max_raw_read	= 16,
+	.write = regmap_slimbus_write,
+	.read = regmap_slimbus_read,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 };
 
 static const struct regmap_bus *regmap_get_slimbus(struct slim_device *slim,
-- 
2.16.2

