Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1652C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D5020868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dvl/HPIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D5020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeK3XCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:02:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43678 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeK3XCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:02:46 -0500
Received: by mail-ed1-f66.google.com with SMTP id f4so4591401edq.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2XBbpoddUxn8L0Ic4aH0nP9i4f9kF4ywqyELelq9lw=;
        b=Dvl/HPIxXglomNtTFiIuB3/vcmwltDNHsYyq2wT0HAf7NbL0u3FkwCajzVLbiCKM2i
         1aYYZXp46RO81oTqw4nZWlSsG4t+SRAiRumx7zGI5OVSixx9CHXHskuCbSk967jkdtvD
         epFSWXDnjwHp6jRk27RAujEoWBw1spMpGsveA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2XBbpoddUxn8L0Ic4aH0nP9i4f9kF4ywqyELelq9lw=;
        b=oyQaFERvedIT6c9VwkKAFX3NUWcOwaV+JXz00K6YfrVy/naCHu320O/5HSGVMyvCQU
         S3rWGuq2SnfMhEXcTcG81XwnycXRMJO1NUJ9SAoy1AGeUQ6t1zPFDr96yWIO3CR+JtYH
         gpiM+UTIgGmtnils6zq00hcY1+qBwmQRdeJGOO/XUacFFKW1MbVeQ+oVAnjAPk2IPCTI
         4rxhN6gzPwKwsBR6OaAxrsvAqdy3h7KeEcE/tSWHKzM3E+UJI66e/z4eNk3iingh+0UG
         cevcMjsUVWxRPByAisEnk380y8zqJEllxm4zt602uCisKwKZHkox4fE9shk9CHdd1ZUA
         f9DA==
X-Gm-Message-State: AA+aEWaMJl9T8TB4NN8Hzn+QC2qaaF5AuFrMD2sxsmmaiFQN1rAXzDWG
        86PlGflKZp1AGjGBMlNjzdMlNhWQH+k=
X-Google-Smtp-Source: AFSGD/UrvQmYfBPDNp8H1+HdKA0Kq4JR2/gdJkXD+8tY+/8cr1suq1QGrA8TyZrzJDCSCVVGBFR1CA==
X-Received: by 2002:aa7:dc51:: with SMTP id g17mr4882519edu.115.1543578822887;
        Fri, 30 Nov 2018 03:53:42 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t10-v6sm767932ejg.41.2018.11.30.03.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 03:53:42 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/6] nvmem: Move nvmem_type_str array to its only user
Date:   Fri, 30 Nov 2018 11:53:24 +0000
Message-Id: <20181130115325.16539-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
References: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since we put static variable to a header file it's copied to each module
that includes the header. But not all of them are actually using it.

Move nvmem_type_str array to its only user to make a compiler happy:

In file included from include/linux/rtc.h:18,
                 from drivers/rtc/rtc-proc.c:15:
include/linux/nvmem-provider.h:29:27: warning: 'nvmem_type_str'
defined but not used [-Wunused-const-variable=]
 static const char * const nvmem_type_str[] = {
                           ^~~~~~~~~~~~~~

Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Suggested-by: Joe Perches <joe@perches.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 7 +++++++
 include/linux/nvmem-provider.h | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d9fd11033c1c..22345e65a301 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -61,6 +61,13 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
+static const char * const nvmem_type_str[] = {
+	[NVMEM_TYPE_UNKNOWN] = "Unknown",
+	[NVMEM_TYPE_EEPROM] = "EEPROM",
+	[NVMEM_TYPE_OTP] = "OTP",
+	[NVMEM_TYPE_BATTERY_BACKED] = "Battery backed",
+};
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 00ff92571683..5b2dd0a987d2 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -26,13 +26,6 @@ enum nvmem_type {
 	NVMEM_TYPE_BATTERY_BACKED,
 };
 
-static const char * const nvmem_type_str[] = {
-	[NVMEM_TYPE_UNKNOWN] = "Unknown",
-	[NVMEM_TYPE_EEPROM] = "EEPROM",
-	[NVMEM_TYPE_OTP] = "OTP",
-	[NVMEM_TYPE_BATTERY_BACKED] = "Battery backed",
-};
-
 /**
  * struct nvmem_config - NVMEM device configuration
  *
-- 
2.19.2

