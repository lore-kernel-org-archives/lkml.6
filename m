Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3739AECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39E821486
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxtTs02e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39E821486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeJRBHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:07:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37207 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeJRBHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:07:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so3011807wmt.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v03iK3x/plWm5Rp2GkHTWEKr5Z/RFjW88mQS4/6o62c=;
        b=DxtTs02efnuzZgcun0XYIMnbYd4502k+bj2hNVsoDdQR84FS0AjrPatM990wsoDfjo
         9Q36etgwMCtgxo61NDNQj4AsdK+1/Q8LE1071vPl2fEBMrS8PkFp/wpKINDe1xI+bK8m
         mCDs99nCRToHPSd94iyTgcek4GbWKHXf60Wxcf8HGZDoF73ndzoDNzPJvom3FbSXJZgz
         ZmufODVijtdDBr6BjJyGzywuD/cbFOzEZJhdkOFSBweRS45GnqUcPJE7bznjuSPDXwdt
         Z9SLw4NGAwjvy8+VIQKlYEjnBzcqSMj4k/CnrrabzNhncP6AGrEsZ94bj7q1TsFR1QNN
         emug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v03iK3x/plWm5Rp2GkHTWEKr5Z/RFjW88mQS4/6o62c=;
        b=aZWyAoGVEQpc8BQAgwutGGUMEGKCdyJZ6H+IfkKPULTu5U7PcAl4gyOQ+iHUUXtB4N
         3p6IwhkieTHQIcuI2d3f2hY5b+PSoKw7nyz+QbFvf322APjkpa2fUfnKIVuNjpQ+7McR
         ItWk/Vv51TmGqqRMIvM80Gs0aoJnwjhTzRYE4/99VOo1v+UuopXLrUYy663JLY9pAWNW
         SvsY7hZlM7nRDcmHhXUnZsdRS9/bQsQudQVGcdvrOs6xIaX7nSfv47q8yX/X1mRkkxOn
         4RaDGUTSWmU1ZV5TgL8mn7E5nSa3fGSrtm19TZJ4GKK2MrltCH9tXbKUIDO0hyq1W+ec
         jpOw==
X-Gm-Message-State: ABuFfoidbhLkgNXbCv2kz1hlkr8ZbbO65npqO/lt6sbB8dZK/EFmvuU9
        o9W2dyjbWlV3zYX9bHRFMSs=
X-Google-Smtp-Source: ACcGV61sfXfTzMzcZbtZzgVmEIR6KfxdqejpnXXX/iaGwn2mcuS7szyCfY0P0BDXmrbsTh83QhePow==
X-Received: by 2002:a1c:1a52:: with SMTP id a79-v6mr3752892wma.119.1539796254873;
        Wed, 17 Oct 2018 10:10:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t3-v6sm16371009wru.47.2018.10.17.10.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 10:10:53 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data
Date:   Wed, 17 Oct 2018 10:09:02 -0700
Message-Id: <20181017170901.13119-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After building the kernel with Clang, the following section mismatch
warning appears:

WARNING: vmlinux.o(.text+0x3bf19a6): Section mismatch in reference from
the function ssc_probe() to the function
.init.text:atmel_ssc_get_driver_data()
The function ssc_probe() references
the function __init atmel_ssc_get_driver_data().
This is often because ssc_probe lacks a __init
annotation or the annotation of atmel_ssc_get_driver_data is wrong.

Remove __init from atmel_ssc_get_driver_data to get rid of the mismatch.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Alternatively, ssc_probe could be marked as __init, I don't think there
is any way for the probe to defer. I decided to go with the more
conservative option first but I'm happy to respin if necessary.

Thanks!

 drivers/misc/atmel-ssc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index b2a0340f277e..d8e3cc2dc747 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -132,7 +132,7 @@ static const struct of_device_id atmel_ssc_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, atmel_ssc_dt_ids);
 #endif
 
-static inline const struct atmel_ssc_platform_data * __init
+static inline const struct atmel_ssc_platform_data *
 	atmel_ssc_get_driver_data(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {
-- 
2.19.1

