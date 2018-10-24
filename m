Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83738ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A5820652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eQaVMF4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A5820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeJYGvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:51:54 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38383 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeJYGvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:51:54 -0400
Received: by mail-yw1-f65.google.com with SMTP id d126-v6so2770275ywa.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 15:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i+Xo04mgFfpYP+XfdBooTGmWNEVkmbd1vRuo5DdFMc0=;
        b=eQaVMF4xerX+nwaPrQ/PaVMywv/48M91I5i+8KLQ1I9Ze+eRK+Vld/OA7zMme3J0fn
         EwocAoeJS1Q5AhhgJ4JZPq0JaVV5ZyjosQi1qF1Ti1yTdyayKuKe3JEYOrTi+9ks2lFq
         Qp/SV80UXi65RdvcAOBTokIfkj/SgFp7yMn3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i+Xo04mgFfpYP+XfdBooTGmWNEVkmbd1vRuo5DdFMc0=;
        b=thLJ2TrQQCx541g6o5rhyrrXC0Pc/9Oh+7z86Qdl26crAjjHzg8CQ0fUsqZIEhvDwk
         ncdyE9uFa2EvqowTNu2VcRMYpouKBCi3ZHzRCL1boCuhfgW9JPyJuaA0fdFFygwAbsIX
         QNw759pwBFZdctw1rp3ZHHd0PrifGgxllv2ht4rGKvjUxlH/JBLeyFsBGXHyajjdm29i
         32t/xtLZ+TIhfJc5HUq2c4jDdbqEq/tYDkwoDEJVSK9bZEVT0tzvrutqe4EX8smJeX4D
         rvtMV6SK5b6msvgkZEeOZzTRqeswZQc6MCmOWv5wbinar9aXxt6Zf1uiM5i9TbAWthvu
         SNZA==
X-Gm-Message-State: AGRZ1gL1LmNxt0AQjqz3ynP85g4MkZXu8ii0DIk4aX7b2zCQL0peAttK
        WznMO4aOPsc8mB7E/YuOogjIrOqfpfQ=
X-Google-Smtp-Source: AJdET5c/no3eefQ31U5xMeB//l3JIY/nE5puZfO+UNtI0hOnJHqW4JeisSW5QPM+SIog17RJesmQvA==
X-Received: by 2002:a81:8c2:: with SMTP id 185-v6mr4156470ywi.70.1540419718987;
        Wed, 24 Oct 2018 15:21:58 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id u67-v6sm625482ywd.14.2018.10.24.15.21.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 15:21:57 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id d18-v6so2831928yba.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 15:21:56 -0700 (PDT)
X-Received: by 2002:a25:8409:: with SMTP id u9-v6mr2996089ybk.421.1540419716210;
 Wed, 24 Oct 2018 15:21:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 15:21:55
 -0700 (PDT)
In-Reply-To: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Oct 2018 15:21:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL+0B6tcfe-TLAeZ+SraWscqe2_R5mWTenxdSNuAhs3_g@mail.gmail.com>
Message-ID: <CAGXu5jL+0B6tcfe-TLAeZ+SraWscqe2_R5mWTenxdSNuAhs3_g@mail.gmail.com>
Subject: Re: Git pull ack emails..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 1:41 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So I've got a few options:
>
>  - just don't do it

As with other folks, this is what we're used to, but it does cause a
lot of "polling" your tree to see what's landed. (And your "Pulled"
email to pstore today scared the crap out of me briefly -- it made me
go look for this thread...)

I enjoyed getting Greg's "Pulled" emails for post-rc4, since it closes
the loop. I've always hugely preferred getting "Applied" etc emails,
and I try to make sure I always send them too.

>  - acking the pull request before it's validated and finalized.

While this can work, I would find it personally only a little useful
since it doesn't actually contain the information I (and any folks
contributing to the pulled patches) need: has it landed? When I send a
pull request for security hardening things, I'm mentally wearing my
seasoned asbestos suit until I see the PR has landed. (Other trees of
mine like pstore don't tend to trigger rants, so those are likely just
fine for this notification method.)

>  - starting the reply when doing the pull, leaving the email open in a
> separate window, going on to the next pull request, and then when
> build tests are done and I'll start the next one, finish off the old
> pending email.

This sounds like an annoying fragmentation of your workflow. I thought
Mark and Kirill's suggestion to stash the PR Message-Id in your merge
commit would be pretty easy to automate, though. (And may just be a
good bit of record-keeping anyway...)

On the balance, I think since most things you start to pull are, in
fact, pulled, the "send at start" method covers most cases and does
let people know when you've gotten to their PR. And I can spend less
time wearing my preparatory asbestos -- just from "Pulled" email until
I see it land. ;)

-- 
Kees Cook
