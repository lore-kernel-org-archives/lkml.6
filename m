Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C4DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344082087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/NLsLtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344082087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeJKQEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:04:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36828 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeJKQEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:04:48 -0400
Received: by mail-io1-f67.google.com with SMTP id p4-v6so5982121iom.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIfRoxCe9Yd1nBFSy6QNQ093Pvbhe1FgXabvQCkt62E=;
        b=E/NLsLtBT2CxRu0XLnDt+DIy4uBHRRdNZMZr8rQNX9ewfpJrQAgN+VCFx4Zc4yhlA0
         9gia0SDNy0/VJCJ4tO6Xo36G58ZjVtzFBa8DVQJRojKk+yEcMmqmb8DgEBylJiijt2I3
         XJuyNP2g5AjQ3UDsabABrwybzBcM0RtZclaJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIfRoxCe9Yd1nBFSy6QNQ093Pvbhe1FgXabvQCkt62E=;
        b=gFKgBJ88D08lMPGo04lDjqn2hcep+klzpUX2ojWWs0VIfZ4cKlbmh7T/YR2X3R2D3H
         w+ZvMnnW5NiixePBZU3TNZuPtWMGSLA9omSw6DyU0wgN3fok744/SGqma4U7M6c2Axv+
         /dbXboMTU8T74mxlczGLr9WVGD4R2K4C/BqPReA++kqhMtR1fqcpRUcrryQNIJYE9Ks7
         tkWWm/9gfSRH/Kkv7iudMTE2R1qNyvuDsVonVf2nN3qMhUW+1TGUnH593O2zOAA1rskt
         GbnDF0XJAQEFlr5yGhP5HclBLZGJ9Ag9pHtMez+SrBkfTuFtDyoHaZm2G3q2XpMlaQQF
         F7CA==
X-Gm-Message-State: ABuFfoi8hcWK8j450KA2vbA8+YszvDMblS3vW49/3hv8xEWGiqvRGlGL
        ObUdqOGLMU0qapkvEq98F6dYXsh78BAE1CMPn8U50w==
X-Google-Smtp-Source: ACcGV63s/Ixjm47oYl4EtZJ1f7jYDRadCpZ2+zLL+HsklqjBID3NH36w22GmcaxSn9fWgqtt/c8NTrOf2g+DKGai7sU=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr376216ioa.277.1539247112666;
 Thu, 11 Oct 2018 01:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181010142504.233467-1-lkundrak@v3.sk> <20181010142504.233467-9-lkundrak@v3.sk>
In-Reply-To: <20181010142504.233467-9-lkundrak@v3.sk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Oct 2018 10:38:20 +0200
Message-ID: <CACRpkdZK3=u-E3KgVQT_Wx8tZBqO3Own_+ASLeq03vaP8q+s7A@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] Input: olpc_apsp: allocate the GPIOs used
To:     lkundrak@v3.sk, Stephen Boyd <swboyd@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, quozl@laptop.org,
        Linux Input <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

thanks for your patch!

On Wed, Oct 10, 2018 at 4:26 PM Lubomir Rintel <lkundrak@v3.sk> wrote:

> Take the GPIO lines are used by the SP. The driver doesn't touch the
> lines -- this is done to disallow anything else from fiddling with
> them because that would confuse the SP firmware.
>
> Also, the lines are now nicely visible in /sys/kernel/debug/gpio.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Sadly I do not think this is the right way to do this these days.
In the past I would have agreed.

A few months back, Qualcomm engineers working on ACPI
support ran into similar issues: there were GPIO lines that
could not be touched by the kernel because they were used
by firmware (BIOS).

The solution we devised can be seen in
commit 726cb3ba49692bdae6caff457755e7cdb432efa4
"gpiolib: Support 'gpio-reserved-ranges' property"
which adds a "valid mask" to struct gpio_chip.

It is further refined in the lates working kernel code to make
it easy for users to set up a custom valid_mask.
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commit/?h=devel&id=f8ec92a9f63b3b11e399409141b7868bb405e6b5

So what you should do is modify the platform set-up for
the OLPC to mask off these GPIO lines as invalid since
they are used by the firmware and Linux should not touch
them.

Sadly I don't know which GPIO driver the XO1 is using,
but if you tell us I bet me or Andy will be able to help you
out in finding the right spot to patch.

Yours,
Linus Walleij
