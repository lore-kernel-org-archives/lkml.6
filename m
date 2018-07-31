Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F01C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ECC204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ln+2YZdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85ECC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbeGaXGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:06:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38439 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731192AbeGaXGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:06:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id p6-v6so14977462ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMiIm0es48vjsLdQKXum+qUegu2/ApORRqOztXnCZ5c=;
        b=Ln+2YZdINtn/p58tGqZjatxrViCwjmv7SDLrDlCI6tHevBifEas+UskREftD2BFsBE
         tyq2D/OSBKlJfkrztYBMM3kCZaP0PQml1qrfyJmgtW0eh4T9LWzRFlBsZK/9183jlc/+
         03x/sXgBLwIDUDH4KHVU7BWpVwJUueQUoJPj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMiIm0es48vjsLdQKXum+qUegu2/ApORRqOztXnCZ5c=;
        b=XSapziTSybeXZH9KZc2xGCyjGEMZLEdnSYDbSgzvSVhfXYbsEjl0fQ7S2Y3taiWfyc
         XxgM6VxfckQdmRm4X82K61uxRN9F3or4BwBD03WC+kXZeVjtFghCg30kNSxbk6OeLSAj
         mXCP7B0sfwfADYcuNMTiaPDbl6KVqt6AAYHdK/DB99WzGRU3PzTXbEw9NRG23v7Tdqt/
         Yh1PmhtvGF7SNUn0YhAn3/c0pVbSkJNS7Q5afjTPV9N5naM1v8C6/35GlikwY7Hvp2tY
         bL4KgA/lLo0ZVkY2fVuRR2Sdg5RQN0YiDe5JqE5Gv8H+fiEMsTcn68mMVGBRflOU0u20
         wO6g==
X-Gm-Message-State: AOUpUlF8WCe4PJA4uciPkvZ5rPp48W11PY0Ru5K77H159Kqs4OM5cxmY
        2LXPeP/bO5QdEJ2vx5ro2D5m4g==
X-Google-Smtp-Source: AAOMgpeMeFAVvWZ1YpEee8ctWHqy8nV2qnAR2jmyqds4VKrJPWYbvPc22BQMkHGXVTH9rzwhLZ99tg==
X-Received: by 2002:a2e:712:: with SMTP id 18-v6mr18580340ljh.101.1533072258601;
        Tue, 31 Jul 2018 14:24:18 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id h4-v6sm2076910lfj.69.2018.07.31.14.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 14:24:18 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        enric.balletbo@collabora.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] usb: dwc3: of-simple: mark PM functions as __maybe_unused
Date:   Tue, 31 Jul 2018 23:24:05 +0200
Message-Id: <20180731212405.27572-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suspend/resume functions are not referenced when power messagement
is enabled:
  CC      drivers/video/fbdev/matrox/matroxfb_DAC1064.o
drivers/usb/dwc3/dwc3-of-simple.c:223:12: warning: ‘dwc3_of_simple_resume’ defined but not used [-Wunused-function]
 static int dwc3_of_simple_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~
drivers/usb/dwc3/dwc3-of-simple.c:213:12: warning: ‘dwc3_of_simple_suspend’ defined but not used [-Wunused-function]
 static int dwc3_of_simple_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~
This marks them as __maybe_unused to let the compiler drop the function
without complaining.

Fixes: 76251db86561 ("usb: dwc3: of-simple: reset host controller at suspend/resume")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 40bf9e0bbc59..8f6d39463e99 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -210,7 +210,7 @@ static int dwc3_of_simple_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int dwc3_of_simple_suspend(struct device *dev)
+static int __maybe_unused dwc3_of_simple_suspend(struct device *dev)
 {
 	struct dwc3_of_simple *simple = dev_get_drvdata(dev);
 
@@ -220,7 +220,7 @@ static int dwc3_of_simple_suspend(struct device *dev)
 	return 0;
 }
 
-static int dwc3_of_simple_resume(struct device *dev)
+static int __maybe_unused dwc3_of_simple_resume(struct device *dev)
 {
 	struct dwc3_of_simple *simple = dev_get_drvdata(dev);
 
-- 
2.18.0

