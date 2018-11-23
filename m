Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4394206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROfZ1Lzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4394206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504256AbeKWXFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:05:43 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54227 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394543AbeKWXFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:05:43 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so18143023ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Wem4PShXx7/eGAD2VT5tYYDmIQsmzlMb8bJeFeHtTU=;
        b=ROfZ1LzjgY7Xhh6uga/Pe/xreeNNhVlcev1I7/Jpv5jUoLuvYJ4LXsUKElfe2UwQEJ
         fkZ99cWagMCg+BTKHCdVYS4racDosf0ZnbpzinfcOkgOjctmUQ8gGidJtXI7zIG9JttX
         Mf3rvE8PE4YrgkySLGiCVXD5bhZP7t7FymPxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Wem4PShXx7/eGAD2VT5tYYDmIQsmzlMb8bJeFeHtTU=;
        b=oJ6TO0uYWaX4hi9I44ow/WEhLLSnqKfzqHs5a2YsKFoVM94ZzeuPWvc2heOVG7Ckh6
         rN3OjRlh+nrsTIT9DoHzdq+qQ6qcXOxwgvkeIf5DYS0x+eUfVMpH44pDffeENCDU22Gd
         fyV1+pJjYGn584uKxTNzcQJkb5iZrdpKdVmngIKfRPyk3BChXSUuKN5Up7U2x5btRyPV
         u6FR9vT4K5omVFQDes+vDLTnqqRTJcDnoSciAX/o6B6pqTI+lyeDpU0ekzmRViDT+AXg
         a+VehqahF7VY8GBEsKHCK5nlgm29jRaYiY9xrmwIEnkxYNd6G/j6CAljtJrzi/arx8sS
         d4cA==
X-Gm-Message-State: AGRZ1gLojyNO8XpM0sFbToEnvR9O4tFk9HIfkMb1/AwqCkoh+qHqNqqD
        Cs9QqIZMfYA8tWT+SolBsvGt9Sl3xoDSZ0motI/jFg==
X-Google-Smtp-Source: AFSGD/Wysgde+wPGurXTA92GN0ZMz+C55XT56+nABgzYzVLWAZbRPlsw0LXgF05qe8X8Z4JaaDng4Qf3CGXW67u0Z/E=
X-Received: by 2002:a05:660c:206:: with SMTP id y6mr12688816itj.157.1542975703208;
 Fri, 23 Nov 2018 04:21:43 -0800 (PST)
MIME-Version: 1.0
References: <58a96c0933bf4c812fa2dd382e6cb377@natalenko.name> <CD517154-3155-4D89-AAA5-11DA0DE7B9EF@canonical.com>
In-Reply-To: <CD517154-3155-4D89-AAA5-11DA0DE7B9EF@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 23 Nov 2018 13:21:06 +0100
Message-ID: <CAPDyKFpHzERzE4T-AExwHAbhzrbxuSLy5cg0et24wzfbOZNw3Q@mail.gmail.com>
Subject: Re: [PATCH 0/5 v7] Keep rtsx_usb suspended when there's no card
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 at 07:06, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> Hi Ulf,
>
> > On Nov 8, 2018, at 8:17 PM, Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
> >
> >> This is based on Ulf's work [1] [2].
> >> This patch series can keep rtsx_usb suspended, to save ~0.5W on Intel
> >> platforms and ~1.5W on AMD platforms.
> >> [1] https://patchwork.kernel.org/patch/10440583/
> >> [2] https://patchwork.kernel.org/patch/10445725/
> >
> > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>
> Do you think this series is ready to be merged to v4.20?

I have had a brief look at the latest version a while ago, looked
good. However, allow a few more days before I can give it my final
blessing.

BTW. We need to figure out what path to route the changes through. I
can pick it via my mmc tree, unless someone object to that.

Kind regards
Uffe
