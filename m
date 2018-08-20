Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D83C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E44F2170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZVNY3sJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E44F2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeHTSua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:50:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38401 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeHTSua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:50:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so6947009pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id;
        bh=qMyHORIoNYPSIueH4e/M3+17FAqMwSDrQJGLfkY3URU=;
        b=ZVNY3sJIwO3XuHiz0cI87HyVdC1EOsAOSydFf/Kto9JVWuN4kHWFhbaNJ6z2hxpwlr
         KcFyX/SlYZyNIdGWfJc29JiN9rmFxgNoz1FHBQ8aPdwg6EY9Fa962uHPbA2I7Ur9xJS8
         TX1nXFv5Ia7aUirXv3/V2S4QfRuG2ncIx5fgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=qMyHORIoNYPSIueH4e/M3+17FAqMwSDrQJGLfkY3URU=;
        b=NLQJXFZp0kNGLjcrbBoo5kTf8xK5szo8HDT36ENaWkKq+vuRwCvmwpY+iiNydgTXEr
         WXVxfGnFnh/IyZ0hDSISUslKDlelmVsC1G9QOxU5KxCLB3QsYeSc72IAeeJInu8X1ApO
         uP2lCYdvAafD1f/Uf0qhgb9THVXlECFjWtg9jhK6q5Ey161NNuPVdlKTTXU9Yh+pSY0h
         a0woh+3aNWPhnbYcBrtC0lYYp0h/c8oKY8AsQxyVQ1RkXCWbwyBEwW2b335DkL1zvowg
         eIWzvXhxfYRxB2W5sN7aSnse9dQ0L0WIqA3CGDoLFSInr0T6NIhi1FX8v+GR6li5p8/c
         ZCUw==
X-Gm-Message-State: AOUpUlFAkZxZh7yahUxJluDP0nU7mBI1dMP0aC0oyKnr0TcUBX94UaXn
        RkFD1dlJ5fX3Z5AKxwI2taEIuA==
X-Google-Smtp-Source: AA+uWPxh6IslMtWTJi5mLBELLcLbp13F/tZiX3PzQugsOiVGo78IspHA3KmmLT/mXvViEwyrW4S02Q==
X-Received: by 2002:a62:bd4:: with SMTP id 81-v6mr49007352pfl.67.1534779264272;
        Mon, 20 Aug 2018 08:34:24 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:9f2c:2145:3c42:4e88])
        by smtp.gmail.com with ESMTPSA id k64-v6sm17064728pfg.141.2018.08.20.08.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Aug 2018 08:34:23 -0700 (PDT)
From:   RaviChandra Sadineni <ravisadineni@chromium.org>
X-Google-Original-From: RaviChandra Sadineni <ravisadineni@google.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        ravisadineni@chromium.org, ravisadineni@google.com,
        dtor@google.com, linux-samsung-soc@vger.kernel.org,
        tbroch@google.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com
Subject: mfd: cros_ec: Check for mkbp events on resume only if supported.
Date:   Mon, 20 Aug 2018 08:34:19 -0700
Message-Id: <20180820153419.32098-1-ravisadineni@google.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on every resume we check for mkbp events and notify the
clients. This helps in identifying the wakeup sources. But on devices
that do not support mkbp protocol, we might end up querying key state of
the keyboard in a loop which blocks the resume. Instead check for events
only if mkbp is supported.

Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
---

 Note: This patch fixes the suspend/resume issue on Snow and Peach-Pit
 Chromebooks, both on vanilla v4.18 as well as linux-next from 20 August 
 2018. Further info at: https://lkml.org/lkml/2018/6/5/1076
 
 drivers/mfd/cros_ec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 65a9757a6d21..fe6f83766144 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -218,7 +218,8 @@ EXPORT_SYMBOL(cros_ec_suspend);
 
 static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
 {
-	while (cros_ec_get_next_event(ec_dev, NULL) > 0)
+	while (ec_dev->mkbp_event_supported &&
+	       cros_ec_get_next_event(ec_dev, NULL) > 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier,
 					     1, ec_dev);
 }
-- 
2.16.4

