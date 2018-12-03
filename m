Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCCFC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07BE20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aYTFU2MZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07BE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeLCKQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:16:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39570 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeLCKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:16:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so2603731wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ENkdUwpMYIjikqqc1QhQM7T86CeGAWnXemUcHFbD02o=;
        b=aYTFU2MZ7/ghfls+aRabDUkSrsGcTIia9n7+ti02Ikl0zukh3A5R4+kPd/2PL9dVlB
         bVX28R9dBILXBboU99T758EvRQ64ucicqi4xbZOoPQA5xl4i9UJk2Jbr0oWzlYaAXKFE
         tBKfHjUHlUL1LsIpIe6D3i3HT+8bCZcuwP61U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENkdUwpMYIjikqqc1QhQM7T86CeGAWnXemUcHFbD02o=;
        b=SF3Qx159yyaMYpPTUMYSlrsyB2VnjW4aEqPa5WkIDCxygWdfECuY9bqzbA20cs1dAP
         uhIAKSnMn+CKB+Rqw0BMBPe/YEd5emvX/Uv3on2kcXwIIpFwnpIc3dJXA69BtZvuhrF9
         SDunE1TxhhvkmnEHtURso+lsVZNZa9gwelawsXX/rOvGOqOQdfDQ3gvB+IxEugnrSByU
         DO5nygvUy9VCKJkw7nBw2/SZhbUkrJ92Zfh4U/KoNasY+Qmf6FSN5npiY1BH2krCrFES
         U2LdABoa16WzB9jxEPfmYRAP1yY/aEyqHBdQ71g9Lkqc8XzVM0VC4gCOuD4vK+jED/DV
         vSlA==
X-Gm-Message-State: AA+aEWaLp8lAKzkvl5pIlTaaIHZ4s4L9bOY/MB+ugdl/EzBYFANcvMiw
        bGy0G60tBpzycbFrnfRRkByKGw==
X-Google-Smtp-Source: AFSGD/X7xfmFlqfllOFSoXoL/fsvUc05xC8M823dMGYQDptYklNoaRsVfRUi3/sznjvgXljdefiipw==
X-Received: by 2002:a1c:13d1:: with SMTP id 200mr4440666wmt.4.1543832164583;
        Mon, 03 Dec 2018 02:16:04 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:16:04 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 8/9] Input: goodix - Add GT5663 CTP support
Date:   Mon,  3 Dec 2018 15:45:46 +0530
Message-Id: <20181203101547.16835-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GT5663 is capacitive touch controller with customized smart wakeup gestures,
the existing goodix driver will work by phandle vcc-supply regulator.

So, add compatible for the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 7adcf1491609..0c09512bcdea 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -971,6 +971,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt1151" },
+	{ .compatible = "goodix,gt5663" },
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
 	{ .compatible = "goodix,gt912" },
-- 
2.18.0.321.gffc6fa0e3

