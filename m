Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C485C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC2121934
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGrE0qGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403970AbeLUX0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:26:47 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44266 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403946AbeLUX0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:26:47 -0500
Received: by mail-yb1-f196.google.com with SMTP id d2so2782188ybs.11;
        Fri, 21 Dec 2018 15:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bnqYQO8FYfQi6F/3FHJMrOf2qBEBdHGC+joEM/JCZp8=;
        b=mGrE0qGKK+HYbhUAu4QxQ7Rwrpb0TZFqFu04mmLUk3aWYoH1Nw93OsrnQ3+VdGKx7x
         BqLdfiKq5NIvlNj/DeCQDoVGVJg4393qWq7JJuc8/LcH+AYkcMdJGIlI/MBXB19aotAe
         3cYo/gPM+NV4DGI5Sp8YKOK7jPapqBWoi6vchUxSMjwnZi2hJ4lynqHwKX6c76Lq9STJ
         KUzKnkP8Ey8YNk5m8Bti+Rc956zXCzROb56akdgn8+RoVcsz6jSIerkLiy4xFgT3tHnk
         idILiIZyCCmFU9lHApRG8r5GhqG/ICl4kB6S5zK8NXpti9rzww83eulig9HsmsII/xOR
         qEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bnqYQO8FYfQi6F/3FHJMrOf2qBEBdHGC+joEM/JCZp8=;
        b=XrusFl8m3JzzZSZI1yoSB3fVi/trq8+s1fl6fUGsvNJiGAPLo1YIan6dRTTZVTElHi
         UKEB38iQa5KAX8jGy5RXk3JVxx2GuwAZyI5pjKOyc6NjxSmTk3zOOh0C1bSyFqwEWh6C
         y92s1uY3LwRh1EQOaWIn2Qc05cZQLtMqidMJJJyTZxBJ8UjOv97M/SKpLbk8N2o1lznu
         +QPTJTRSWk0AY/DNBcTjQBC+6cDWRfzwls89S60SCpjMXGHMdqIOciF+gDiopfYq8wqA
         SuaHS9LlzKbgm4FzsU/t1z6RSr3XQ8vEAC9YfzBQ47jQnumS8yUePclx5+FH8CC4ware
         FxLQ==
X-Gm-Message-State: AJcUukc+bfcnR6gh0c7vZnGR78UttyjWrNR4IM/jK9I2elsuECN11phu
        wOaiBwSs2KQ1kA7dMa9aXu4=
X-Google-Smtp-Source: ALg8bN7P/4wHolNKa2ABRWOzTGYRQuTQ6MUY/x0RPm2lFGJCXIwD1Hxaq3Dx6fSdz19l8y4mvhIhNg==
X-Received: by 2002:a25:c3c3:: with SMTP id t186mr4606231ybf.337.1545434806273;
        Fri, 21 Dec 2018 15:26:46 -0800 (PST)
Received: from localhost.localdomain ([67.191.186.148])
        by smtp.googlemail.com with ESMTPSA id l140sm8011664ywe.77.2018.12.21.15.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Dec 2018 15:26:45 -0800 (PST)
From:   Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Subject: [PATCH] Staging: iio: ad7192: replaced bool in struct
Date:   Fri, 21 Dec 2018 15:26:26 -0800
Message-Id: <1545434786-15220-1-git-send-email-indigoomega021@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced bool in struct with unsigned int bitfield to conserve space and
more clearly define size of varibales

Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
---
 drivers/staging/iio/adc/ad7192.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
index 7433a43..7d3e62f 100644
--- a/drivers/staging/iio/adc/ad7192.h
+++ b/drivers/staging/iio/adc/ad7192.h
@@ -35,13 +35,13 @@ struct ad7192_platform_data {
 	u16		vref_mv;
 	u8		clock_source_sel;
 	u32		ext_clk_hz;
-	bool		refin2_en;
-	bool		rej60_en;
-	bool		sinc3_en;
-	bool		chop_en;
-	bool		buf_en;
-	bool		unipolar_en;
-	bool		burnout_curr_en;
+	unsigned int	refin2_en : 1;
+	unsigned int	rej60_en : 1;
+	unsigned int	sinc3_en : 1;
+	unsigned int	chop_en : 1;
+	unsigned int	buf_en : 1;
+	unsigned int	unipolar_en : 1;
+	unsigned int	burnout_curr_en : 1;
 };
 
 #endif /* IIO_ADC_AD7192_H_ */
-- 
2.7.4

