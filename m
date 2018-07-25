Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E395EC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B80120833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a+5WB2np"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B80120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeGYXmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:42:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33608 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbeGYXms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:42:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so6204744pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qAC1H26pnQ6DxbqqPc4rsGCCCFylb2IBm7i3FTClGSc=;
        b=a+5WB2npiwKYJpsN+hCT2pUeEBWNn8W7KvuMGf56aBZBOu4r1/zvSK7JoeQB/1gb9h
         2GMXKXgJ1tIu6SiCQWqTq9ew4y/Ea94Tl2LCuuVnhqEtJDA5/fuQ/vnRGZ2nZSEgJL1B
         wy5xS8CgvDSqMwCm3BQa8pSTQvcexdiYadjK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qAC1H26pnQ6DxbqqPc4rsGCCCFylb2IBm7i3FTClGSc=;
        b=XoafZhtI8gBLBd38ORToN2zcn2f5NuwOOcDWbV28z8Ak5iYQjjhBvEbF/xAT100Ng6
         wu+8ll050+3ve/nChPsN7GuICllVtWFKoE/OK24dcqfxFAxngdHwhMQX6jvBhGbtx+mb
         g4QQz8A8FvjZY/qkU4WEpI7yVnOQfMYTbiJ/i2O3p+RTTW5Dij4Fdvm9BB0r0v0uQXEa
         x9dZCbaoDFaUCQEfTT1ff9tbVn46KJRnwMJJjHiblMcsHjFSV5wkvgi6xYMZ+zU7ZWDu
         CGU74uZPnsOpXkp6ZrK59FP6sp7LjDlgMup6ZHcuAAoXf0iiWemcFuYE3qKxJOmOU3lU
         XtGg==
X-Gm-Message-State: AOUpUlHkf2QJR+ymO3oyg58LEhZiPi5SbngvzrKqQDzN2Z/rr5tSBxNz
        o7oj7IABgkaGKpdkvHOeVY/eI3Cr4E2wZQ==
X-Google-Smtp-Source: AAOMgpfBed5mmY46fMmCaQyNoECdqM7g48G9Ka/zbOGuawf6UN9g0mHU+m+1UQkVZybu3Aqj2JTMKQ==
X-Received: by 2002:a62:15c8:: with SMTP id 191-v6mr23636162pfv.194.1532557743212;
        Wed, 25 Jul 2018 15:29:03 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id o21-v6sm23839234pfa.54.2018.07.25.15.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:29:02 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2 0/3] pinctrl: msm interrupt and muxing fixes
Date:   Wed, 25 Jul 2018 15:28:57 -0700
Message-Id: <20180725222900.33231-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a collection of pinctrl fixes for the qcom driver that
make things a little smoother for DT writers while also fixing
a problem seen with level triggered interrupts.

The first patch fixes an issue where we always see one extra level
triggered interrupt when the interrupt triggers. The second and third
patches make things nice for DT writers so they don't have to explicitly
mux out pins as 'GPIO' function and as 'input' instead of output so that
interrupts work properly and also makes sure that a gpio is muxed out
properly to 'GPIO' function when a gpio is requested by gpiod_request()
and friends.

The discussion never really completed on the previous thread so I'm just
resending these patches to restart the conversation. In the cases
where a driver needs to do both pinctrl muxing for some non-gpio
function and also GPIO control they'll need to explicitly mux the pins
at the right time. If we force them to mux the pins into the function
mode after requesting the GPIO at boot then we'll be better off because
it will force the code to mux out the function or GPIO explicitly all
the time.

We will have a case in the near future where the UART driver will want
to mux the RX pin into GPIO mode so it can get a wakeup interrupt during
suspend path and then swizzle the pin back into QUP/UART mode when the
wakeup interrupt isn't necessary anymore. In this case, I imagine the
driver will request the pin as an interrupt during probe, that will
convert the GPIO into an irq and mux it out as a GPIO function input
pin, disable that IRQ because it's only needed at suspend time, and then
need to explicitly mux the device into "UART" mode before finishing
driver probe. Then when it goes into suspend, it will need to remux the
pin as a GPIO function input pin, enable the irq, and wait for wakeup.
On resume, it will disable the irq and remux the pin as "UART" mode.

Changes from v1:
 * Squashed the raw status bit part into the same write in unmask path
   based on suggestion from Doug Andersson

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>

Stephen Boyd (3):
  pinctrl: msm: Really mask level interrupts to prevent latching
  pinctrl: msm: Mux out gpio function with gpio_request()
  pinctrl: msm: Configure interrupts as input and gpio mode

 drivers/pinctrl/qcom/pinctrl-msm.c | 67 ++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

-- 
Sent by a computer through tubes

