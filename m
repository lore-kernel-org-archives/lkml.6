Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FF3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999FA20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jV3l9+rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfAKIj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:39:27 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42760 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfAKIj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:39:27 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so10200021lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zlDng9S8L0oO0/SeFbQwhq1SiBSleWA4PjM7GHpD5yk=;
        b=jV3l9+rhYtT/zl9Bz7uzkxvzaUF3BaPBw6FlisPBbKp8mGDMlRo0IlcosQiUyuH2Wf
         ltwsqHlXIy1xdoQqgcX78r60NB0B+oBvtQ8P8xP6OSy8VtCt4NbdeaS2+LlzDGiafC5U
         BwaicTDT4T0x6lucBlbIu+8/YDGrn0Z7FsgvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zlDng9S8L0oO0/SeFbQwhq1SiBSleWA4PjM7GHpD5yk=;
        b=ZarRJPB0NbR8x8PeoUXCK/BvvulFua3YkP0DhCBJZJ1vF+ULOojJiv1W6HisV0zRqQ
         dBfoaM5ocX1EYWvuBnNHh/HvJFGtZf/DWcU12n26DbLTQVFXeO6YZSLt4yBwh7KXZAvM
         nvOr55eMddt6tNQZ29VN0GBeI2tDPaY0Uz+EjQkBTnYd0gH7kdf66XFVyC1w3P/xQ7uz
         S9m3bkuaGWkgoEPqkhZA7oP4c6G16K16uGuJr6q2St7PheIcVODd+NJkMB6QLhJgP6l2
         PY+9TmY+/uZ8oDmbHkdQ8s86b+XWnU40jn67/j4HnTTNvhM5w/74qvzYzVHfkq/6QSCy
         Cu2g==
X-Gm-Message-State: AJcUukekOp0P00foCj0cUKeikuK4Am2gzM9DUuiHzlCPtYZs+NoNk4Q8
        IbOEdVfHHsnN4reRB86OjHWIi6KtuUwx/c17TXZzug==
X-Google-Smtp-Source: ALg8bN6fIk1oX7nly1s5OzpcFsbk5GeBYU4mVU5SgKQSWAtuo8Y31qYHyE3qndAxFGkiW73KS3VVNBjLsnJUbtiGkCA=
X-Received: by 2002:a19:4849:: with SMTP id v70mr7360546lfa.62.1547195964687;
 Fri, 11 Jan 2019 00:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20181217213430.GA28450@embeddedor>
In-Reply-To: <20181217213430.GA28450@embeddedor>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 09:39:13 +0100
Message-ID: <CACRpkdbttVUV50oAOO=v6Nw+PQTEqufP+53pZMOPYwX6fmXEiQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix potential Spectre v1 vulnerabilities
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:34 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> offset and lineinfo.line_offset are indirectly controlled by user-space,
> hence leading to a potential exploitation of the Spectre variant 1
> vulnerability.
>
> This issue was detected with the help of Smatch:
>
> drivers/gpio/gpiolib.c:580 linehandle_create() warn: potential spectre issue 'gdev->descs' [r] (local cap)
> drivers/gpio/gpiolib.c:927 lineevent_create() warn: potential spectre issue 'gdev->descs' [r] (local cap)
> drivers/gpio/gpiolib.c:1053 gpio_ioctl() warn: potential spectre issue 'gdev->descs' [r] (local cap)
>
> Fix this by sanitizing both offset and lineinfo.line_offset before
> using them to index gdev->descs.
>
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
>
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I don't know what to do with this patch and I am also worried that
it is dangerous and irresponsible to drop it.

I am worried because I simply don't understand the conditions under which
this can be exploited, to what extent, and I am worried that I am sacrificing
performance for security that is not needed on this
performance-critical path, which is why I am asking for performance
effects: I really would like it if someone could take this for a ride
on some x86 system with the mockdev and libgpiod.

It's not like gdev->descs is a secret or contain anything sensitive,
the typical info is just electronic set-up. I get the idea from the commit
message that this is all that may be exposed?

If this can be exploited to expose the whole of kernel memory on the
other hand ("speculation windows are large"), I would be an idiot if I
don't apply it. But then the commit message would say that the entire
memory is at risk?

Yours,
Linus Walleij
