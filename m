Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E8CC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3D721580
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z1jMPBFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3D721580
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbeHNTyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:54:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38303 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387536AbeHNTyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:54:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3-v6so9375332pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tB73vw/ScZXdbL/f9MHIOWSOWp2ygs06ypWa1EFsTMk=;
        b=Z1jMPBFIXp+ppeVk+QMOLJIo9j+BUWBkaiibpPH4MYpO8wLc9TJ8LvS3qthY9TXYOx
         KAAL8FfKPK3Dnt499CByBtdfdGXWmqGMG6cxhEEma5zfWcenfEF+yinwkn06ZZtcIAbl
         qEckzQo2D57hCcRxjtWaKYhBZO72OD6sSaR8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tB73vw/ScZXdbL/f9MHIOWSOWp2ygs06ypWa1EFsTMk=;
        b=Pl3uCproBiR06TH2yCgjPMYsNs6EwRjuzbJWPq/Qn+lVShGsbr77LDY2s29r/sHoR3
         7dVQf3SK8uVrQ3ewOWhXZd8wzWkEjhK7tCHQXwwO0uH5xU486bBq/jALd2xwc69ZmseY
         0JJY1OOtFQ5gfd81fxCfzOqZSExS/SYzZGoypKgLNDEe9+g5iSJycE/nelipIVOZZX/e
         OCoWjOJGn+yXLoV/Rr6aiCGLoSyXUN8vyCgqr/TbpVmM07tt4vgyTNfOU+SA7UddxTQB
         DdNhseomSZzowCfH9gR3FeRKALHG3jhVlTXQtNK6v06qACWnZaa1PyU9+mwo4fnJbOLC
         SSYw==
X-Gm-Message-State: AOUpUlEOgKaLQIu+KtYu31RmuPpu4wzZtQDyMYkPRgYvLD23iCt5VaHZ
        8plPQpBZwQZaKK70ilyVLJlQVQ==
X-Google-Smtp-Source: AA+uWPx1YHGj3Dm7CpSTZx0YPe9jR5Z8CGVmY8wiuWyfhn/0Rdf2/Hax7hc0z6l2CZkANbSRipuaVw==
X-Received: by 2002:a65:5c83:: with SMTP id a3-v6mr21965781pgt.164.1534266413860;
        Tue, 14 Aug 2018 10:06:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id d19-v6sm67940763pfe.42.2018.08.14.10.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 10:06:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        collinsd@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] regulator: core: If consumers don't call regulator_set_load() assume max
Date:   Tue, 14 Aug 2018 10:06:14 -0700
Message-Id: <20180814170617.100087-2-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180814170617.100087-1-dianders@chromium.org>
References: <20180814170617.100087-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all regulator consumers call regulator_set_load().  On some
regulators (like on RPMh-regulator) this could be bad since the
regulator framework will treat this as if consumer needs no load.
It's much better to assume that a dumb client needs the maximum
possible load so we get correctness first.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c     | 10 +++++++++-
 drivers/regulator/internal.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6ed568b96c0e..a4da68775b49 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -732,6 +732,7 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	struct regulator *sibling;
 	int current_uA = 0, output_uV, input_uV, err;
 	unsigned int mode;
+	bool any_unset = false;
 
 	lockdep_assert_held_once(&rdev->mutex);
 
@@ -751,11 +752,17 @@ static int drms_uA_update(struct regulator_dev *rdev)
 		return -EINVAL;
 
 	/* calc total requested load */
-	list_for_each_entry(sibling, &rdev->consumer_list, list)
+	list_for_each_entry(sibling, &rdev->consumer_list, list) {
 		current_uA += sibling->uA_load;
+		if (!sibling->uA_load_set)
+			any_unset = true;
+	}
 
 	current_uA += rdev->constraints->system_load;
 
+	if (any_unset)
+		current_uA = INT_MAX;
+
 	if (rdev->desc->ops->set_load) {
 		/* set the optimum mode for our new total regulator load */
 		err = rdev->desc->ops->set_load(rdev, current_uA);
@@ -3631,6 +3638,7 @@ int regulator_set_load(struct regulator *regulator, int uA_load)
 
 	regulator_lock(rdev);
 	regulator->uA_load = uA_load;
+	regulator->uA_load_set = true;
 	ret = drms_uA_update(rdev);
 	regulator_unlock(rdev);
 
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index 943926a156f2..f05c75c59ef4 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -41,6 +41,7 @@ struct regulator {
 	struct list_head list;
 	unsigned int always_on:1;
 	unsigned int bypass:1;
+	bool uA_load_set;
 	int uA_load;
 	struct regulator_voltage voltage[REGULATOR_STATES_NUM];
 	const char *supply_name;
-- 
2.18.0.865.gffc8e1a3cd6-goog

