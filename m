Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D94C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C2E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543190;
	bh=4CSWEAdwlDSXtIyWdtY+XhwrZcKqNlBD4l8pUUH/0s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Edj4BZbXKjgqi23oNhVR9Fg140fkxVBEiKUGMiphNl6rH4qMR2vML1fwCVksU6s/P
	 CDVKNezXPeAK42ZgxwPvuYEHIt/hW6bHSZZF903gbgPbUAClYMOX1/XN8rginxgYkT
	 jZJ3wrVStoSCBqbveoZQ1mfwXsbOO4Nybl+V9sWM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C2E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeLKPq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:46:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbeLKPq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5B32208E7;
        Tue, 11 Dec 2018 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543186;
        bh=4CSWEAdwlDSXtIyWdtY+XhwrZcKqNlBD4l8pUUH/0s0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WvNhYkX80jfYP90HYDN/IZ5MFftY43le0+grB/efZ46qYiW4RddmVisH2DMIE5mlF
         ue5i/9AcGQlNjDaGMhbHsmu2pbZjqxjujDlStsSjyC2lVxxZiF5Kj40dISh2kdp3WG
         7s2cpot4D1YVl8SBLRXHL1IY2csVldLaic6MqWe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.4 44/91] leds: leds-gpio: Fix return value check in create_gpio_led()
Date:   Tue, 11 Dec 2018 16:41:03 +0100
Message-Id: <20181211151609.585460748@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

commit 2d88a331e48095cf60ad9bdf3177bd401bf99727 upstream.

In case of error, the function gpio_to_desc() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/leds-gpio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -118,8 +118,8 @@ static int create_gpio_led(const struct
 			return ret;
 
 		led_dat->gpiod = gpio_to_desc(template->gpio);
-		if (IS_ERR(led_dat->gpiod))
-			return PTR_ERR(led_dat->gpiod);
+		if (!led_dat->gpiod)
+			return -EINVAL;
 	}
 
 	led_dat->cdev.name = template->name;


