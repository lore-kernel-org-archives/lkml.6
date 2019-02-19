Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8592EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3612146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="vJTmVuiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfBSKAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:00:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34965 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfBSKAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:00:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id j5so5505013pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 02:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vpWbXvvA2LrR1Xzzsnj9xpvOjDbw7axnmTpRmntEJRM=;
        b=vJTmVuiV0JoBwxkfGxJDnH+OHQQiE8WMWBDQpvFfLOXcrq8jl8LV1I0LzPoYMutnZK
         RqqodJdG5F3wL260KRay0ikMlu3a70nsCQIEz/Oz7ukgLqdA5lIlkk2NeaYF9mYn4oFS
         TjuCPJJk0WOHCDa4tm0FfiErcG07UNPs3QGDCq0vX35DJ/D2/HF0nEVMrE+IfJS0NbT/
         8Pys9lQL65wjzfxbHJUBEUIwaebgPkIehsKLFV7qNAgSoqb1UNqW6FhfIDOmJsVjfuJS
         5SDUPMI60YWOAsB5bi4d8V3ZZIFd04FALy6RQqHJgkmP/lVaAEKio4ap641t1TeJF0jj
         72sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vpWbXvvA2LrR1Xzzsnj9xpvOjDbw7axnmTpRmntEJRM=;
        b=gIVSZyitAo8f5oHdcBeQa3888Agzhbb0wwaws1h7smDsaveUmVE8n9hzz7yn4+9ays
         +TfoSAlOt9b6XWSGP1vc+EMool4+w1Y6flNLWzsuA85EpfUmf+2PN4ZO/PVwdqBi3Qos
         l/zO9EnfUT2UsXTp0ABjMYXVUux21LoXwEHZfi4pE9ecdD11kMa496MMtFK9vrFEOiao
         S0Nspy0lC6eWFNhYoEMtmptbfkukCuy51DjjooDNgAt/EsvfUKXoZdHucgJm1YV6w0RH
         AYW3DPeVdZXE/0tq6Q3RwphUUPeVwwNDyNTsWetESZIucfxUYiTCF5yr7I3WKQRI219y
         589g==
X-Gm-Message-State: AHQUAuafqEfQyMOO99q6vqOvTvwrO8sYdy0igNncZHkBldLeR0Pk0oZW
        L3m5kf5KFk64xHrunpnJxvj9Mw==
X-Google-Smtp-Source: AHgI3IasWycQwXWJADzp+7NeBys80Ja5RiM/7jqHkLWQA8B01HS6ul7N+CxOYhiYdytnP2ySbkPfcQ==
X-Received: by 2002:a62:f598:: with SMTP id b24mr28541166pfm.72.1550570419650;
        Tue, 19 Feb 2019 02:00:19 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id m20sm18229216pgv.93.2019.02.19.02.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 02:00:19 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     James Ban <James.Ban.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] regulator: pv88090: Fix array out-of-bounds access
Date:   Tue, 19 Feb 2019 18:00:02 +0800
Message-Id: <20190219100002.29026-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219100002.29026-1-axel.lin@ingics.com>
References: <20190219100002.29026-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix off-by-one while iterating current_limits array.
The valid index should be 0 ~ n_current_limits -1.

Fixes: c90456e36d9c ("regulator: pv88090: new regulator driver")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/pv88090-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index 7a0c15957bd0..2302b0df7630 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -157,7 +157,7 @@ static int pv88090_set_current_limit(struct regulator_dev *rdev, int min,
 	int i;
 
 	/* search for closest to maximum */
-	for (i = info->n_current_limits; i >= 0; i--) {
+	for (i = info->n_current_limits - 1; i >= 0; i--) {
 		if (min <= info->current_limits[i]
 			&& max >= info->current_limits[i]) {
 			return regmap_update_bits(rdev->regmap,
-- 
2.17.1

