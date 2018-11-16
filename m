Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777D3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329E920811
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KY5/fwTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329E920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390271AbeKQEF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:05:26 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:36434 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbeKQEFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:05:25 -0500
Received: by mail-lf1-f46.google.com with SMTP id h192so17130705lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 09:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7PxJuNxu0qDyYVPQvn0asw+7sVZBrhzRh4wOx2MTZo=;
        b=KY5/fwTZJcFg8XrBYQiEEu4M2rk/CcqcEUzk4fVhAUMeq/AWTGpUA9+sUr7iaz2HfR
         M9eZSUhS29bXVNnQMVP7Rpd4Ti4Lu8Mu0frck3fIeBEzFjRjDj7S/re9PpJv74oSWK2R
         K+gehY3GzB+DHZdN0wm/660ZfNzp1P3PXeRq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7PxJuNxu0qDyYVPQvn0asw+7sVZBrhzRh4wOx2MTZo=;
        b=aTsSQUOPsFytAj/v/sy5cIkaI76H4TWlFa9e4ugtwtU4LyDhusKqi48iUewBL7bQ93
         Nk+RP4eGmK2Z6/e+imm0VRBJTW8dpuDDTG5GqsvMbG12clYEjAV2SA8v6e98H60MoL2L
         OtTpntS/sCj6ro8HVgamDFUI5E55HzqXfMHCJSPLdimHsKvvnHPGE68GYae4BeYqIpES
         bZyZeirTBBP/dwpWUHWKtbTsvyMlvbhhJ75EwEYSNiruuS4prpjYv3L0MsLbpSPDhe4r
         /XabLJfe1qGy8kHERzf1Ntk9NPIoDvn2fl0oQntcUOGUxhC3p8acoL1N8IjaAzRQt9Bf
         zhWg==
X-Gm-Message-State: AGRZ1gJk8YGfhbFw421RrlKaYh288G6qsORjzVbgoXJNOgfjM+BOdJqd
        OVuAdpr2pMkCvZMLuNDA9RJD0rLuUaU=
X-Google-Smtp-Source: AJdET5etcR6AoaqDphBjHlQqsQHVF4sNuHEOqk1ncnRb602XC4Q/bwKWvPlF51+X2qMQy6Ta6aAeNA==
X-Received: by 2002:a19:c7c2:: with SMTP id x185mr6426993lff.123.1542390721623;
        Fri, 16 Nov 2018 09:52:01 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id y24sm4468337lfj.17.2018.11.16.09.52.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 09:52:00 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id e26so15324659lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 09:52:00 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr5708643lff.16.1542390720099;
 Fri, 16 Nov 2018 09:52:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU6P0HdDWGMmsjyArQ746N7RBE3qMVq3aZgkfGjb153yJw@mail.gmail.com>
 <CAHk-=wi1f2tTnHe_DoMBsoj7v38G746Kk=tpouGg0_Y3fUFqKA@mail.gmail.com>
 <CAHc6FU5vaPLF8kcTAnHGHPkJQMf7GwMOX3YOg=DC=XFHrYPmdg@mail.gmail.com>
 <CAHk-=wgxioabke99QwPvMJ0YJ8of0vyAT4Rxw3zoNvgjn0Y_kg@mail.gmail.com> <CAHc6FU7oZnb+-gwiAp5KRz1y1FEF-P6rMkSEhb9jC5eJ1_+U9Q@mail.gmail.com>
In-Reply-To: <CAHc6FU7oZnb+-gwiAp5KRz1y1FEF-P6rMkSEhb9jC5eJ1_+U9Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Nov 2018 11:51:43 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgNS==_EbLtWQe5xWQ4Q1QP4UTwd4f33QVg4WLzR+y46Q@mail.gmail.com>
Message-ID: <CAHk-=wgNS==_EbLtWQe5xWQ4Q1QP4UTwd4f33QVg4WLzR+y46Q@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2: 4.20 fixes
To:     agruenba@redhat.com
Cc:     cluster-devel@redhat.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 2:44 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Ok, I've changed the merge commit as follows now:
>
>     Merge tag 'v4.20-rc1'
>
>     Pull in the gfs2 fixes that went into v4.19-rc8:
>
>       gfs2: Fix iomap buffered write support for journaled files
>       gfs2: Fix iomap buffered write support for journaled files (2)
>
>     Without these two commits, the following fix would cause conflicts.
>
> So merging v4.19-rc8 would have been sufficient. v4.20-rc1 is what I
> ended up testing, though.
>
> Are you okay with that now?

If the only reason for this was the trivial one-liner conflict, the
real fix is to just not do the merge at all, and not worry about
conflicts.

I handle simple conflicts like this in my sleep. It's actually much
better and clearer if the development trees just do their own
development, and not worry about "Oh, Linus will get a small conflict
due to other changes he has pulled".

So what I did was to actually try to generate the tree I think it
*should* have been, and just merge that with the simple conflict
resolution.

You might want to double-check it - not only because I rewrote your
pull to not have the merge at all, and in the process modified things,
but just to see what I think the right approach would have been.

Now, there *are* reasons to do back-merges, but no, "Oh, there's a
trivial conflict" is not one of them.

                  Linus
