Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58070C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DF42086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVIn4Wnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfBUH7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:59:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37492 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUH7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:59:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so8846240wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 23:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wd5LWqxi3KTL1mk2vfXcGPq8iJCNRzZJVnK0M/1Bo3U=;
        b=bVIn4WnrPcR4HTYDzRKojaZ50k3GEfJW7Sksmhzc/679sbwDlgI2DA5Gs1UvmPeQwZ
         ZQJBAQ29bKaDtL4yT6B7KkLO4O4HkVub2imU1j6cLxBviJ3PQ3ZR/vrw7s9aRT727icr
         l7v7ITADpl/TXytVuSDehgcFhc0OrM7ytHMs6o7GABVjrvSJDZOLo787S58bB5+W87B3
         6nCLqR5RdiGg/9Ks+pHvv86fQ6goEN25lPRO8CLii2y+IvG2ogkV5kZFtAQ+HT3e2Qtv
         kPIDSVsIgnLnBFrFD8hUEMrABLNL41O+qXcM3Ocab8fE5K9WMo0ODNNF2UQRBjS2iiO7
         ELGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wd5LWqxi3KTL1mk2vfXcGPq8iJCNRzZJVnK0M/1Bo3U=;
        b=CGI7KYtT6meaGdtyfObCUECzo65OoHuhv+g31XF/EeaRkn19BbWwy55s1rAl2OfH6c
         xWx61ocOkgAGPNB/8ii0iCmwOI+rdRQog1ThgsNZTSPzfcaCIK9rbSnSXdP2umqXE2iK
         3pbAKNHEhvNHeoq/h9VF7cj+FNmucDfPwUA2gEmQGXmLaUgt2QTEQU3JHre78Au0X1eo
         /8q5lmp+6QER9gu7hfHlnJLlC72QZBx580+Gwdymn0efHQN339WcG/InkdeDLnOU7623
         3ny5J+b9Uo2jfnwfwKi0BYxbP6msowkCA+rjmy3fFRSnsSZP8KpCMe4aaWbiSRPkrxs9
         EwcQ==
X-Gm-Message-State: AHQUAuYafGk/Fj21NLDT0F1H6VML3GGHk2fZJeeyoMF7pDfkO18bap7B
        421Ni3HvJBvdXdnRYJG/dpUZ6g==
X-Google-Smtp-Source: AHgI3IZbHPzMylUlX8znklRpZt8Js/R70hjxQ5T3DuZ42/aaRjBoP2ALBXGBtxVjwwPJ9do6lNHT3w==
X-Received: by 2002:a1c:dc8a:: with SMTP id t132mr10206801wmg.48.1550735948722;
        Wed, 20 Feb 2019 23:59:08 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:a9b1:5119:7e50:9df])
        by smtp.gmail.com with ESMTPSA id o12sm73384517wre.0.2019.02.20.23.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Feb 2019 23:59:07 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, ulf.hansson@linaro.org
Cc:     sunzhaosheng@hisilicon.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] PM-runtime: fix deadlock when canceling hrtimer
Date:   Thu, 21 Feb 2019 08:59:02 +0100
Message-Id: <1550735942-3569-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rpm_resume() desactivates the autosuspend timer, it should only try
to cancel hrtimer but not wait for the handler to finish because both
rpm_resume() and pm_suspend_timer_fn() are taking the power.lock.
We can have the deadlock sequence:
CPU0                              CPU1
rpm_resume()
  spin_lock_irqsave
                                  pm_suspend_timer_fn()
                                    spin_lock_irqsave
  pm_runtime_deactivate_timer()
    hrtimer_cancel()

hrtimer_try_to_cancel() is enough because dev->power.timer_expires is also
set to 0.

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Reported-by: Sunzhaosheng Sun(Zhaosheng) <sunzhaosheng@hisilicon.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 04407d9..78937c4 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -121,7 +121,7 @@ EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
 static void pm_runtime_deactivate_timer(struct device *dev)
 {
 	if (dev->power.timer_expires > 0) {
-		hrtimer_cancel(&dev->power.suspend_timer);
+		hrtimer_try_to_cancel(&dev->power.suspend_timer);
 		dev->power.timer_expires = 0;
 	}
 }
-- 
2.7.4

