Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BC1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE1E21717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krS6DcA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE1E21717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeHCLQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:16:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34697 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbeHCLQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:16:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so2945818pfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HRW6O4efBYp6blG857CB8di1nLi2rEOUolh4QLy7tww=;
        b=krS6DcA9qqFtRrh+52C1NYMUsvRwEGZnRWYte0hh5yGoeXCvZVJYfNTpyYN4SZWMJe
         pZA1SC0Dehj5pHY9sA5+d90hfRZyMQH2sYrYh1dTH6TM3rUXCIyt202fD8T5djHbUgo9
         0VW3dwBzjPzYuHsXy2wAS1Y8LZNCdhl2Fgj4iU7usO3LVYjkj2soOEcH9jOdcGKdz0N/
         4lUXm0BilV0fPPP86kF0dMeO92xgfOEQ7qTdMkbzHBnizAthFQhvGvGurs6Wi1URcFVx
         92fhJziJ9jZ9/t4CJN9FO/aAqBkPH3lWCo6B3OwcTTYTZdy5rpKeH0wNE9ves+XpgXAJ
         I08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HRW6O4efBYp6blG857CB8di1nLi2rEOUolh4QLy7tww=;
        b=kvLISRJPEo4ixzIqOtHYPVbznRzvdRuW/YSPuikVN0kXkqmdOz63GpeJp1+lreyAQA
         lfK1+pIUYAKg8V9UGZxlSkGf2nNgmdO8O5C14UC+1cnD9w4UrQXZDEJ90g/oixAfd1Eo
         6jOCU+KA+0lcA0qJr7d4l/tyJut1Gf3aMS93StAVk/zzx5O4IDs4cBc83g46U762l5Zi
         foba99T5bSGMJW1NFuKaFVI+pQ759aE9GsQlEngIsJfoCrixv32YuhzZThwxFhDz/ZOW
         sS3UUVTElNcBrrL+nTTuZbB5CZw6RlrmTxjy0StJ5C06GETvqK/YHd4VD7JAwGXbrnkR
         vdxA==
X-Gm-Message-State: AOUpUlFHlmZpEe46ktFHCHg6OKzmdwKxNPQ13GEx4tXLY/kTmrFgEQcF
        W7x4MGBpvPoPQ3XYPALZrLM=
X-Google-Smtp-Source: AAOMgpfJjsXVcTru7CvUJzqYZq7xP15Hpj+vm4iTTgZ2DhowiNtIAb6OV87BMORIYXmpLqrISFmQKw==
X-Received: by 2002:a63:c50c:: with SMTP id f12-v6mr2885335pgd.88.1533288051509;
        Fri, 03 Aug 2018 02:20:51 -0700 (PDT)
Received: from parths.sibshivalik.com ([219.65.63.222])
        by smtp.gmail.com with ESMTPSA id x4-v6sm5652046pfm.119.2018.08.03.02.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Aug 2018 02:20:50 -0700 (PDT)
From:   Parth Y Shah <sparth1292@gmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, jdelvare@suse.de,
        bhumirks@gmail.com
Cc:     linux-kernel@vger.kernel.org, Parth Y Shah <sparth1292@gmail.com>
Subject: [PATCH] misc: eeprom: assignment outside the if statement
Date:   Fri,  3 Aug 2018 14:50:43 +0530
Message-Id: <1533288043-19624-1-git-send-email-sparth1292@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assignment of any variable should be kept outside the if statement

Signed-off-by: Parth Y Shah <sparth1292@gmail.com>
---
 drivers/misc/eeprom/max6875.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/max6875.c b/drivers/misc/eeprom/max6875.c
index 0e32709..fc0cf9a 100644
--- a/drivers/misc/eeprom/max6875.c
+++ b/drivers/misc/eeprom/max6875.c
@@ -148,7 +148,8 @@ static int max6875_probe(struct i2c_client *client,
 	if (client->addr & 1)
 		return -ENODEV;
 
-	if (!(data = kzalloc(sizeof(struct max6875_data), GFP_KERNEL)))
+	data = kzalloc(sizeof(struct max6875_data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
 	/* A fake client is created on the odd address */
-- 
2.7.4

