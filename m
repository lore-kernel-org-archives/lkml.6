Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCA4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D17120848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D17120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeLCRSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:18:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:33684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbeLCRSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:18:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95BB6AC52;
        Mon,  3 Dec 2018 17:18:03 +0000 (UTC)
Date:   Mon, 3 Dec 2018 18:18:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     pavel@ucw.cz, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, chanho.min@lge.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181203171801.GF31738@dhcp22.suse.cz>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
 <20181203083942.GF31738@dhcp22.suse.cz>
 <20181203123149.GB31795@redhat.com>
 <20181203123857.GS31738@dhcp22.suse.cz>
 <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz>
 <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz>
 <CAHk-=wibyrfrpRoyGRwFrLZvrxAg=j5ueTje=4GckJcJSy-pwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wibyrfrpRoyGRwFrLZvrxAg=j5ueTje=4GckJcJSy-pwg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-12-18 09:06:18, Linus Torvalds wrote:
> On Mon, Dec 3, 2018 at 6:17 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > This argument just doesn't make any sense. Rare bugs are maybe even more
> > annoying because you do not expect them to happen.
> 
> Absolutely.
> 
> And valid lockdep complaints are a real issue too.

No questions about that. But in this case there is no real deadlock so
the splat is disputable. And we have a "do not use" freezable_schedule_unsafe
which shouldn't tigger the splat yet it would make the suspend issue go
away AFIU. Not a great fix and we should target for something better
long term but good enough as a poor's man stop gap fix.

> So I don't think there's any question that this should be reverted,
> the only question is whether I take the revert directly or get it from
> the PM tree.
> 
> It does sound like the de_thread() behavior needs more work. Maybe,
> for example, we need to make it clear that zapped threads are *not*
> frozen, and instead the freezer will wait for them to exit?

I was actually proposing something like that during the review
discussion. Basically set PF_NOFREEZE all the threads and wake them up.
But that is not so simple because they might be at any path when they
sleep (this is the biggest design flaw of the freezer IMHO).

-- 
Michal Hocko
SUSE Labs
