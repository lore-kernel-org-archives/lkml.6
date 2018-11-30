Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67EEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D11B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYtMXcvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D11B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeLADPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:15:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39908 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLADPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:15:03 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so5432034ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Q6OpVlKGi2rNqRFLuocPd3nAs+AvtLdb1mSVpc1EnA=;
        b=IYtMXcvPk8+BDvFq2Q2tdfg9Rwd44S3kfp4mU1Z7O5P4HmDpKH50HnwftrxRChC9gr
         mcU1/XKs8lU+B9cy8BpheN343aEDbGBg/tacXx6uGRLOseXTUuY0b7lYcS0Fx+gVGlwL
         d/cW/S16Pw9BcKsfNY65nlIt7i8S53wbk7zoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Q6OpVlKGi2rNqRFLuocPd3nAs+AvtLdb1mSVpc1EnA=;
        b=QSJC90MbCqNosn2nePrdXHGcZC2ElxD+QTxSodDK2b19pg/zh7J8vlnemRuIve/lJB
         L2wK5s5AaRCYF0vNG4alunsGc9ncOgqRiLH+/b50VaClfIGMHvE5Ws3L0R/sMjKREgCy
         qm+Z1Zr/gyAZZSW1CtGLnZpEgiSGztBsIWwwK1odt5YGAS55LgBF2ohIr04o5/+HBhx+
         dg6AQ1mrN9kE8cp/GtLQvUvAt+MIU01UTpGaTZ6kuk26Gz6bQbllWQAAXsh1QItE3qTk
         cxWlXZ22z0LEAILmpeD3Uao3Tl1HQrx9xtl4xLqRT/80qHLP4STNqG6iDSd5wiDxAyBP
         jC0Q==
X-Gm-Message-State: AA+aEWb3bLQ17yU5hQe0rLpr94kOW7//6YZxA3WCR77ZZDMovEdEBCuB
        +Yyn+/baTWWt4Vg7EUs6Ku/2NQ==
X-Google-Smtp-Source: AFSGD/X6Lm1WS5hC8lqISP4G+FznzWxMvIBnP2h2EOCLz3/i4IaSqq3+7YUOt1dFf9VbYgX8c4dB4Q==
X-Received: by 2002:a2e:5418:: with SMTP id i24-v6mr4603769ljb.51.1543593913761;
        Fri, 30 Nov 2018 08:05:13 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id d82sm889847lfd.82.2018.11.30.08.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 08:05:13 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     airlied@linux.ie, wens@csie.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/sun4i: tcon: fix false-positive uninitialized build warning
Date:   Fri, 30 Nov 2018 17:05:08 +0100
Message-Id: <20181130160508.28230-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With GCC version 5 and 6, this uninitialized warning can be seen.
GCC have been fixed in newer versions.

drivers/gpu/drm/sun4i/sun4i_tcon.c: In function ‘sun4i_tcon_bind’:
drivers/gpu/drm/sun4i/sun4i_tcon.c:1091:21: warning: ‘has_lvds_alt’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  bool has_lvds_rst, has_lvds_alt, can_lvds;
                     ^~~~~~~~~~~~

Reworked the code so it covers that false positive also.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 0420f5c978b9..317d4fa3429c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1161,20 +1161,20 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		 */
 		if (tcon->quirks->has_lvds_alt) {
 			tcon->lvds_pll = devm_clk_get(dev, "lvds-alt");
-			if (IS_ERR(tcon->lvds_pll)) {
-				if (PTR_ERR(tcon->lvds_pll) == -ENOENT) {
-					has_lvds_alt = false;
-				} else {
-					dev_err(dev, "Couldn't get the LVDS PLL\n");
-					return PTR_ERR(tcon->lvds_pll);
-				}
+			ret = PTR_ERR_OR_ZERO(tcon->lvds_pll);
+			if (ret == -ENOENT) {
+				has_lvds_alt = false;
+			} else if (ret) {
+				dev_err(dev, "Couldn't get the LVDS PLL\n");
+				return ret;
 			} else {
 				has_lvds_alt = true;
 			}
+		} else  {
+			has_lvds_alt = false;
 		}
 
-		if (!has_lvds_rst ||
-		    (tcon->quirks->has_lvds_alt && !has_lvds_alt)) {
+		if (!has_lvds_rst || !has_lvds_alt) {
 			dev_warn(dev, "Missing LVDS properties, Please upgrade your DT\n");
 			dev_warn(dev, "LVDS output disabled\n");
 			can_lvds = false;
-- 
2.19.1

