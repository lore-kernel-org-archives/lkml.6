Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC6DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164D8216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SDXEFUWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164D8216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeI1C4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:56:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41878 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeI1C4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:56:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so2690662pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFTLVJAKx+sexf/Xa3m9BU7+lRei3FyqM0RY7ixgKMQ=;
        b=SDXEFUWkZOlUfxvW+Dr5m/MSA8xOzZ+YmmJoigAGWr3cy2o9Imix6frbeBq7SJAw1O
         cqKVLp47uEDy08cOsEv8uZKiCvjFHBgpKHOVCoz38cuaFYdQsU3F3OF0yiXHBTSmePD+
         nLkGWG9Tq2v3+/SWmv2C9tA9tV0vsu89mDA08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFTLVJAKx+sexf/Xa3m9BU7+lRei3FyqM0RY7ixgKMQ=;
        b=At7npWOXHFbe2+981WYU6nGnUOdiLy2DDJ3YNsIq6BmuUHUtJhYKdktr7ZOV9O+Mxe
         BbhNt1BN6FZHLymlQR0kUlo19rlDXL3N7sjvm9nBClogniVQvRnBq5O+5KOb7k+YjGc7
         9uweZrEm9GCXAoHfESIOy5CUaVXL0At0lGowy6fz+GwqhYYWlZZY9+gmI0yoPj09k2XX
         t7/RiabycjWnh0m9QakqdklhoF0XbntYwH6ZJ299enTLaSy341kHY8bY5ZP3AEl0BkZq
         G7UR20rkKkS9/8fEGMyk5pqkCrI1plARH/L3gdv1Zt985SG/b6lHUryDUyL5qja7NJ0A
         ifwg==
X-Gm-Message-State: ABuFfogTuJSTs7T9b86cQ8c8wu1Yizx4RtFIgKHRfsnw4+5zREHTe1xU
        0xYednj5JJm9iY09HpRMjfgc5w==
X-Google-Smtp-Source: ACcGV63PXyCg8g1tZFkGLNm9PtNbl1dxNsGv8TwPEieQ7U/33T1HzHL4vtr/Ahxo/omxwy6yIQZSCw==
X-Received: by 2002:a62:22c7:: with SMTP id p68-v6mr13188086pfj.53.1538080565191;
        Thu, 27 Sep 2018 13:36:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id f67-v6sm6104968pfe.75.2018.09.27.13.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:36:04 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     rjw@rjwysocki.net
Cc:     Dilip Kota <dkota@codeaurora.org>, dtor@chromium.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [RFC PATCH] PM / core: skip suspend next time if resume returns an error
Date:   Thu, 27 Sep 2018 13:35:23 -0700
Message-Id: <20180927203523.60856-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general Linux doesn't behave super great if you get an error while
executing a device's resume handler.  Nothing will come along later
and and try again to resume the device (and all devices that depend on
it), so pretty much you're left with a non-functioning device and
that's not good.

However, even though you'll end up with a non-functioning device we
still don't consider resume failures to be fatal to the system.  We'll
keep chugging along and just hope that the device that failed to
resume wasn't too critical.  This establishes the precedent that we
should at least try our best not to fully bork the system after a
resume failure.

I will argue that the best way to keep the system in the best shape is
to assume that if a resume callback failed that it did as close to
no-op as possible.  Because of this we should consider the device
still suspended and shouldn't try to suspend the device again next
time around.  Today that's not what happens.  AKA if you have a device
that fails resume every other time then you'll see these calls:
1. suspend
2. resume (no error)
3. suspend
4. resume (fails!)
5. suspend
6. resume (no error)

I believe that a more correct thing to do is to remove step #5 from
the above.  To understand why, let's imagine a hypothetical device.
In such a device let's say we have a regulator and clock to turn off.

We'll say:
  hypothetical_suspend(...) {
    ret = regulator_disable(...);
    if (ret)
      return ret;
    ret = clk_disable(...);
    if (ret)
      regulator_enable(...);
    return ret;

  hypothetical_resume(...) {
    ret = clk_enable(...);
    if (ret)
      return ret;
    ret = regulator_enable(...);
    if (ret)
      clk_disable(...);
    return ret;

Let's imagine that the regulator_enable() at resume fails sometimes.
You'll see that on the next call to hypothetical_suspend() we'll try
to disable a regulator that was never enabled.

...but if we change things to skip the next suspend callback then
actually we might get the device functioning again after another
suspend/resume cycle (especially if the resume failure was
intermittent for some reason).

Obviously this patch is pretty simplistic and certainly doesn't fix
the world, but perhaps it moves us in the right direction?

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/base/power/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3f68e2919dc5..27c7d1f76cee 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -999,7 +999,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 
  End:
 	error = dpm_run_callback(callback, dev, state, info);
-	dev->power.is_suspended = false;
+	dev->power.is_suspended = error;
 
  Unlock:
 	device_unlock(dev);
@@ -1750,6 +1750,9 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
 
+	if (dev->power.is_suspended)
+		goto End;
+
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
-- 
2.19.0.605.g01d371f741-goog

