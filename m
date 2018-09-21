Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEBCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEC220858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdC4Sc3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEC220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389781AbeIUQY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:24:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46190 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUQY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:24:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id k14-v6so10302012edr.13;
        Fri, 21 Sep 2018 03:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6fncp2wBKiaAhFqes5VbfWoYDTuWvL2B06DeOxEt5SM=;
        b=SdC4Sc3c1H+O8OJTrSmV9MNm9SmoO/lrebyfMRX9FWmHF8czXdSYPIQZPJxb4SldoD
         CL1Wo7PGKxAzY+4RcBxmvfMXaov3brxpQ8ht+aQtzSrzfm1ANllzJuhV3HLXDPZEbegq
         78QA/beyhhcYkbI0BL4IGU0pY/IWl3YW8s58aLDHyR7IiSPVNsCseAbJJJ8tdiW2we1c
         FmUPU4hVlquDneN3wfopugIW0iCz7T8WVoAwJdWfaSiPrw0cDTlJK1RwLVdGXIxiqGzt
         PQk91lBjqnWLybGEJCkGYtibZnUgrBwtPNnUf/HPvRKugiIjDtsetmuBtbs41i9A1ZuC
         scRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6fncp2wBKiaAhFqes5VbfWoYDTuWvL2B06DeOxEt5SM=;
        b=IfJ/m2y6/6DpgOXfJbJdeyfjFZWifx8l62WEWs8n17piIWMsXwewXYw/RMzcOhl2V1
         iyTDLkDXBsWbWX97pUDf6m2k1+xqGxU8uZzHsyf/UArddvJrkRJgr3V3/NONYk4h6V3J
         1iiI+Q97I38To9sZbLA7S0og0nFOv+HUxYTLaSRmqdQDRFJyROIs0g259aR802iFSFGt
         DBgDblsjyz2UsG9buPq5D0GLTzmty/WnaRVbqU+4B3UZWeqNf9s86J9zPWWcEGcqCLHZ
         uEJnKFe4Ft4JOQE3SPLavu2iG84H083XkviqPKLQX+4Ji2AMJsEKG8lA1mT3+t/Y5UHU
         8gVw==
X-Gm-Message-State: APzg51C6uZ9PDeBYIOCLf8OgFh+zKQKtHoZb8FAkyrH0xF1JoYze0ubv
        PmTDfIN1FqyV1C+uyhFvwA0=
X-Google-Smtp-Source: ANB0VdaMYaqVZYfnfcbwYllJrScMAXrUOTKp8YNY7WGqsdaa/s1BmCin6FP11AiWAEt5Wh2yp3BMpQ==
X-Received: by 2002:a50:8345:: with SMTP id 63-v6mr10583836edh.5.1537526168721;
        Fri, 21 Sep 2018 03:36:08 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id k28-v6sm1900871ede.11.2018.09.21.03.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 03:36:07 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@codeaurora.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2] gpiolib: Show correct direction from the beginning
Date:   Fri, 21 Sep 2018 12:36:04 +0200
Message-Id: <20180921103604.13361-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code assumes that the direction is input if direction_input
function is set.
This might not be the case on GPIOs with programmable direction.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/gpio/gpiolib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4b45de883ada..00c17f64d9ff 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1352,7 +1352,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 		 * it does, and in case chip->get_direction is not set, we may
 		 * expose the wrong direction in sysfs.
 		 */
-		desc->flags = !chip->direction_input ? (1 << FLAG_IS_OUT) : 0;
+		if (chip->get_direction && gpiochip_line_is_valid(chip, i))
+			desc->flags = !chip->get_direction(chip, i) ?
+					(1 << FLAG_IS_OUT) : 0;
+		else
+			desc->flags = !chip->direction_input ?
+					(1 << FLAG_IS_OUT) : 0;
 	}
 
 #ifdef CONFIG_PINCTRL
-- 
2.18.0

