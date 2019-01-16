Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79604C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4710C20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAQg3wWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfAPVLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:11:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38464 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfAPVLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:11:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so6701834lja.5;
        Wed, 16 Jan 2019 13:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZC/R8I02rqLCUVmu/Wi64L1mcvQxP71e+q0r7wmFss=;
        b=NAQg3wWIq+52aPeHZCAO8VsN9ZCQJnLSamPyV10aZTXLvoEAJJ2VsWl/7zTpU/8vWZ
         qmsAp+e7JqzR6arfg/Yof+4JVLmpkCRnVZNw196a7kanTfkTbI5a/XeFR5v6s7bU0xVf
         x2Hs4c/v6EmOrmTkrFDt/CGaikJOo9+SOXkMAn5jIjgGFhmWMCIKVFAli9Cq4Uxcal8c
         RiJohvfepnhiEj6X2uZYjXqz8R42sUzhvXz7noHaC+XKWH9pehlI91TSpvlrpwylKYqE
         pZKU1re53q8MpPu54McCkJ7iTwMBpoLmdXRYvwOixdJhNCGinv2eZcv0TK4CcVXdBgzG
         orCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZC/R8I02rqLCUVmu/Wi64L1mcvQxP71e+q0r7wmFss=;
        b=gHWLS0CGA0JKdnh3HgcPj6C/iXcb5PfZXNj3jYlA22qIeljB+EyK/6N1dxSUxKAT7D
         sd3Uey0o4pDH3fGoe6Whb2RTItr3lAvAN/vh+SQphUyH0Ysbcy1JgmgMXtJ6g3xi/WBg
         AeTBU8GMeRYJYSRVoeerbBuWKvh/IfQoRfT55Se8dPCSI2HT9WQvoFWklBW5loITyUUJ
         D9DZmKFdDOa+xVOK4//27tVQRj04GyaeUuvy1oMAYU5dnYgtABLkZrJuuX/A3PKeFEhx
         1MnsJdeqp8u64ZwdJsFWL69ymXlNiSZt1m29bBL17Rjm14UoIK6fmGmL6R4o4V0gXXoY
         l91g==
X-Gm-Message-State: AJcUukesuHld8d3ASGK6MuGCNbx0v589anA6IGrzM0Cu5fAiT0ZhceNY
        TU0xkqKjUDcSQGPTY6FTVPw=
X-Google-Smtp-Source: ALg8bN58rQr8MjHbIKHJf+YJqFD/Ai9cXHn5DcRaMq+07eICYl/wtyuNRo1tXTVBtdnD42eNeawgaA==
X-Received: by 2002:a2e:84ca:: with SMTP id q10-v6mr7821129ljh.65.1547673102633;
        Wed, 16 Jan 2019 13:11:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6c79:3c25:1ea9:fa4b])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm1221524ljf.28.2019.01.16.13.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 13:11:41 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH] input: misc: pwm-vibra: Prevent unbalanced regulator
Date:   Wed, 16 Jan 2019 22:11:31 +0100
Message-Id: <20190116211131.18809-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

pwm_vibrator_stop disables the regulator, but it can be called from
multiple places, even when the regulator is already disabled. Fix this
by using regulator_is_enabled check when starting and stopping device.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/pwm-vibra.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index 55da191ae550..66677ee770ca 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -42,10 +42,12 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 	struct pwm_state state;
 	int err;
 
-	err = regulator_enable(vibrator->vcc);
-	if (err) {
-		dev_err(pdev, "failed to enable regulator: %d", err);
-		return err;
+	if (!regulator_is_enabled(vibrator->vcc)) {
+		err = regulator_enable(vibrator->vcc);
+		if (err) {
+			dev_err(pdev, "failed to enable regulator: %d", err);
+			return err;
+		}
 	}
 
 	pwm_get_state(vibrator->pwm, &state);
@@ -76,7 +78,8 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 
 static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
 {
-	regulator_disable(vibrator->vcc);
+	if (regulator_is_enabled(vibrator->vcc))
+		regulator_disable(vibrator->vcc);
 
 	if (vibrator->pwm_dir)
 		pwm_disable(vibrator->pwm_dir);
-- 
2.17.1

