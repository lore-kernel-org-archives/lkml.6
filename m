Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA08C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E654F222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LujUUfzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390584AbfBMITp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:19:45 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35849 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387986AbfBMITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:19:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id q11so1094308lfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k5HL1AU4IwF5lyOey8vUv2mnDrmflsOM52BqSGf8rJ8=;
        b=LujUUfzymPOgao18J6GeFYBxv2dwtYa3m9al28EOrh+rbqaJEj1y5PaT/EC2RrfghZ
         /3hTs5TCWmu/Ecm7J7IV9T4riyc8Y5qhn+cDa3DPxZHDHrsQfzROQWN1cPwWgPCQ5ytT
         y5L1NiDXJot85wyNlji6p+r/5lOh35djfKMcm+RnR0b7QYJD8MotIkNR9DjRvYWLKtXq
         FBCVAWGV+AdNnFi4uTIycvgjjQjzsYXy0KfYH5ES7AHb+WbsiyatqXxHbtZH7NF2Y1rQ
         2FM3Snz1xvOcocpqAUelsjmtvkARgrTUdve+H56xe8h61kVaZnMZFFBY4xws1TfW8niq
         Z/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5HL1AU4IwF5lyOey8vUv2mnDrmflsOM52BqSGf8rJ8=;
        b=k0g3PPHIo0iL+YDK/wDOqhqp4X8DAi0Pb9sUrij6jWoHD97DxkK1P7aIb/8DaF2Byr
         p9blFtu03URrmZ9WED5u6y8TTed7FHx7dOZ9e+wvt/4WmcnQeZ1IFPZ7AyOzX9wLWk6h
         8t5INJsWBoZRwfiRGXiqNyclK7mdFRW2LRoRv7HYVZnY6y+kn/4RdedeP1qITRbVk4Pa
         bd8SGOohgDtx85pk78t8f8ttpNq3V2LJl2xbPRAzV4Xep58aAvc+uwvu/A5F8A+o8CV+
         AGxdECDm1PV2VCxpNuuD9VDuc6S727fmxqqXryNP5lOSguhXZjJuknrQVWToVeEoDVec
         /ICw==
X-Gm-Message-State: AHQUAuaqDuIoPhuLlP57lZv6FC/AJ7jJpzgkD929ZxTEgO0rRYpcACJd
        npCfxdOtDzRfsjjraOrxUFGNUhzr8JC18F/pvPnQXw==
X-Google-Smtp-Source: AHgI3IaqF5De1BQ35vaR0tDR8Z4QlY7NZoLGgjX/qzcaVnhc/F81JRUPrmJZ01YN5cecln0oRqdw5cPxs9zdVoGU9OU=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr4561649lfl.129.1550045982673;
 Wed, 13 Feb 2019 00:19:42 -0800 (PST)
MIME-Version: 1.0
References: <20190212035205.23477-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190212035205.23477-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Feb 2019 09:19:30 +0100
Message-ID: <CACRpkdYOeQh5LZS1U_Wa+1uSLr4EU9+tY4KY4MFW1yvZLA3zOg@mail.gmail.com>
Subject: Re: [PATCH] qcom: spmi-gpio: Fix boundary conditions IRQ domain translate
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 4:52 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> GPIOs on the SPMI PMIC are numbered 1..ngpio, so the boundary check in
> pmic_gpio_domain_translate() is off by one, correct this.
>
> Fixes: ca69e2d165eb ("qcom: spmi-gpio: add support for hierarchical IRQ chip")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Good catch! Patch applied with Brian's review tag.

Yours,
Linus Walleij
