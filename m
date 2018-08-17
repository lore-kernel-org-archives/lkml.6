Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18473C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3142170B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mnkFNYGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3142170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeHRA0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 20:26:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44930 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeHRA0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 20:26:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so4004872pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 14:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=IA6SmaLVr+ETtsp29EXWBRBcXR13M9iZ3XYAYd82Q9o=;
        b=mnkFNYGbE4ItU8JFkl0o1h6OsVYA1dNCw2zR9FuGBd0mAB3AwohCyEcm67wvB9VyUd
         KJgPKcrzgpxJWV0npPnD0RDO5RjYQqwI9eKvtpoGvG4IKb8Fdy5jxzRvX9MCyTRCZn63
         U9bEBjGzNIvxlpclSyHOHbx1HCmxqKkRldAFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=IA6SmaLVr+ETtsp29EXWBRBcXR13M9iZ3XYAYd82Q9o=;
        b=TJT9UvzwukTp88Cj+dcoIabP1G1CUrKjud4QnGerldMzajKiBip05MBM1TN3VXBvuH
         5uyMe9H93Kt8OvNQkq7YsYDMS2Q4LaaA6FilgCtc9hnrob9qetpOsLAdjLAYRFyeZy1/
         GRu8Ti37vt3LMnBrahHrltFmBZoi8qADPzKXYRWS1jbsj9bj0YgjMhf3YYvtFu2cx5J3
         bnyMy2IQSw8DWZY2J4qnW0asfAvxYoGvm+6GjT1RreMklG08jsNJoLjnLkDnDh/P743y
         wqfndDDCfnJyivmoPSPrXH3BN68HImVZYUaqXaERhcXkzWvyKKhojA3pShSagjdVOy0N
         uJpg==
X-Gm-Message-State: AOUpUlF2FUQUral+Elip4mVx/9sGTW3kVTypcHQQK5ZQmF0gusdrkfgz
        N8F30iHYIt6rTEcOn/xVsZIm3g==
X-Google-Smtp-Source: AA+uWPz9Hx40jZqVQ12/qGPpQVp5q8pFQ9LYZhiVLfrLDDv3+4QyVMN2DrelVSZSZTs/RkSlJKCwjw==
X-Received: by 2002:a63:788b:: with SMTP id t133-v6mr34347695pgc.329.1534540904936;
        Fri, 17 Aug 2018 14:21:44 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:9f2c:2145:3c42:4e88])
        by smtp.gmail.com with ESMTPSA id h10-v6sm5640989pfj.78.2018.08.17.14.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 14:21:44 -0700 (PDT)
From:   RaviChandra Sadineni <ravisadineni@chromium.org>
To:     dmitry.torokhov@gmail.com, ravisadineni@chromium.org,
        ravisadineni@google.com, dtor@google.com,
        linux-samsung-soc@vger.kernel.org, tbroch@google.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        tfiga@chromium.org
Subject: Input: cros_ec_keyb: Remove check before calling pm_wakeup_event.
Date:   Fri, 17 Aug 2018 14:21:35 -0700
Message-Id: <20180817212135.222689-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180810082344eucas1p2c525a61cb176b4ab1dab22347afd539b~JeE3uTBkU1731217312eucas1p2T@eucas1p2.samsung.com>
References: <20180810082344eucas1p2c525a61cb176b4ab1dab22347afd539b~JeE3uTBkU1731217312eucas1p2T@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: RaviChandra Sadineni <ravisadineni@google.com>

hi Merek,

Unfortunately I could not get the device to boot even after using the exynos_defconfig. 
Can you please try this patch and see if this fixes the issue. If not can you enable the
debug logs and send me the logs.


Currently on every resume we check for mkbp events and notify the
clients. This helps in identifying the wakeup sources. But on devices
that do not support mkbp protocol, we might end up getting key state of
the keyboard in a loop and block the resume. Instead check for events only
if  mkbp is supported.

Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
---
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

