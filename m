Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE17CC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A191205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WaH9ILqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A191205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbeKBBBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:01:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42951 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbeKBBBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:01:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id q6-v6so14534010lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkK2xYMLGCrG5zn6705/L8jW4iYM6Jihp0vIHYmHv6c=;
        b=WaH9ILqpyaI0fahfZ4bL832OGrts5SI9iAVi38KMFQCnDut8ZdAHsa9dmw5M3KvicQ
         CbFxnJLgaJRSv1vXp9sgyVUXH74Hq65+3RAjzDgqEH1yByu+J5qo7bI/1gHd6jHR/uDA
         8T6/+IKTPCdMXcgtGe2Tvx6HTXNiqJMicdsXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkK2xYMLGCrG5zn6705/L8jW4iYM6Jihp0vIHYmHv6c=;
        b=cR3eVnSa2UdeSIfiU4ZNaFf1HL/X+eIwqbdUVAkeNc7uZCIwCTTWexBsv8LmOKjM/u
         ccDojdU5ITMxkFS5XTvEXAIaSQdE07vyssjsI591Jup6oUiFpiD8+V3dvspHDI7x6XbL
         OQSzaS/cXVtEROmP3Wjzq35X7Bl17tCh7aEcljTQvMR8kgjO7r1YpJLkEIM3b4bWfXM+
         eZtbLcePIQ6BrKK0ybvibZbS/Mg/6YmVc0Bd8fAka3iEQG8FMD4rZdp5p0EYcEerIFEL
         gxQxUbcQUKSZNs4O7x/JKKB2nxmE6ktPLGCFXOBeMItvGeWP5NGVyXZbX0ekfcX/d7Fc
         BOwQ==
X-Gm-Message-State: AGRZ1gKE424Xesv2JUbvAUXm7Yzne3rUtSjCW0SSrHucJjKb3KhELErZ
        Nnxx6/f2TtPoYqHHFrNt5n6miVMH/gwskw==
X-Google-Smtp-Source: AJdET5djnQgek0axXaqb/370N/BOS61q0byb7gmYhzKfBWqCpMsE37cEI4fq4ygb1AVLI7gJbNv/OA==
X-Received: by 2002:a19:1901:: with SMTP id 1mr4197333lfz.99.1541087859840;
        Thu, 01 Nov 2018 08:57:39 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y10-v6sm4918636lje.30.2018.11.01.08.57.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 08:57:38 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id m18-v6so14539798lfl.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:57:38 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr4641455lfa.106.1541087858030;
 Thu, 01 Nov 2018 08:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181031053355.GQ32577@ZenIV.linux.org.uk> <CAHk-=whAE6gVi18=u4sSWe1m2RWPh19YCkKQmW4Kx+NQX1mg8w@mail.gmail.com>
 <af28fc2c-d207-875e-8070-f64ead878b5a@redhat.com>
In-Reply-To: <af28fc2c-d207-875e-8070-f64ead878b5a@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 08:57:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjVRQVZL+QMnb=CyCOY8yzEZ=S1DBCE7=FiiWsQfV_5Q@mail.gmail.com>
Message-ID: <CAHk-=wjjVRQVZL+QMnb=CyCOY8yzEZ=S1DBCE7=FiiWsQfV_5Q@mail.gmail.com>
Subject: Re: [git pull] mount API series
To:     swhiteho@redhat.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, ebiederm@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 3:53 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> When I look at the discussions I'm seeing two main issues (please
> correct me if you think I'm wrong about this) which are (a) whether the
> design is correct and (b) whether there are still bugs in the current
> patch set.
>
> Which of these are you most concerned about?

I'm most worried about bugs _due_ to the new design.

Exactly because it splits up what used to be an atomic sequence, I
worry about the intermediate states having issues (the refcounting
things we've already seen, for example), but I also worry about the
fact that it completely changes the model, and that that makes things
like security hooks fundamentally different.

The latter may not be a "bug" in the sense that it's all intentional,
but it does mean that I see *one* mount-time security hook now having
been replaced by *five* security hooks.

And that's ignoring the alloc/dup/free ones.

As far as I can tell, the patch-series simply added the hooks. It made
no attempt at making sure that previous hooks had sane semantics. Do
they?  So now a system that has an old mount hook can be bypassed by
simplky using the new model instead.

I dunno. The patches are illegible in this regard (and I don't blame
the fsmount ones, I blame the security subsystem that just is full of
random indirection to random sub-security systems, which in turn just
have hash lookups for data structures set up by other operations
entirely).

Eric was pointing out bugs as late as the weekend before the merge
window opened. That, to me, does not say "ready for the merge window".

                   Linus
