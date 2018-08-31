Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58A2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8B820839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CJYsw5AU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8B820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeHaFFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:05:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38996 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHaFFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:05:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so4670451pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=0XoKe3GHJIT/a9jBC6M95Aq7BUYBMfJDm5HAfySP0oo=;
        b=CJYsw5AUyqv6J7hUNhi7oaS5XdhDK0J9pE7SE8piB6yblqypEjBl5uOIMh7V6r+AAR
         Qr5cV2ysoStmzUYU7OFNqzIosRXKxGDGuV5Bxe1uOItMD4jl5r7KLgZUAADGRIQUdHlm
         POERgr0cl2cU+OQOQUSzoEwtdwNB2/UYwVB4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=0XoKe3GHJIT/a9jBC6M95Aq7BUYBMfJDm5HAfySP0oo=;
        b=LEZAVlV6vG4SZ9WsVgWR9v1FR6365v93d8nJa3+SO5yZ5ooN7rbHdBd9CYDtlxNB0K
         gKRQrFjGJnYuCrSinksvwqb1L3P2XsHD9muION4e3vXySK1I8kVrIfvzS5bhYw6/RXTX
         5RTvlwvYFNoMT6OA6Ho6xWB5NjfSarBdATCAhN/I1tlAu/AhONp7RnEhtVJdOSyc/1Ta
         nYH9pF6EaiKfn6iKnv1KPn1ybNcT1fhcrfF3FgHrPqeXVnuK7bbxH30YFYwf0ZzOF5Bx
         wid44syquVRiPXkFg2r4EgnLmhbk2mzj8RLWRjWzPq6+KgVDf6EkYrkD61RHK0bz9sD7
         GvLg==
X-Gm-Message-State: APzg51AyjLMqqm8Zn+PmhLr7DL29cEch40Abz4+6zS24UZgTVmTjA3Cv
        z8tQIbSpsDYJSc3oFSA6lsEpFg==
X-Google-Smtp-Source: ANB0VdYi1m2e/Im4wufNBG/IzqK6qh3GDOIPNd8j9ZjmeVLuXXjiqeubspY406SXLlIrb5O/mg3Pbg==
X-Received: by 2002:a63:3741:: with SMTP id g1-v6mr12165448pgn.59.1535677218724;
        Thu, 30 Aug 2018 18:00:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id m26-v6sm25341954pfi.102.2018.08.30.18.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 18:00:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180830152340.242249-3-dianders@chromium.org>
Cc:     "Ivan T . Ivanov" <iivanov@mm-sol.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20180830152340.242249-1-dianders@chromium.org>
 <20180830152340.242249-3-dianders@chromium.org>
Message-ID: <153567721669.93865.15006485526507438075@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFT PATCH 2/2] pinctrl: spmi-mpp: Fix pmic_mpp_config_get() to be
 compliant
Date:   Thu, 30 Aug 2018 18:00:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-08-30 08:23:39)
> If you look at "pinconf-groups" in debugfs for ssbi-mpp you'll notice
> it looks like nonsense.
> =

> The problem is fairly well described in commit 1cf86bc21257 ("pinctrl:
> qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant") and
> commit 05e0c828955c ("pinctrl: msm: Fix msm_config_group_get() to be
> compliant"), but it was pointed out that ssbi-mpp has the same
> problem.  Let's fix it there too.
> =

> NOTE: in case it's helpful to someone reading this, the way to tell
> whether to do the -EINVAL or not is to look at the PCONFDUMP for a
> given attribute.  If the last element (has_arg) is false then you need
> to do the -EINVAL trick.
> =

> ALSO NOTE: it seems unlikely that the values returned when we try to
> get PIN_CONFIG_BIAS_PULL_UP will actually be printed since "has_arg"
> is false for that one, but I guess it's still fine to return different
> values so I kept doing that.  It seems like another driver (ssbi-gpio)
> uses a custom attribute (PM8XXX_QCOM_PULL_UP_STRENGTH) for something
> similar so maybe a future change should do that here too.
> =

> Fixes: cfb24f6ebd38 ("pinctrl: Qualcomm SPMI PMIC MPP pin controller driv=
er")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

