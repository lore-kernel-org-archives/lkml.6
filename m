Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF855C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734652082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qt32olri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734652082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJYV2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:28:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42459 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJYV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:28:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id q6-v6so5957963lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTa1ov64YaEhBNacBE+yn3O2NjTzj3qewlBa7u1Eia4=;
        b=Qt32olriIP3I2KRFxHfsq1cgZ9txbCcXlVi32R2KbrJ/+cIbBEN/ZbRuBxfZI0n46D
         Tu18CYn4/C7znNCEap8BWgzhneRLD23LE1No29ssvRQS3Cru/tEetqIQ2Cra/eHBjBMS
         ZIyQVj4qF1ylwMfREqy4jxqmm1G6ztVy973rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTa1ov64YaEhBNacBE+yn3O2NjTzj3qewlBa7u1Eia4=;
        b=sw0nl4MbLKdx4CZr4MEsaLtJk3vuYq1BdRVgTAeqr8vV1JQAzb5JOX5WYw0IxO0hPc
         JmpuXNuQQAZ6qoem24AaUNDo0Oe37u+97cW1IYRk4ZWld4d3A+z0Xjzfzz5xz/4+nwrz
         vC33KLmDl3D8ONsEqwqN9mVfYfKLiBe84oXsw4lVbyxC57F/xRnIiz9EwIbNyvXcMdZJ
         hqlWH7Mbk1GltAH8BC0lbBN+2fbnu6DYp0XK2No/L97w0QkDe/9QoSPtmUQ62hbWmn0e
         YqRV7d4JoeDCX3yFBV3G4AQ8byxXT4SaGdBUdn77/lsIfxEPjqW29Kg54QyNf3UU/MuN
         1Ewg==
X-Gm-Message-State: AGRZ1gJCQILwQWBHmeKG7jb7F2j+SPTWf83erwhYCZTvegTs9OQlSTIf
        1yStp07Ls86GgIaWpY9cAlaCi21DabsqDs7SEdiZWQ==
X-Google-Smtp-Source: AJdET5c7RqXhrHNYXJQhziCQYMrR8h5lxQ3NEYuFgFcgatrpOOWUij8PKRRmWkFa60AszOCyqHW8V0WbsQgwPNXVQvw=
X-Received: by 2002:a19:f813:: with SMTP id a19mr1088472lff.67.1540472132922;
 Thu, 25 Oct 2018 05:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181018001432.710-1-liviu@dudau.co.uk>
In-Reply-To: <20181018001432.710-1-liviu@dudau.co.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Oct 2018 14:55:20 +0200
Message-ID: <CACRpkdaHBf1eJig5t2_u89HhKb2Ne8FV1AhfdZ3Yy_XTZQdEqw@mail.gmail.com>
Subject: Re: [PATCH] leds: gpio: set led_dat->gpiod pointer for OF defined
 GPIO leds
To:     liviu@dudau.co.uk
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 2:14 AM Liviu Dudau <liviu@dudau.co.uk> wrote:

> Commit 45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device")
> removed the common code path that set the led_dat->gpiod pointer in
> create_gpio_led(), but only added it back for the devices that have
> a valid gpio_led_platform_data structure. Calling gpio_leds_create()
> in gpio_led_probe() is not enough to get a valid gpiod pointer.
>
> Fortunately enough, gpio_leds_create() already gets the needed pointer,
> we just need to assign it to the relevant gpio_led_data structure.
>
> Fixes: 45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>

Ooops
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
