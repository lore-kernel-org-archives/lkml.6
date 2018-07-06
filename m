Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB188C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39DD23E03
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z5bQioAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39DD23E03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933661AbeGFQWZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:22:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40075 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933068AbeGFQWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:22:21 -0400
Received: by mail-pl0-f68.google.com with SMTP id t6-v6so3104283plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lZF1dfoK8II/30Ro89PVWEoJpEsSsWVJI8WlHeVFNj8=;
        b=Z5bQioAfb4LbEqKvpvKVwcKhSy0lmSEKyk0D/TiFA70Jan6Sxtd2od7K2Cv+nYFbzE
         uoNXnXgY3AaY6/dQULEA+lq8DKvJquBWZEgwLhmQU8nRjgXdBwMbcmqtKVJyZpBtqsxM
         CO7b2z0mMDXjrgZUIZcMC5PkZOJFOJ2hKrPAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lZF1dfoK8II/30Ro89PVWEoJpEsSsWVJI8WlHeVFNj8=;
        b=qCjxbne4GKZq95CS5ADL4nrVvW/qZJJ/QTUEsSyj71jZvHi7yab0b1fbwfbVyUcPJs
         j0ZFn9nczjQAHt2u+wytz64hsEUw2UDR5FOtrI2eS98dQBC4jXbb/rqLydkG5MVCVMwy
         ET5SIVmWcAV7QF4aqfgVXoMSJauwXu09C7Ms7NOH9drZG0qnXo3lJkygr5OQuDkr0vaY
         uJx98D1cEEnIust59WtnoR5uTaHv+YMTxB7r0IqAXZ2FYU1JWrSbjFvLlI+w7OeKyzaS
         txplOUnlxCtOkfTTmp96ixYhhYqDxdvgemNLBKwV9tKPaSpSNEXUIcWauRAOhJ5APYqN
         gTxQ==
X-Gm-Message-State: APt69E2eO9UoQCEkXrSdzRzGv4z4QZxYHuVOzjXuYRwD6iL1bvQbjOK7
        v+Qm572ujig67HNS0boWHoO20A==
X-Google-Smtp-Source: AAOMgpfXX+JtVGwhLuE0zuHZ6zCCqqnneoKsXj4XgLSa25ONEj0/K0uNJHZx/WARqwxG9d/rRHsW4A==
X-Received: by 2002:a17:902:8f82:: with SMTP id z2-v6mr10925709plo.203.1530894140628;
        Fri, 06 Jul 2018 09:22:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id e125-v6sm8926688pfe.52.2018.07.06.09.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:22:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bruno Herrera <bruherrera@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 3/4] usb: dwc2: Turn on uframe_sched on "amlogic" platforms
Date:   Fri,  6 Jul 2018 09:21:53 -0700
Message-Id: <20180706162154.196345-4-dianders@chromium.org>
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
2.18.0.399.gad0ab374a1-goog

