Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90926C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBA120693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eg01xkR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBA120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964982AbeFRUxb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:53:31 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37902 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935789AbeFRUxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:53:00 -0400
Received: by mail-pl0-f68.google.com with SMTP id b14-v6so9672673pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=meiSnBBK0ywRIXK/yaRVrlxaRWAocHhuZyzKLwIJ/aQ=;
        b=eg01xkR1S/aOOHhJacjxOBw57mLGnh87wAQ6JMjqNmoZGIW8lh/GHEGQOXpqkJ4atg
         QzbxAExUfy3oUxQUdyzxvSXAKKPvskL86PJhSdGG1CBQN8jZ9dShdnMxOqhk3mWOjQmh
         nvig4q3R+kN7dQ1mPu79MLs3Nq2CdwenzHSUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=meiSnBBK0ywRIXK/yaRVrlxaRWAocHhuZyzKLwIJ/aQ=;
        b=qoJB7KdJqdflFhMicXb2c1U5yQKEc5BG+7aUeaWtdQXxTyZDfMxXqv6eju3JTwZtay
         /yKaYTysrnammKDXW5h9G/3VvvJ+hWrOKAx2zmo3wmWO6bMblxNCfB2HOSKrUC6wA79D
         TJFTnUwCQana/fz7LAYs48fBknfSbKY7LMm4xVMlHdJa/Suik3+iI6JBGUbTJdnpN6V7
         8h7jWlpzy3vvjkZMB/AYWU8pesfoqCI3gs9cyGL8KIPqW9IFKrgBXc+w1N7Gjn6pkVtl
         WiVjXcNfCecatfgUK8zW875mcFCb1ZceFhPTFgRFdye3kpZhug1vkCH2h2gWyhwg/YD3
         KpsA==
X-Gm-Message-State: APt69E2/rPwFZI5LbcyPQVNDMz5ID1B6NVtjZLhCFRoKcq01TZ14bAPB
        utz7+R/qFar4mhYRXrg0jiiLbg==
X-Google-Smtp-Source: ADUXVKJkhZ8dDNpGbbWKfOQs7+Vo31T8zaoGXI87BSuZycqhudwl8EmQAZlrZSnTdcHDns+zRH8A1Q==
X-Received: by 2002:a17:902:2884:: with SMTP id f4-v6mr15735274plb.204.1529355179840;
        Mon, 18 Jun 2018 13:52:59 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id a27-v6sm27052196pfc.18.2018.06.18.13.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 13:52:59 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
Date:   Mon, 18 Jun 2018 13:52:54 -0700
Message-Id: <20180618205255.246104-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618205255.246104-1-swboyd@chromium.org>
References: <20180618205255.246104-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We rely on devices to use pinmuxing configurations in DT to select the
GPIO function (function 0) if they're going to use the gpio in GPIO
mode. Let's simplify things for driver authors by implementing
gpio_request_enable() for this pinctrl driver to mux out the GPIO
function when the gpio is use from gpiolib.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 3563c4394837..eacfc5b85f7f 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -176,11 +176,27 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
+				   struct pinctrl_gpio_range *range,
+				   unsigned offset)
+{
+	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	const struct msm_pingroup *g = &pctrl->soc->groups[offset];
+
+	/* No funcs? Probably ACPI so can't do anything here */
+	if (!g->nfuncs)
+		return 0;
+
+	/* For now assume function 0 is GPIO because it always is */
+	return msm_pinmux_set_mux(pctldev, 0, offset);
+}
+
 static const struct pinmux_ops msm_pinmux_ops = {
 	.request		= msm_pinmux_request,
 	.get_functions_count	= msm_get_functions_count,
 	.get_function_name	= msm_get_function_name,
 	.get_function_groups	= msm_get_function_groups,
+	.gpio_request_enable	= msm_pinmux_request_gpio,
 	.set_mux		= msm_pinmux_set_mux,
 };
 
-- 
Sent by a computer through tubes

