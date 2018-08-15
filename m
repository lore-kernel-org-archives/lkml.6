Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9605C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43D72147A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e0egPQ/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43D72147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbeHOTeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:34:44 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39255 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbeHOTen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:34:43 -0400
Received: by mail-it0-f68.google.com with SMTP id g141-v6so2749300ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6KISIxZ2EemZ82ShxS2pOE/UKqoR6QqIfFbZ8UaqU8=;
        b=e0egPQ/hVFwxTKE2FCh7WqAbsDma5Ga7vdDrYTLpy7QeQwntcFmEvnT9z7wD9PZakL
         nxSbHXs4g1PB+lX4+hikdlEHIU8rB2dcOigyCrlBFhZUjfCZV0H7MM5dhIMFfTw0Uaob
         CC0EE4c8yueKPVESvKW8IOeo2kh8NJlbRXbMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6KISIxZ2EemZ82ShxS2pOE/UKqoR6QqIfFbZ8UaqU8=;
        b=ZZsPaORsMAq6gWYLl99LHICcMpKXxB1HLkb+G8pGtnwx+Nk++78mU04EzptDlumW3i
         3439koEvFxm+J53SvV7gZmQbJnB60IXK0qrw2eLOrKkwCw8Q4SFyQmBkxSNUnzZ9yL8C
         /SPXHY2p7ePigPshjFXXI8XG3Lk6MV1zj8ZwV10PVfChxzGJyv1xP1D1zIxXF0Bmp00X
         HIvwe2dBfW4Nk1yLjL6HrUhzUXwGV/PUYjSKHmhMUSIYhch2XDJ9VXBXIB6CgQss+7c8
         Q/nkMdUxxUVPVh+Vp6dol+fQIOFbpVLRW1/94HznY5Qku+D+7OqzqStGtPoiFrmAhBwx
         W7Bg==
X-Gm-Message-State: AOUpUlG+AuKyJJpIedkIa6JFV1qYKVJ3OhDZ3Q+5D2ArV8CPXWONte3j
        8EeoDR7R0A4sHhIcKFjSi04LS6ilypE+2l9S2vRPCw==
X-Google-Smtp-Source: AA+uWPx1XFBkuLd0CKqTwD5qgkQxR7Yhob0nSI+GxGQbJgCqpZyPZLJ2wGvCnq6tULsPvShQgXd9mLUo058jhW7bAcI=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr18296255itm.113.1534351310525;
 Wed, 15 Aug 2018 09:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180813214328.GA15137@beast>
In-Reply-To: <20180813214328.GA15137@beast>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 09:41:39 -0700
Message-ID: <CA+55aFw5Tkn6DgkAZS-UGOjJpYp2R4rFAm9ixu_=FONeqRyofg@mail.gmail.com>
Subject: Re: [GIT PULL] gcc-plugin updates for v4.19-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 2:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull these gcc-plugin changes for v4.19-rc1.

No.

It adds yet another BUG_ON() without having been merged.

I'm not pulling this. Dammit, have you learnt *nothing*?

I'm, disappointed in the whole feature, but I'm also tired of having
to go and even look for these things.

Then actually *finding* them makes me just pissed off.

               Linus
