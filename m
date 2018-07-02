Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DDFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE81125187
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I6ZCiaUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE81125187
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeGBXAr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:00:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:47093 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932693AbeGBXAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:00:05 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so16821pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 16:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+LqYyoehxMdLQtWTxTW7y/oqkNi8bd7AMQyVF2BQAQY=;
        b=I6ZCiaUuDwrL4hI5biTHnkDDiOXwemMbtegfugYYPej4xZqmsyrgDDEOqYVDfbzkUQ
         il4UIn3EiNBoWkVSO1CafWpTdbbbrKzV4UiKTpZRCNdtsBP9kZ8SAywD3W7VkjgVSamE
         zgkZwRmTZq68cG4TJLZ2DEWGGYrcPKmaogL64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+LqYyoehxMdLQtWTxTW7y/oqkNi8bd7AMQyVF2BQAQY=;
        b=B8+/nEY0d4CKcLiAzP/1rYMWD9hWY+H1Rr7miMD6kq4sRnjNgWHO43pOtrW1VcL7jQ
         tHF4nziSoANh5kvsHPGcgF3k3TSvVLc6Bk956B126lqB2XrznrZJnS3ka5PhCYNEEGZf
         rYAPTthGG8yOnwrFTehMDgrd3K3PQ1K5O04nsG2tvyDnyH+gam5ViBgRLMkOOtUd6DGp
         nwtQzEyBxfbHJjqNM77iFQcn5EKgFDAtZxsP0l4BJ3Xpp3inLvA/1JW4qsQ9j1LunNmb
         aDQeb7xUI1/ztPNoQ2HwoQE4we1d4/LjrciPGTi6xyyNLWdFAlOC5rFq3vlnvPxcQkjk
         rNyQ==
X-Gm-Message-State: APt69E0YvIL3JkkCKYs6pcRar3BH3WUTiiHQLaVnJtyFfTX3PvLRb9Rb
        Npm4YucUDCz/r3N1gkC9TAzIKA==
X-Google-Smtp-Source: ADUXVKK50cPWtyO1yJ3srLpRda1/sOw6yJ2m7iHxJureUoOxJGqeaVXrDBYmD54n7gF8pxHhH63ozw==
X-Received: by 2002:a17:902:b81:: with SMTP id 1-v6mr27978847plr.164.1530572404784;
        Mon, 02 Jul 2018 16:00:04 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id v66-v6sm18878027pfb.84.2018.07.02.16.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 16:00:03 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     iivanov@mm-sol.com, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/3] pinctrl: msm: Fix msm_config_group_get() to be compliant
Date:   Mon,  2 Jul 2018 15:59:38 -0700
Message-Id: <20180702225939.109169-2-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
In-Reply-To: <20180702225939.109169-1-dianders@chromium.org>
References: <20180702225939.109169-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you do this on an sdm845 board:
  cat /sys/kernel/debug/pinctrl/3400000.pinctrl/pinconf-groups

...it looks like nonsense.  For every pin you see listed:
  input bias bus hold, input bias disabled, input bias pull down, input bias pull up

That's because msm_config_group_get() isn't complying with the rules
that pinconf_generic_dump_one() expects.  Specifically for boolean
parameters (anything with a "struct pin_config_item" where has_arg is
false) the function expects that the function should return its value
not through the "config" parameter but should return "0" if the value
is set and "-EINVAL" if the value isn't set.

Let's fix this.

From a quick sample of other pinctrl drivers, it appears to be
tradition to also return 1 through the config parameter for these
boolean parameters when they exist.  I'm not one to knock tradition,
so I'll follow tradition and return 1 in these cases.  While I'm at
it, I'll also continue searching for four leaf clovers, kocking on
wood three times, and trying not to break mirrors.

Fixes: f365be092572 ("pinctrl: Add Qualcomm TLMM driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/pinctrl/qcom/pinctrl-msm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 0e22f52b2a19..2155a30c282b 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -250,22 +250,30 @@ static int msm_config_group_get(struct pinctrl_dev *pctldev,
 	/* Convert register value to pinconf value */
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		arg = arg == MSM_NO_PULL;
+		if (arg != MSM_NO_PULL)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		arg = arg == MSM_PULL_DOWN;
+		if (arg != MSM_PULL_DOWN)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_BIAS_BUS_HOLD:
 		if (pctrl->soc->pull_no_keeper)
 			return -ENOTSUPP;
 
-		arg = arg == MSM_KEEPER;
+		if (arg != MSM_KEEPER)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
 		if (pctrl->soc->pull_no_keeper)
 			arg = arg == MSM_PULL_UP_NO_KEEPER;
 		else
 			arg = arg == MSM_PULL_UP;
+		if (!arg)
+			return -EINVAL;
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		arg = msm_regval_to_drive(arg);
-- 
2.18.0.399.gad0ab374a1-goog

