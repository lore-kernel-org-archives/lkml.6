Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A17BC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A8323DDD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iHgD+fUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A8323DDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933683AbeGFQW0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:22:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37345 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933336AbeGFQWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:22:22 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so3099553plc.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 09:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/KPLtXATXcbvJucvbamLqM5yqUuoHw6PR+c5raAL6A0=;
        b=iHgD+fUvi6Nqj5Z+luiuuZtS6DXUH8TsrQW5XNjUo5dtjaPICbuOqm4m/Jdit9MTYD
         C9eA7mh3aY3M6xq+YgOLGZbAlwWKxVahibZ2cy8c0OM0TGTrukX06p97uTe9BUn8Wzy+
         5F9eY0VhrNIMhNTxIXypjZQkzFS9UAnSFG7SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/KPLtXATXcbvJucvbamLqM5yqUuoHw6PR+c5raAL6A0=;
        b=Mq//fD8hT402oYz0N+XP3fYdye0TD3PeIqUzlxtch8DkW9q96nKSOjXw3/pmmYPWY3
         R9Rtf4JHnywZKA2QhBJ9zRCgaPhGCMQalsSMlH1VlvAh6vxMeCGK90Nnje327Y+AZYFU
         SFGKrMWUmeBlmV+NpAppR9TFvo/MOzV0ih2Py70Qf/PLj3Pa7xvpUm8CLiB6l0xw0ZFg
         ZovjT6KFaacPk4EMJ5Zt8sSb38lWEi9sCfr3LvhKqkzu+FFN082tEq+dNUvilrWcBwER
         Gjexqh0VEuCaxqX/2UjSPYhAzG6Tb/xTzCnb+Rx4fVJwZzjc//WV8Zt4P60ZodubQj8t
         XDLw==
X-Gm-Message-State: APt69E2AxuoEvqji15u7eJIOM5//dHPs9+dPkyqmLTgJ25zwhacplDPQ
        3cSLbGw7k2tf2+eDVq8Inx8NCA==
X-Google-Smtp-Source: AAOMgpc5KKKqfATpgSmUgKIDRihxDlFIr+6pXfTENmQBsJzsdBG/zi0DSq66tQkOJhwuQytZXhwkAQ==
X-Received: by 2002:a17:902:3c5:: with SMTP id d63-v6mr11179170pld.163.1530894141977;
        Fri, 06 Jul 2018 09:22:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id e125-v6sm8926688pfe.52.2018.07.06.09.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:22:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bruno Herrera <bruherrera@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 4/4] usb: dwc2: Turn on uframe_sched on "stm32f4x9_fsotg" platforms
Date:   Fri,  6 Jul 2018 09:21:54 -0700
Message-Id: <20180706162154.196345-5-dianders@chromium.org>
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
2.18.0.399.gad0ab374a1-goog

