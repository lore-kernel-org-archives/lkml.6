Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA00DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994172177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pc/ilK8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfBRT3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:29:44 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44379 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfBRT3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:29:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id g2so13104092lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pgCp4S2duFLKqiJvUf7YiJ/+RJnSiM50UEgpk3l1pWM=;
        b=Pc/ilK8pyvtbZZFqSRwtHqrgDRaTJGr90bQdlKyyRJ6Qfx3fheGv5llWS2qk5zP1ap
         rP6ziRoYiArUV9grIyKKRTndCrtBfOh1OCCqXTQERJ/sRUOyXoapgf99R6IAzU5Qq1eF
         9Xt+YOScLTE1/eA531RuURUuA1OmoSxJfbHlqxIPhheC4CPplL9d8loFXJx+/NYH331j
         nWlbxjwPbBJqqBT58/rkGV26AYBfDabXqijNvK3WvkR3UYw+q/yatN/rXG+43IN8OxoL
         KddMDesjAoDHYDbG6hDbsqP5U4p2AdraQM2LdLZGPhHSxrq97IJbiWHYShXolYFKgD27
         YMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pgCp4S2duFLKqiJvUf7YiJ/+RJnSiM50UEgpk3l1pWM=;
        b=S5A1h94u72Qa5UqnZI60k6lVwCx2Q0LIcdCrjLjltU/UdsykCzjvKLGCl25RTbDNZH
         k+VGlXRSmD/BdtaXZgTIwArGn+WHxFN/zIxOn9mDT3UPmDgSPfusGeqv37SRX6DUJQw6
         94rGkRmxs07Wxd5FuhJggOo9r/WpH+g5fW/hivAY+WnLzRQetYlaApzWI3anRH9feROn
         eiudMY24ZOCuaY0UZbwZ+AmEnSLszP1h8FQHRSEnYaK3WBis1qx0jj3qCLOtYkdkunHJ
         egD6quj6kxp4+TPfXprN12zUu0u0RR3c/c4eYH1MHuBoZ6Fo4q5SoO9dvcd1BJdnK/8r
         KthA==
X-Gm-Message-State: AHQUAuZHzzlPv0KSlKLBFY4kEQJhePs18Bd0PJLWG+Sg6NUMs4MV+b2U
        taU3aZoqVuHm1Evu5cTXy/xTys+8i1A=
X-Google-Smtp-Source: AHgI3IZzM6ceg0AD+eKddTkN1gnojkrYhuuGScdCv7k781ERTucx57pSuZfBlV4pkmVRF2cf02Zs/g==
X-Received: by 2002:a19:1d1:: with SMTP id 200mr14609482lfb.7.1550518181483;
        Mon, 18 Feb 2019 11:29:41 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id g68sm4040266ljg.53.2019.02.18.11.29.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 18 Feb 2019 11:29:40 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Drop lockdep annotation in drms_uA_update()
Date:   Mon, 18 Feb 2019 20:29:14 +0100
Message-Id: <20190218192914.14766-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e5e21f70bfd3 ("regulator: core: Take lock before applying system
load") took the regulator lock before calling drms_uA_update() in order
to silence a lockdep warning during regulator_register().

However, we are not supposed to need locks at this point as the regulator
is in the process of being registered, so there should be no possibility
of concurrent access.

Instead, remove the unnecessary locking and simply drop the lockdep
annotation, since it is no longer valid.

Fixes: e5e21f70bfd3 ("regulator: core: Take lock before applying system load")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/regulator/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7ed134afb316..c6c280163c05 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -922,8 +922,6 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	int current_uA = 0, output_uV, input_uV, err;
 	unsigned int mode;
 
-	lockdep_assert_held_once(&rdev->mutex.base);
-
 	/*
 	 * first check to see if we can set modes at all, otherwise just
 	 * tell the consumer everything is OK.
@@ -1347,9 +1345,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		 * We'll only apply the initial system load if an
 		 * initial mode wasn't specified.
 		 */
-		regulator_lock(rdev);
 		drms_uA_update(rdev);
-		regulator_unlock(rdev);
 	}
 
 	if ((rdev->constraints->ramp_delay || rdev->constraints->ramp_disable)
-- 
2.20.1

