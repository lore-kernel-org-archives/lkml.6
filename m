Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE728C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C5D21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSzRaqdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C5D21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeJKPyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:54:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34909 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJKPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:54:10 -0400
Received: by mail-io1-f66.google.com with SMTP id w11-v6so5969723iob.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xh3J084cKgp3cfmsxOKFArb3aBSr9ruhmYH4QDI6itM=;
        b=kSzRaqdCxU5+ixGka5rjM4fL96ist47fA37I39wzKJt/OfO0CsgPefgcY90K8AEoZE
         e1V+aR6/giek9d8bCBO6ucFFdPmtIQ+PTUIEtlabdFQIMHgajBV9J4x/mycJd6B5vDix
         cEDTKC78otBFoWq+u8EA9zhe4gw1vx5Ob/15I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xh3J084cKgp3cfmsxOKFArb3aBSr9ruhmYH4QDI6itM=;
        b=Gb2zCxeV8HqR3f4Y0ANzSs5dbg/oZOtP5zEILA5CnWNx+TAJOHJlqkY4ExUyuBoCjG
         O2DFe8u6T7IucblSc1K4KGOaXqqVTHyhQeB2RS12I17F/dYJQbMv64imvX31je2FA2qZ
         XIdM+VddIRvaAprppHQZEEaH3KlaSvma07p+yVkrlH6qtOiG0mzb8KlZ2587SBHw47fi
         2NR9QCpBmR+pVTHwewz3aZIElU9HpI+iT2ZQSlgIsKx6C6tdO7nVtQqkCPRqj1GKZhHe
         IAbnMveDGtvDwFjCWHyM4qOnjDr8tAkN3D+jPtRtBc2QGkCa7CammGuUrMdm33D6z5xZ
         buOw==
X-Gm-Message-State: ABuFfojFHhL7A0iGpqkTqWboEqF+FV3ospvWbBTFxRhg7dAMxaBll6iW
        bANpThGj5tnSTZ2becQEzaKjbrgZ+nhitUSx9QcmmQ==
X-Google-Smtp-Source: ACcGV617irYAf4VGRYIFi/0TEr1p5+NrW5rZw8kmVOudQs7SBtKu3dYhEFjPoQCziTVYvP2GRjYKEhs27HmsMA3ib2I=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr396375iof.304.1539246477342;
 Thu, 11 Oct 2018 01:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <90dbf770-5262-5128-e585-c44d086568f9@ise.pw.edu.pl>
In-Reply-To: <90dbf770-5262-5128-e585-c44d086568f9@ise.pw.edu.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Oct 2018 10:27:45 +0200
Message-ID: <CACRpkdYQBxvHh-AfODddzc5G+BMBhUBSRXUdLVO8_99yniUYPQ@mail.gmail.com>
Subject: Re: Bug introduced in the of_get_named_gpiod_flags function.
To:     wzab@ise.pw.edu.pl, Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wojciech,

(Thanks also Randy for forwarding this!)

On Wed, Oct 10, 2018 at 6:32 PM wzab <wzab@ise.pw.edu.pl> wrote:

> The function of_get_named_gpiod_flags in older versions of the kernel
> (up to 4.7.10 - https://elixir.bootlin.com/linux/v4.7.10/source/drivers/gpio/gpiolib-of.c#L75 )
> contained an important workaround:
>
> /* .of_xlate might decide to not fill in the flags, so clear it. */if (flags)
>    *flags = 0; Unfortunately, newer kernels do not contain it. Therefore if the
> "xlat" function in the gpiochip driver does not set flags, (like e.g.
> the Xilinx AXI GPIO driver: https://github.com/Xilinx/linux-xlnx/blob/c2ba891326bb472da59b6a2da29aca218d337687/drivers/gpio/gpio-xilinx.c#L262 )
> the random, unitialized value from the stack in of_find_gpio
> ( https://elixir.bootlin.com/linux/v4.18.13/source/drivers/gpio/gpiolib-of.c#L228 )
> is used, which results in random settings of e.g., OPEN DRAIN or OPEN SOURCE mode.
>
> I have also reported the problem in the Xilinx forum:
> https://forums.xilinx.com/t5/Embedded-Linux/Bug-in-of-get-named-gpiod-flags-function-in-the-kernel-random/td-p/897695

It seems the commit removing this is:

commit 762c2e46c0591d207289105c8718e4adf29b2b34
"gpio: of: remove of_gpiochip_and_xlate() and struct gg_data"

But I honestly don't see a problem with it.

You are referencing an out-of-tree driver. Use the in-tree gpio-xilinx.c
that does not do any custom xlate and you will be fine.

I looked over the driver doing custom flag translation in the kernel tree,
and they all set flags, so this is not a problem in the upstream kernel.

Yours,
Linus Walleij
