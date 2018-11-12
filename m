Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A83C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59882223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qck16Sbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59882223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbeKMISs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:18:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41765 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeKMISs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:18:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id v18-v6so11101959wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 14:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h8FyXYiX1JYlhpgok0kX7/UtLhabN87KEZsebfJjrnE=;
        b=Qck16Sbl4aXrZ/tvIdmunxAGBs9uLuGiPyLRy9zCGbhbNXUkdO+NT0s4myaIKGgk1C
         fYAjRT5rBAzOvBmNzTZFemXvYT2fCZnJ1C/rVQpT1yKRvkWZxnUsGOG69emQbm7YSp2R
         zK3HSEv/OG1pZSieR1+SsTd7YuBgnXm7TFWpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h8FyXYiX1JYlhpgok0kX7/UtLhabN87KEZsebfJjrnE=;
        b=kcshSf/OYdZFRTtRYLTS/cKNFC0gcIypw7Y2Dp6SKaV2uCYdB0AfOzoKljEfc5DWT2
         pqjwAfIG7/CKXSqbMwWjzRX8/8NMuK9lWvXnE9bnQFXAqVtIHFeuKa8/YlzTUUwPhsQU
         Fhunva/K11b6I/7MJPPikq1gZXn1TxmcTNYjbpgjL+VaL7PZsQywgT+aOi960KlfNZ2h
         rFldRVQ5XQpTo2Y2S/ROEJN5nMjMSfQtQnRIKpUPdHk/UYh0dX2YOIrdz4ezZA25oLqI
         f6PDLPhOvOdn9FEJeGf/flx19cT61tvfwglhz3uAajUvZJayhDR0v2MHoyTUKPY0WDbB
         aAGQ==
X-Gm-Message-State: AGRZ1gJr9+f/pCgj8NKZbwUANj+q9MxPI1huR0MijNG1iR4yrjaNkVJf
        49wBdGIge4R4BVA53f7cjgk6OQKzqzgGxE9Xnuvm9w==
X-Google-Smtp-Source: AJdET5eCTuS6gohMODOqbWPL8qWlUCRX6EDAxOohsigtMGbUwnomJXrtxlXsroaNmpW/lMcME8LjGYImHY/oP13+j88=
X-Received: by 2002:adf:a20a:: with SMTP id p10-v6mr2507800wra.249.1542061418184;
 Mon, 12 Nov 2018 14:23:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a1c:4054:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 14:23:37
 -0800 (PST)
In-Reply-To: <20181112185651.17138-1-mzhivich@akamai.com>
References: <20181112185651.17138-1-mzhivich@akamai.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 12 Nov 2018 14:23:37 -0800
Message-ID: <CALAqxLVCwWATXruj+PAAtKMuE4TDCgHCeQAmpz39k33xFm_68Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "clocksource: Make clocksource validation work for
 all clocksources"
To:     Michael Zhivich <mzhivich@akamai.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jason Wessel <jason.wessel@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 10:56 AM, Michael Zhivich <mzhivich@akamai.com> wrote:
> Revert commit 1f45f1f33c8c ("clocksource: Make clocksource validation work
> for all clocksources") to restore correct clocksource_delta() computation
> for clocksources that wrap frequently, while retaining the check for tsc
> drifting.
>
> Truncating result of clocksource_delta() to 0 causes incorrect behavior for
> clocksources that wrap frequently (e.g. acpi_pm which is only 24-bit wide).
> In particular, large time deltas (e.g. last = 0x000000, now = 0x800000)
> will be incorrectly computed as 0.
>
> If acpi_pm is used as the clocksource watchdog, and machine is under heavy
> load, the time period for the watchdog check may be significantly longer
> than the requested 0.5 seconds.  If the watchdog check is delayed by 2
> seconds (observed behavior), then acpi_pm time delta will be
>
>         2.5 sec * 3579545 ticks/sec = 8948863 = 0x888c3f
>
> which will be treated as negative and truncated to 0.  This behavior will
> cause tsc to be incorrectly declared unstable in clocksource_watchdog(), as
> it no longer agrees with acpi_pm.

Thanks for raising this issue and submitting the patch!

Yea, this is a concern particularly with quick wrapping clocksources.
Though I worry that if you're already blocking the watchdog from
running for 2.5 seconds, you're likely to also block the watchdog for
more then 5 seconds, which if I'm remembering would result in the same
problem?  In other words, does this really solve the problem, or does
it just push the bar a little further out?

So, I'm wondering to really fix this, do we need to find some way to
raise the priority of the clocksource watchdog, so it isn't deferred
for quite so long?

thanks
-john
