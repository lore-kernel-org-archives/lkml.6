Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6117C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916B321473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Si8y/WYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916B321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbeHPXHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:07:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36286 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeHPXHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:07:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so2500016pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TKFhrCZAISo/nb50FJthb7MLa2uEO7xUM+Q3exqfqjI=;
        b=Si8y/WYTkuBLam4XhCR2KZH+Wff+781dI6FG01GYN95UezkQqWtpXqLbphrrSlulA+
         Fx4qP5u3TywVX8tQ6Ubwz7U8tE95aJliKyhyECTAwJbL7CGlm8eAU6C1UczgwdtxT9Rf
         TIfRMfYAEX4m3TYoVcjPWWlNzOLiZkFVj3EjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TKFhrCZAISo/nb50FJthb7MLa2uEO7xUM+Q3exqfqjI=;
        b=oXnfIaKZ6qz0BEw6IqG38ho7Xi4M9QodzZs6+sAk/4WngRmmKW7Hk99jRS4mh1BjLn
         m1yDrkhvk+65Y2lcfHsIjQymB8ub9fq3bFMIB5e6WtrJlWx7qzA4UC+DBr3RvrvNkL1p
         bJZI8WZoOUpnbUY1kRUGjNnIa5t1cHIqy3h+px2dwMaMNJAW5O8Vpim9cqpfxFI2KFpt
         HuWWKPJRX6iHucQQZ2sKWSYHivN9UL8QD4steUOO2NpTC9/xBjbAvj7r97FsUCnFQhhG
         ic8tCoQ7yYBcTKqUH6iXiMEZK8y7XSLYZi6NuR0RI1dwzykkDdteUFJGkvMHmzybtXr2
         8Zeg==
X-Gm-Message-State: AOUpUlH+NLFOd3Z0JSKHeHqpAVz9K0+7KWkphTIgJQ0WCxZrFPemL0MB
        V+xpnXpa+4ucboiDUYCg3If3aw==
X-Google-Smtp-Source: AA+uWPzzJA3n9bq4jFj2pO7i6/1WdLjjJeJH/RdKO31CiZXBo4jGU/i5fm/hKpvlS8fFlVFUhZum/g==
X-Received: by 2002:a63:e647:: with SMTP id p7-v6mr29855537pgj.218.1534450009796;
        Thu, 16 Aug 2018 13:06:49 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id v6-v6sm234958pfa.28.2018.08.16.13.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 13:06:49 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 0/3] pinctrl: msm interrupt and muxing fixes
Date:   Thu, 16 Aug 2018 13:06:45 -0700
Message-Id: <20180816200648.90458-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Changes from v2:
 * Better comment in patch#1 to describe this stuff
 * Squashed the raw status bit part into the same write in mask path
   based on suggestion from Doug Andersson

Changes from v1:
 * Squashed the raw status bit part into the same write in unmask path
   based on suggestion from Doug Andersson

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>

Stephen Boyd (3):
  pinctrl: msm: Really mask level interrupts to prevent latching
  pinctrl: msm: Mux out gpio function with gpio_request()
  pinctrl: msm: Configure interrupts as input and gpio mode

 drivers/pinctrl/qcom/pinctrl-msm.c | 77 ++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

-- 
Sent by a computer through tubes

