Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438FCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64A92146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="N56/Vu0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfBSKAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:00:16 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45862 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfBSKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:00:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so9893029pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 02:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=AWF8WmIcXsXp+3YLVFL2KKMhmk7vP1sOCsapR6uiVtg=;
        b=N56/Vu0l+xENo+8kFkZvIw8yq6zRsidMWIqgKNjJPeo5T1P0g4SmvkuKEuSCt2PYGV
         zysJebYmvbUmaAD3ChR+0NiH97H5u0Gbq+G3zWIEzr17tiN9rBgxANsIildfEkbzS9au
         RK7uz6GnDD/pYGHiYkwBAw9zaIQnqYxgSeBNYD2VklfLiVHr20Oe5C/ncYFY2Xp0TDkM
         n2hK66Rl6k4rZFraPQ+lBb0cHOPRvurH336Gv8842DEZYdOt5P489oOvNIJaAmYltpO5
         6lv6DpSSkH6HrKscYLG5acGrmuWdbqtx2c+gEWavVtW6nRJ5WVQIe4TMDcAZVzXCqpXp
         xI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AWF8WmIcXsXp+3YLVFL2KKMhmk7vP1sOCsapR6uiVtg=;
        b=jKr62j8z4zBQLrlj4RNsDXVQ8CMiwfn5o/XQVDzv5bwwcme5LmL+tDINyvmPByBQrl
         +WzHt6UOlxZ+i2G+VdwU+gU2VlOAyz1NqGQQ9E0AME++2baSSrSJPUgrgjfvB3ai1p6G
         rsaSC+H8tFWi09qzeGRfqfIL/CYH2zToCoHqC3hwLsWuig5mjoWpIBitU5IE0Msed1x8
         krSdn+3sreY/GRkcnaLy1iJyJq1lpk+58gq+h4B+821vzFHYWkTko1yTDfyIRtZ44n7T
         pjdefiXOx6NG9GfnCdsF5si9K/9vQ8rOYxtL2ksWfHsOsQiAY2uGqkg8TPs2Hnv625cS
         Bu9A==
X-Gm-Message-State: AHQUAuY2Lzimd+y4FGPfHlEwHZvQPl6WuUCuE3Psrfs5eLi3i/R1fv2H
        xnW6rq9Kcl9pHuCIquiyenBNYw==
X-Google-Smtp-Source: AHgI3IYyTk226rS2N5xSvS9+RETGsgZNGECtwDJfN6EglyJ7rI9nd2j6jXC6MRuiJ2oMqJjVqQRVlg==
X-Received: by 2002:a62:6f06:: with SMTP id k6mr16476958pfc.257.1550570414754;
        Tue, 19 Feb 2019 02:00:14 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id m20sm18229216pgv.93.2019.02.19.02.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 02:00:14 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     James Ban <James.Ban.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] regulator: pv88060: Fix array out-of-bounds access
Date:   Tue, 19 Feb 2019 18:00:00 +0800
Message-Id: <20190219100002.29026-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix off-by-one while iterating current_limits array.
The valid index should be 0 ~ n_current_limits -1.

Fixes: f307a7e9b7af ("regulator: pv88060: new regulator driver")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/pv88060-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index d5dab9bef378..da6ed723e398 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -135,7 +135,7 @@ static int pv88060_set_current_limit(struct regulator_dev *rdev, int min,
 	int i;
 
 	/* search for closest to maximum */
-	for (i = info->n_current_limits; i >= 0; i--) {
+	for (i = info->n_current_limits - 1; i >= 0; i--) {
 		if (min <= info->current_limits[i]
 			&& max >= info->current_limits[i]) {
 			return regmap_update_bits(rdev->regmap,
-- 
2.17.1

