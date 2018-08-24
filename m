Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03674C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B6621477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3H0TgrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B6621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeHXWBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:01:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40856 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbeHXWBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:01:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id 207-v6so2486591wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=33LtWkpTWxHMxdScma5Qhv2DxchwM+QTJvratPDp5Jk=;
        b=I3H0TgrMOzl2xXB3/6XU4zfN6IfSsXbAXLs8bzOxpzMk4+t+vzrIXtcv/c0nQ59Nds
         reG+MDqGs+ZlhPV5e5bmjvR45txV4NiXV9v+cp3sRX08wlc24y7PJbY+m3rBPA2xX7Kr
         f6OoI3KAp2J6HqZVV2xWlr6FxGeyvhzUSjTqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=33LtWkpTWxHMxdScma5Qhv2DxchwM+QTJvratPDp5Jk=;
        b=h//S0HjeSG5aE00FDqTN13c55281oyJ3dGlGcTqAK1n320ng4Wapjruw/Cw70rI5dx
         xCrBuOA0yMGp9kl7LEPD93PRQOn5bXCJFVuJuNCRBiW5+LnG2EC//sQnbDm/SrRoFzi+
         vU1IxHONNAe2AYZS9JLzhZ+GqvEVQIvyWqaX2pJkv3cO4GAbU7wPszUjjR+cgFptTSUf
         tDepc46rI56kdY36yNPMWhWx4iFeKFqY8FZGVE1yKs98Ug0kcmKQaaaw6y6lMArbrwha
         +8RoaVGWD63j25T1AUOoY41ebGsacOb6/Wta2FQqL8LLMU9FkOEvVTApJA7kJVd4NxG0
         vaeA==
X-Gm-Message-State: APzg51D2lijzif9Xoek8j9KMYPFNbvyjWeq36FVokKO7sRTpcz+yYnep
        y19+O+ASdk1fSeI3eCIymlLm8wbSQYrDB8AzGPWguQ==
X-Google-Smtp-Source: ANB0VdYUPW6gc/X6z1JTLjZmqiAte7Wneu4xAvlivv9jhamRbHRyO9pIbuKbsChEVl6WWvd9XEMPq1DzqYLmiOZPSd8=
X-Received: by 2002:a1c:98cc:: with SMTP id a195-v6mr2109029wme.64.1535135130316;
 Fri, 24 Aug 2018 11:25:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 11:25:29
 -0700 (PDT)
In-Reply-To: <CALCETrXY=PSdp6mpQ89yBQPsMrDj7j2p8AyLR1o4_+heiMzRbQ@mail.gmail.com>
References: <20180817121251.4EB5318E01A1@virtux64.softrans.com.au> <CALCETrXY=PSdp6mpQ89yBQPsMrDj7j2p8AyLR1o4_+heiMzRbQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 24 Aug 2018 11:25:29 -0700
Message-ID: <CALAqxLXk3shySjd7__Rxvegw-dUDETmAmVOPR6Oto0j3mpZv5w@mail.gmail.com>
Subject: Re: [RESEND PATCH] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 10:47 AM, Andy Lutomirski <luto@kernel.org> wrote:
> Minor nit: if it's not literally a resend, don't call it "RESEND" in
> $SUBJECT.  Call it v2, please.
>
> Also, I added LKML and relevant maintainers to cc.  John and Stephen:
> this is a purely x86 patch, but it digs into the core timekeeping
> structures a bit.

From a quick review, looks reasonable, so no objections from me.

thanks
-john
