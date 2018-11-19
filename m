Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BA1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F403C2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V87+lMhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F403C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeKSNXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:23:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeKSNXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 08:23:42 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A967620989
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 03:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542596492;
        bh=DD6pDfG8A7Gq+tfNzebe+8Z2NwxIZKby60Cfrmj/NvE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V87+lMhX3kmhUUP+Tn0geRikhoux/PWvtNyBxa0wiYRmxTOefYnei1OvtbAUQMwWd
         aysvtfT3l0AflrQgJLoW479+2sgPVl4dZ6BlMevny/mBpCbheyz7UwIcEH79vHBuRk
         maIUAoytFXdkikm8z2heeQRw1dUED08IP14iq+7Q=
Received: by mail-wm1-f41.google.com with SMTP id 79so1720226wmo.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 19:01:31 -0800 (PST)
X-Gm-Message-State: AA+aEWZyZLD4KKT0jt3JVSKYrs8MT0KjGu6zIwLkvEmRR6wAs9/WG1sA
        JTRk8m3YOfhjMa2ZUSPjvSSFq5/EtlfXrvLWiMxaQA==
X-Google-Smtp-Source: AJdET5cqdF/er4ApqnNZwhYaiang6nw8gDQK+Z0AXWbQe9Z4BaWgWIoGeE2F3jJIxM3xKeKOc/D9ul/yl8W1C8pA+fA=
X-Received: by 2002:a1c:110b:: with SMTP id 11mr2802652wmr.83.1542596490017;
 Sun, 18 Nov 2018 19:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org> <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com> <20181119024704.GK32577@ZenIV.linux.org.uk>
In-Reply-To: <20181119024704.GK32577@ZenIV.linux.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 18 Nov 2018 19:01:18 -0800
X-Gmail-Original-Message-ID: <CALCETrU_-PK=EoJZJSV0W1y_2tju0RzkyZvwK3ZPaYf6rvpQJg@mail.gmail.com>
Message-ID: <CALCETrU_-PK=EoJZJSV0W1y_2tju0RzkyZvwK3ZPaYf6rvpQJg@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jan Engelhardt <jengelh@inai.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 6:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Nov 18, 2018 at 09:42:35AM -0800, Andy Lutomirski wrote:
>
> > Now here's the kicker: if the "running program" calls execve(), it
> > goes away.  The fd gets some sort of notification that this happened
>
> Type error, parser failed.
>
> Define "fd", please.  If it's a "file descriptor", thank you do playing,
> you've lost.  That's not going to work.  If it's "opened file" (aka
> "file description" in horrible POSIXese), who's going to get notifications
> and what kind of exclusion are you going to use?

What I meant was: a program that has one of these fds would be able to
find out that an execve() happened and the program needs to refresh
its access to the target task.  This could be as simple as POLLHUP
and, if needed, some syscall indicating exactly why we got POLLHUP
(e.g. execve vs exit).

There would be some sort of indication that a program that holds an fd
pointing at an "opened file" could get -- probably poll() would return
some status indicating that execve() happened and our capability is
gone, and, if needed
