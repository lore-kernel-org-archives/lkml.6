Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E1CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E8F2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EuZ996MD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E8F2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbeGZV03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:26:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44334 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbeGZV02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:26:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so1802640pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poRASEvlVBUAcfLB4RhlwSj/p7/jDuj4PF7wn26CH6s=;
        b=EuZ996MDr/awcYYi/XmOHQH60XNrvktL6KUpom+u4h04Llj4H+kWvXsF4G83MBGwJA
         FLASRPQBPuyYwGxHe48PcaQys8VTNtnBDzUPyxGg44JBQgIt8deE5Q8DIG7fGZhZKsMR
         vEbHJEa2w4NSqRv5TFhdj0LqYKIYEnZb5Yb8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poRASEvlVBUAcfLB4RhlwSj/p7/jDuj4PF7wn26CH6s=;
        b=p637QKHJb0R4urMsin0N289/9sIdEJtBxLDu2fQgvbONYLFhcg/13KpDGXMHtb55Yc
         x/VBRI7fFkiunkZdhAlHAWaDQncgRfQCzrb1xMX5AxuUmprPuRcB/HumnW3sVVgjGMaN
         YJ5jSnkcfDvkg4F3a4Nrd+C6DJkkJEqr9Rc85makuR3zaXUPZOQmzzqumzRewK9hzYAP
         WVNw9kgSy89SzxAEXvHQYofbPzLcCRaGOhzyGdgLGWCbG0cE7rbBKXQhIJe+jgMs42yi
         Fx2ZZaLOYfEdfOfdcGRctU0g/gcji6pyI37saBRNnrkuEWVtJHMIPAqkRgL6fhfmv/hs
         u9pA==
X-Gm-Message-State: AOUpUlGuYev2UuKuByEVpvLUVAGNXJGY2o/S6/20FujZEIvIwV2pPMf/
        OqfjDv4k2q78ngXc1b7qWJMK5g==
X-Google-Smtp-Source: AAOMgpeTZUEvqBv0EEh4ci8/3umHRH8aF6yjX+RHRA2ViJhGz627ApLDNUterAuw1dXDa3gOx2rt8A==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr3539635pfb.29.1532635682969;
        Thu, 26 Jul 2018 13:08:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id u11-v6sm5784169pfd.117.2018.07.26.13.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 13:08:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     balbi@kernel.org, hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     stefan.wahren@i2se.com, grigor.tovmasyan@synopsys.com,
        Bruno Herrera <bruherrera@gmail.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>, john.stultz@linaro.org,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [REPOST PATCH 3/4] usb: dwc2: Turn on uframe_sched on "amlogic" platforms
Date:   Thu, 26 Jul 2018 13:07:29 -0700
Message-Id: <20180726200730.18290-4-dianders@chromium.org>
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

The uframe scheduler has been off on Amlogic since commit f94310ac076e
("usb: dwc2: add support for Meson8b and GXBB SoCs").  While this was
after most of the recent improvements, notably the commit 9f9f09b048f5
("usb: dwc2: host: Totally redo the microframe scheduler"), presumably
the parameters were copied from another platform and the uframe
scheduler wasn't tried.

Presumably if everyone is good w/ the uframe_sched turned back on we
can kill all the old and crufty non-uframe sched code.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/usb/dwc2/params.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index db97bb16ecc4..93380f7c32b4 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -110,7 +110,6 @@ static void dwc2_set_amlogic_params(struct dwc2_hsotg *hsotg)
 	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR8 <<
 		GAHBCFG_HBSTLEN_SHIFT;
-	p->uframe_sched = false;
 }
 
 static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)
-- 
2.18.0.345.g5c9ce644c3-goog

