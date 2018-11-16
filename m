Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0DFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D82020883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D82020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeKQIUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:20:10 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40738 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQIUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:20:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id t3-v6so3043126oie.7;
        Fri, 16 Nov 2018 14:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9NvbhSpo0zQeyuL+LUNt8x1V7zepvjibuZy5WzTCHqQ=;
        b=I3Ps4f8uMYsUkb0zF2ipgdkt3ADE9RQl1J363oMOq8vRyxhIJ9Zex7erCW/e+ZC/43
         X/0AMAY5zzqOIQtA2oaD/GVIV5oFnmyggXGix8luh5whrHhs1ox04mlFGVDrzEkCjVol
         kTJ5L5Iw6fN674Yoj4WoPgwpxMfvHmWPqHsdfVanll7aqQRkl4HOX1BjyrO6XvwV33OG
         TUko4va4UWZNEv6nEybHhz8vH1YTrEVH9/aVeuqN9V1yO5w6TWDRIePOAdhvxb7+HvcV
         p60NIYpTO3MWToqqPsfZCRjdwV7ZqLpP7iaYvNwol3gVhjyX07BTAnizEY39Ku0TJM/c
         3k3g==
X-Gm-Message-State: AGRZ1gJw9D8UQXsckrjQWDKLYdoetTpJvXDpNzCQ4xztAxHFDKRCHrly
        5zzRHsKuIP1EEKkj9aCQtQ==
X-Google-Smtp-Source: AJdET5e5DOQMKdTTe1/yMJfAdHb5U2JfXm/uQdrWavCfxSRwskq2cLvBhhtcYmKSBS8mLQgPdB7VfA==
X-Received: by 2002:aca:c108:: with SMTP id r8-v6mr2059706oif.258.1542405959485;
        Fri, 16 Nov 2018 14:05:59 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.googlemail.com with ESMTPSA id w5sm2316587oif.48.2018.11.16.14.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:05:58 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pinctrl: mediatek: Convert to using %pOFn instead of device_node.name
Date:   Fri, 16 Nov 2018 16:05:40 -0600
Message-Id: <20181116220540.17222-4-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116220540.17222-1-robh@kernel.org>
References: <20181116220540.17222-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Sean Wang <sean.wang@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index d2179028f134..7ff5ffa88198 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -419,8 +419,8 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 
 	pins = of_find_property(node, "pinmux", NULL);
 	if (!pins) {
-		dev_err(hw->dev, "missing pins property in node %s .\n",
-			node->name);
+		dev_err(hw->dev, "missing pins property in node %pOFn .\n",
+			node);
 		return -EINVAL;
 	}
 
-- 
2.19.1

