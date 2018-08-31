Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BD6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A4C20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GCczFZMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A4C20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeHaFFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:05:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38370 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeHaFFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:05:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id u11-v6so4612033plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=/bADHtJnE/uQyaPeJFGbnr0961MOMbCdwSvh67TLjPc=;
        b=GCczFZMmp6sGfdImyFcybDYDNW2lvU4Buor4aRjuodBKVnJkcIg+yPRWlDS4nUuG6Y
         JRBl0PyAGSkCnRCg2Uw32C8YcyrCPd7edyOpaWpWp6PGbIZ3IGEbtIYhHleXYvGTXKKZ
         XsjPUCcFVvqiPs3VJ7TnQnqADwA+vCbvZ0gbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=/bADHtJnE/uQyaPeJFGbnr0961MOMbCdwSvh67TLjPc=;
        b=nnA6yC8A9j+RCZUllZcgAvpoixN81ObCxOLMDw5nKgi4cpedDpbyoi9vvdvlDYZCBS
         IuTpevTswzumGs2WCZITFKGaLMzhnuUvuKqyjVuUM/jMlAxG1YMqfnEyMmK5WwNJpiHQ
         hM0a1MlE4ZZNpXV0JHj06ERMmcT6OTh13sEnMXkRGSGpNDRqSa+GuA+rFL+lEfeGNkdg
         digqtt11vbZMW88IWng5YwavXtvRw0I2MXqmGkqdKUjq/J9P999m03+65NBpnV2hejtt
         EDM9rIIPJ7a42mPiTAZZh8Wlj5qhcmnGd+tBfMaRZnkWwWatYdugz5XArenQ8MqNGcEi
         RtZw==
X-Gm-Message-State: APzg51DWHKYe1++OwffJ1SmCjLaXyXTwti9M69LrfdVZvWQP7Ghce+QR
        3bnEKH2a05+vIsTq8qMYQjDD2w==
X-Google-Smtp-Source: ANB0VdbfVjRLBt4ZLScYywiez7MH44JUIgOrooh8d3bW0eAmBjQp8gFA6crlOVcCGBPzJmq/mvuMfg==
X-Received: by 2002:a17:902:8605:: with SMTP id f5-v6mr12414688plo.271.1535677210818;
        Thu, 30 Aug 2018 18:00:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id z22-v6sm16454618pgc.67.2018.08.30.18.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 18:00:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180830152340.242249-2-dianders@chromium.org>
Cc:     "Ivan T . Ivanov" <iivanov@mm-sol.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20180830152340.242249-1-dianders@chromium.org>
 <20180830152340.242249-2-dianders@chromium.org>
Message-ID: <153567720861.93865.11098054819022547198@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFT PATCH 1/2] pinctrl: ssbi-gpio: Fix pm8xxx_pin_config_get() to be
 compliant
Date:   Thu, 30 Aug 2018 18:00:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-08-30 08:23:38)
> If you look at "pinconf-groups" in debugfs for ssbi-gpio you'll notice
> it looks like nonsense.
> =

> The problem is fairly well described in commit 1cf86bc21257 ("pinctrl:
> qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant") and
> commit 05e0c828955c ("pinctrl: msm: Fix msm_config_group_get() to be
> compliant"), but it was pointed out that ssbi-gpio has the same
> problem.  Let's fix it there too.
> =

> Fixes: b4c45fe974bc ("pinctrl: qcom: ssbi: Family A gpio & mpp drivers")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

