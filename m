Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id H+seHQJ6G1s7EQAAmS7hNA
	; Sat, 09 Jun 2018 06:58:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AF89B607E7; Sat,  9 Jun 2018 06:58:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="NfcsRwzf"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0C457601D3;
	Sat,  9 Jun 2018 06:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C457601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeFIG6Q (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:58:16 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46939 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752599AbeFIG6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:58:15 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so9463670pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uZBqoWtjjeUzY2076A/z+mJX2jdlBeb1CpwbvAQbF8Y=;
        b=NfcsRwzfOyY1M+2K10Ycdy7AWniusH97gOrTbHgtaoRAZ3cNx0IaA2bJSoiV7FNVY6
         HBKxdkD8QAoP1QSi7zoBL97gc8lqzpoCwq6MXfklp7gXyWR/g3jXWkXwPbS4drkOrUay
         UWFz5my7w+pqZSxrJdYaCjxl78zzW4O6CHAsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uZBqoWtjjeUzY2076A/z+mJX2jdlBeb1CpwbvAQbF8Y=;
        b=PMLxDrEcAfJ4hjbLBCTHYRjFifhJB/v30lJaEPZWTtYzlnA7JVZHjlWl2gZRSEObAr
         lQnli/ah8FhXsc3aOD574rbZR/5hKTKQ37th9FSdDTniJ5cHb4b7EI7OVYfulUPZApJZ
         /7sk1sT96PMbRA0wIdpmi2BWsFD5rXOMJTYRi/FiU4Fa/2DNR6R1JjmNPALj/8mmj4Y+
         8+h5j8kWq1zWdQ/xKaMvyuI1p/LaKBeLzVUCR5pY4wO7t5a69ond6jNCj34CkncCAMux
         T5LY9n/xntZkZl8W8N9U2BTNVhv7xZAg2CCAzX2byO3FnwhKvWot8kjo/Gh9gGehyCpz
         Pz9A==
X-Gm-Message-State: APt69E1t/umVT4H7pTZlYZbWykPDihedE3uHgY/WWSpQjJAghfncmJuI
        rtDBv211H6N1aSrG4d+V4vdXDDsQqy4=
X-Google-Smtp-Source: ADUXVKKDBHqh8+bi57zsQEoCBq/qAPuApi0IYTg9icRm5JXbVJW+5VOJqKiobYP5YBr6PISNR8ZC1Q==
X-Received: by 2002:a17:902:b786:: with SMTP id e6-v6mr9791709pls.260.1528527495223;
        Fri, 08 Jun 2018 23:58:15 -0700 (PDT)
Received: from niteshade.hsd1.or.comcast.net ([2601:1c2:5000:8d45::3f0e])
        by smtp.gmail.com with ESMTPSA id 9-v6sm40269427pfn.129.2018.06.08.23.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 23:58:14 -0700 (PDT)
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: linux-kernel@vger.kernel.org
Cc: Matt Ranostay <matt.ranostay@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] tsl2550: fix lux1_input error in low light
Date: Fri,  8 Jun 2018 23:58:15 -0700
Message-Id: <20180609065815.6005-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADC channel 0 photodiode detects both infrared + visible light,
but ADC channel 1 just detects infrared. However, the latter is a bit
more sensitive in that range so complete darkness or low light causes
a error condition in which the chan0 - chan1 is negative that
results in a -EAGAIN.

This patch changes the resulting lux1_input sysfs attribute message from
"Resource temporarily unavailable" to a user-grokable lux value of 0.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/misc/tsl2550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index adf46072cb37..3fce3b6a3624 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -177,7 +177,7 @@ static int tsl2550_calculate_lux(u8 ch0, u8 ch1)
 		} else
 			lux = 0;
 	else
-		return -EAGAIN;
+		return 0;
 
 	/* LUX range check */
 	return lux > TSL2550_MAX_LUX ? TSL2550_MAX_LUX : lux;
-- 
2.14.1
