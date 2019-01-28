Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9E9C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC75214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPMr7hVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfA1ORh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:17:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33212 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfA1ORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:17:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so14399337ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnCwQx8NoJkUd1q9lUiNxR5g2FVyPHrO2YY/Ijat5fE=;
        b=MPMr7hVoeNRiaDaK5D1ei2FIt2O39HxW1zDfWzRmUtgVhS39lwGblZmx1DSFnqXNZn
         vS1ZYnXiXk0HZ62JXi1kNIyTqJYwaqeaLCzW2Q5CDQGpBy+dgclptEpe95RGnNzb8Cdn
         Njx5/cLuhHxynOv4Z8TbV1D547KGmtm5+rd80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnCwQx8NoJkUd1q9lUiNxR5g2FVyPHrO2YY/Ijat5fE=;
        b=RWtzD1USSy31sZYHdVswAKx/VkV5gAwcaaOU1n5cu9GsPomzINZsvq8dVg7z3lSOXP
         qQIGCukL2NCwWwwYIXb8nzTUTezM0+oMVSf/ac8x77+lNwbhEp68SqnP8RrN+ukpM1xk
         6O1Ycdys73L/Jj97tii71WwvwfUjdmdFUCDNYKrzgY95+KrdH4KZB64Nv1JWa8trmQdJ
         1trEdGv3J0m7P7b5OH1NtkvOINQgJnR6c1fecaNl8ei01HNuscciL/YCy4CrLpbYfSZT
         J7GG8n6rv6RwsAM5LaazwrTbnajbtoVwHPe5hqXnn2oar/zFTkVEHvcqXAq2aa6Gwdw9
         F9pQ==
X-Gm-Message-State: AJcUuke63nw+0rOuILrOJwv+FNwsB1btOm1hIvHjtBVzWvh8PRfejzCw
        dtx3WdSx2KqWt4vkQ3S0grR1kFQzaP9cd+RQcQH0pw==
X-Google-Smtp-Source: ALg8bN6rsdQBw+GEmzHWQHODjQdy8aEReOcviuubyOACPjUr+pVtPUM9cnVFnjbLj0mhoegONM9CkhzPVBl/T28W3ZE=
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr16801786ljt.107.1548685055127;
 Mon, 28 Jan 2019 06:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20190124202205.7940-1-ilina@codeaurora.org>
In-Reply-To: <20190124202205.7940-1-ilina@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jan 2019 15:17:22 +0100
Message-ID: <CACRpkdZVrwviuXo_3epzDTacrYRnyTAWOLKSpNG7j_0Fv8CkEg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] qcom: support wakeup capable GPIOs
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rplsssn@codeaurora.org, linux-arm-msm@vger.kernel.org,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 9:22 PM Lina Iyer <ilina@codeaurora.org> wrote:

> This is a bug fix submission of the v1 posted here [1]. The discussion on how
> to represent the wakeup-parent interrupt controller is on-going [2] here. The
> reiew comments in [1], from Doug and Stephen are addressed in this patch.
>
> The series attempts to add GPIO chip in hierarchy with PDC interrupt controller
> that can detect and wakeup the GPIOs routed to it, when the system is
> suspend/deep sleep mode.

I kind of start to get the hang of this now. This is starting to
look finished. Some words on the hierarchical GPIO IRQs:

I have started to look into hierarchical GPIO+irqchip since
the usage of such is spreading.

I have been on to Thierry patches trying to make him implement
more generic helpers in the gpiolib irqchip library functions.

In short I see the following:

- Hierarchical gpiochips all have .alloc() and .translate() functions
  that look more or less the same.

- They all fall down to remapping either tuples or entire ranges
  of IRQs from parent to child with a linear look-up table on
  allocation.

So my idea would be to add support for this into the gpiolib
hierarchical irqchip helper: by supplying a parent irqdomain
and a list of translation tuples, we should be able to handle
pretty much any hierarchical GPIO irqdomain (famous last
words).

Right now I am converting the IXP4xx platform to hierarchical
IRQ from the ground up (it is not even using device tree
so it is a bit of a challenge) but it seems to be working.

So I will try to post this in some hopefully working form, and
on top of those changes or before them introduce some
helpers in the core for hierarchical irqs. Or I fail.

Anyways, I do not think my ambitions for refactoring the
helpers can stand in the way of support for these use cases
and new hardware, so maybe we need to merge a few
more hierarchical drivers just bypassing the gpiolib
helpers. I don't want to block development, and I suspect
Thierry might be getting annoyed at me at this point, so
we should maybe just pile up a few more hierarchical
chips so I can refactor them later.

What do you think?

Yours,
Linus Walleij
