Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C93AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B043321531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrMQau+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B043321531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbeITVaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:30:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:56197 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbeITVaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:30:15 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so13747842itj.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vB6icuBZtONcdJE81OTynlGpnhhW6fzCbvvtxe8DkLI=;
        b=WrMQau+BpefXqQvP07/ruh3mFJYJ552mcL7eohJuW3DQgykWBte7Sx3S6iVe2MdcIz
         a/kGDNkIQXQThGpVpGpwZak6XNFq8LeOuCJyuYlDDEfdimvURc728JQ57gSBfEGAECiL
         0z/MyE45UEAIB+e0goCCysvdkb4tkg+Co9sbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vB6icuBZtONcdJE81OTynlGpnhhW6fzCbvvtxe8DkLI=;
        b=BNon0doY18JsS4Jy3JXm81AUWBVt/5d0ER2V/pZwKI3tOlOx4YhrrUlUK8K2rfEQFr
         ey9zCQd1BTM5231pBWa3zQ51/fbPG2o1CQjR3JHg7KI13Qbd2vvg4YIFkfB0xnq1rQ39
         2y3fvT2VSaR3YxmqYxmJEX0o7qVZD9ISBIGF5Z8nT/8cNewbMQx+Y0Vc0MAjyoVedpYI
         NLs+YSeKSv/kuMwPFS1aUZ3x3j3674RZK5OPcOqpl5JUE4YHMbsV31tm3lDnuMzedq0Y
         4qK9WwPjBXsMjF685dYvQjQEhYstXVoFaYxBP093cORy+a72HlN9wJ3XQFhTo9epph4X
         B/yA==
X-Gm-Message-State: APzg51A3NiBvL4OaYodUJKswCk2JjKBEPodWpqrCutkX6FHoDEw1pfVS
        dy3PwbI/Jp3CuVA8DG8rbJDaku/2cnWBsaBG5TSfhA==
X-Google-Smtp-Source: ANB0VdapblOv9Jf68dKod1lHvNIk5i5HkehWxIOM/i9GwP5Q3i4crble/ChXy5Y5MgLC2ktlGCR0X9TCJ3kHKUiUFBw=
X-Received: by 2002:a24:7605:: with SMTP id z5-v6mr2440285itb.62.1537458369879;
 Thu, 20 Sep 2018 08:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180919221331.2511558-1-taoren@fb.com>
In-Reply-To: <20180919221331.2511558-1-taoren@fb.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Sep 2018 08:45:57 -0700
Message-ID: <CACRpkdZGjvLZY7snev5W2rRGgO7bQsSqn5u2v5Nw0tH9sa4yBw@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
To:     taoren@fb.com, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>, cov@fb.com,
        tfang@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 3:13 PM Tao Ren <taoren@fb.com> wrote:

> Currently, the aspeed MATCH1 register is updated to <current_count -
> cycles> in set_next_event handler, with the assumption that COUNT
> register value is preserved when the timer is disabled and it continues
> decrementing after the timer is enabled. But the assumption is wrong:
> RELOAD register is loaded into COUNT register when the aspeed timer is
> enabled, which means the next event may be delayed because timer
> interrupt won't be generated until <0xFFFFFFFF - current_count +
> cycles>.
>
> The problem can be fixed by updating RELOAD register to <cycles>, and
> COUNT register will be re-loaded when the timer is enabled and interrupt
> is generated when COUNT register overflows.
>
> The test result on Facebook Backpack-CMM BMC hardware (AST2500) shows
> the issue is fixed: without the patch, usleep(100) suspends the process
> for several milliseconds (and sometimes even over 40 milliseconds);
> after applying the fix, usleep(100) takes averagely 240 microseconds to
> return under the same workload level.
>
> Signed-off-by: Tao Ren <taoren@fb.com>

Actually this is much more intuitive too, it is the typical way to handle
a down-counting timer. Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Sorry for any cargo-cult programming on my part :/

Would be nice to get a nod from the AST2400 users that this works
for them too, so included them in the To: field.

I can't test it on up-counting hardware right now but I convinced
myself it is handled just like before so it shouldn't be an issue.

It actually would make kind of sense to restart the up-counting
timer from zero and set match to whatever value is passed in
as well, so I might send a patch for this. It's no regression though
so no hurry with that.

Yours,
Linus Walleij
