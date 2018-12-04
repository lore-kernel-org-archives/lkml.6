Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C697CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845E12133F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jk9+HgqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845E12133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeLDRbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:31:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45189 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLDRbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:31:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so12560288lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39m9E0VeBL6XcL0p1zS7vY7NjLylANqyT9o0sAkukiY=;
        b=Jk9+HgqVS9t7+ScB8IpvRt//+TvvlvvTHXJJ8/5WNW6UN8G37nSK/NQFh4itqeh1xR
         VPBLVpYiabijjJWFfBDkSH/cOhCPg1Pwi2rC5r6yKvsSnkxMwIusmmLwKvlBdOLkMdxp
         pmwYG2XUvcXl0h9iRYlsiXUlZj8easYtJcfZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39m9E0VeBL6XcL0p1zS7vY7NjLylANqyT9o0sAkukiY=;
        b=mWuOQez8zTRzSgh9K6vu2xDLSQVwW4hcXl44eZzoyZyplAut8CGljQyia2ilPRaiVT
         FN9WZlBUN17ZNQ93TXEycooHsOqbaRBsA1N2bJ6ld7FxJA9Pz9C9P+ESKuTb/zoQXqVE
         x7mHbrgvxbfU1DC0dudznLzCbfsEAxLa5d0xXhwtZ4Wy8LEaPLAlvQh5w+UCxspwKsf/
         lcGHFqvxwJhgIKJaPPBtV/YHVWj89l1Sjf+KNVYl5e+EosuxEGx9l5qLQmumuhYTs5AT
         qvwGDtHyhKdczY8eiKKwAAp420R0m9hFYyUdn+sNqBP79rnHJ6nITFn4HOgFmvECqbWw
         arlg==
X-Gm-Message-State: AA+aEWaqA7gD4dF/CubxX2fXh++gjy51zZeqaqFREwzX4Ge9rXvyiUhe
        ytI8wHZ8LyROERJlQNAZ8/gYOwhYsdE=
X-Google-Smtp-Source: AFSGD/XRk2vQOvGn0SX/8WAMGYWj7vdSlmDbihZ9JoDUdrivsvw2VaJmTQy9mOdw0YleFKxp+eKk0w==
X-Received: by 2002:a19:9904:: with SMTP id b4mr11848698lfe.95.1543944689846;
        Tue, 04 Dec 2018 09:31:29 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m13-v6sm3362690ljg.56.2018.12.04.09.31.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:31:28 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id v15-v6so15659359ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:31:28 -0800 (PST)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr14770641ljj.6.1543944688104;
 Tue, 04 Dec 2018 09:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20181203083942.GF31738@dhcp22.suse.cz> <20181203123149.GB31795@redhat.com>
 <20181203123857.GS31738@dhcp22.suse.cz> <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz> <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz> <20181204090228.GC73770@gmail.com>
 <20181204091020.GD1286@dhcp22.suse.cz> <20181204093310.GE73770@gmail.com> <20181204095802.GF1286@dhcp22.suse.cz>
In-Reply-To: <20181204095802.GF1286@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Dec 2018 09:31:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgaEw566btStrWE+NOgPJLn1whS-Yw1-=K2Qr6MDvSZ+A@mail.gmail.com>
Message-ID: <CAHk-=wgaEw566btStrWE+NOgPJLn1whS-Yw1-=K2Qr6MDvSZ+A@mail.gmail.com>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux 4.20-rc4)
To:     mhocko@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>, pavel@ucw.cz,
        Oleg Nesterov <oleg@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, chanho.min@lge.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 1:58 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> AFAIU both suspend and hibernation require the system to enter quiescent
> state with no task potentially interfering with suspended devices. And
> in this particular case those de-thread-ed threads will certainly not
> interfere so silencing the lockdep sounds like a reasonable workaround.

I still think it would be better to simply not freeze killed user processes.

We already  have things like

        if (test_tsk_thread_flag(p, TIF_MEMDIE))
                return false;

exactly because we do not want to freeze processes that are about to
die due to being killed. Very similar situation: we don't want to
freeze those processes, because doing so would halt them from freeing
the resources that may be needed for suspend or hibernate.

How about something like we set PF_NOFREEZE when we set PF_EXITING? At
that point we've pretty much turned into a kernel thread, no?

                Linus
