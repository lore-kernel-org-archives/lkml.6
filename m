Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD90C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CE52082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ci1RwWMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CE52082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJ3PE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:04:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41609 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeJ3PE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:04:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id c32so10000440otb.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2av1VkUOmj5NuLLb2nDh7g3+wtFP2oyPc8Y9Alg75f0=;
        b=Ci1RwWMbhXIsLzWyJBV9UeLJQd4PrwcbFX7pf5zPNAGY0kZgTEev6NNPo53AOZQl9x
         pmDLXze7sHwjWIseRTT4S9BQE/ON1Pgbb4mGhE2h+dP78Uw1HdzwsctQr6eNkqy4wkrG
         sTjbOfTZ9MLzOAnRLwNdxN1bjQZS6ggCv+flM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2av1VkUOmj5NuLLb2nDh7g3+wtFP2oyPc8Y9Alg75f0=;
        b=EizvopDQTk/qg49GGSWV0P80Ifsd6MSNB/AgCESOhQPb7/maIOuNfFrCsoaD03pYQj
         BEJlOkcpqaRfwJ7g4GAqvNcBjB/cilVal9Z2jnNIPD6ws5OwUpLz0beXrLNLgFpACJ1a
         jswCHgOYkL/WT7Xe6yj+lfHD+4Trz3h+1f1ayPSMrd2QeFBdYDpqeTNlHuoTfPh77R5G
         UC7vRavEE32VtMAgVJESkYBoWzMsMDbgVq3I+tiICiGm90YWPqiAa8odQTk0YhRhM44m
         LSeR6TUKjgLn5ex5dI66PD9Wy8NG0naJUSfWBoSUZc5C9ZHjbUdfwn8lJxDb9lSRH20H
         uJUw==
X-Gm-Message-State: AGRZ1gJRHY8wf9ZmbBMkBsEgShHfwYxcX40D87gnD737KAdJy2qGSuWN
        He3o7osyBfmt8a61RHOKg48Vd317LOuB7bT1xCs=
X-Google-Smtp-Source: AJdET5cu1eSQS8JTIQVbKtKfCBAoEuPOgtCN1n1s1YYsZJ5vMo7fvg0SP6z/olq+yU5mH9vx3OxkdKs8+puuLXOVbRA=
X-Received: by 2002:a9d:63ca:: with SMTP id e10mr10974632otl.106.1540879939936;
 Mon, 29 Oct 2018 23:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org> <1540830201-2947-3-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1540830201-2947-3-git-send-email-daniel.lezcano@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue, 30 Oct 2018 11:42:09 +0530
Message-ID: <CAOh2x==N=YM+4WE8wouM9mFd0h0L+npwww97e2HAf2HsEm5J0w@mail.gmail.com>
Subject: Re: [PATCH 3/4] base/drivers/topology: Move instructions in the error path
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 9:56 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> When the function topology_parse_cpu_capacity() fails, we set the boolean
> cap_parsing_failed to true and we free the raw_capacity. This is correct as
> the function begins with a check against cap_parsing_failed thus protecting
> the function to be re-entered.
>
> However, even it is impossible that can happen with the current code, let's

Why impossible ?

> move in the instructions:
>
>  - cap_parsing_failed = true;
>  - free_raw_capacity();
>
>  ... in the 'else' block when the error is detected, that is more semantically
>  correct.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/base/arch_topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index b19d6d4..7311641 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -155,9 +155,9 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>                         pr_err("cpu_capacity: missing %pOF raw capacity\n",
>                                 cpu_node);
>                         pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
> +                       cap_parsing_failed = true;
> +                       free_raw_capacity();
>                 }
> -               cap_parsing_failed = true;
> -               free_raw_capacity();

While it is fine to move free_raw_capacity(), it is not to move the
other line. With your
patch what will happen if the first CPU in DT doesn't have the
"capacity-dmips-mhz"
property set ? We will never set cap_parsing_failed and keep on
re-entering this routine
which wasn't required.

Note that the current implementation isn't written to always print an
error where this
property is only partially filled and the same wouldn't happen with
your patch as well.

--
viresh
