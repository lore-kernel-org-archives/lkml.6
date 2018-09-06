Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A00C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D822075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="humain+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D822075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeIFQro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:47:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51240 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIFQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:47:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so11185283wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=hAQltCDob1QT626+UKow4KSqmQCSsrkxJvuvO272vb0=;
        b=humain+2xZy441dmpqZhn4rerDs+bhxkgBZo8FM3GX1Kj+T8c3iZNFOszIPAI/3VGU
         l8KbfNg6UScAJ0LLUFw2vW4IXV66d89sFJEBwSrhsNVBzHVvraaLaJyY0QEaRyn/bQcF
         oTV7V0Qx/MzbtmUQDet8aIY/H+YotcI5FMmeo3ZFgB8ob82vWqP2qabrfO1JOkw/eOOS
         /IbJ15piia+Gbkv/i/NM2+BLPJJnLMCAuWDHk3vA7nTBfW+jOsqHbNm3x5CGGwxqpI/b
         R2TZZkjCOxPOnTAp/5hMpT6LZWFnTkv7XG5f4hJgJoUPkfQECbT8rYtUAJjoQds0+kQg
         yOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hAQltCDob1QT626+UKow4KSqmQCSsrkxJvuvO272vb0=;
        b=IMA3OtsWjlv921YVqnZqqT+X6vUovCrw5R7iWQLlk2mo571i4EYWhmqGRn8bX6Ym5x
         5gNwqbBzCE55GjFsxPeyevP0btImoRLL/o2T428IX/r9QX3s8dKOSrj/H8sUstJttyew
         EbkHHXGweUz42xITS9GqV71DaUwC0scW9cT3yFL84XiHj52BZ1VyfNqdyuQeGR4ts9pv
         94Xp0afaNjpUIkOu22fg1DkmBiy56reKrTnniQdDIMij6y32NQTSLaTYdEBhnxAEPJoM
         TdeFt6NlKQ74KaF8jjBy2xFNvdCnr8sMamLngdHs2n/w7lVpbX1ULnzFHjiVF2xkVM5T
         3ZLA==
X-Gm-Message-State: APzg51DX6L7sJS2tnAzfIHDLrbarM1kJ5HPcOHJpHvdh7SxMoPB7QSyK
        ++Vmeqkr+VLfxZwWrtj/kUZroA==
X-Google-Smtp-Source: ANB0VdY02+wGej9m5GnL7wS40mNFbi5RiwHIwUQz8wHje0P2XS7zmd0HShCRPHzaVdaghSz7F0IAOA==
X-Received: by 2002:a1c:82c8:: with SMTP id e191-v6mr1858952wmd.35.1536235951353;
        Thu, 06 Sep 2018 05:12:31 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id h15-v6sm2922770wmb.21.2018.09.06.05.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 05:12:30 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH] memory: ti-aemif: fix a potential NULL-pointer dereference
Date:   Thu,  6 Sep 2018 14:12:19 +0200
Message-Id: <20180906121219.23948-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Platform data pointer may be NULL. We check it everywhere but in one
place. Fix it.

Fixes: 8af70cd2ca50 ("memory: aemif: add support for board files")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: stable@vger.kernel.org
---
 drivers/memory/ti-aemif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 31112f622b88..475e5b3790ed 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -411,7 +411,7 @@ static int aemif_probe(struct platform_device *pdev)
 			if (ret < 0)
 				goto error;
 		}
-	} else {
+	} else if (pdata) {
 		for (i = 0; i < pdata->num_sub_devices; i++) {
 			pdata->sub_devices[i].dev.parent = dev;
 			ret = platform_device_register(&pdata->sub_devices[i]);
-- 
2.18.0

