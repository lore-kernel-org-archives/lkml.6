Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A45C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B1620867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dH8G/FPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B1620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeIDBvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:51:13 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:52075 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeIDBvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:51:13 -0400
Received: by mail-it0-f45.google.com with SMTP id e14-v6so2500779itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYanFnXJm+hkRSURtE8QmXyNMWyfrMyvK4YNHxVBaXg=;
        b=dH8G/FPuBZBxGz1oxquQZKZ7M4hnm+nKuKW/iVu/oTe5wqrkKUK2m5j7xJJsn6PJYm
         anU5fYAC0Zy9xqD0c/VASAPWpk5dtkwkzdw9A3bKoayZa8WxRWMK/5qdm5yKWMl1saNU
         K171gX5D72ZcH0B1nCFUsgAwbqTFs9dDO4Elc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYanFnXJm+hkRSURtE8QmXyNMWyfrMyvK4YNHxVBaXg=;
        b=GAiEgYrOO0OCSL0ajS/MyOkIVtVCyivgaDUEAPqYBiRtuwrBq1uFse5gImdPIElbQs
         cMmnN4aZdsy73498SGPrp9+Q9dRDHRXm6AxuOycVxdVXFJXSmUsxJU9HgBHVPQmXyuLp
         PXy3T6RMdPWmm+PcuzepuXku90C2YqB0TYcS9iAeUNSzIMIrygN3x+jHiLxyvf42lA2V
         Ly6euYcdxOMxfUAQyR0XytD4mwq4x+jkXPQZkwM3ydgnQ3xGTfOk+j5up+qawW0EMEXi
         ZAvoX62N+jmdF1WSYtHQfzCIxVOq/DXhqWa/f0o5pEKMUxwojWGmoILeF+UGMk53kKct
         2PrQ==
X-Gm-Message-State: APzg51DYSGBX//J9B1O/ln9GkKwWGbQPQSz62UJNdqNHYU5BsjW+yRK2
        esG+ZEf3LXwu56RMzBYtY5x204796+DglBOTVM4=
X-Google-Smtp-Source: ANB0VdYi5jEK+onzgSCfpizFK3fR1QJ0GjjA8k+AtZnVYxK6boGsOEbmnjNg9POxjTnGJVYeGfyfaIHwtDRPMqc/EoE=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr21069629jaa.10.1536010150184;
 Mon, 03 Sep 2018 14:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <1535875700.17858.3.camel@med.uni-goettingen.de>
 <CAGXu5jJ7kGm-DGUB8uwwhd-Hv7i4WEcSKumTf2MBsj_-yzWcqg@mail.gmail.com> <1535960372.32005.1.camel@med.uni-goettingen.de>
In-Reply-To: <1535960372.32005.1.camel@med.uni-goettingen.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Sep 2018 14:28:59 -0700
Message-ID: <CA+55aFy=T6TmG_VcLvSTb02RyKTacxVCxwUALRn8_7cdoic0pA@mail.gmail.com>
Subject: Re: VLAs and security
To:     "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 12:40 AM Uecker, Martin
<Martin.Uecker@med.uni-goettingen.de> wrote:
>
> But if the true bound is smaller, then IMHO it is really bad advise
> to tell programmers to use
>
> char buf[MAX_SIZE]
>
> instead of something like
>
> assert(N <= MAX_SIZE);
> char buf[N]

No.

First off, we don't use asserts in the kernel. Not acceptable. You
handle errors, you don't crash.

Secondly, the compiler is usually very stupid, and will generate
horrible code for VLA's.

Third, there's no guarantee that the compiler will actually even
realize that the size is limited, and guarantee that it won't screw up
the stack.

So no. VLA's are not acceptable in the kernel. Don't do them. We're
getting rid of them.

               Linus
