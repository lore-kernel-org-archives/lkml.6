Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD47ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1348621565
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8awrdLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1348621565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390687AbeIUWIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:08:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37426 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeIUWIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:08:11 -0400
Received: by mail-io1-f67.google.com with SMTP id v14-v6so12819879iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5be9Yy44zxfcpBkhC2jQQmdEFjrUOIB6gvfsNDQ+kNA=;
        b=M8awrdLjO4LXfzo0d/iAgpEjkZP5wtoPEy/+36TlxGtEzMKvaslDZ79+aJy3dmiPuQ
         eTXNRE5xX2mxcbfMWARNQPInyvdjUs+hqQVfihUoxdRUENdmVZ82AVLQCPspgFhGklHD
         A2h0F67HqSkqOFLyzbCODmxZMtOlGdD8NkuU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5be9Yy44zxfcpBkhC2jQQmdEFjrUOIB6gvfsNDQ+kNA=;
        b=IOgf3CRk0sVQ470kl/r3aeq4b8fkjvefsQkCwTtG8Lgwy7Hg2vqyRbFmn4dJGR9q2Z
         0B7TmDSPvUk8wtXmFCV8yF7Az66aVS/FseBzuCJmD7uJw4yeMvGA6wbVDlO1SfftSBnf
         y+O3PYT1vZlIk7rxdWSeVPWwNHCAL2qpiREBeJZECFG98nt+vWymao++7SoC9D8/uDKV
         SVSZVGCWDkFOgfX9aq8lbxxUB64UHN8wVC4HATqrkOmNS3Eb2WMUXAQyPau9HzhhdZ2e
         7axX0CWQ7JpQuU3BTA/KHeW6+MIxfNopoDP9uaKsL0kLDpmTHmzqHjQ2i5wJPUTyondT
         ih8Q==
X-Gm-Message-State: APzg51BzzI+Si2rmyzyJFgwYAw3f0CXEshG0aWCq+csPDdrORuqgOVmX
        cjboxsIau8BUuY/KhObNZ2GHdGjXohsJoKEbZIvS7w==
X-Google-Smtp-Source: ANB0VdaenSWISoDJf0wDu6rWd19lxF6WqdwMjcZRUeLQ6bhH4nSNm36dKvTM1yKqQChzgRweiTlCoYkqQug40XhhAm0=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr39486211jab.113.1537546715458;
 Fri, 21 Sep 2018 09:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180921015941.28468-1-yuehaibing@huawei.com>
In-Reply-To: <20180921015941.28468-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Sep 2018 09:18:22 -0700
Message-ID: <CACRpkdbHALf7m2uQ091dBmD9aTctzN2ym5=vZ1wFbE_ayJ-8Fw@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: sunxi: fix 'pctrl->functions' allocation
 in sunxi_pinctrl_build_state
To:     yuehaibing@huawei.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 7:00 PM YueHaibing <yuehaibing@huawei.com> wrote:

> fixes following Smatch static check warning:
>
>  ./drivers/pinctrl/sunxi/pinctrl-sunxi.c:1112 sunxi_pinctrl_build_state()
>  warn: passing devm_ allocated variable to kfree. 'pctrl->functions'
>
> As we will be calling krealloc() on pointer 'pctrl->functions', which means
> kfree() will be called in there, devm_kzalloc() shouldn't be used with
> the allocation in the first place.  Fix the warning by calling kcalloc()
> and managing the free procedure in error path on our own.
>
> Fixes: 0e37f88d9ad8 ("ARM: sunxi: Add pinctrl driver for Allwinner SoCs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
