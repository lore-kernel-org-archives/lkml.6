Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BD7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AB720862
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cm5gGTFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AB720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbeGSPwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:52:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38249 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbeGSPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:52:08 -0400
Received: by mail-io0-f196.google.com with SMTP id v26-v6so7343423iog.5;
        Thu, 19 Jul 2018 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9XyS2+Bjfxgi4gGbi43c33wHKsoxIM0ST7EsX47Tuw=;
        b=cm5gGTFbP0qWGa010xXAjOG7WIcdtNXFTliB3RbeVdpfkaCwQPGf5oOrlhtA5OKL1n
         Za4Zxs4GzVrgvVJCTyYM+uxaN9LuROjHZ7MwRcm/RgaZ39EyrhqLqoSMnnoR9WZ4dAnn
         agoCsLjIFsyZy4xfZngAIaHd6zO4o4EoJqiRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9XyS2+Bjfxgi4gGbi43c33wHKsoxIM0ST7EsX47Tuw=;
        b=M8pBoWCtt7iQX5AKl3JZv2OYN26MJjU6o6NWBm6nB8XzEgI+85R6EG8yFT1xJOZbbr
         nJWsXpMfuOfRW/qRgGlcUh1HodTThGkZ8WmUC0zfGJhvFqHQlBiVgFHBwlK0ogt+MjF8
         Eqhh4xZGsagGV/VWKWSsgUPmMJKjaxsPAzzUl7Ks/GHXdzfhYmTCQ0BNyvINgyeuoRiT
         X24gNs09O/fM92qapWocDme/C1L3Vq0Z2Dt0ZrNHxg+IyAOfDcdLXtgAgLuuivMCY8+Y
         3NWD1rgV/8fpoHbYmwB+80BS055ntKlslU5YoYHujnPHIGtdXSYHqA1c6Ud5WxXeL1mY
         fjBQ==
X-Gm-Message-State: AOUpUlH7j7byWTD8cL2mTy4PIoiznR9r8fPw9SrN/9SUEchP9gbJLFb7
        BqDNes3Towk2VgjuIB9FPdclPvIMzray3RrsaZw=
X-Google-Smtp-Source: AAOMgpchUxS0q/FR3EYMnuS7ERDVbtREJFPkmhFa3Png8gRPxVUKp/2AuSyD5m8j2qxz9UGXAWW2eKPIDoDcMs0HOr8=
X-Received: by 2002:a6b:f612:: with SMTP id n18-v6mr1663888ioh.259.1532012911924;
 Thu, 19 Jul 2018 08:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180712172942.10094-1-hannes@cmpxchg.org> <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718120318.GC2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180718120318.GC2476@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Jul 2018 08:08:20 -0700
Message-ID: <CA+55aFw7t++BzEy-XsatNcauw3Wn22SSXfd3iTYECi4fJ97CCg@mail.gmail.com>
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, surenb@google.com,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christoph Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>, shakeelb@google.com,
        linux-mm <linux-mm@kvack.org>, cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> And as said before, we can compress the state from 12 bytes, to 6 bits
> (or 1 byte), giving another 11 bytes for 59 bytes free.
>
> Leaving us just 5 bytes short of needing a single cacheline :/

Do you actually need 64 bits for the times?

That's the big cost. And it seems ridiculous, if you actually care about size.

You already have a 64-bit start time. Everything else is some
cumulative relative time. Do those really need 64-bit and nanosecond
resolution?

Maybe a 32-bit microsecond would be ok - would you ever account more
than 35 minutes of anything without starting anew?

             Linus
