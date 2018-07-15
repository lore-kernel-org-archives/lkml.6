Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68688ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 03:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC2C208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 03:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iNxwAA1M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jg1XUpwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC2C208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbeGODU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 23:20:27 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40001 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732559AbeGODU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 23:20:27 -0400
Received: by mail-yb0-f193.google.com with SMTP id y11-v6so14232937ybm.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6kqUcT5XCPL8eyZueSZyqjrAkj3mUnXzKyOyIkOaZAA=;
        b=iNxwAA1Mt4HUpP/KCPpm09AgvS81MKPO+uEY9opKVBRk+rJI9b6prLsZj9uyS6kmh8
         YwsMrMAFRD9pebg2xOXZLoBiaTR9Fzs1Kjep6QNUNCfxlcQHHX9VwJfBRaa7hQlxlVnl
         3QqbfkpVMP45JwO6amuRDQXhdT+9S79UP5sZv/zJFphi9nCw2IkHHXlMBMUPsCU9VzZ1
         WXVr0IN9VDe+R6sXQ45Pc5bV1fXtIpzkp0uEiKxCISoC+zKHQkwJIWpmMCjr/x10UluS
         guuLaoO+cqjK0q9BQCFNSvWNkb0Kc6pTen0+iAqPDrCa1eInHpro07+mM4IP+J9dXARg
         AdhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6kqUcT5XCPL8eyZueSZyqjrAkj3mUnXzKyOyIkOaZAA=;
        b=Jg1XUpwcuqX5jobUgbltNKL51b+GcxqQH2FcVCLWFJanytmZ8VXBzP5pZOuz8i5Zad
         gha9en1fuIGZ/fwq/Cb+Z4LIQexJehoaA4zmJnxrcf5e8C+DKrm5V0WSN3TkcAeYn15n
         E+3rhmRhIj+FVvHDdbybmXdeMMniNa0G4Lfs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6kqUcT5XCPL8eyZueSZyqjrAkj3mUnXzKyOyIkOaZAA=;
        b=W4eCaRIaZ8AjYo3n7l04YmGRH/pfJZZgT9XoawYRjWQlrWOTMk+sCd99jzK3rdU/Zv
         d28hXIMEkeRgq6tWugBCAyG3ouM7+RyveRHyREFrA5oGJyerG+gs1vVinNtCOf4t9GwL
         cRf2mUPyKqo8PB4PJIqGdZHSZUPIs80fmBEl2wQRNKJobXKFWpgvwhHKFfxML/jooXVh
         tfuu65mLstiJi57uPkTAoieUskHb5kTWfXj4FPHU2Z19BPHwqkOjyq/bUWjV7/qebCK4
         CCA+9E/OEy9RZZwlFPvkgxOY0qYkfe+H8Bxr6iHtw2Xpt2L8tlIHoiazjiTo/04LLTvc
         lH1g==
X-Gm-Message-State: AOUpUlGkPMCrbdq4beVSYNllRUAWQ7KlHWDZq7VNCQ4tfgtf2+iqoaXB
        bjV5DFVhJ1sL0ikhUtU36uFMIojubN7E6C9zQSHMxw==
X-Google-Smtp-Source: AAOMgpdZKB8wFhVVc5EWu+aOjoIPooj0BIJFePWq0IuXKBR/dOuu8x/N8Ga4ozQc0h+G2Lf3VM/5u9U1EeBTj9dXoBI=
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr6556528ybj.112.1531623550259;
 Sat, 14 Jul 2018 19:59:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 19:59:09
 -0700 (PDT)
In-Reply-To: <20180715024430.n6bcnb4k7cm3ugtj@gondor.apana.org.au>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jJOZ3u1BTf8U20wErphfjKzaGK+m1sdhA89LqVP3MDYZA@mail.gmail.com>
 <20180713062204.2o7gz5xri374nii6@gondor.apana.org.au> <CAGXu5jJp3Y4RZD+ZUYsWqf+sTbGJwdN3M=KOiPBn9VecYE4OgQ@mail.gmail.com>
 <20180715024430.n6bcnb4k7cm3ugtj@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 14 Jul 2018 19:59:09 -0700
X-Google-Sender-Auth: nfvKOVo_fXUShMDNg78kbDY7D50
Message-ID: <CAGXu5jLkhC8Jb0zVXuVZnbJM6tmMpyGkaoCvw=jACLA3fnoChw@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 7:44 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Fri, Jul 13, 2018 at 08:07:10PM -0700, Kees Cook wrote:
>>
>> On a plane today I started converting all these to shash. IIUC, it
>> just looks like this (apologies for whitespace damage):
>
> Yes if it doesn't actually make use of SGs then shash would be
> the way to go.  However, for SG users ahash is the best interface.

Nearly all of them artificially build an sg explicitly to use the
ahash interface. :P

So, I'll take that as a "yes, do these conversions." :) Thanks!

-Kees

-- 
Kees Cook
Pixel Security
