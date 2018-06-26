Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AB0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF3926637
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fL5+NkLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF3926637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeFZHrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:47:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35111 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeFZHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:47:18 -0400
Received: by mail-it0-f66.google.com with SMTP id l16-v6so193784ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rq9QsMchOENMwOUTX8BDExSZJXli0LTuQMG04Dr7daE=;
        b=fL5+NkLZKYPeYWMeWZjDRMubpZJngH6VOqLVdE3Ag7KyBuQLDTfo+ySxYMno9tMzw3
         aEPX8bKQhEKUggFynxdazanK/V8ruiUo56bySQ0qrvIJmweKOFdiazCEYFjxI6s152gH
         LllZqkxvfKM+46bpyV/jRNKxOZMHAO5Mb3rkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rq9QsMchOENMwOUTX8BDExSZJXli0LTuQMG04Dr7daE=;
        b=cAC0PiTypfTyfRixnsAxCAlzNN7+aysXAH2R/qdQUBUbFtHLK16tqwziu0eNJFo81w
         FPrxpRuuHm1gPPpeNWwYoQurEwNiaD31Hu0K/Eq24/Xmw5n2/Yd+If2SyEXoQ13xbuYl
         ML3PYMxUbJZnFMCUpKQuf1FiW6ibfMIasLqp0ImaC39OTa4vMaL/zO3+Z7TLJFdmtb/8
         +jfl9Z2f3IggOu4fXUznPjBdbivnEOX7/rsBXd6vB/XD+SMvuXjVz/pquTwJb+SQNg7k
         2gEBpz7C+w0zCDJ7p6j64FjUwWwxBRbSTobd5RDjV0Go56/GDqpEl9J37OBXLGOfAvG5
         bxVQ==
X-Gm-Message-State: APt69E25RSoDPk1cWwO81iXpX7rHiNww9Bhh+3XzSyz1krWWrjXHV+vc
        6u7vHI3EWTs9S7HmuSSGJ7gKorRX3cwGAMtXrOEkcWCk
X-Google-Smtp-Source: AAOMgpcJw8Yi74OMTAt6fSaowjrTeT6LA/IxXpl9Kb0yUlMOtNHMHCFd+GJbJnT4tWAFAS4IAEHBYOKaRxtANeusqVc=
X-Received: by 2002:a24:5746:: with SMTP id u67-v6mr568260ita.38.1529999238381;
 Tue, 26 Jun 2018 00:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180621185442.17086-1-geert@linux-m68k.org>
In-Reply-To: <20180621185442.17086-1-geert@linux-m68k.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jun 2018 09:47:06 +0200
Message-ID: <CACRpkdb_9NJ-_yMUJY9yaUZN6ZHYq2OBsw54AccQSKYB5+efZw@mail.gmail.com>
Subject: Re: [PATCH] w1: Allow compile test of GPIO consumers if !GPIOLIB
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 8:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
> not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
> functionality only, can still be compiled if GPIOLIB is not enabled.
>
> Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
> appropriate.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
> ---
> v3:

Patch applied to the GPIO tree.

Yours,
Linus Walleij
