Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F32C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3A520831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E/X0P7MT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3A520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeKCFzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:55:22 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36880 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeKCFzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:55:21 -0400
Received: by mail-yw1-f65.google.com with SMTP id v77-v6so1287994ywc.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BIjU7pzqch9dFIuENV7CmwQSRTMq/IUDa7N0FX+t/WY=;
        b=E/X0P7MTQguBI4akKlGJCkcR+MQoA0aslvkVCwZSh0wwmzuUaA6PxxT5HTzSUK/IQR
         b25Mb9lxFU4AZngDqMG0VwIXRRmUJuTVmRBrx/CbhMBqyqkUiMDf7xJ5FbJSUBgLhWcG
         RcmG3v+meWn8IDjCDeBm9zmnBXEIqsn5/qOaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BIjU7pzqch9dFIuENV7CmwQSRTMq/IUDa7N0FX+t/WY=;
        b=Ax3vLuk1wpaVDcfk0yKheLinaoD0waW8elPKOwe3iT7V/dTveGjmGONbzyjXcgE3vP
         81df+HNVO3yoXHwJ4O9mSsMDhigA+o22zkiUezLOKqj5j+s745iJ6oeJusIHwvrfSdLk
         WtBwFCwrIOAwRaJ18lZPwMwYLlSAQyRWgRD9QJmeFnlZ4OIZegvWcJEc29b2quF2abWx
         9mc1eXI9MjGGwFvK+Su4YGtT46fg20z/Qvb4wfWAs4EOgq5IxiS2agSsah5VFF8IzVqW
         Oc5d/zMm51adrFfS/ICG1Z8/94CBqDx5JnhwBAVswGAib2uNKAAzauxT1TQqsbVR74ke
         +OQQ==
X-Gm-Message-State: AGRZ1gJ07A4tI2+o0SkW8QTV5YOZw9lyOpU4DRpkBOCFl5PHu1GqK3Pq
        3ERgTbrirQJGXlShJYXVc5atC2SEGPI=
X-Google-Smtp-Source: AJdET5dO5pH4FX7q1dRAZsCMXm5Lp/eA3UjS0YuVbdejg+F+JoWzPRGizoX2glDfcZEEbdOMq80KIg==
X-Received: by 2002:a81:56c5:: with SMTP id k188-v6mr12729099ywb.328.1541191603366;
        Fri, 02 Nov 2018 13:46:43 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id r18-v6sm17953493ywa.16.2018.11.02.13.46.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:46:42 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id j9-v6so1319810ybj.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:46:41 -0700 (PDT)
X-Received: by 2002:a25:6e84:: with SMTP id j126-v6mr13482509ybc.209.1541191601469;
 Fri, 02 Nov 2018 13:46:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 13:46:40 -0700 (PDT)
In-Reply-To: <22cb7c93-1160-b181-5702-1d7bfcee5b18@rasmusvillemoes.dk>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk> <CAGXu5j+eGQ3oo_1qSwW-BEVSK=vcLmNLWH8E7fPiawobo=_fbQ@mail.gmail.com>
 <63e10688-5207-e8a4-dac2-d6c6094fbcc2@rasmusvillemoes.dk> <CAGXu5jL6RCL=WvCBJQytw=KnN74dp=1gd5wO-fO3i8tjAT=pvw@mail.gmail.com>
 <22cb7c93-1160-b181-5702-1d7bfcee5b18@rasmusvillemoes.dk>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 2 Nov 2018 13:46:40 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKas+bWbqS9juAYrQzbgGq8U08Q91dy0zdmkSZDU++rag@mail.gmail.com>
Message-ID: <CAGXu5jKas+bWbqS9juAYrQzbgGq8U08Q91dy0zdmkSZDU++rag@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] runtime format string checking
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 1:09 PM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> That's a bit too naive. At the very least, you must exclude static
> stuff, i.e. restrict to actual auto variables. Otherwise you're making
> things worse (a "static const char []" just occupies some space in
> .rodata, a "static const char * const" occupies the same space for the
> anonymous literal, plus space for a pointer). Furthermore, you must
> ensure that nobody does sizeof() on VAR. With a trivial extension of
> your script to exclude the "static const char" places, I get

Yes, thank you. That's the part I was forgetting and why I was doing
[] over * back then. There are certainly uses of sizeof() on these
strings. So, it seems better to get sizeof() right that the const-ness
right.

>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/format-security&id=b7dcfc8f48caaafcc423e5793f7ef61b9bb5c458
>>>> This one covers cases where the pointer is pointing to a const string,
>>>> so really there's no sense in injecting the "%s", but I was collecting
>>>> them to make real ones stand out.
>>>
>>> I don't agree. [...]
>>
>> Okay, then I'll forward this to akpm maybe?
>
> Yes, if all they do is replace f(..., s) by f(..., "%s", s) that should
> never hurt. Maybe check if there's a ..._puts() variant that can be used
> instead, e.g. seq_puts().

Alright, I'll see about bringing that series forward in time...

-Kees

-- 
Kees Cook
