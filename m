Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7560BC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D62223E03
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aSb6/6Xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D62223E03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933620AbeGFQWU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:22:20 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46052 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933517AbeGFQWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:22:18 -0400
Received: by mail-pf0-f196.google.com with SMTP id y24-v6so8825302pfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vDIrkkGnKtuUhTna2+qlhQEY4Z80qaFM3p58k9IlUjk=;
        b=aSb6/6Xv00RMk23atV4Y1QrakB6ui8SXO1RBFSwB+8lVGTx0GmT/dhAdUO18FOwE3m
         QGmfbfI42bGdeWpEtGXjhsfb3B6A1XXeetK7Wjwl0mzmdOsjshbgp1pAo0hYA7O0aPFP
         WK091JrfzV0sGMHd+e+hqvK6nDWf11ICt30EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vDIrkkGnKtuUhTna2+qlhQEY4Z80qaFM3p58k9IlUjk=;
        b=VODXKm3+UIhS8P0RPMSedlN0DWMO+EVRO8vc2dVcrRI2zM5Q4GRUuq1TGN7RH8LsKz
         Le32QfEYsw5myKU/zwoU6eenjNwzNXBPR6PD2aqbV9g2xkNmQYTY+mx46vNutDAfPwY9
         aSbVhAHYDNXaxMQJ5aq/mVVtYKR9umHtilitZ2jt2wv2RVf1fBIaVmJOFjhmPNAHciJZ
         OfnNlfgDELJ9B5d3ACtlazXGWdNTfyPxiA/VjT2sfat2Wktj+B4wUYP1lHvklW8ZAUk1
         5fSDr9aDopF3Ht1GjMFoH+BvYaTjExQNjTKF/EF17bjmvO9Ar4U2uI+jkgrcSY+oHpQp
         eSbg==
X-Gm-Message-State: APt69E14d3/8pCKecmxGeir8hYiRLTe28MSiswVg5QTga8cb7jIMW1M7
        VZEgxUqE8EB8iiMpnvYzm0IXnQ==
X-Google-Smtp-Source: AAOMgpeJJJ91kGHC9WvAcVWdRN34mcVc7HuQ8hcq0e3cpyQvemM0tihfuGkmkalLcP16VoysVI7OGQ==
X-Received: by 2002:a63:6441:: with SMTP id y62-v6mr3854612pgb.240.1530894137941;
        Fri, 06 Jul 2018 09:22:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id e125-v6sm8926688pfe.52.2018.07.06.09.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:22:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bruno Herrera <bruherrera@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 1/4] usb: dwc2: Turn on uframe_sched on "bcm" platforms
Date:   Fri,  6 Jul 2018 09:21:51 -0700
Message-Id: <20180706162154.196345-2-dianders@chromium.org>
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

The uframe scheduler has been off on Broadcom since commit
58b179dcf28c ("staging: dwc2: disable uframe_sched on the bcm2835").
Since then there have been many many improvements, notably the commit
9f9f09b048f5 ("usb: dwc2: host: Totally redo the microframe
scheduler")

Presumably if everyone is good w/ the uframe_sched turned back on we
can kill all the old and crufty non-uframe sched code.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
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
2.18.0.399.gad0ab374a1-goog

