Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D434FC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8928C20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J/2EgAKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8928C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbeGZV0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:26:31 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36416 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbeGZV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:26:29 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so1289698plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wc5hbhavH7L2NkclXtN89Ag9ST2Hc6CGNYH6SJz0Sjs=;
        b=J/2EgAKpJggjM+FxQO4ZigL5pOsa2VS81Zd4JTat8gkRSe4+w+e67RkxPndSCVr9s7
         UWbWWIF9A8qeoHVZawq/yoqmkuv2MVhjaHQi8KGSCgDqBp3Eta0y5zQGH2w/N0Ms34Vq
         M+Hhu0wAXOBFW+hBTFs57X8w1Wi+5PT/mZJNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wc5hbhavH7L2NkclXtN89Ag9ST2Hc6CGNYH6SJz0Sjs=;
        b=DAwcIb0LI84xKJP3xh7oHfw3Zmxi2YB/E+YvyWpzj6ZKcs6zCJSWvPXjQeYneY6Fbv
         qN7XK3bCwRhh0Ia/our5q4vc5Lx9/qXuopRpoOUVM7hQ0+DbT2YXs9V+OvpT7q55OK4S
         TunG88ge+9uRkJIGegC8mfTezCeeitWDb/QUEthOyDnkQvrquQz2m48JkvnsqaETOod0
         jpZi6hALCPcDFJ3MDppDJ4ESS2oZqyXMyRT2Fsu3jVio8zKsrbiyPpSDA7YTymLFJEpC
         DDJXjbsKLBQ8FhHvbPCeTR4YXctsVUf0BzTy/9LnAHG+oNtnKYnAxvrE/CUet+iHla0W
         Fg5Q==
X-Gm-Message-State: AOUpUlFoPUOIZtnwY3PhUK2alhFjHMOkPwxf1lgdiKJLcnRL5FYONVbh
        4gEey8d+hsNKrlsXnNbd8D/g7g==
X-Google-Smtp-Source: AAOMgpf+aFE9GQhs9ldJn5LrKjljoJ5SWqNFcLU7bAEVC6sXMVeMJhRia4DThQe+gBmI0K/dV4X1Ig==
X-Received: by 2002:a17:902:294a:: with SMTP id g68-v6mr3361812plb.58.1532635684415;
        Thu, 26 Jul 2018 13:08:04 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id u11-v6sm5784169pfd.117.2018.07.26.13.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 13:08:03 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     balbi@kernel.org, hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     stefan.wahren@i2se.com, grigor.tovmasyan@synopsys.com,
        Bruno Herrera <bruherrera@gmail.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>, john.stultz@linaro.org,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [REPOST PATCH 4/4] usb: dwc2: Turn on uframe_sched on "stm32f4x9_fsotg" platforms
Date:   Thu, 26 Jul 2018 13:07:30 -0700
Message-Id: <20180726200730.18290-5-dianders@chromium.org>
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

The uframe scheduler has been off on stm32f4x9_fsotg since commit
e35b135055e2 ("usb: dwc2: Add support for STM32F429/439/469 USB OTG
HS/FS in FS mode (internal PHY)").  That commit is pretty recent, so
it's unclear to me why the uframe scheduler was left off.  Hopefully
it's because someone copied it from other parameters and didn't think
to try it?

Presumably if everyone is good w/ the uframe_sched turned back on we
can kill all the old and crufty non-uframe sched code.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/usb/dwc2/params.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 93380f7c32b4..7be35bcde713 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -131,7 +131,6 @@ static void dwc2_set_stm32f4x9_fsotg_params(struct dwc2_hsotg *hsotg)
 	p->max_packet_count = 256;
 	p->phy_type = DWC2_PHY_TYPE_PARAM_FS;
 	p->i2c_enable = false;
-	p->uframe_sched = false;
 	p->activate_stm_fs_transceiver = true;
 }
 
-- 
2.18.0.345.g5c9ce644c3-goog

