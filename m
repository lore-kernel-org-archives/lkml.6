Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC86C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D276B20693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jPr6aJPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D276B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936346AbeFRUxB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:53:01 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45116 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935531AbeFRUw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:52:58 -0400
Received: by mail-pl0-f66.google.com with SMTP id c23-v6so9662275plz.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xXLdOe+TEivcD1MfhOKCVphqd2SeaiSR+SNu1OBqM6g=;
        b=jPr6aJPO8zIQPEdQEVM12NpaBLgd3lTH73GnZOz+o/2MzcMQnqCG0gIlWqtBkgRlZo
         dyJsVUQuC0vikv/OdhdlYWVZ2zw+OSCsKi+HgekOz+mOvJDxyooL9vU3k+GSvopA+0CH
         K3njNB5YgWUOnyq/9yKSZalad3mXCu0XvoW/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xXLdOe+TEivcD1MfhOKCVphqd2SeaiSR+SNu1OBqM6g=;
        b=szkCTAUa6Z1ySUpNlPNpX7//RJO8/Jq7yYPdtr0HhjZ4clwywPnePS3PGQp6b17KQl
         o5oV+u/JnYVMjGHG5/7RdwFXzdnzu4LnKEksq6m9GdBO+aq1aFTYJ31GQubAZbdhJRGG
         Ta/QTo2qQu2cwL5D1efVoVytmzvWnBR+7oeEXiVqvyOBfLujtRX2boMWOJROzoBYbwGc
         17LCe/vhfaSjYU3V6U+06hVWk1jy81du+fZ5a+2hNUBmczQNMP3m0Vqnq+tClbrmBU0i
         3qQqfR6ghCA48BBUEKE4zNm6EkdmFEkJk37zQ5wjIPzWelw1dBe9bfl95b4iMdTI3Unc
         8hMA==
X-Gm-Message-State: APt69E3TDPOwoaOwyDpfycnGC2+RmAmrQcrFSadBX5Em9lixFO/y177+
        00TgCdOktvJLmkWdieYii+EjVw==
X-Google-Smtp-Source: ADUXVKJ9a6eJK0iA/lY3e/9RFXjLUTH+HS2pQsA+3/ciInP+HA/l/MW62mMwKlhAgUOOwJiduQomAw==
X-Received: by 2002:a17:902:f83:: with SMTP id 3-v6mr15516016plz.282.1529355178150;
        Mon, 18 Jun 2018 13:52:58 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id a27-v6sm27052196pfc.18.2018.06.18.13.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 13:52:57 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH 0/3] pinctrl: msm interrupt and muxing fixes
Date:   Mon, 18 Jun 2018 13:52:52 -0700
Message-Id: <20180618205255.246104-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
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

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>

Stephen Boyd (3):
  pinctrl: msm: Really mask level interrupts to prevent latching
  pinctrl: msm: Mux out gpio function with gpio_request()
  pinctrl: msm: Configure interrupts as input and gpio mode

 drivers/pinctrl/qcom/pinctrl-msm.c | 70 ++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

-- 
Sent by a computer through tubes

