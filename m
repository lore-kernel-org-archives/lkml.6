Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2CEC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 19:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3162175E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 19:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L5rWF88C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3162175E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeHRWu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 18:50:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37939 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbeHRWu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 18:50:59 -0400
Received: by mail-it0-f67.google.com with SMTP id v71-v6so15881003itb.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Ux9/hfoOKU/F/cGWjCj8V9Bs4MG4AQRYHbKiKyzrMc=;
        b=L5rWF88CVm3oq9f7hHqVlrAL5dfiwCV014EYRf2ZTyDYCDJkLdVHyRTmhYUpqrpNXG
         XhRs1dO/C+OKvddkcJCn4LrMG9uiFE7YqTs5Fsb5E5ZSHfPZJ9ICGmjClKY53YX1viwv
         +z26PPTj7Ky+9nusmtCSqOJg0dEcqmSSrF9yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Ux9/hfoOKU/F/cGWjCj8V9Bs4MG4AQRYHbKiKyzrMc=;
        b=Y/PMkLBflzgaW4k5HobF2MS+VJe/KTU3rng1CcQY3J2gwxtw9KIyqZwhhNx17l5PZM
         SxgM7uQfcTGvCYQiiVURMNpKNElB2MTx/v1lHFVyAAabRleL69hcRnRm83Y30ISSCCOZ
         /I16NrafqWJEJvk0fHLxe9BuE4K2wySB5ED8xKw5KXt2Wtf5yCDS2/F2pm3edvw2vNL+
         R3CgfzzylO6+0DxoK0HkvRPhXPD2nTIx/gPHF34yL8NHOpfyxhX6VbClNxz1pFFMEsZo
         n5btAOOYtRYxmLXjAqQ3Qsp+lsdZXxm5cLLEj3mxL2+Bd+7O+pCNhZyWO/xy/+yWGmBa
         jRdQ==
X-Gm-Message-State: AOUpUlE68peuteVFGWiQ0d0mwFhsom8AiMW9SGO/yzaROs+qSFh345Lg
        rZyxiffSNT6Bx3TNUvH4NWIWn5FkletxHyMdS9O9leGe
X-Google-Smtp-Source: AA+uWPwpXzE7O+zCzqptzMoOq5ZSxcOQj1KIwVovMupcKXL8DIPdZSYFmIJgXM2u1wzwDahgy8857oD+j7yWD0oOwGo=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr36196966jaf.70.1534621330406;
 Sat, 18 Aug 2018 12:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180818024506.GA26409@ziepe.ca>
In-Reply-To: <20180818024506.GA26409@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Aug 2018 12:41:59 -0700
Message-ID: <CA+55aFzCLHBs6pEYOaMa1QsKvySX+Uak+by+ZThs22t=DpS4tw@mail.gmail.com>
Subject: Re: [PATCH] Revert "Permit silencing of __deprecated warnings."
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 7:45 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> Linus would prefer that __deprecated never produce a warning in an
> allyesconfig compile. Since we have been at this state for some time,
> the option no longer has a purpose.

I got rid of the option, but of the code too, and - trying to set a
good example - looked around for actual users and got rid of one
long-deprecated function that hasn't had an in-kernel user in four
years.

If there are some out-of-kernel modules still using
pcmcia_request_exclusive_irq(), I can only say "Oh wow, you haven't
fixed your broken out-of-tree module in the 8 years it has been
deprecated, see how much I care about your complaints now".

Maybe somebody will be willing to look at other cases of __deprecated,
but at least I won't be seeing warnings about it any more.

               Linus
