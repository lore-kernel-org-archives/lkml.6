Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA91EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9800F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vp8luyYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9800F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbeGJSso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:48:44 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37795 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733312AbeGJSbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:31:13 -0400
Received: by mail-lf0-f66.google.com with SMTP id j8-v6so19144551lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OkFGVlTupMIy0BVQ3T/arjwEZphiZbJiESq5NpaNc9M=;
        b=Vp8luyYqQrVJI/rRtAV07+AcvdmVsBah0G75jvrXnG4Xli/Rb5o9acH/ps6XGxMdtF
         BRvWbaiHT7pJWLjyETUYosN1XSY6Zq4cyVGRmK+KMNpk0QIzWchO/d9WlVAwl7202poF
         OOPnnOGB/VzegALw5rCGHzIgB6UwglDgbsIfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkFGVlTupMIy0BVQ3T/arjwEZphiZbJiESq5NpaNc9M=;
        b=RwPtMWnUaAF6tQgedozecQDyAOjQQuAdtjYtTDuVtd0FV+i+aLN/c8muW6/JBTgMuM
         Dae1cqmLfRlMkitLsJtn74ZYzJBDlRUMn3EjDosEwhviof9DvUdPkGt0zAzm38+ravhq
         qfHv3tP0gRBsBG8lB5BjAwJP5D5/AuCvtq0GW0C4XM9ys27DEFoAS8jSwtFskmSQ5Cdm
         +FrWbJUMwn861nHZjJy0/G1q/YpkZlRfcxq7uNDhWw0DBpEhkL67OahjNI7uEhXwVdQR
         /I8fjzAcxNEMXUDz0HakIV1P+c4E5IvCfiK7OwuncpqARhgzVH4BQRFuahwZSfh2YtnO
         +D/Q==
X-Gm-Message-State: APt69E1cnfA+iC6WoRqRQ5Cvy6g4YhcedyVCTqtoKMr4Hk23tcRFo3qr
        3zGC8GI9fkPUQf/VwM08Zy154mjIJOs=
X-Google-Smtp-Source: AAOMgpegLFMU5B2nWo+peDPG9msAn4WY1yVItTDw7NWi9j23uLjPBqaGPs/XdfNG6TOERSKBq1lzqQ==
X-Received: by 2002:a19:9481:: with SMTP id o1-v6mr3720249lfk.38.1531245521612;
        Tue, 10 Jul 2018 10:58:41 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id o86-v6sm1374298lfi.82.2018.07.10.10.58.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 10:58:40 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id p6-v6so17424607ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 10:58:39 -0700 (PDT)
X-Received: by 2002:a2e:5c07:: with SMTP id q7-v6mr15254259ljb.119.1531245519031;
 Tue, 10 Jul 2018 10:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180619234349.166190-1-evgreen@chromium.org> <20180709173022.GH2050@tuxbook-pro>
In-Reply-To: <20180709173022.GH2050@tuxbook-pro>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 10 Jul 2018 10:58:02 -0700
X-Gmail-Original-Message-ID: <CAE=gft5+oOFv8y-XCtiQ8mc7gQ1FFSK0+bPk=mJu--ovLfDDJg@mail.gmail.com>
Message-ID: <CAE=gft5+oOFv8y-XCtiQ8mc7gQ1FFSK0+bPk=mJu--ovLfDDJg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: msm: Pass along set_wake failures
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 10:27 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Sorry for not getting back to you in a timely manner Evan, I wanted to
> read up more on the details of how this is supposed to work. I still
> haven't done so, but here's my concern:
>
> When we power down the SoC we're no longer powering either the TLMM or
> the GIC, so the MPM or PDC is used to waking the system on some set of
> triggers. As such set_wake on an individual pin or irq should be routed
> to the MPM/PDC driver, which (in the PDC case) is implemented using
> hierarchical irq domains.
>
> As such I think that we shouldn't toggle the wake property of the
> summary pin at all; i.e. the patch should remove that call rather than
> propagating what I believe is a constant failure.
>
> Regards,
> Bjorn

Hi Bjorn,
That's okay, I always feel bad pinging. Thanks for the thoughtful
response. Stephen and I are starting to think about how wake
interrupts should work with regard to the PDC, and we're at a place
where we're a bit unsure of the path forward.

Our understanding is the downstream kernel had an interrupt hierarchy
of GIC > PDC > TLMM & everybody else. In the downstream world PDC
acted transparently, forwarding most requests directly onto the GIC,
but quietly handling wake interrupts as well. With the upstream PDC
driver, the #interrupt-cells got changed to 2, and it seemed like
folks didn't like the idea that PDC was acting transparently. Correct
me if I'm wrong there. So now we're sort of unsure about how to wire
in PDC. If we make everybody an interrupt child of PDC, then we lose
the ability to specify the third GIC parameter, and we're stuck
expressing interrupts with respect to PDC pins, which is an awkward
mental translation. In this world, does TLMM need to do direct-connect
stuff to get wake-able GPIO interrupts working? It would kind of have
a foot in both worlds, with its summary interrupt as a GIC interrupt
but the wakeable ones as parented by PDC?

So anyway, with regard to this patch, I'm happy to create a second
spin that simply removes this function, but for me at least it brought
up some larger questions we've been wrestling with.
-Evan
