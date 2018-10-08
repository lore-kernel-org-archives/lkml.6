Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76034C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A99C2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KkmbcIN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A99C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJHXou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:44:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43560 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJHXot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:44:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id p24-v6so8605078pff.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzbIQGVke+G0uyE3ie/RdMq0ogkmeNz0swT4Wn03utU=;
        b=KkmbcIN445KUD7q79TVRBvsrOiHukuMegeIPWpV/IlUondtCTBNrVgNjI2JnvHgxQJ
         ZBdkw5XeuD9LFoFinqCA5IVNRKBh8R5vlArhlIt59fU7nxbucT88vnH8n0AVp0OjhXPl
         ZoEjCrCch1h/+gLsUV+Vr6eITIVe8FTOz5iPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzbIQGVke+G0uyE3ie/RdMq0ogkmeNz0swT4Wn03utU=;
        b=PZA41UuU9p1N04RoY2udGbVR6WgPXbC52Rc7xZ/NbhFIv3KTXL9nrN4HH+QqAmHHo8
         G06VaI7MEaQR8ld3fTIr+ZaCPMqhCbQPXDW4SnzoNxyFdncfVi2ThS4DFQhhCe8b4h7u
         WNzBGYG25+CfmGooYJNzoiD06q+5D24y8fdAc0b1SPRopoIyulOh3HQr0SShElXYqrwi
         /K4QHs8UAj7VahMjMMsaSNGC2fx37znCOzUKy/h+3O9w0OdqB7+XUt/Ky833aL+dTVrC
         akrfH6BRdiIV+k2o/mRK4PJ19Shuw3GTlOJiURjl4laEe6w+MDk/MlB3qWC7OBEr/Hkt
         yFiA==
X-Gm-Message-State: ABuFfognaYxnL++xwtFDhZ0584pTaFFYYQFBpBATs0fATdgkbFDufrBe
        vXXJo7Xhp+NhmIJ29wi0Z002ow==
X-Google-Smtp-Source: ACcGV60HQTKs3hS8h5367cHTXM4EL165I3NgTijyyN+1xr++3PRoPwpCFBIa3KRVm6VbN1lf/V1t4w==
X-Received: by 2002:a63:c044:: with SMTP id z4-v6mr21649691pgi.274.1539016337655;
        Mon, 08 Oct 2018 09:32:17 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 3-v6sm29832077pga.12.2018.10.08.09.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 09:32:17 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/4] gpio chip cascade fixes
Date:   Mon,  8 Oct 2018 09:32:12 -0700
Message-Id: <20181008163216.97436-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally this was a single patch but then I noticed some
other things that didn't seem quite right so I added on a few
more patches after that. The first patch is the important one
because it fixes a bug where a stack pointer is assigned to
the gpio_irq_chip structure and used later on when that stack
is gone.

Cc: Evan Green <evgreen@chromium.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>

Stephen Boyd (4):
  gpio: Assign gpio_irq_chip::parents to non-stack pointer
  gpio: Drop parent irq assignment during cascade setup
  gpio: Remove unused 'irqchip' argument to
    gpiochip_set_cascaded_irqchip()
  gpio: Clarify kerneldoc on gpiochip_set_chained_irqchip()

 drivers/gpio/gpiolib.c      | 24 +++++-------------------
 include/linux/gpio/driver.h |  5 +++++
 2 files changed, 10 insertions(+), 19 deletions(-)

-- 
Sent by a computer through tubes

