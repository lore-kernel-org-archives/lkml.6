Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881F5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4188625187
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="exlk8zuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4188625187
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932754AbeGBXAH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:00:07 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37358 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932213AbeGBXAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:00:03 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so24793plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 16:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sBGMSszs7fd7q6UmVsMDQdICXfnheaxKdBLkMD4O5Vk=;
        b=exlk8zuo8o9OJeqF95at1gqJW5bnR0RmGDGBBs8yZDHH6Ago7tz/7o2voNf5GhVxNU
         UqkDjj0iMd4tFnkaA0PK4RCtIo/Qwa/4Z1V/8NN5f9WqGb685qxYOBSvxQ7Nor5To3Cp
         yF5/fXOgCM1DewY22QdmJHe+O0q+MQLto58iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sBGMSszs7fd7q6UmVsMDQdICXfnheaxKdBLkMD4O5Vk=;
        b=FlQy3tTTROSiBIV+Zg+dRG8bkn8mdI2Lfhni/LeqOBdS1Fyfu61bCB2hpXoaIhevJc
         3MwfjIt6UhNfRiPP9lKNLGp1e3cchYfHds6g9ndjZr5X3W7+sPcuahDAJx/Y6cMsTW/l
         Kmh+RhjcFISf4yK5s64OGdChEVtuW32boZnPu9Jcyp6jqbbNX9sT1XUkxMpiqamWPeqU
         w3an8hYQZ4dkLDhFNh9qIJrt4s0SjFNv/I/YsZVqqKbQ4qxk0GT6xFX2edtg+bMAIY5T
         s0evm3EgjZvDioCklPyEqTuFSMB9VUThK7gPnLqhCY9NXa6szgdKa1Vl+orZOTWqX/Hk
         +S8g==
X-Gm-Message-State: APt69E0yrW91fY5Fb6mj69w9g7KfxY0GNoaHyMbRwFjPEcY4xCAfyOPv
        TC+NERBwOUHWxGsKlQRz5FbMyQ==
X-Google-Smtp-Source: ADUXVKIeqG0Lt7gnsEpHw79uykG0jG9fgBFykfLkH8mCCVUWzeYUQioUU1Uh0bzoelZuFtVv4F/bvg==
X-Received: by 2002:a17:902:768a:: with SMTP id m10-v6mr27595670pll.293.1530572403401;
        Mon, 02 Jul 2018 16:00:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id v66-v6sm18878027pfb.84.2018.07.02.16.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 16:00:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     iivanov@mm-sol.com, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pinctrl: Document pin_config_group_get() return codes like pin_config_get()
Date:   Mon,  2 Jul 2018 15:59:37 -0700
Message-Id: <20180702225939.109169-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinconf_generic_dump_one() function makes the assumption that
pin_config_group_get() should return -EINVAL and -ENOTSUPP just like
pin_config_get() does.  Document that so it's more obvious.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/pinctrl/pinconf.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/pinctrl/pinconf.h b/include/linux/pinctrl/pinconf.h
index 09eb80f2574a..8dd85d302b90 100644
--- a/include/linux/pinctrl/pinconf.h
+++ b/include/linux/pinctrl/pinconf.h
@@ -28,7 +28,8 @@ struct seq_file;
  *	is not available on this controller this should return -ENOTSUPP
  *	and if it is available but disabled it should return -EINVAL
  * @pin_config_set: configure an individual pin
- * @pin_config_group_get: get configurations for an entire pin group
+ * @pin_config_group_get: get configurations for an entire pin group; should
+ *	return -ENOTSUPP and -EINVAL using the same rules as pin_config_get.
  * @pin_config_group_set: configure all pins in a group
  * @pin_config_dbg_parse_modify: optional debugfs to modify a pin configuration
  * @pin_config_dbg_show: optional debugfs display hook that will provide
-- 
2.18.0.399.gad0ab374a1-goog

