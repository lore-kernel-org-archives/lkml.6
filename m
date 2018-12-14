Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E96C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3B621486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789002;
	bh=pcYjMC+3aw1WumIMa5Z7Ni4fB6N/+wgRIGQxsIQXHj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ukndzw2crfKTUdpHElfpHns/WN/uSoVdDSyRQ9IzzVY6hTjbflpazcCGGGPiN9Tzv
	 LX29nxFRY222v/bwFnjv466kAal3ombCSxqhudzQXQ/edJCuxDJI5oA4e92Zh92jlE
	 VHHByKkw+K4ir5rZXdhIrHNX8j9gwx3uZP/uTL+w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3B621486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbeLNMDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:03:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbeLNMDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3242145D;
        Fri, 14 Dec 2018 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788993;
        bh=pcYjMC+3aw1WumIMa5Z7Ni4fB6N/+wgRIGQxsIQXHj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=difDro2NM9MHDYQOFaAoOyfhftZVT2J7UcsOFvOQ3qK/5FkmO/k1GdcUw+5hM15ON
         h5i9wPIT/qH93I97Xst6lJln7HTegcEk1iie3cd6yAqcd2DRp3N1TWjmvn+1mpSSNT
         lDCov8vq9xOUDWYwVMpYHB3lj8KveXOSuKSMmQ04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 053/142] hwmon: (ina2xx) Fix current value calculation
Date:   Fri, 14 Dec 2018 12:58:58 +0100
Message-Id: <20181214115749.184546248@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index c2252cf452f5..07ee19573b3f 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -274,7 +274,7 @@ static int ina2xx_get_value(struct ina2xx_data *data, u8 reg,
 		break;
 	case INA2XX_CURRENT:
 		/* signed register, result in mA */
-		val = regval * data->current_lsb_uA;
+		val = (s16)regval * data->current_lsb_uA;
 		val = DIV_ROUND_CLOSEST(val, 1000);
 		break;
 	case INA2XX_CALIBRATION:
-- 
2.19.1



