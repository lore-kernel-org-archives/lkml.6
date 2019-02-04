Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D752C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AC52082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="re3rzPlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfBDUTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:19:36 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40394 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfBDUTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:19:33 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so2903677ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=XDhprpW25ibYQtXn/diyTm923UlnRp+IEFM44smCoIQ=;
        b=re3rzPlLyL0O9k2gcpHK7yxBTUrO9Aa1v67GpOgvI5DJoVXXYE50ShdSMq+TmReMPr
         FU0EAVpBeEnq7WAmhSKuVYG6EvlvFtWqbLpBxixHuotxTXaWFKJMBEWySFGfTFucxFlG
         66Us6Ix0PVZqg8dC7KdutrRHnBy8OSTdBplci4S7hBuGhX+cFzhfPP3Jmc8TPsybvFIo
         sfNS5G/KxPrC+qoI2iYaXgrveq1JEFtKJAYTYzmeijPPMEBvn3q/1e/BF3Wx9lYeL4OW
         v2Zqe8DKPn4ShWOj41eQp+6bsEaMFpQyAvVr0GhgNm6meobvxRJnBnbhAnlFbgN/0LEQ
         85BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=XDhprpW25ibYQtXn/diyTm923UlnRp+IEFM44smCoIQ=;
        b=TlS3WNW3Ui9tXYT15Fnc0H4Ta/yIqJjmMul8iDqkC0nc4VAFK2fYwvqGQ5Dh1e00CH
         TRxJ93s77FV1B89i8sM+nr1OQQYBs54aMaqiJ5nywpHipWHFvnQ11UIua3bUY7hKw4+o
         dmtz9b2iFx7EWj+7ethanN+H3Hf27sVRTm8vhtDV4w5/9QREhuBw7xT1xkDA8dQcEvxV
         bhIGpdpH8MDsnogBfPwQ71kaNU3TGItov5ikwMC34Qe5AaVhgZi2gJf3ytIvUBbac6zB
         POkzJcSLjdbyRvhDMKNIjjyJXC2TckqybM+VHTLHo6nGEP4rlA8yf5wZC0LCul3etLwv
         ImJg==
X-Gm-Message-State: AHQUAubdNyoJUmou9KVEY06x60kBiICH3NftsoxMixt21W/E8M7sTHwq
        2xbicNjXG5omnnYrULNT3z59Fw==
X-Google-Smtp-Source: AHgI3IbedeEYn+jG2jNNEn1fatbi8B0QrS5thMK38+OMLobx55GzhYweBcEM5kSWdzgC1NzO9mMEpw==
X-Received: by 2002:a5e:8f07:: with SMTP id c7mr871510iok.242.1549311572609;
        Mon, 04 Feb 2019 12:19:32 -0800 (PST)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id x79sm470003ita.34.2019.02.04.12.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:19:32 -0800 (PST)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] hwmon: (lm85) add support for LM96000 high frequencies
Date:   Mon,  4 Feb 2019 13:19:06 -0700
Message-Id: <20190204201906.8859-5-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204201906.8859-1-jgebben@sweptlaser.com>
References: <20190204201906.8859-1-jgebben@sweptlaser.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LM96000 expands the freqency field from 3 to 4 bits, to
add more frequencies in the 22.5 to 30 kHz ranges.

Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
---
 Documentation/hwmon/lm85 | 3 +++
 drivers/hwmon/lm85.c     | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/hwmon/lm85 b/Documentation/hwmon/lm85
index 4f531f4acc3f..2329c383efe4 100644
--- a/Documentation/hwmon/lm85
+++ b/Documentation/hwmon/lm85
@@ -140,6 +140,9 @@ of voltage and temperature channels.
 SMSC EMC6D103S is similar to EMC6D103, but does not support pwm#_auto_pwm_minctl
 and temp#_auto_temp_off.
 
+The LM96000 supports additional high frequency PWM modes (22.5 kHz, 24 kHz,
+25.7 kHz, 27.7 kHz and 30 kHz), which can be configured on a per-PWM basis.
+
 Hardware Configurations
 -----------------------
 
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index b23cf8e4c54b..a95d48316f06 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -202,6 +202,11 @@ static const int lm85_freq_map[] = { /* 1 Hz */
 	10, 15, 23, 30, 38, 47, 61, 94
 };
 
+static const int lm96000_freq_map[] = { /* 1 Hz */
+	10, 15, 23, 30, 38, 47, 61, 94,
+	22500, 24000, 25700, 25700, 27700, 27700, 30000, 30000
+};
+
 static const int adm1027_freq_map[] = { /* 1 Hz */
 	11, 15, 22, 29, 35, 44, 59, 88
 };
@@ -1574,6 +1579,10 @@ static int lm85_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		data->freq_map = adm1027_freq_map;
 		data->freq_map_size = ARRAY_SIZE(adm1027_freq_map);
 		break;
+	case lm96000:
+		data->freq_map = lm96000_freq_map;
+		data->freq_map_size = ARRAY_SIZE(lm96000_freq_map);
+		break;
 	default:
 		data->freq_map = lm85_freq_map;
 		data->freq_map_size = ARRAY_SIZE(lm85_freq_map);
-- 
2.17.1

