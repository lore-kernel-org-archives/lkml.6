Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D19CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0C8214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nCN3dmA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfA2NgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:36:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35621 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfA2NgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:36:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so22130544wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9B/EYyDjVhwtFa4eu+FJyKZCq3f87a75jGygGJDT3Ao=;
        b=nCN3dmA022fVoyzr3tJY2v7OxsMenYqoZp6x2FhnbQocJezj9XT6vKlEqRujl+LC1P
         HiL64LM4IoQ7TOQaMNMqCaLvwVhM4SOmoUXSudE87XDA2zpb8koqvYCVbL6TR0NWi+Kg
         msqqHzP2EkY81OFeQ/8NB9fW48t+CjumYe1Rv7eE/2i3UF64NXcfCIW8QnVNZhXb1NqA
         jbKJ5I5jbwzJDHKmzk+CzZx/Rsy8bFnKgsXy9OLAOszuKLT3HdJORWdGjXUtbXjhL6SG
         +RTdlYVu7TLZtK0g9LZCxeFhdLH1J6YPHBgI/k6f7fvBJBgxfHS6knD5+Igd4NxESlrz
         lWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9B/EYyDjVhwtFa4eu+FJyKZCq3f87a75jGygGJDT3Ao=;
        b=p2uyaXh23Jkp8cyJoRCk7XeavKbMnunW1JAT/5Qww8g3N9YU+YBHBNwO6MmVcs4BY6
         DskH2OE/TTyY2f86i2ch9jvtVCgy6++DsIj96j8BzrxObK965AKc0uX1J1tI9JuwkVzK
         buRfQ1nZH8KQ6+wPk3hTj0E/K+gh6kBnPBLXdTaawe2EEUU7nN37nFyb7rBmJeCVx0bp
         sGByxGJvSDj75nfFT7ssYsi6CmLTYzigCyWZ+UzdfWljpwGPdShpB5IVAEhb+G0soWBs
         EvEha8qSvxGDtHBALpLeFLlVOfHmVI/DLJ8c7ZXA3JVqfngI3QSOJ3VABF0hvMCqEMdF
         5OUQ==
X-Gm-Message-State: AJcUukdLVnaDxsfme5drLLBtcIfOVYjcQkH4Dvosw+9ALH9Oqf4pqxt1
        uhFm8pqAOZw01vU7HugUwpva+w==
X-Google-Smtp-Source: ALg8bN7U2cDDyyUMIAPvJromCa8gSWnM+Gg97gr9mIH0EAk+ERqoTTW6ngl78L4ob7Zr9JhvnvNmIQ==
X-Received: by 2002:adf:9123:: with SMTP id j32mr27275092wrj.122.1548768970770;
        Tue, 29 Jan 2019 05:36:10 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k128sm4367891wmd.37.2019.01.29.05.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:36:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 13/13] MAINTAINERS: add an entry for max77650 mfd driver
Date:   Tue, 29 Jan 2019 14:35:45 +0100
Message-Id: <20190129133545.1931-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129133545.1931-1-brgl@bgdev.pl>
References: <20190129133545.1931-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I plan on extending this set of drivers so add myself as maintainer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f64f8d3740e..d4032d94c275 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9221,6 +9221,20 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAXIM MAX77650 PMIC MFD DRIVER
+M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/*max77650.txt
+F:	Documentation/devicetree/bindings/*/max77650*.txt
+F:	include/linux/mfd/max77650.h
+F:	drivers/mfd/max77650.c
+F:	drivers/regulator/max77650-regulator.c
+F:	drivers/power/supply/max77650-charger.c
+F:	drivers/input/misc/max77650-onkey.c
+F:	drivers/leds/leds-max77650.c
+F:	drivers/gpio/gpio-max77650.c
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.20.1

