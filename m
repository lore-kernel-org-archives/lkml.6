Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCCBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F39221523
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PAc8k7mv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F39221523
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeHPX32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:29:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39684 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeHPX32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:29:28 -0400
Received: by mail-pl0-f65.google.com with SMTP id w14-v6so2620863plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bOvOReGf7yVHhNU1ZeGyQl2H33R2y45ruh4KEVYJe8=;
        b=PAc8k7mvSxhs2ACYSRLLR8UEKlib42DjlZkaZZMa6MmV5G544D6Uwyzpv+QNdXvFfA
         RNX9Mu1hvunTEyvSWZssnD4Zyp8nPz7h1gd1WTk1yj5L4OyIaf/d65PQAwbw4GA9rw6F
         RG8MSBlo+P9suGTLtH7Kplmu7kft631kqjWK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bOvOReGf7yVHhNU1ZeGyQl2H33R2y45ruh4KEVYJe8=;
        b=N83vlylWsK4E5Ubrv7J2GjEFvipQUTePz3qQJv2LUFljxlFyWpKQIgAQDyac/6VSpD
         Q4zYN7kC09TuRJpjre5mLn7DPBQzVG2Yma0dIZT7iNXuaOohZfvfLVpjYlvwou321njx
         rgq/anMD+HRZe0nwenyUNPTWYptVuWmaqKm2CP5iJe6RAjONTlYEAI7lYFYjIGUBcecj
         KpsLOIECbpfqzNRYGmjp45TC25at4AL0L2NV9+7kbkhfgmgR2YW3DXT4XngJPfFOj5ae
         oquumtTP7fyFQBYZm9GMp6xu8ljaSB9a/aoDx1ZkNYF9xXUfoOSzD8GmfFh0yemu3NJ1
         PGkw==
X-Gm-Message-State: AOUpUlEC76gn36T4XKr0RDTGiXxVfJqmAc6PvVUl0kEjVTGKjeZ5N5YK
        qD0xQKpY1bnLGtAqb8t+WfJGsw==
X-Google-Smtp-Source: AA+uWPyrXqOXrxBBiJWTfhRU7LNOnE+G90kQa1h6+mQL2JmTt0KRLg0HbF5CW/Vi8e7VzKgv8rWnZw==
X-Received: by 2002:a17:902:262:: with SMTP id 89-v6mr30103651plc.221.1534451335302;
        Thu, 16 Aug 2018 13:28:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id t76-v6sm209647pfe.109.2018.08.16.13.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 13:28:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        collinsd@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] regulator: core: Add the opmode to regulator_summary
Date:   Thu, 16 Aug 2018 13:28:01 -0700
Message-Id: <20180816202803.250079-2-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180816202803.250079-1-dianders@chromium.org>
References: <20180816202803.250079-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's handy to know what opmode a regulator has been configured to in
the summary.  Add it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2: None

 drivers/regulator/core.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6ed568b96c0e..00e931da887a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -426,19 +426,24 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(name);
 
-static ssize_t regulator_print_opmode(char *buf, int mode)
+static const char *regulator_opmode_to_str(int mode)
 {
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
-		return sprintf(buf, "fast\n");
+		return "fast";
 	case REGULATOR_MODE_NORMAL:
-		return sprintf(buf, "normal\n");
+		return "normal";
 	case REGULATOR_MODE_IDLE:
-		return sprintf(buf, "idle\n");
+		return "idle";
 	case REGULATOR_MODE_STANDBY:
-		return sprintf(buf, "standby\n");
+		return "standby";
 	}
-	return sprintf(buf, "unknown\n");
+	return "unknown";
+}
+
+static ssize_t regulator_print_opmode(char *buf, int mode)
+{
+	return sprintf(buf, "%s\n", regulator_opmode_to_str(mode));
 }
 
 static ssize_t regulator_opmode_show(struct device *dev,
@@ -4660,10 +4665,11 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 	if (!rdev)
 		return;
 
-	seq_printf(s, "%*s%-*s %3d %4d %6d ",
+	seq_printf(s, "%*s%-*s %3d %4d %6d %7s ",
 		   level * 3 + 1, "",
 		   30 - level * 3, rdev_get_name(rdev),
-		   rdev->use_count, rdev->open_count, rdev->bypass_count);
+		   rdev->use_count, rdev->open_count, rdev->bypass_count,
+		   regulator_opmode_to_str(_regulator_get_mode(rdev)));
 
 	seq_printf(s, "%5dmV ", _regulator_get_voltage(rdev) / 1000);
 	seq_printf(s, "%5dmA ", _regulator_get_current_limit(rdev) / 1000);
@@ -4695,7 +4701,7 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 		switch (rdev->desc->type) {
 		case REGULATOR_VOLTAGE:
-			seq_printf(s, "%37dmV %5dmV",
+			seq_printf(s, "%45dmV %5dmV",
 				   consumer->voltage[PM_SUSPEND_ON].min_uV / 1000,
 				   consumer->voltage[PM_SUSPEND_ON].max_uV / 1000);
 			break;
@@ -4727,8 +4733,8 @@ static int regulator_summary_show_roots(struct device *dev, void *data)
 
 static int regulator_summary_show(struct seq_file *s, void *data)
 {
-	seq_puts(s, " regulator                      use open bypass voltage current     min     max\n");
-	seq_puts(s, "-------------------------------------------------------------------------------\n");
+	seq_puts(s, " regulator                      use open bypass  opmode voltage current     min     max\n");
+	seq_puts(s, "---------------------------------------------------------------------------------------\n");
 
 	class_for_each_device(&regulator_class, NULL, s,
 			      regulator_summary_show_roots);
-- 
2.18.0.865.gffc8e1a3cd6-goog

