Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2FBC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C43214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C43214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeHVNRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:17:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33561 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbeHVNRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:17:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so988189ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rCCopusBEhR7W2GcEMhLDPHTAwNTe7aLrwbnxmk0XgA=;
        b=WlQW55NTuFKACttRRo+jLCVUg9f2S0gvKJyu3Hc6VFDZ4FGDMleSTRQ/TKtnh7DrFp
         j0agezh6YNi8mou1EPwV/4n3e8FAPLzKMixue4LWqS1JY+w+ElaoSVlvfysSBb09o6q1
         PVQODZ15Ed6foTn8WZaBes+lB+hqwK7caUGVEci2dDm24TK6e9xr0yMTYHtiGdgsTfGg
         4ssRJIR6QyxbFri75HQ2vjsznGefEM9cJFMFdPQw3y8hSb1s5M3OVZwPpcIRqRE+hafZ
         MrDr+9957zMCCn3Iykz5SpEzr4MlQbpxbjfpNdcMmOv7ZnZIr+kq5Pb/oQkaw+FYtDp+
         ukTw==
X-Gm-Message-State: AOUpUlF5H9vPWTWE06NvwlggM5ZMInxRjXfdtsdNLm0CfO+j9wG14sfq
        yqeP5mciDh6UnT5U1egRJHuSqado
X-Google-Smtp-Source: AA+uWPwIXxXSyHsM4mwsMatfgD3jkS5r11/CQakyUzUySy8WA2ig95PyVHNWdzzfz/PX21pbfdp3DA==
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr21447144ljk.116.1534931621684;
        Wed, 22 Aug 2018 02:53:41 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y131-v6sm233521lfc.26.2018.08.22.02.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 02:53:41 -0700 (PDT)
Date:   Wed, 22 Aug 2018 12:53:27 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com
Cc:     mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com,
        matti.vaittinen@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: regmap helpers - support overlapping linear ranges
Message-ID: <20180822095327.GA21659@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't give up voltage mapping if first range with suitable min/max uV
does not provide the wanted voltage.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

We may have HW which handles regulator voltage setting like:
LDO5 voltage reg:
bit [3] voltage range selection
bit [2:0] voltage selection where:

If D[3]=0,

000 = 0.7V
001 = 0.8V
010 = 0.9V
011 = 1.0V
100 = 1.1V
101 = 1.2V
110 = 1.3V
111 = 1.4V

If D[3]=1,

000 = 0.675V
001 = 0.775V
010 = 0.875V
011 = 0.975V
100 = 1.075V
101 = 1.175V
110 = 1.275V
111 = 1.375V

which can be described as:

REGULATOR_LINEAR_VOLTAGE(700000, 0x0, 0x7, 100000)
REGULATOR_LINEAR_VOLTAGE(675000, 0x8, 0xF, 100000)

If consumer wants to use exactly 775000 uV current implementation of
regulator_map_voltage_linear_range will pick up first range (as 775000
is between min uV and max uV for this range) and fail because first
range is not supporting this voltage. This change makes
regulator_map_voltage_linear_range to continue checking rest of the
ranges if they support requested voltage before failing out.

Unfortunately this approach only works if 'range selection bit' follows
immediately after voltage selection bits - which is not case for
ROHM BD71837/BD71847 PMICs. Hence I will soon submit patch with helpers
supporting 'pickable range' register - which would solve also this
issue. Yet, the 'pickable range' solution is not as elegant as current
linear range solution is (in my opinion) - hence I suggest this addition
for cases where we have contagious vsel mask but overlapping linear
ranges.

 drivers/regulator/helpers.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 2ae7c3ac5940..ef09021dc46e 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -321,17 +321,18 @@ int regulator_map_voltage_linear_range(struct regulator_dev *rdev,
 
 		ret += range->min_sel;
 
-		break;
+		/*
+		 * Map back into a voltage to verify we're still in bounds.
+		 * If we are not, then continue checking rest of the ranges.
+		 */
+		voltage = rdev->desc->ops->list_voltage(rdev, ret);
+		if (voltage >= min_uV && voltage <= max_uV)
+			break;
 	}
 
 	if (i == rdev->desc->n_linear_ranges)
 		return -EINVAL;
 
-	/* Map back into a voltage to verify we're still in bounds */
-	voltage = rdev->desc->ops->list_voltage(rdev, ret);
-	if (voltage < min_uV || voltage > max_uV)
-		return -EINVAL;
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_map_voltage_linear_range);
-- 
2.14.3

