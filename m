Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7166CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3581B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LhWHhCw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3581B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeKTKxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:53:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46325 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732427AbeKTKx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:53:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so58652pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQFlPoUGI7dL3RgysecfMO9uU1Gp9bEesffpxHIWcbg=;
        b=LhWHhCw/9X1OHGJIoGLEMjHPI2U2BkEL6SWuIantHdrjEIqIubSKUVh1UrzB9u5jAZ
         kEoQYJs2znHvxRilIe7ZnjYoQEbyVLuWeHpQtCsllJ5MDZrQ+3BCIrIZrrQjuk0ERD/u
         Iw9YlOtrKyfrM27H6i8E6hDeFHKppvB+N6uFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQFlPoUGI7dL3RgysecfMO9uU1Gp9bEesffpxHIWcbg=;
        b=SSongBFU27GNftSMU6uiZhg5vWefW4SvgPR2KBb3/VHe8hwMNI43v5VHeVO9lZaCiy
         14xaMPnGd/w1/7hWPcrru+6VgRwQfP/0sCJ5XtpTtXo2shaiOW+WdrTsAN6UcpXiIuoB
         03PWAqMQlGX4t6YDJ0m44RKVAPwsbh9EGfOXjh0NoVkTbTkBWy+4kPHcnO10QX7iAqwZ
         n5jWKtIIPVskx0WOi3dpN84GDgW8VmpPYTTPGEBzLEFGpRjc0g1ffNikIrh0mB0OZwkN
         rfQS6yPIwcEu5E++kAmoybdlb94f/ZTP0fCnIfujHPjzm39Sh/K46hI/LKx/LzNbetmg
         wyBA==
X-Gm-Message-State: AGRZ1gKBV/0mf3ya4WluBjFSfGZ6QM/7bY7eA1AlO9qBAKfe2fBVUrea
        FuIOmejCkFHJ9XJD1vLpj4DmiQ==
X-Google-Smtp-Source: AJdET5fQ0KJE0bfhjpzc/y+7dXArN1FfliIemF3+2oXhNSamjz/Q4VyC7QwJG5xQWN0pOIj7GVXBYA==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr2371061pfb.209.1542673631650;
        Mon, 19 Nov 2018 16:27:11 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id z83-v6sm55240218pfi.4.2018.11.19.16.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 16:27:11 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        swboyd@chromium.org, Dmitry Osipenko <digetx@gmail.com>,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] regulator: core: add enable_count for consumers to debug fs
Date:   Mon, 19 Nov 2018 16:26:52 -0800
Message-Id: <20181120002654.1891-5-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181120002654.1891-1-dianders@chromium.org>
References: <20181120002654.1891-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that consumers all keep track of their own enable count, let's add
it into the regulator_summary.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c5da6079e1cb..23e852d38b88 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5305,8 +5305,11 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 		switch (rdev->desc->type) {
 		case REGULATOR_VOLTAGE:
-			seq_printf(s, "%37dmA %5dmV %5dmV",
+			seq_printf(s, "%3d %33dmA%c%5dmV %5dmV",
+				   consumer->enable_count,
 				   consumer->uA_load / 1000,
+				   consumer->uA_load && !consumer->enable_count ?
+				   '*' : ' ',
 				   consumer->voltage[PM_SUSPEND_ON].min_uV / 1000,
 				   consumer->voltage[PM_SUSPEND_ON].max_uV / 1000);
 			break;
-- 
2.19.1.1215.g8438c0b245-goog

