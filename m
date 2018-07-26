Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B43EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415F120671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jYChSlM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415F120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbeGZV0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:26:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42323 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbeGZV0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:26:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so1802876pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/myg6m+9/E2E5usmaA3mgBuQgW1vnAMb6sfkOe5tok=;
        b=jYChSlM7RnMm2wPFHBUMCAw2dL4hsCluRiGF/p5szHUtz8pdiOYpM8xEXY0QvhCc2O
         u6GuZehq+9VJJZmuLU2ukUtoqqq0FhAFla52X5fVdjHVrFYf9fWmlRwFBKIZKaj3idC3
         wybTMcBcZF7hqLY9wR/f01qaRV88AICE09YTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/myg6m+9/E2E5usmaA3mgBuQgW1vnAMb6sfkOe5tok=;
        b=ADwj2gLDcBzlaCh6uHv/EuvDlxz8rzY2rWzyc2Ij2aGXj33W4UnXki2VLXN85zcYVp
         VQ1/cnE/FXwt0eUKBWwEj/fKlwV99IKRYviJMK15wWxdKHVepREffptn7luO58ft+Kko
         bKfGRMdDqa5c034yExwCT3BrM3MsWn0CcLBGe5BGMRrhxOR0kjx4v3fz31Q5SfEHHjkw
         3HXuNF2d5XgBxVfFoj95oZAPAl7g6js4pyivylrO52qej1YIr1TrW5W4W0J5cmjdZ4JH
         1zykCSl68SVSRYD59D+Gy7dh70SCiJonjf1mu53/fa51WR9Kh2RQ7WhXg6KKaqA/G9Ns
         HDGw==
X-Gm-Message-State: AOUpUlHe7nUb4vhX1AMbN7xRlwyTaRt9SGwtPgdmckirThUEye5bS/CT
        4UJBFOniAVzVjqLFKcQYpZeZww==
X-Google-Smtp-Source: AAOMgpcD9dtJtKK85I4RVkl1vzkP+CHk3cdc63Iv+Dt0fV67dvsEw0HGXsF6uml0d/rpFrfcIJXFQw==
X-Received: by 2002:a62:930c:: with SMTP id b12-v6mr3476478pfe.193.1532635680239;
        Thu, 26 Jul 2018 13:08:00 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id u11-v6sm5784169pfd.117.2018.07.26.13.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 13:07:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     balbi@kernel.org, hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     stefan.wahren@i2se.com, grigor.tovmasyan@synopsys.com,
        Bruno Herrera <bruherrera@gmail.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>, john.stultz@linaro.org,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [REPOST PATCH 1/4] usb: dwc2: Turn on uframe_sched on "bcm" platforms
Date:   Thu, 26 Jul 2018 13:07:27 -0700
Message-Id: <20180726200730.18290-2-dianders@chromium.org>
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

The uframe scheduler has been off on Broadcom since commit
58b179dcf28c ("staging: dwc2: disable uframe_sched on the bcm2835").
Since then there have been many many improvements, notably the commit
9f9f09b048f5 ("usb: dwc2: host: Totally redo the microframe
scheduler")

Presumably if everyone is good w/ the uframe_sched turned back on we
can kill all the old and crufty non-uframe sched code.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
---

 drivers/usb/dwc2/params.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index af075d4da895..14b8742e62fa 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -47,7 +47,6 @@ static void dwc2_set_bcm_params(struct dwc2_hsotg *hsotg)
 	p->max_transfer_size = 65535;
 	p->max_packet_count = 511;
 	p->ahbcfg = 0x10;
-	p->uframe_sched = false;
 }
 
 static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
-- 
2.18.0.345.g5c9ce644c3-goog

