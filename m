Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F944C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0162D2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="CS7KQExs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfBSKAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:00:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38860 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:00:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id m2so7639313pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 02:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3mFeUWMugI/wTPhCRrLyvTSDoouVJ2MfSJdTCfLxMvA=;
        b=CS7KQExskOQu+y+EsnRCll4D0L1AQfHDqt/5XZmLS4XLxySJvm7lTanBg91abIWMoy
         5TZ00cqcZnRWt82evglmUK6CdB4bEYviAJDN4DrH21QVEY2C3ESDXWgH5O8Rfu51XzKP
         rgwQFKNo97ikZazBD14biejJStIxrnppUvuL+/D+G5COuBZ+aAUPjZYZJvRDNTY1pUKl
         wTrcrzUll+FYSMm2KgWU5jrQSBEgaVZWzVTmr//qquBW/sjGYwpvhhsN1OUy07ZoaDcv
         ukCy7gICD1jESKmLz6ITAxE7kenuVgtWQKMv/Gt0wyrdUbViuLONZrAPID68/pNmeKjK
         eUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3mFeUWMugI/wTPhCRrLyvTSDoouVJ2MfSJdTCfLxMvA=;
        b=j2vvHjwr00XczZ1+llNmZFRq2+x8C/+HRz87aPmPa4xD3WgJqEtyqVEvu3p9HeEnQx
         dvxz4UR5i/hbuBVdW5mqKBvg48MZIMHmmOnJcNmwg0DBvADBAEMItpcFVQwCtoF+XJqr
         iUPNnzu8GDueovo9/8AwPUkHl8f/IWWNc+ODk0ZjdAiGnTcc2Y6Pi8npjlr3Qy7wWtlC
         CfHaqTogDE3P9DpRk5FFWytOCboblJTriNPK0i8USCSDthTXQ1aly62ReBnuSqGeKZtP
         oY3DIGrYRTvavOalzI0rAcqgYvAaeteQaARM+jcYcSk46qKwLKYJuPmDpFCCe4HZ/lYU
         ujTQ==
X-Gm-Message-State: AHQUAubJ1mnXhwYf50RAbzyISopAPjXPWsrVF3NDCkOYJxCw5IEKfntd
        pJWTzbw5chU3jxoWbHCeVCr9kA==
X-Google-Smtp-Source: AHgI3Ial0a/xzwiQK7VUoZ2MSYetk+omPoKZrolxqXoZ5v8Xp5+7B2EWxwKxWNrFCbGuUQy5JrkenA==
X-Received: by 2002:a62:e017:: with SMTP id f23mr19762538pfh.152.1550570417256;
        Tue, 19 Feb 2019 02:00:17 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id m20sm18229216pgv.93.2019.02.19.02.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 02:00:16 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     James Ban <James.Ban.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] regulator: pv88080: Fix array out-of-bounds access
Date:   Tue, 19 Feb 2019 18:00:01 +0800
Message-Id: <20190219100002.29026-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219100002.29026-1-axel.lin@ingics.com>
References: <20190219100002.29026-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix off-by-one while iterating current_limits array.
The valid index should be 0 ~ n_current_limits -1.

Fixes: 99cf3af5e2d5 ("regulator: pv88080: new regulator driver")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/pv88080-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 9a08cb2de501..6770e4de2097 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -279,7 +279,7 @@ static int pv88080_set_current_limit(struct regulator_dev *rdev, int min,
 	int i;
 
 	/* search for closest to maximum */
-	for (i = info->n_current_limits; i >= 0; i--) {
+	for (i = info->n_current_limits - 1; i >= 0; i--) {
 		if (min <= info->current_limits[i]
 			&& max >= info->current_limits[i]) {
 				return regmap_update_bits(rdev->regmap,
-- 
2.17.1

