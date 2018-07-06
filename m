Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071A4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B5923DDD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gqhJfhOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B5923DDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933699AbeGFQXB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:23:01 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37935 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933402AbeGFQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:22:19 -0400
Received: by mail-pl0-f67.google.com with SMTP id b1-v6so3105545pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 09:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V6tFuVhw9q3NaTlCN0tBQIeSj1osbaNqt87EqArHcp0=;
        b=gqhJfhOUYitgZ+TYtSuFdwBBuUDXLxDjni2GNbG/LrCzSc7+NvpupdEW6VIBiMln6k
         9QtX+3AVT8FpsyMwD3LAxCzJhHIvjuHEcDL23DhdzsF3yZ/E2hgy3/3xEFbYVKXlojao
         hjo2pQ/1K8XcQBYEjPYd/uM6onYOItIdLXiXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V6tFuVhw9q3NaTlCN0tBQIeSj1osbaNqt87EqArHcp0=;
        b=pJlkmA9qfYEmG33TwA7NbDIBn+PCSDLrF0hjJ0KO8tj45ckB4wHQVCa0beXcNa711I
         WrK8XVcAWQ0Yhi4Pi3KE1VW4vUZc8VhDDNxM6y5hRLwzdKy7iCE7eRt431A13jjOMyTr
         fgcD9IZJjaWaGbVkt7VIioVTIDGdwRY07yx3fejcij0elsWFgdEqHM+ZXKT1HVzEH28+
         KYWGBQRongtipbJVMo7ATCz6TakrnQJoVbKaKEn3WQb88AmDvVjka43qC77FjM+6FtCP
         pERlJ4jwH1PqxKhzVyq92m1tfDwqP08jgqhqzikKirfqwNwLg613U4JWD0BnIAyuDNGc
         t0yQ==
X-Gm-Message-State: APt69E29+kuOCo2tgIhh92gB12Yv28Zkm2paIZgFXUyhLIHlJuNKvexh
        Ijswa1OKsqRx/BBWBZmKOr61n2WnHFc=
X-Google-Smtp-Source: AAOMgpc/BK0cKXOVR1VGfifumkg4fnmJj+iO8sBVoEOd/EEKdIVKBkiFOKp82YU5v27KmxmKuJt7AQ==
X-Received: by 2002:a17:902:e281:: with SMTP id cf1-v6mr10943824plb.86.1530894139277;
        Fri, 06 Jul 2018 09:22:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id e125-v6sm8926688pfe.52.2018.07.06.09.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:22:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bruno Herrera <bruherrera@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 2/4] usb: dwc2: Turn on uframe_sched on "his" platforms
Date:   Fri,  6 Jul 2018 09:21:52 -0700
Message-Id: <20180706162154.196345-3-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
In-Reply-To: <20180706162154.196345-1-dianders@chromium.org>
References: <20180706162154.196345-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to have the uframe scheduler off on dwc2.  Running
with uframe_sched = False is equivalent to saying "I don't want to run
the correct code, I want to run the old and incorrect code".

The uframe scheduler has been off on HiSilicon since commit
37dd9d65cc41 ("usb: dwc2: add support of hi6220").  Since then there
have been many many improvements, notably the commit 9f9f09b048f5
("usb: dwc2: host: Totally redo the microframe scheduler")

Presumably if everyone is good w/ the uframe_sched turned back on we
can kill all the old and crufty non-uframe sched code.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/usb/dwc2/params.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 14b8742e62fa..db97bb16ecc4 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -67,7 +67,6 @@ static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
 	p->reload_ctl = false;
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 <<
 		GAHBCFG_HBSTLEN_SHIFT;
-	p->uframe_sched = false;
 	p->change_speed_quirk = true;
 	p->power_down = false;
 }
-- 
2.18.0.399.gad0ab374a1-goog

