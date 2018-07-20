Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3906CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D025A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Rb60WA+U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UmKhfSvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D025A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeGTWDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:03:19 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:40253 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbeGTWDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:03:19 -0400
Received: by mail-vk0-f65.google.com with SMTP id s23-v6so6697624vks.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Mwk+GJ1m2Bzq8jZ82f2g4Q6JdsBheHZJ1Z1QtAUFJQM=;
        b=Rb60WA+UPKt65EeqtgZ24fRnmaw20LiV5Jy9d9kz5OdblTLWHfNaIOYdDQUmUO+v5T
         niPbTqESWsGY6UL3yQlblCKgyHm6+nLAp3rN9oplPdb1y5BGxTuoqVKY86Vs+B7T3OuC
         DV5d5AwFmjSNAUvb9pxCV9fBCYrHY1qwj86ILz5GQKHcY2oRrnRnPXn1HmzFb6WfJGgH
         kOi8Bb8XqzKqSm+l2fMej1iu4ZZVe+KPv4dvwsAsuNhPk7ngoFaxrVgU5ZbfvAu5qxdt
         R+WFfBJHz6E297byviEwQks6Q9GVobRFuCkyqvD8sSLTRKNOD3GFQ402abF81AxVm00K
         0awQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Mwk+GJ1m2Bzq8jZ82f2g4Q6JdsBheHZJ1Z1QtAUFJQM=;
        b=UmKhfSvS0NbP9RvAhaMW4H7tRRHOW9tDl301vM/jZMfl/io5FpppB26GuIkVCtJnbR
         M72flhyaNsQsRXQh46OUibmv0e7OvCjr6K5T9+mr+zq1vTnCHxJNWr6qWL7oeTWxCNsF
         51P5YABnNjyXJCfvmJIoAB0Cz53jbJAU5dpFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Mwk+GJ1m2Bzq8jZ82f2g4Q6JdsBheHZJ1Z1QtAUFJQM=;
        b=qLdIEQbKp6vdjkMXsnXE/TF2eF0+OXBMo72/ZtUdzrYMUKL9HdGPg/eAMHi9hcz0/7
         jF0B+EmJJg/P0Ro248zFvMlnYS6/xMsfnb9zLOBenDoVfGjuYLGRet5Cv+/9MQHi4gAh
         1Z3l8bO0rctgpLDCjSm87nsX9/6U8QzOwN/hubjWo52iIhgQ7uhVGJAy2ErAkY0NkXDf
         lZccFZpqvtn8C61FPZVIkJ0a81boVGZ3SbFh2f0hIm8bQM3OoBuwTUP1upfL7xQ1BcQ4
         xMre55OQvs20CeEleUDlC2Cb245hhDodaJV4rAAlIy12AB4b8EgAp9r8osjsxn4qDSo1
         UMQQ==
X-Gm-Message-State: AOUpUlGcHww+ziijz8chgeGJ7QwO0TMo71YBcFiyF0k3k+Rmkg2TSfYN
        4LquIhcrqm5bR11AVvLZVe5XCoXpp2mRG3nPY4i8Tg==
X-Google-Smtp-Source: AAOMgpdbKBod4SDPUopxCzxUEI42If3n1bv6GyadO7bD8kuAtlkol3iMbrpmdVuYJ/neVMEQU+z1j9MQ0WXiW6GNU8I=
X-Received: by 2002:a1f:9d16:: with SMTP id g22-v6mr2202688vke.5.1532121196322;
 Fri, 20 Jul 2018 14:13:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 14:13:15 -0700 (PDT)
In-Reply-To: <1532087461-3474-1-git-send-email-dkota@codeaurora.org>
References: <1532087461-3474-1-git-send-email-dkota@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Jul 2018 14:13:15 -0700
X-Google-Sender-Auth: eMBUMhTgVB2WIUUnzlN_kwun0q0
Message-ID: <CAD=FV=Va2sr7AOvvo-Pw1ARaZyxzAGLK19qMG+PyNMpmAkV3Og@mail.gmail.com>
Subject: Re: [PATCH V2] Add SPI driver support for GENI based QUP
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     timur@codeaurora.org, Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 20, 2018 at 4:50 AM, Dilip Kota <dkota@codeaurora.org> wrote:
> This patch series adds SPI driver support for GENI based QUP.
> Also adding the device tree binding document for reference
> as per reviewers request which was merged in Linus tree.
>
> Girish Mahadevan (1):
>   spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
>
>  drivers/spi/Kconfig               |  12 +
>  drivers/spi/Makefile              |   1 +
>  drivers/spi/spi-geni-qcom.c       | 685 ++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi-geni-qcom.h |  14 +
>  4 files changed, 712 insertions(+)
>  create mode 100644 drivers/spi/spi-geni-qcom.c
>  create mode 100644 include/linux/spi/spi-geni-qcom.h

This looks like it was supposed to be a cover letter.  Typically
that's labelled as "patch 0" in the series.  Other handy traditions:

* The cover letter should contain a description of what changed
between this patch and the last one

* You only want a cover letter for a patch series with more than one
patch in it.  In your case you only have one patch so you should have
no cover letter.

* It's handy if your cover letter has prefixes that match the
subsystem just like the patch itself.  AKA: "spi: spi-geni-qcom:"


Personally I use "patman" to help me with sending out my patches.  See
<https://github.com/u-boot/u-boot/tree/master/tools/patman>.


-Doug
