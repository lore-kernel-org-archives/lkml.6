Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73A4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF79F20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8o/gYwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF79F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbeLEJwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:52:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbeLEJwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:52:40 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EE92082B;
        Wed,  5 Dec 2018 09:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003559;
        bh=AbUhNGDwiGy8pQXb3MwZAbHtQVqV+uiXUjbQHOHqlKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8o/gYwJL5pZznYNX22GmrxVT+btLNxZZR2RGkr6RxsTgah+DQPlNjBX56gmwq+/a
         GdYvevBMfib4rMVl4bKZAKk++K+haL6ptUqdy2jVGLu7kRX95YpnFaUhSfUznZ4wSH
         1VvNh8cVy5YW8rn0LNldJD+fbMTLJC6TUNuuYcIQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 05/33] hwmon: (ina2xx) Fix current value calculation
Date:   Wed,  5 Dec 2018 04:51:03 -0500
Message-Id: <20181205095131.7685-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095131.7685-1-sashal@kernel.org>
References: <20181205095131.7685-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolin Chen <nicoleotsuka@gmail.com>

[ Upstream commit 38cd989ee38c16388cde89db5b734f9d55b905f9 ]

The current register (04h) has a sign bit at MSB. The comments
for this calculation also mention that it's a signed register.

However, the regval is unsigned type so result of calculation
turns out to be an incorrect value when current is negative.

This patch simply fixes this by adding a casting to s16.

Fixes: 5d389b125186c ("hwmon: (ina2xx) Make calibration register value fixed")
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/ina2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 9ac6e1673375..1f291b344178 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -273,7 +273,7 @@ static int ina2xx_get_value(struct ina2xx_data *data, u8 reg,
 		break;
 	case INA2XX_CURRENT:
 		/* signed register, result in mA */
-		val = regval * data->current_lsb_uA;
+		val = (s16)regval * data->current_lsb_uA;
 		val = DIV_ROUND_CLOSEST(val, 1000);
 		break;
 	case INA2XX_CALIBRATION:
-- 
2.17.1

