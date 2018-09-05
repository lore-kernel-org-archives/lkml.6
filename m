Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD63C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A442B2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVOl+3z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A442B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIEOl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:41:58 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37686 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeIEOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:41:58 -0400
Received: by mail-io0-f195.google.com with SMTP id v14-v6so5505093iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nR7U1uBPQaGxb78vtMHfAeA5S3gnqvXRpnnXdrveQd0=;
        b=AVOl+3z1KnKo0nVFe2XFYxaapzK+gY+vuJeJpQtMEeBS/9DoNqRQxoW2gtBYjdYUoJ
         DOyQ0U9Mj2rNNAc6J1npLxcLnQbWyRLiY3ToEdqgcAyo5shlgHojMNivnKIxKdkuPuhQ
         LOLBOGDyzhIiothB6unKIQiooS75J4V9pGdZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nR7U1uBPQaGxb78vtMHfAeA5S3gnqvXRpnnXdrveQd0=;
        b=Eh5HWxqB9m6Z4/OHtuoGFn/WbqAx3atpUE7oHTsZ+5nQWgMFliK7MOqsOL2H7zXywn
         dttDRGaJAP84B+TdaeUxm6lP9S7AX8WP5EuWpsBUCJSEy4W6aznANBr6RSfxkDdOXsRs
         fKQQR5xXVpqgomiLykAmavh8if/AqCHOUat8bJ5pFuD9PFzCeA5J6gP/MjQBxhRsVWa5
         wwq1s+6voZNtiQRF3ibg+8P+55wIjeXC8+93uR1OcZK+uvSzpf8oKt29kdbqT5U5GleZ
         eJTM/wOp1gGcuu31N4678I45imJaG6z6hgudmisnglcuOKLlzKRmuhGLxXgfuPNG8ykT
         EuhA==
X-Gm-Message-State: APzg51CIhrd0C6t/NXzIhSLJGgxpPhorksLJmZ05+fh1oELo+jCf9aGK
        OhDINOryIyV0wXcggOYd9LAxxpZIh41CbQaQaox8gQ==
X-Google-Smtp-Source: ANB0VdaeF1ZvG3Rd5Vf7oZZZ+0Um/049g5IIr4orRhjeRUX3vAfxMoD67MIPL1Z0tXrBgNa7N1gDwAAaapQaQ4FN77g=
X-Received: by 2002:a6b:3a55:: with SMTP id h82-v6mr25448537ioa.76.1536142347065;
 Wed, 05 Sep 2018 03:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180830152340.242249-1-dianders@chromium.org>
In-Reply-To: <20180830152340.242249-1-dianders@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Sep 2018 12:12:15 +0200
Message-ID: <CACRpkdbW7NGwT=kjoo5ZEKBivg9wYSmitJVZwHz_2J24OEdfoA@mail.gmail.com>
Subject: Re: [RFT PATCH 0/2] pinctrl: Fix two more xxx_config_get() functions
 to be compliant
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Ivan T. Ivanov" <iivanov@mm-sol.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 5:24 PM Douglas Anderson <dianders@chromium.org> wrote:

> I have no way to test the patches in this series, but Stephen Boyd
> pointed out the problems being fixed here when he reviewed my patch
> ("pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get() to be
> compliant").  It seemed nice to (finally) follow-up and address the
> problems that Stephen found.  Hopefully someone can test them out and
> make sure they work as advertised.

Both patches applied with the review tags.

If people don't test RFT patches, then maybe they will test
linux-next.

So applied to devel for now.

Yours,
Linus Walleij
