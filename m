Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA880ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2849208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Az0VIVQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2849208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeGPVaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:30:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39182 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbeGPVay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:30:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so33257554wre.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EZNJr0eTyWX+0EudR48uBYNiRNF51MCqerQkoqYyZ9E=;
        b=Az0VIVQZfEq0jkiaBA1HAotzCTuvNYQ0nrDN9rLp+TJ+fw0+XtwJJB95tOICtWEwu/
         rQoEy00IDem9WBMYJCPLcrNEQ69sKoeSXg3oSuSXSqOmgFHKzFMUCAhRZxa9/YeQA7UR
         +VfW9tJ4uwtJKMPx3fE0etl0NbAyGaWzCrjr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EZNJr0eTyWX+0EudR48uBYNiRNF51MCqerQkoqYyZ9E=;
        b=cOPk/PT1vVrj2Nq+TBOvN3djQICOW32r+RUhiGJ0g5lq4U3vZ+0sF8jlVlQHHwKsI/
         OESrBWlmPe28IB97womqFt8A2oxyAl7FdB/ZLIynMGPpnLvmGo5ZUYMgLeJgxTNkedid
         BWnJrEAyN256cZHbJHQ/VcyKyZq+2OPCComzZ4FFl0H5OuIptChxLvtkZr5Lsgf+G8uY
         6kNmyDPKbJO5uWCGbS5tXhiumlDGBfr8fAqJbnO9mqg1IEx75L/abon6INhY3mokbROd
         d/xHBGKD5MewHmXzJFrS/38P61UN5ngWiOMeE0Gi7ZQowdc0jj1Pv6CNyiAy9jD3ITFy
         bcfA==
X-Gm-Message-State: AOUpUlFsa6PyPjo7E3tRz/vXcjJzbHPxnJd955GyENppDWTEHvX58hmp
        zqSHOBzqPpYzI5ENqo9ot18L0U3n6fhGKHo3dACwVg==
X-Google-Smtp-Source: AAOMgpeuzPPpqNziXQIOKY9q0N3HqAH/hsypb3oMxci3el6ZhnS9x2X5LvDqaX53ASJC1HBqXuedkjnJCPs3FhOAcKA=
X-Received: by 2002:a5d:4b50:: with SMTP id w16-v6mr13034087wrs.87.1531774902106;
 Mon, 16 Jul 2018 14:01:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 14:01:41
 -0700 (PDT)
In-Reply-To: <1531773650-30424-1-git-send-email-mojha@codeaurora.org>
References: <1531773650-30424-1-git-send-email-mojha@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 16 Jul 2018 14:01:41 -0700
Message-ID: <CALAqxLVMaU4FJ1xu78ow=FwSbmQObw0-HGBUTpgr27vjKTOqrw@mail.gmail.com>
Subject: Re: [PATCH v4] time: Fix extra sleeptime injection when suspend fails
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, gkohli@codeaurora.org,
        cpandya@codeaurora.org, neeraju@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 1:40 PM, Mukesh Ojha <mojha@codeaurora.org> wrote:
> Currently, there exists a corner case assuming when there is
> only one clocksource e.g RTC, and system failed to go to
> suspend mode. While resume rtc_resume() injects the sleeptime
> as timekeeping_rtc_skipresume() returned 'false' (default value
> of sleeptime_injected) due to which we can see mismatch in
> timestamps.
>
> This issue can also come in a system where more than one
> clocksource are present and very first suspend fails.
>
> Fix this by handling the sleeptime_injected flag properly.
>
> Success case:
> ------------
>                                         {sleeptime_injected=false}
> rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>
>
> (sleeptime injected)
>  rtc_resume()
>
> Failure case:
> ------------
>          {failure in sleep path} {sleeptime_injected=false}
> rtc_suspend()     =>          rtc_resume()
>
> sleeptime injected again which was not required as the suspend failed)
>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
> Changes in V4:
>  * Changes as suggested by John
>     - Changed the variable name from sleeptime_injected to suspend_timing_needed
>     - Changed the boolean logic.

Thanks so much for reworking and resending this again!


> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
> index d37588f..ee455cc 100644
> --- a/drivers/rtc/class.c
> +++ b/drivers/rtc/class.c
> @@ -102,7 +102,7 @@ static int rtc_resume(struct device *dev)
>         struct timespec64       sleep_time;
>         int err;
>
> -       if (timekeeping_rtc_skipresume())
> +       if (!timekeeping_rtc_skipresume())


Hrm... So I'd have instead inverted the logic *in*
timekeeping_rtc_skipresume(), rather then here,  but this looks to be
close enough and I can fix that bit up.

Can you confirm you've validated this version of the patch resolves
the issue you reported?

thanks
-john
