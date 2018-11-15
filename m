Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA49C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791B02086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BKCdxCMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791B02086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbeKPDTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:19:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43983 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbeKPDTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:19:39 -0500
Received: by mail-lj1-f194.google.com with SMTP id g26-v6so17868681lja.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbiOAftS7FAMpHHC1DdtU81lKY1uvOpqPmRMOSme1A0=;
        b=BKCdxCMcYgOqxHGY1m6XZO0JjFd8KK/lCIlEQczAp+NJbJmg+7cE8QbuWVSGZtcVNR
         /fNU6F9SVW60xnTTPy/leV7F4QTc7DSIvEaJy3QQ+K71j8Zu+2RXh97UIHw6K9IiDGjW
         BpSEe7FywaIj+Iyn9EZJXOmuTfvvREUrO+juo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbiOAftS7FAMpHHC1DdtU81lKY1uvOpqPmRMOSme1A0=;
        b=tXTdubvhs2OQjQn7oHRg3/7EjPfdchnwhkvBiXbeZHZYcyjhzJgIBCUuRkLzbAzefn
         nFe7axQPdlGTnpZ1prTZaFa4dhjbl2HpFSV9jVG0QVVrD/Z2+L6wmKJR3NmEzfINkR1F
         vB1lLMJA6WR4x2JLDVKXdUUi5N+Ryt7bc/I0siakLRtq71ApsvfM9H9FsID3dGEM/W/C
         NawncvmcUGeNx+rIzJqpmyTpxUPPY/Ft9jeuxGlZmnkjiO+i9t7GmlNlGLPnbewFQMFX
         7CQgku+f6Ln3IdJwLFMWohbVXj38iT9MOy8HcUa5Td443zwwo3NlG9um+tlh6CmPN5Sp
         6Rsg==
X-Gm-Message-State: AGRZ1gKrttmegl3sQda0inUP26xajz2mtBGFo/4zwu5brewJghfAVaX7
        Zm9/Uar1w3Mv2iQodrIYsUx8ujIxZfU=
X-Google-Smtp-Source: AJdET5fZ1XwW13lX0m+msMVkriFtqLXGqvEfCgcIrfto0Dl3V0mGzW7s8VCkgXSFE4/m896xbcYMhA==
X-Received: by 2002:a2e:9059:: with SMTP id n25-v6mr4064889ljg.155.1542301858855;
        Thu, 15 Nov 2018 09:10:58 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id o88sm4430133lfk.38.2018.11.15.09.10.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 09:10:58 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id p86so14673897lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:10:57 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr4209484lfc.124.1542301857304;
 Thu, 15 Nov 2018 09:10:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU6P0HdDWGMmsjyArQ746N7RBE3qMVq3aZgkfGjb153yJw@mail.gmail.com>
In-Reply-To: <CAHc6FU6P0HdDWGMmsjyArQ746N7RBE3qMVq3aZgkfGjb153yJw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Nov 2018 11:07:09 -0600
X-Gmail-Original-Message-ID: <CAHk-=wi1f2tTnHe_DoMBsoj7v38G746Kk=tpouGg0_Y3fUFqKA@mail.gmail.com>
Message-ID: <CAHk-=wi1f2tTnHe_DoMBsoj7v38G746Kk=tpouGg0_Y3fUFqKA@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2: 4.20 fixes
To:     agruenba@redhat.com
Cc:     cluster-devel@redhat.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 6:00 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> could you please pull the following gfs2 fixes for 4.20?

No.

I'm not pulling this useless commit message:

  "Merge tag 'v4.20-rc1'"

with absolutely _zero_ explanation for why that merge was done.

Guys, stop doing this. Because I will stop pulling them.

If you can't be bothered to explain exactly why you're doing a merge,
I can't be bothered to pull the result.

Commit messages are important. They explain why something was done.
Merge commits are to some degree *more* important, because they do odd
things and the reason is not obvious from the code ("Oh, it's a
oneliner obvious fix").

So merge commits without  a reason for them are simply not acceptable.

                Linus
