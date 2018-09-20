Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C411ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B172147C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+pvBrdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B172147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388622AbeIUCdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:33:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45539 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:33:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id r4-v6so9567616lff.12;
        Thu, 20 Sep 2018 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N/Wj/Ce31UHtgG56wu9+wBfD+B1MQY3nPhNgA+c5JMY=;
        b=i+pvBrdJwCDe7rpdzFN6Q0aQvDlSpGftOS9U3vIlhn24Rl9C+VcqFZTrrHRP3MmBGL
         N2T/SszVShjB0TZpZBudFkcPAve0Nj+gY9rZsSY9jq3SF7FwUN3958TicDMxxPclqbOx
         cet0MDP/L4z20DzXlSXN7Z1YtZWY2KurEOdWbROT9a6KEgmA0ZZ/J7Gh7ndXuoD/qEfr
         MavwiofMNYH7JzavuiJJv4qXxhzCftL3k1e6QjOz6h1M8LV6SKE/RzhKs22uZrjuy9AO
         4qFhF2igw6IVnCaYo6OEyCRKNYovu5Kyc4mOcBn0wNJceXKtzE6/D5z3KpihkIhEUtiv
         4rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N/Wj/Ce31UHtgG56wu9+wBfD+B1MQY3nPhNgA+c5JMY=;
        b=dkG+n4VQXW7CVQUGteQIfsFweUPA6xuK8rzhjRtWAjfdJ5hJAdFt8gKPVErsRnQk4G
         pw+HWOfEuFaITxz9q6dfjL4WuGi4/ZgIw4RfbgFLYmFF+5+xImAHcfQVtcThAtC8mn+U
         fRvnkLHBpod7aD70oHm6xlL+Mk2yiTZE1mVNVkyR7xM6EYBuxEbPkjIJB+CJkfR5ZexD
         jOPDNaLl9L9nt3VUGcydt/sBAslRHppE9CJnHaTnS0aWgkrVErVOVEj2ODzP+WcRAiJA
         rKLgxYKipvjiKCW082DK0JzL1VNwiFfQJRkyTO7bi1oXej5zV7Tk2tP2/Q/WXDZGzWea
         oI2w==
X-Gm-Message-State: APzg51AOwuawcHOaEBpvypkUHfrnugs5kwWGWzk7/oeRXVU4RTcu4Q+A
        BUGn9g8nXOjDVILmGwVVCog=
X-Google-Smtp-Source: ANB0VdZIh8dGDsv/WqfM+b5U4mklud3nw7G4hKUSZfvlKAwWgkBl0hp8DQzI3ss82bkqMHNyFaYT9A==
X-Received: by 2002:a19:8f57:: with SMTP id r84-v6mr15464793lfd.131.1537476479561;
        Thu, 20 Sep 2018 13:47:59 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p4-v6sm1821609lfj.49.2018.09.20.13.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:47:58 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v4 4/7] [media] ad5820: Add support for of-autoload
Date:   Thu, 20 Sep 2018 22:47:48 +0200
Message-Id: <20180920204751.29117-4-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kernel 4.16, i2c devices with DT compatible tag are modprobed
using their DT modalias.
Without this patch, if this driver is build as module it would never
be autoprobed.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/media/i2c/ad5820.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 625867472929..e461d36201a4 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -372,12 +372,21 @@ static const struct i2c_device_id ad5820_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
 
+#ifdef CONFIG_OF
+static const struct of_device_id ad5820_of_table[] = {
+	{ .compatible = "adi,ad5820" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5820_of_table);
+#endif
+
 static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
 
 static struct i2c_driver ad5820_i2c_driver = {
 	.driver		= {
 		.name	= AD5820_NAME,
 		.pm	= &ad5820_pm,
+		.of_match_table = of_match_ptr(ad5820_of_table),
 	},
 	.probe		= ad5820_probe,
 	.remove		= ad5820_remove,
-- 
2.18.0

