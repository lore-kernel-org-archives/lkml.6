Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B6EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D49921532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b68xOgqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D49921532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390480AbeIUVHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:07:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41651 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390337AbeIUVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:07:42 -0400
Received: by mail-io1-f67.google.com with SMTP id q4-v6so12604610iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWF0oavyzxsfqYnY4ibRxCYvUIKMLinUThDYvQrqzQ4=;
        b=b68xOgqPXb5U94vvXPanBAtm/QWe+J0CEIlmZ8p9TkhG5ECBFez2nvWZ/Tv4xN4YpK
         /kjm2kUeJTrgCuBUu3OMMt71RwMh+yQLjiTZnTSvyVdbv//1PYvb2xeBJ5o7RWn7Qr6g
         G8Ko19or0hwfBz5iigvvkm+hgN8bdFKPPcluI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWF0oavyzxsfqYnY4ibRxCYvUIKMLinUThDYvQrqzQ4=;
        b=cp0WC4ir8vd/Jxq8/DRZEzXQriRYbkIAEjV3pxk6ZUEkHwuT8pBLE/GZvbm97mzN0C
         G81ycHMbes0PhpROc1v6GnQe1r9eOKzkYrf572jc6KW3awvKF/DVzDd8l2yk50PjZfvZ
         ctPI/r++Oh8WoqkQHPbhtAT3NTWW/ZdCxO+CRh5bxU94XHaKwutbIDB38Oi1MQSoKvRO
         lP9OZF0IhgPtqbhem4eCFvv3Z7cql3AWWYLjCImiMCUscNmA1j2j/GYImav0oPmzxqEu
         m1rqIsHbw5qERzLqoi79ERh+NPUeWIkk/3U0uKsMHqvUbswCXdsiivcvjQbcNGx6LFI0
         GPPA==
X-Gm-Message-State: APzg51CCZ3JOS5sS6CTm0YTydozTeVxf4vQ6WmXv6qFSAPHhMfs3/fhp
        vht4ToJ0PaLavytfDcWNw2u2rJx51BYMZDmsdPfV6g==
X-Google-Smtp-Source: ANB0VdbDt6e6PjzvMA3c4XM9sR+FjyZ3GbO6qOdYYF1i+TbG5YoBjjnS+GLzK6rwSFhGwX1DQIlktq7FBHuFzzCsYy8=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr37098534iog.175.1537543101171;
 Fri, 21 Sep 2018 08:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <1537408698-196297-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1537408698-196297-1-git-send-email-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Sep 2018 08:18:08 -0700
Message-ID: <CACRpkdaeoKvaAkAFUL3n7Z9r3zU2GhnvdxekxjKuPS1nLcAMpQ@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: qcom: spmi-mpp: Fix err handling of pmic_mpp_set_mux
To:     yuehaibing@huawei.com
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 6:48 PM YueHaibing <yuehaibing@huawei.com> wrote:

> 'ret' should be returned while pmic_mpp_write_mode_ctl fails.
>
> Fixes: 0e948042c420 ("pinctrl: qcom: spmi-mpp: Implement support for sink mode")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied.

Yours,
Linus Walleij
