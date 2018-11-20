Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769F7C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EDB206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aB+/G4om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EDB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeKUEXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:23:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39425 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbeKUEXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:23:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so1409368pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 09:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNUMejFQuDMj+wup8HTPKXJGuAmbtH0/1h00eWCthkE=;
        b=aB+/G4omTeIkW1B6oAKkzHl6iLyojcE5Ugzg+QJPPsGP2E0hykxwrcCnkhzbMo5v1Y
         7ghC64t+KcKyi0fAGSYhSig7/hzMu0k3JIoXZxp1+Q4Q/OFbZt6Qhtb04lUPfVkQaepm
         CDOmqiwXbQzVgoSzbphD8kZ9SdNw+GXj601HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNUMejFQuDMj+wup8HTPKXJGuAmbtH0/1h00eWCthkE=;
        b=iG2xRQP87uB6oDvURqkTw8TSPTwPi8RXV4mSmzQJLBMbV2v3dnd8ysDJCnqf7daVWJ
         2w4YJ2yA74OuSS4L6I2Yyzlntg7dAbDDV7JJGSIdk6FqIq9i28vXRl5hg2D3y2JGzFXN
         wV5rCHysUQ6FMEPaCFaVWB2ww+pqbmJfoUPW6sixCauNkwvQpCk8XQf2LRMpc0IvcKqI
         5sS9ck0P9LHYT8wnHMQrymdPP0X17Cm8zTfj1uByVfXa0utXxBXqlUNvz8h3uqXewQ8O
         o4md3EtswG6OGcuLM4ZOj+9Kmuh0f5+BksWhKhM0NEpE1BLatqnekGaX02qv2ytwoqco
         Mv1g==
X-Gm-Message-State: AA+aEWbQeeeWRELAK4/zzR1ajCgO77GfK5s3BW08EY+2X913RdCqgOFl
        DybhQT3rwG63l2P7hTLHl/tV3A==
X-Google-Smtp-Source: AFSGD/WwRVQGLeZlUa4OT9alIFVAdJSIIwe0AKtevsssggh4IbSmRuH406Ix65qLE2M8KqrnZrWysg==
X-Received: by 2002:a63:f34b:: with SMTP id t11mr2761108pgj.341.1542736388544;
        Tue, 20 Nov 2018 09:53:08 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id k129sm51807764pgk.29.2018.11.20.09.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:53:07 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>, evgreen@chromium.org,
        swboyd@chromium.org, Dmitry Osipenko <digetx@gmail.com>,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] regulator: core: Avoid propagating to supplies when possible
Date:   Tue, 20 Nov 2018 09:52:54 -0800
Message-Id: <20181120175255.227783-2-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181120175255.227783-1-dianders@chromium.org>
References: <20181120175255.227783-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we called regulator_enable() on a regulator we'd end up
propagating that call all the way up the chain every time.  This is a
bit of a waste of time.  A child regulator already refcounts its own
enables so it should avoid passing on to its parent unless the
refcount transitioned between 0 and 1.

Historically this hasn't been a huge problem since we skipped dealing
with enable for always-on regulators.  In a previous patch, however,
we removed the always-on optimization.  On one system, the debugfs
regulator_summary was now showing a "use_count" of 33 for a top-level
regulator.

Let's implement this optimization.  This turns out to be fairly
trivial with the recent reorganization of the regulator core.

NOTE: as part of this patch I'll make "always-on" regulators start
with a use count of 1.  This keeps the counts clean when recursively
resolving regulators.

ALSO NOTE: this commit also contains somewhat of a bug fix to
regulator_force_disable().  It was incorrectly looping over
"rdev->open_count" when it should have been looping over use_count.
We have to touch that code anyway (since we should no longer loop at
all), so we'll fix it together in one patch.  Also: since this comes
after commit f8702f9e4aa7 ("regulator: core: Use ww_mutex for
regulators locking") we can now move to use _regulator_disable() for
our supply and keep it in the lock.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
NOTE: this patch is based atop the patch ("regulator: core: Only count
load for enabled consumers") because that patch changed the signature
of _regulator_disable() and this patch touches calls to
_regulator_disable().  If desired the order of the two patches could
be swapped.

Changes in v2:
- Squashed in ("Remove loop disabling supplies in regulator_force_disable()")

 drivers/regulator/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1271b5406ad7..dbe2f2e6e625 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1824,6 +1824,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 			rdev->supply = NULL;
 			return ret;
 		}
+		rdev->use_count = 1;
 	}
 
 	return 0;
@@ -2493,7 +2494,7 @@ static int _regulator_enable(struct regulator *regulator)
 
 	lockdep_assert_held_once(&rdev->mutex.base);
 
-	if (rdev->supply) {
+	if (rdev->use_count == 0 && rdev->supply) {
 		ret = _regulator_enable(rdev->supply);
 		if (ret < 0)
 			return ret;
@@ -2541,7 +2542,7 @@ static int _regulator_enable(struct regulator *regulator)
 	_regulator_handle_consumer_disable(regulator);
 
 err_disable_supply:
-	if (rdev->supply)
+	if (rdev->use_count == 0 && rdev->supply)
 		_regulator_disable(rdev->supply);
 
 	return ret;
@@ -2650,7 +2651,7 @@ static int _regulator_disable(struct regulator *regulator)
 	if (ret == 0 && rdev->coupling_desc.n_coupled > 1)
 		ret = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 
-	if (ret == 0 && rdev->supply)
+	if (ret == 0 && rdev->use_count == 0 && rdev->supply)
 		ret = _regulator_disable(rdev->supply);
 
 	return ret;
@@ -2735,11 +2736,10 @@ int regulator_force_disable(struct regulator *regulator)
 		ret = drms_uA_update(rdev);
 	}
 
-	regulator_unlock_dependent(rdev, &ww_ctx);
+	if (rdev->use_count != 0 && rdev->supply)
+		_regulator_disable(rdev->supply);
 
-	if (rdev->supply)
-		while (rdev->open_count--)
-			regulator_disable(rdev->supply);
+	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	return ret;
 }
-- 
2.19.1.1215.g8438c0b245-goog

