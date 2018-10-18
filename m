Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E647DECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F8020644
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itjFww/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F8020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbeJSFvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:51:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33661 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeJSFvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:51:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so35291711wrs.0;
        Thu, 18 Oct 2018 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNv++1abTTRnYPMGGuIwfM1wdQiQQQZALUdqCqNOOL8=;
        b=itjFww/ircLy9jzzboIwitT3h/iCC3y2+tdvn3H55Bu0YYaNB3CtpKXtv9ktpoBM5g
         DJ3lABnIPbZxjDjI4LNVQCOHTO84eYFY5i9TocNoYD+u3yHuDy/9Ebzdc433/m2ouTxb
         0NhcsK3hK1xqsEcg7ckIAGDPssxEG97kpYI59J7cOA4/8I0SkiXFF5EAd0WcF0fuD9CC
         QGUMV3wyPc0AyeU7QTcIvikL6DJY6eyiCTi0raoeqMKYWTgPg/LEmTS7FmAVSqvSXU+D
         0eJbEas5WVhBnHgC/36xtZ9y1frCSYDt7sabjjEN9bFaZpNv7oquohM5wT4q3dsvsfGF
         2Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNv++1abTTRnYPMGGuIwfM1wdQiQQQZALUdqCqNOOL8=;
        b=JR0A5oPgiyC0cfxAOl3bbbA85L+SyXfyKElliGly4DxsIMQEPolfpuvA3Usuo1pMT4
         YM7LT1tT297eeimi8YFYYhBw01DrJXZbYKRjeknrxAqJ+JQC9qQ8ZDKKzDOuqpKjHQ/s
         6r0Ho2VdusJZrLtzS4FYA1UOJ6dOb3cnflcZSpA9uP4epJ8kn6PS/eC4YcFHHoZFDcKP
         MB1c+EmG4pzILAOssRUnqcue0e09Rg1p47pd1ezkkPlpb8ALzFrd4qzo4mfCdU37uAZE
         DdE5QJluHsSUI7RqGPi8WrmU44wH0GTABNryqDZt7auRnWyL/1J/hW+J8BdG+2sfGt+W
         i0vw==
X-Gm-Message-State: ABuFfojlhElTwXVFjr8qBSfeF4XU33Q7wPymOwbLAZJYUS5G+L2vHq0N
        8EJfKNbzLrdfu4Ytfjkoii0=
X-Google-Smtp-Source: ACcGV631ADclRGkV2xO3KIenbHKvG8G7iRrVLee8XjiofdNO9KlsG7DkXet1q530y1/747yEbsCfyw==
X-Received: by 2002:adf:f14a:: with SMTP id y10-v6mr29716831wro.29.1539899329706;
        Thu, 18 Oct 2018 14:48:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z2-v6sm15139791wrh.8.2018.10.18.14.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 14:48:49 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] rtc: s35390a: Make buf an unsigned char in s35390a_init
Date:   Thu, 18 Oct 2018 14:42:07 -0700
Message-Id: <20181018214207.4223-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/rtc/rtc-s35390a.c:124:27: warning: implicit conversion from
'int' to 'char' changes value from 192 to -64 [-Wconstant-conversion]
        buf = S35390A_FLAG_RESET | S35390A_FLAG_24H;
            ~ ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
1 warning generated.

Update buf to be an unsigned char, which matches the size and signedness
of the buf member in struct i2c_msg (__u8).

https://github.com/ClangBuiltLinux/linux/issues/145
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/rtc/rtc-s35390a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 77feb603cd4c..9fd51337cfae 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -108,7 +108,7 @@ static int s35390a_get_reg(struct s35390a *s35390a, int reg, char *buf, int len)
 
 static int s35390a_init(struct s35390a *s35390a)
 {
-	char buf;
+	unsigned char buf;
 	int ret;
 	unsigned initcount = 0;
 
-- 
2.19.1

