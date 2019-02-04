Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19CEC4151A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CAD214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmZuOKV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbfBDQ0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:26:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45716 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfBDQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:26:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id q15so433554wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uh0mWn8UrzjjJpP8IvQQtBqJhS8PhQJ/5HnUmOlZIks=;
        b=gmZuOKV+QFRNuw7Xiq01qUxU2MZBcpwkazl6G5C+h5WY9pAGCiz91/y7DoyN/0jhFY
         DZ8i3Vafab444Z0m63eLyReMXiadyi2xz0C+aOngk/lRbyG81BWpa+kBRlKmiLkPSDct
         YfqFD1w+6asWT2k4jairtsCwvVi474zCNUtO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uh0mWn8UrzjjJpP8IvQQtBqJhS8PhQJ/5HnUmOlZIks=;
        b=gzoVrM1yc9LpplA4RMvambaHynufPg15jBfAWNsft8JU7CCoN4HDXzNzMZvFu+D5zH
         9Gl2coNxmaBjMxyNFyXqPJkszcZpNPslWs275Zc0KDxZCUWfgImuObW4vMvuL/R9jG3X
         nS6nbs7LdWaHrc7dJThwic3HAElNEhZOoW7jDWyWIKex6JgrpvmKfumiLsOiOIsPY6S1
         FsxllZdT0Bs72kdZOVYuErBeINa7rHHzTf9uMUDXPtf5Un+WZx6IzFCg6Y+TkFquszqQ
         eubPnSqXBokWugqcPEcEJEMppLHBBnSG0RlJXUWaOa+jWfEPz/taDBWeka7sjusf7uzS
         vimQ==
X-Gm-Message-State: AHQUAubYTiyMRJ/BftIvnJdW67CLvWIS8L2XyFR3uB2FClzx9+IJoLMp
        GwlL2Js+glM3l7uLKCZTYOMIJw==
X-Google-Smtp-Source: AHgI3IbIksHA+DShAzSt1p3DgS3JyqNTcMkRaDm5sNHqKr9m4slS51ApzahFGlivX+nk/RtPLDUzrg==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr148455wrw.310.1549297558732;
        Mon, 04 Feb 2019 08:25:58 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70b6:b9c6:89e2:36a])
        by smtp.gmail.com with ESMTPSA id a4sm1251992wrt.37.2019.02.04.08.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 08:25:57 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, ulf.hansson@linaro.org, biju.das@bp.renesas.com
Cc:     linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org,
        thara.gopinath@linaro.org, linux-renesas-soc@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/2] PM-runtime: move runtime accounting on ktime_get_mono_fast_ns()
Date:   Mon,  4 Feb 2019 17:25:52 +0100
Message-Id: <1549297553-17647-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to what happened whith autosuspend, a deadlock has been raised
with runtime accounting in the sequence:

change_clocksource
    ...
    write_seqcount_begin
    ...
    timekeeping_update
        ...
        sh_cmt_clocksource_enable
            ...
            rpm_resume
                update_pm_runtime_accounting
                    ktime_get
                        do
                            read_seqcount_begin
                        while read_seqcount_retry
    ....
    write_seqcount_end

Move runtime accounting on ktime_get_mono_fast_ns()
With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
monotonic across an update of timekeeping and as a result time can goes
backward. Add a test to skip accounting for such situation which should
stay exceptional.

Fixes: a08c2a5a3194 ("PM-runtime: Replace jiffies-based accounting with ktime-based accounting")
Reported-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 1caa394..50740da 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -66,13 +66,22 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = ktime_get_mono_fast_ns();
+	u64 last = dev->power.accounting_timestamp;
 	u64 delta;
 
-	delta = now - dev->power.accounting_timestamp;
-
 	dev->power.accounting_timestamp = now;
 
+	/*
+	 * Because ktime_get_mono_fast_ns() is not monotonic during
+	 * timekeeping update, we must ensure that now is after the last saved
+	 * timesptamp
+	 */
+	if (now < last)
+		return;
+
+	delta = now - last;
+
 	if (dev->power.disable_depth > 0)
 		return;
 
@@ -1312,7 +1321,7 @@ void pm_runtime_enable(struct device *dev)
 
 		/* About to enable runtime pm, set accounting_timestamp to now */
 		if (!dev->power.disable_depth)
-			dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
+			dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
 	} else {
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
 	}
-- 
2.7.4

