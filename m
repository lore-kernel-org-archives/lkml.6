Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A3EC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCD020862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OD5guXgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCD020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbeGZV01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:26:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41427 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731504AbeGZV00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:26:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so1803421pgu.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5ISkcd4OFF7lL/r7udB8vKFGOj44Y74EZmaS9ksBcc=;
        b=OD5guXgfjtPnqOoPztqSAT2onCZGRpWRpcqpqOJ6ix58Hbx9461pM8x7tqO1q/JN3S
         3ohKncJQmwPuh5ypjtuO7AnTxlM2eMqddtWyNqis6Nd+xf2g5bfKZNPfsGoLqCpQTngn
         EdEGXbZg1PqRcm6nYjs8yiMEI4Tm+I+/gdAUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5ISkcd4OFF7lL/r7udB8vKFGOj44Y74EZmaS9ksBcc=;
        b=UtnWMsH9aFJhozEzEatW3EzHtVTp9iaP+sA+ad2DGakFbvM950Ct3R34awpCVty8ER
         qFWlW5ZuJG8kcHIOD/pmvkMLvBAznbKaU1CSFnFXR7iS3iK7rpyYMN/Mk1Ycb0H9Io8A
         M4X+WqMgoLhEILWyaYo1Zhp0ZfUMN6FOaY9VX5eVcv4R8YcoD/KomQTajtIuSyC9B8bu
         7roHVqAjCYLOw0wB3L2cQxZNFKD9QcTwcBHLMGeaaje/j7DVBxFB0GBQRXGGVj4DhXR2
         r66yImbTzoa+7AAh1x4Y1k4yLCqY++SSJG9E/VcOuSb5KQ3QmtrBs8nxwY+mLR426SrZ
         6XIw==
X-Gm-Message-State: AOUpUlGCaIOHBleQkvt6GKtcKu3Yq6QAj9Nz/HqFCNuWV59tb+Ka6QZo
        Hc7U2Kf+MEjbGB1oICfDdMySIA==
X-Google-Smtp-Source: AAOMgpfZUUQvn0cT6OrLJVROHeARBUZI1ihZBf6CLB8hJ479EvKbBA9I8Z37qR0XhEdEhDL/CDSeLg==
X-Received: by 2002:a63:7d48:: with SMTP id m8-v6mr3321908pgn.0.1532635681614;
        Thu, 26 Jul 2018 13:08:01 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id u11-v6sm5784169pfd.117.2018.07.26.13.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 13:08:00 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     balbi@kernel.org, hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     stefan.wahren@i2se.com, grigor.tovmasyan@synopsys.com,
        Bruno Herrera <bruherrera@gmail.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>, john.stultz@linaro.org,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [REPOST PATCH 2/4] usb: dwc2: Turn on uframe_sched on "his" platforms
Date:   Thu, 26 Jul 2018 13:07:28 -0700
Message-Id: <20180726200730.18290-3-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180726200730.18290-1-dianders@chromium.org>
References: <20180726200730.18290-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Tested-by: John Stultz <john.stultz@linaro.org>
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
2.18.0.345.g5c9ce644c3-goog

