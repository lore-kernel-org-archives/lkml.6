Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39297C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84BB20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hh8ZFtM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84BB20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeGYXnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:43:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46568 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731581AbeGYXmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:42:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so2140319pfn.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=St6GA7EQfesMvQkxgGbb3MU3M3YjzaV9AWMKmBCouNo=;
        b=Hh8ZFtM/GapFvbm5ucHLFHNKCW92R6+horDtCwxwjcdi7MhrY6qhdP4UIHzCxw0L53
         0gSdt0oJNJ368s/PDcQ+byBuf/gjxGcQui8loS9TE53cZuSi4aELuW5tWyIKyPDJx8CA
         uAq1OgXxIZji+GT1G5EyQ00MbfWbtm4xmpRXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=St6GA7EQfesMvQkxgGbb3MU3M3YjzaV9AWMKmBCouNo=;
        b=WnNBzGoZbHJIxI71mohAL33tAawk556Lw3V3zKLrv5nCjepN5BMAbjP2/S6++9YQk6
         xgJQ8zBjZ7gVseV4U1dsr4s326KgeT6dqWi96Ht+9hxDb50vXcVBBhpqnokb3MisC+qk
         ytb1xVcdbbeLtb5P+UaBx1FnC1Y74hrSKesbVT8Ys8Ietxc8IF2TWb38CRwWbmXLK3C5
         OiIvfvswM0dkMsqMaEsMJl9Bi8TlsTZ4xxjEPC50v1lhEnWIyW+cFlCICNHx0fUTVTpZ
         pSD996Y50F8AY0IUYCoMG8Yhuttuxa8quHluz6U8I7ha2pAEpxp2XjzBcoeFVnMLWF/n
         oyWw==
X-Gm-Message-State: AOUpUlGLQQZDehofFdfPTWy+V5H5KbaOdThgQqPdOGczMN+Lds2ZjI7g
        pF7z0gc3NBbvnanqbSCAqv/Vog==
X-Google-Smtp-Source: AAOMgpeeh17JHQh+xn4AGSpPCKxCACFpQlSRyUWcXhSQ3zvCwNyhf1fs+/tqXKiN/COPlHzgJiNUYw==
X-Received: by 2002:a62:5047:: with SMTP id e68-v6mr24193364pfb.157.1532557744708;
        Wed, 25 Jul 2018 15:29:04 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id o21-v6sm23839234pfa.54.2018.07.25.15.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:29:04 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
Date:   Wed, 25 Jul 2018 15:28:59 -0700
Message-Id: <20180725222900.33231-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180725222900.33231-1-swboyd@chromium.org>
References: <20180725222900.33231-1-swboyd@chromium.org>
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

Changes from v1:
 * None

 drivers/pinctrl/qcom/pinctrl-msm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 3970dc599092..1d7367149268 100644
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

