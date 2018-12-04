Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF44C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DD22082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DD22082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeLDSRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:17:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:33090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbeLDSRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:17:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D600B160;
        Tue,  4 Dec 2018 18:17:18 +0000 (UTC)
Date:   Tue, 4 Dec 2018 19:17:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, pavel@ucw.cz,
        Oleg Nesterov <oleg@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, chanho.min@lge.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181204181714.GR1286@dhcp22.suse.cz>
References: <20181203123857.GS31738@dhcp22.suse.cz>
 <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz>
 <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz>
 <20181204090228.GC73770@gmail.com>
 <20181204091020.GD1286@dhcp22.suse.cz>
 <20181204093310.GE73770@gmail.com>
 <20181204095802.GF1286@dhcp22.suse.cz>
 <CAHk-=wgaEw566btStrWE+NOgPJLn1whS-Yw1-=K2Qr6MDvSZ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgaEw566btStrWE+NOgPJLn1whS-Yw1-=K2Qr6MDvSZ+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-12-18 09:31:11, Linus Torvalds wrote:
> On Tue, Dec 4, 2018 at 1:58 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > AFAIU both suspend and hibernation require the system to enter quiescent
> > state with no task potentially interfering with suspended devices. And
> > in this particular case those de-thread-ed threads will certainly not
> > interfere so silencing the lockdep sounds like a reasonable workaround.
> 
> I still think it would be better to simply not freeze killed user processes.
> 
> We already  have things like
> 
>         if (test_tsk_thread_flag(p, TIF_MEMDIE))
>                 return false;
> 
> exactly because we do not want to freeze processes that are about to
> die due to being killed. Very similar situation: we don't want to
> freeze those processes, because doing so would halt them from freeing
> the resources that may be needed for suspend or hibernate.

Yeah, we do not freeze oom victims but that is really far from trivial
to achieve. In order to do so we post-pone quiescent state until we know
all the TIF_MEMDIE threads are gone. See oom_killer_disable. In short it
is a painfull code.

> How about something like we set PF_NOFREEZE when we set PF_EXITING? At
> that point we've pretty much turned into a kernel thread, no?

Hmm, that doesn't sound like a bad idea but I am not sure it will
help because those threads we are waiting for might be block way before
they reached PF_EXITING. I would expect that threads that actually reach
that state usually die shortly. Unless I am missing something we are
talking about basically two cases here. Those threads are frozen while
de_thread waits for them because zap_other_threads cannot wake them from
the fridge or they are blocked in uninterruptible sleep somewhere in the
kernel. The later is the fundamental problem. The former could be hacked
around (check PF_FROZEN and use uninterruptible wake), I guess but I
haven't thought that through yet.
-- 
Michal Hocko
SUSE Labs
