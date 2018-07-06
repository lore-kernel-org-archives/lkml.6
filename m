Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE73EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E90623DDD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PbkejXIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E90623DDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933568AbeGFQWS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:22:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44804 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933402AbeGFQWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:22:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so8829877pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7yWaLhpb0XHr/ThHkeE+BEqTfIGJfRdCsgtN9XmfBkg=;
        b=PbkejXIQSy4ePXuXOptpM9q8bLytq1RC4cZgN/LFI/t+8K5YDtmgigPkWniIGFRL76
         azKHFlKev7CUZ3OC+Vcejwc/dqYchfzmYhpRIcCir2pvr72RInNl5muIoY909p3tD/Nn
         H9Rz0R2ZXI4FIRrzCAKGJTjXrdEoxf21oLpzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7yWaLhpb0XHr/ThHkeE+BEqTfIGJfRdCsgtN9XmfBkg=;
        b=txd3n9v9/MO4nM4L6TmooUi6WM2QxxHS0p6RCSuD760Dp1ACLNYFIHv13/AtZ2Xgcc
         Tm8yjSk+hn1YXIXcz0cQ18qA4S66//JmY+2g1SYSRYNNLl4A6MBwN7Zxth7hvfOxKWS8
         YK4lPvts5HY4g/+dqYQ5iGxfbS2W9OekUyW7D2dd4OyyxM4GNtC3+YdxqiIIZHb2e0gV
         WTZS2oDdnuKUx3OLPWwcTbVKNo2J3gEszMuvWqufuLX3fY4J6kkgnNjjhQABnWLp/kmx
         BkwICyHXGL90JqgTSFIqCQgEFX430Uofy0vBmdtxvR/VI4V5foEFEUViOS3iHNJfvUHL
         cpNQ==
X-Gm-Message-State: APt69E3WYinnYjnvzN9BN2JAfQ+Qcy21DPHx/FohS9P3dsnBZ8WxYW8m
        jqx5mILAEAC16fErttD6FZR2YQ==
X-Google-Smtp-Source: AAOMgpc3SK9HwXp3hGnDnw6pDurkwceCKtlX1jSkxAkUjoHcnn3Em5PoKqYsqlXRoLWeRys/wcXY5g==
X-Received: by 2002:a65:5581:: with SMTP id j1-v6mr10280692pgs.203.1530894136571;
        Fri, 06 Jul 2018 09:22:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id e125-v6sm8926688pfe.52.2018.07.06.09.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:22:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bruno Herrera <bruherrera@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 0/4] usb: dwc2: Turn on uframe sched everywhere
Date:   Fri,  6 Jul 2018 09:21:50 -0700
Message-Id: <20180706162154.196345-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at a dwc2 recently, I noticed that some platforms still
have the uframe scheduler off.  As far as I know, nothing good can
come out of having the uframe scheduler off.  Let's turn it on
everywhere.  Assuming this all works out then some time in the future
we can gut all the old code that handles the old non-uframe scheduler
and make everything simpler.

NOTE: I don't have access to any of the platforms that I'm changing
here, so I'm hoping to see a Tested-by from those on the list.


Douglas Anderson (4):
  usb: dwc2: Turn on uframe_sched on "bcm" platforms
  usb: dwc2: Turn on uframe_sched on "his" platforms
  usb: dwc2: Turn on uframe_sched on "amlogic" platforms
  usb: dwc2: Turn on uframe_sched on "stm32f4x9_fsotg" platforms

 drivers/usb/dwc2/params.c | 4 ----
 1 file changed, 4 deletions(-)

-- 
2.18.0.399.gad0ab374a1-goog

