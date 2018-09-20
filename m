Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F481C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B31E20833
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7Wj2Awl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B31E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeITVKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:10:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33864 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeITVKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:10:38 -0400
Received: by mail-io1-f65.google.com with SMTP id c22-v6so7736297iob.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ueYwWp9hOt4ubExEkrr5fI9g24XfOKpvzRXjVeuX2wk=;
        b=L7Wj2AwlEo5PGQi0CWQgTcVvPFHT6d8zL/e4PsSt6dReSpXfBaJBAfdGK0skifCB72
         I0OXtYhbxC5xcU5hVUprXg3hA41Zb9XEVkpAlNFxdmlX+Ole0H23FgFbSCMaDydHEh3T
         5PoPq/NUjKFbKAVJAFtuA5mlB+mlD/45SZSrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ueYwWp9hOt4ubExEkrr5fI9g24XfOKpvzRXjVeuX2wk=;
        b=dUzDwN9KJAJMvRkEyCQ6Ps+SUJYYlHQ8GUEhB3nLoNf54kVAyo7oVEneMuJqeekaNM
         Q57OF0HpP8/FHLI4v4wUgt9fiJ8gghzRT3HRe/mUSsgSOu1mZTDx2aBofoB64s29zSVx
         VWsvUyCaHhm4NFkZFoFYVirbJxjqs5ROpRQp3hF7j6VBzm18ado7nBG/1UzhFf8mJQ8S
         2uzZ65omlsi3L1Y1Xv73zBMnb5xvO3cpsbXBo0F+lbFbI8hSJT64sbTHRFlV3CGeG+e7
         cuv7TlCy9pAU06OQkddRMvELgI1y3MbDV0hmTMDtLG7v6gTy4zJEh4G1i2oU9dYtoERc
         mjVg==
X-Gm-Message-State: APzg51A5gEZkQQzdOiSDWX0uHQUnG3dPFXmqWbDuTshi2rdwY8da/gMf
        OAeWSVStuyiBONlkouPQ97uUDrkW6OeJeBZBd8W4Z7OA
X-Google-Smtp-Source: ANB0VdYpnMZn6VeKPMaYx4cHT5M+/p5Obd9DMysQNm+zgalAvBgo9RPyMh1peqweQzu3+/B6//hIdWtlnyCcdOAWwvI=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr33067327iof.304.1537457198194;
 Thu, 20 Sep 2018 08:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180918153621.71984-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20180918153621.71984-1-mika.westerberg@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Sep 2018 08:26:25 -0700
Message-ID: <CACRpkdYhpBYEY0OJA0A15Q7OOM31ogGxeaUbNNqSMpJ9af4hOA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: Do pin translation in other GPIO
 operations as well
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        rajatja@google.com, casey.g.bowman@intel.com,
        matthew.s.atwood@intel.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 8:36 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> For some reason I thought GPIOLIB handles translation from GPIO ranges
> to pinctrl pins but it turns out not to be the case. This means that
> when GPIOs operations are performed for a pin controller having a custom
> GPIO base such as Cannon Lake and Ice Lake incorrect pin number gets
> used internally.
>
> Fix this in the same way we did for lock/unlock IRQ operations and
> translate the GPIO number to pin before using it.
>
> Fixes: a60eac3239f0 ("pinctrl: intel: Allow custom GPIO base for pad groups")
> Reported-by: Rajat Jain <rajatja@google.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I applied this for fixes.

However when merging with devel I get some a merge conflict,
probably due to some cleanups from Andy.

I tried to fix it up (just use your code) but please check the
result.

Yours,
Linus Walleij
