Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B605C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F2120870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGR4Bqs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbfAKMWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:22:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35080 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfAKMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:22:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so10670210lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 04:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaSKI4nvhnbCZeyaDFHOR9LECZaCcGkEr9VUMXpihjs=;
        b=RGR4Bqs55LDe2TRrIBM0sivajev4ckMbJz60bum+N3t8J5V0OYgvMrxPdCh8XArzVZ
         GzEKM4FI3pWPLZn08nMyJmR6MSqOBNEDTnarPfdU+/mz2HlRO84XPv5p8vx26GT0qDg7
         1ymKhg0PKGjgu1CFBl7cWe5gbuo5o47Erwvos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaSKI4nvhnbCZeyaDFHOR9LECZaCcGkEr9VUMXpihjs=;
        b=R6pEvKy+4EgRk5bX0NgClXh0feGfcu9pak5//gTYiN0yeZrwmbm0U4ZJllW1nwizSl
         XMt6Jnq1p0+uH9cIFMwnONaWaVxcFQbObZ4tkDVdE8hifBTb9wu472K1mIutGNGdmoBf
         bcS4RPZdJ4XiiH480KB3hitIs1UGRH7gXQWPYhhEo36ZWIOLkrnkzG1WGy0IZcnV9/q0
         Mndv96k5URQyIV9T6YE0pccRKTWaeFUL7QYT0jpeavswkY3T3XBJzYgio8OuzbbGpb8n
         vX4fOa3TYjcVtkqFvTV1WI6XMrhG3tASO59wm2C+C4znmk2hYp543uU0kCLmMYC52iLW
         xNLg==
X-Gm-Message-State: AJcUuke0YqefzFCkILDefWfbU4wx3JhYQn5M2KvGeaF7LDxOFHg2g4IS
        ZE7k7eFE1JYtJG3qBNzGRRnPOVfYPGLIFC1qF+IJxg==
X-Google-Smtp-Source: ALg8bN49feO5dRHaTMUjkeNJP6CeQUf4AHE8OSPU96hXwEc7Ey6nRm936iiUJb8D3SK9XuI1uAlStmaswkDqCM6UZ/U=
X-Received: by 2002:a19:5154:: with SMTP id f81mr8414427lfb.96.1547209366534;
 Fri, 11 Jan 2019 04:22:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546621488.git.gustavo@embeddedor.com> <84a16ed64a29984b11c34b4f31cdef0758ffbfb2.1546621488.git.gustavo@embeddedor.com>
In-Reply-To: <84a16ed64a29984b11c34b4f31cdef0758ffbfb2.1546621488.git.gustavo@embeddedor.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 13:22:35 +0100
Message-ID: <CACRpkdaEP=nnE5SQE0OZ7Mi_VCnVn9AK9bGu2tJ5XR3+uFHfvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: integrator: impd1: fix NULL pointer dereference
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 6:18 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> There is a potential NULL pointer dereference in case devm_kzalloc()
> fails and returns NULL.
>
> Fix this by adding a NULL check on lookup.
>
> This issue was detected with the help of Coccinelle.
>
> Fixes: 684284b64aae ("ARM: integrator: add MMCI device to IM-PD1")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I already have a patch fixing this from Nicholas Mc Guire, just that I
forgot to push it upstream. I'll fix, sorry for not applying his patch
earlier.

Yours,
Linus Walleij
