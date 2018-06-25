Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D562DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831E526204
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bPOPsFDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831E526204
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754519AbeFYWjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:39:24 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37892 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbeFYWjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:39:23 -0400
Received: by mail-io0-f193.google.com with SMTP id l19-v6so14089445ioj.5;
        Mon, 25 Jun 2018 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjV6sY0KGLTLGi3s9ylDR0HjcGLJ9Oqm/mPQb/B1Oe4=;
        b=bPOPsFDhOha0PB7uRavY69UP2p9yyUlJto72IyMnpNDM7bODCgiN6umKR8we2UM1oe
         TzJqxSxU+aVO1nSREozjN4XdeLWViYawTIKrxKBaFXWeEugSSufB35s8r4IiW3s8bO6h
         Tm+htGsNIJ/CxFkbNwg0DLErCA71AMmS6CKww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjV6sY0KGLTLGi3s9ylDR0HjcGLJ9Oqm/mPQb/B1Oe4=;
        b=LN2eZx3qCWfcspuqzRQxNYurkA4PUTnqwRWRwweXzUUoBpCPl3OMexEgt8TCACSMHK
         2D7iHKAc6H41+z9k5biAoaWAuY8kcOzEiWfNpEhq9Zwv0xAccmX8oCZd6K7rhKeftfOu
         W3hHwu2apMZG0pRFhOYL0vcv4FBJdZc5U6SrdkESGz7unS/+SLqcUSa7gmOtnaXonU3t
         jNlPbaThiVr7NI5Rb193+T6CW4dUamzNAU/CFalYOz0d1t3cJuFMnDe4t5B4yENbgnHi
         q6YQeGgQZWUznzMP0aBReGnejtw40lMddDReBaTYnQQCTL3KHC57jtZI/rP5x7XyzzqA
         XU6A==
X-Gm-Message-State: APt69E0RrmPWDgiZY7ABQoPiUzTqiDj14eD14Ocf/AVs7ymhhJGzAq5x
        u9OJ820e3cDfc5Mf++57IX7xptpq6JGDMlSGXO8=
X-Google-Smtp-Source: AAOMgpee0//zdxzDxngpn+M6Gg8X+jWl3oPLt24l7TlRhmGiJ4OP0AqdY/ttGR0gcJ7t6sUDlvg0C9uskRp0J5S4AoE=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr12334603iog.238.1529966362448;
 Mon, 25 Jun 2018 15:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <87muvr58ak.fsf@xmission.com> <CA+55aFxTtemhGJweOKfATojapGzD-riaowDUSh65OA2pCB+w6Q@mail.gmail.com>
 <87d0wetyh2.fsf@xmission.com>
In-Reply-To: <87d0wetyh2.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Jun 2018 06:39:11 +0800
Message-ID: <CA+55aFz9RSQuk6eN5p_1J=-iKUi3=qvaOi_Dqip=VsqzucJb4Q@mail.gmail.com>
Subject: Re: [GIT PULL] userns fixes for 4.17-rc2
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        astrachan@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 4:15 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I don't understand the feedback about only accepting something like this
> during the merge window.  The entire point of my change was to remove
> subtlety.  The code was very straight forward to test.

But it *doesn't* remove subtlety - it's just subtle in a different
way. Now it's subtle in the odd pid counting instead, and how  it
generates temporary kernel mounts all the time.

And the problem with the old code apparently went unnoticed for years,
and only hits some very odd cases. So there's real risk from the
hange.

> This is a silent regression of a security feature so it is possible some
> people have upgraded their kernel and not noticed the regression but are
> affected by the information leak not honoring hidepid introduces.  That
> seems to me to be a candidate for stable and thus an rc kernel.

Definitely not in the form you posted it. It's simply not obvious enough.

> Would you prefer a patch that does less towards fixing the root cause
> for now and to be backported to stable?

It's not about whether this is "root cause" or not. It's simply about
the changes being subtle and unclear, and the commits mixing things up
and not being legible enough that anybody can just go "yeah, that's
safe and obviously a fix".

The odd pid counting optimization wasn't even *explained* for
chrissake.  Never mind that the sysctl access code was mixed in with
the other changes.

So the way to get this merged is to make each step obvious and
independent. At that point I may go "yeah, this fixes a real issue and
doesn't introduce new ones".

As it is, it's not at all obvious that it doesn't introduce new issues.

                Linus
