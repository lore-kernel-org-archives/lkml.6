Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D7FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEAF2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H21Lmc/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEAF2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeJCOAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:00:16 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38063 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeJCOAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:00:16 -0400
Received: by mail-it1-f196.google.com with SMTP id i76-v6so7400384ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJnCMErbbPQgEG5shh6NRnBZ5h85arAjh6HW68G1UsI=;
        b=H21Lmc/jMidpB3GqDDYMYB/EbYwvBgxndIUE+lM1/MZvXf9dnXih/F1LVBR0HWODtG
         9Lc+ErMztAUg4yELLgN99rYAF93xctX5teSqbIZNRr1YioRVwUwbop3YCZ4K/jktff6d
         dV7nXr5pp2YFJzKYEc0Ap0MeJT+GcQoohVKkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJnCMErbbPQgEG5shh6NRnBZ5h85arAjh6HW68G1UsI=;
        b=c8UcBB2UUYWAxAC9swabhqfoLWXdy6obcAXImg0iJhDizAxLFuNkpfMOUYNxBeFWOv
         4N/YD2t+rZMBrRyTsc4n8rpOBUWcKORe9SB55Eo9oe6Utu1lr+Ws2hwk9tJW9Flh+UAZ
         KM8lcPuLSLo3LdjuGK7OPOzEXtLeaMy6etNoBjD5KQLQQOOxnXRDoeKoS07NsFQepxNj
         ffr4t89Sb1jlT0pvng/G6zIl8fSZ2OWC3ypyOnRvim9GLsEJLbgOmEIUsV5/xgaK9Bdr
         xARsfF+pYnaZv+owiUygaSair9nCqli8jYBfHJCbp62eecnu2kshZo+GIP/bFu6uRr8U
         03aA==
X-Gm-Message-State: ABuFfohkT1xjckLh8t995VWH/11G/vR9sggLPnICNZp0jxAUKkYZQ4lt
        daY6wmecbXQmp3F0OX4R4xNSvV+vUe3/2TojUmiLpg==
X-Google-Smtp-Source: ACcGV62fE9zaa+MXaN+BRCFWWCG/Su5krjRNTGv3wK7CUwN691QDuwmdw6YOxffUL+do8lCg+0tECYFomfAe0UIz6ak=
X-Received: by 2002:a02:3f5d:: with SMTP id c29-v6mr89002jaf.107.1538550790316;
 Wed, 03 Oct 2018 00:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181002211555.2779637-1-arnd@arndb.de>
In-Reply-To: <20181002211555.2779637-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Oct 2018 09:12:58 +0200
Message-ID: <CACRpkdZ_+v1rqYP=Z1tdY-YSeLJ3UYbJWJKa_+4PZXKxdLWieQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: fix 'const' pointer handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 11:15 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The 'tiles' array is initialized to a constant pointers to constant
> strings, but the declaration is only half as constant:
>
> drivers/pinctrl/qcom/pinctrl-qcs404.c:1660:11: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> drivers/pinctrl/qcom/pinctrl-sdm660.c:1417:11: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>
> Let's make it more constant.
>
> Fixes: 22eb8301dbc1 ("pinctrl: qcom: Add qcs404 pinctrl driver")
> Fixes: a46d5e98190d ("pinctrl: qcom: Support dispersed tiles")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied with Bjorn's ACK.

Yours,
Linus Walleij
