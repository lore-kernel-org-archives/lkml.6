Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C309AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB2420672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HMj5nQ9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB2420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeLKQUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:20:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42306 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeLKQUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:20:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so6854153pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 08:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gAsc11UnxkDiHWz0X8BXN8M+xCIYepZ89UJiAO9CHrc=;
        b=HMj5nQ9x8xe+zGZr34xC1raTNbGjuRNyCZqLMTZV/UvDG3zW0osxAnnJ7xI1Nk5Wmy
         D2yYSMGm5tSRL3QE2GVJ37B/fl7XHYnmKuTfJY1q9oeaU/WaPDRU18RP847u7HL7tsnU
         Vf/lTjxzLQeRS3RAc6shSP5G2L83JkzpyPArc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gAsc11UnxkDiHWz0X8BXN8M+xCIYepZ89UJiAO9CHrc=;
        b=AJngB1a3CgDfumUoHbMiLIfekE1cgI3MMNIN54K7BDYIq277KkD7adC6e9+f5xKhOs
         UjqbEAFCtp8R8ca8O5pw2Nl++0jT8s1YWM9DUomg7xuyfTzXH9sKkZhbpMhpaV+EImkJ
         o7w8PDcFx4kNmv6CeqK5LZiLtd9SnoppFt7C8civ3RbS4uasM5O0bNvtyTH14Ch0FbCK
         uz/K8JAyu+Qr80NcLgyOxMJpoJPODAiyfwbH0G7m0XZ0zceeb8/Sb2fVCnTFGul+HDqY
         FU0Ic56Dn6c7K76g8+zM8V+czQaVh8Defg5CBD19okeklXQoGxTbwSopYAuHknnBO7AV
         WBvg==
X-Gm-Message-State: AA+aEWZVGIZ4MrfhpJjFvOC2+5qfcC4/RfQmf1hx6CA6ISZy+fEk/vNh
        o4QPchZ0ux9ids8///iIE3zpXQ==
X-Google-Smtp-Source: AFSGD/X9JuV9woBChGvKoyfyrs1Se/2I3fNQ4VSe8/l5xGEDbQ7xdmepb8nt45DUOmth2r8MBDkWlQ==
X-Received: by 2002:a63:451a:: with SMTP id s26mr15258964pga.150.1544545250559;
        Tue, 11 Dec 2018 08:20:50 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id v9sm20008752pfe.49.2018.12.11.08.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 08:20:49 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        evgreen@chromium.org, Brian Masney <masneyb@onstation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] regulator: core: Clean enabling always-on regulators + their supplies
Date:   Tue, 11 Dec 2018 08:17:19 -0800
Message-Id: <20181211161720.102888-1-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of regulator_resolve_supply() we have historically turned
on our supply in some cases.  This could be for one of two reasons:

1. If resolving supplies was happening before the call to
   set_machine_constraints() we needed to predict if
   set_machine_constraints() was going to turn the regulator on and we
   needed to preemptively turn the supply on.
2. Maybe set_machine_constraints() happened before we could resolve
   supplies (because we failed the first time to resolve) and thus we
   might need to propagate an enable that already happened up to our
   supply.

Historically regulator_resolve_supply() used _regulator_is_enabled()
to decide whether to turn on the supply.

Let's change things a little bit.  Specifically:

1. Let's try to enable the supply and the regulator in the same place,
   both in set_machine_constraints().  This means that we have exactly
   the same logic for enabling the supply and the regulator.
2. Let's properly set use_count when we enable always-on or boot-on
   regulators even for those that don't have supplies.  The previous
   commit 1fc12b05895e ("regulator: core: Avoid propagating to
   supplies when possible") only did this right for regulators with
   supplies.
3. Let's make it clear that the only time we need to enable the supply
   in regulator_resolve_supply() is if the main regulator is currently
   in use.  By using use_count (like the rest of the code) to decide
   if we're going to enable our supply we keep everything consistent.

Overall the new scheme should be cleaner and easier to reason about.
In addition to fixing regulator_summary to be more correct (because of
the more correct use_count), this change also has the effect of no
longer using _regulator_is_enabled() in this code path.
_regulator_is_enabled() could return an error code for some regulators
at bootup (like RPMh) that can't read their initial state.  While one
can argue that the design of those regulators is sub-optimal, the new
logic sidesteps this brokenness.  This fix in particular fixes
observed problems on Qualcomm sdm845 boards which use the
above-mentioned RPMh regulator.  Those problems were made worse by
commit 1fc12b05895e ("regulator: core: Avoid propagating to supplies
when possible") because now we'd think at bootup that the SD
regulators were already enabled and we'd never try them again.

Fixes: 1fc12b05895e ("regulator: core: Avoid propagating to supplies when possible")
Reported-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Brian Masney <masneyb@onstation.org>
---

Changes in v2:
- Rebased to 4.21 since the CL it fixes is there.

 drivers/regulator/core.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 79cb090ff22f..90ecba09583e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1354,11 +1354,21 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 	 * and we have control then make sure it is enabled.
 	 */
 	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
+		if (rdev->supply) {
+			ret = regulator_enable(rdev->supply);
+			if (ret < 0) {
+				_regulator_put(rdev->supply);
+				rdev->supply = NULL;
+				return ret;
+			}
+		}
+
 		ret = _regulator_do_enable(rdev);
 		if (ret < 0 && ret != -EINVAL) {
 			rdev_err(rdev, "failed to enable\n");
 			return ret;
 		}
+		rdev->use_count++;
 	}
 
 	if ((rdev->constraints->ramp_delay || rdev->constraints->ramp_disable)
@@ -1820,15 +1830,18 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		return ret;
 	}
 
-	/* Cascade always-on state to supply */
-	if (_regulator_is_enabled(rdev)) {
+	/*
+	 * In set_machine_constraints() we may have turned this regulator on
+	 * but we couldn't propagate to the supply if it hadn't been resolved
+	 * yet.  Do it now.
+	 */
+	if (rdev->use_count) {
 		ret = regulator_enable(rdev->supply);
 		if (ret < 0) {
 			_regulator_put(rdev->supply);
 			rdev->supply = NULL;
 			return ret;
 		}
-		rdev->use_count = 1;
 	}
 
 	return 0;
-- 
2.20.0.rc2.403.gdbc3b29805-goog

