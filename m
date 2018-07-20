Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE861ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D96204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D96204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbeGTP6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:58:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:33914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731797AbeGTP6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:58:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30DABAFDD;
        Fri, 20 Jul 2018 15:09:49 +0000 (UTC)
Date:   Fri, 20 Jul 2018 17:09:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCHv3] lib/ratelimit: Lockless ratelimiting
Message-ID: <20180720150948.nv57fjmmrmo2r7rx@pathway.suse.cz>
References: <20180703225628.25684-1-dima@arista.com>
 <1531789154.18720.3.camel@arista.com>
 <CAHp75VdmQ1YLzWpYb7878zKOCCyOEicdLAtpohbmY2hL1h1RNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdmQ1YLzWpYb7878zKOCCyOEicdLAtpohbmY2hL1h1RNg@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-07-18 19:49:10, Andy Shevchenko wrote:
> On Tue, Jul 17, 2018 at 3:59 AM, Dmitry Safonov <dima@arista.com> wrote:
> > I would be glad if someone helps/bothers to review the change :C
> >
> 
> Perhaps Petr and / or Steven can help you.


> > Thanks,
> > Dmitry
> >
> > On Tue, 2018-07-03 at 23:56 +0100, Dmitry Safonov wrote:
> >> Currently ratelimit_state is protected with spin_lock. If the .lock
> >> is
> >> taken at the moment of ___ratelimit() call, the message is suppressed
> >> to
> >> make ratelimiting robust.
> >>
> >> That results in the following issue issue:
> >>       CPU0                          CPU1
> >> ------------------           ------------------
> >> printk_ratelimit()           printk_ratelimit()
> >>         |                             |
> >>   try_spin_lock()              try_spin_lock()
> >>         |                             |
> >> time_is_before_jiffies()          return 0; // suppress
> >>
> >> So, concurrent call of ___ratelimit() results in silently suppressing
> >> one of the messages, regardless if the limit is reached or not.
> >> And rc->missed is not increased in such case so the issue is covered
> >> from user.
> >>
> >> Convert ratelimiting to use atomic counters and drop spin_lock.
> >>
> >> Note: That might be unexpected, but with the first interval of
> >> messages
> >> storm one can print up to burst*2 messages. So, it doesn't guarantee
> >> that in *any* interval amount of messages is lesser than burst.
> >> But, that differs lightly from previous behavior where one can start
> >> burst=5 interval and print 4 messages on the last milliseconds of
> >> interval + new 5 messages from new interval (totally 9 messages in
> >> lesser than interval value):
> >>
> >>    msg0              msg1-msg4 msg0-msg4
> >>     |                     |       |
> >>     |                     |       |
> >>  |--o---------------------o-|-----o--------------------|--> (t)
> >>                           <------->
> >>                        Lesser than burst
> >>

I am a bit confused. Does this patch fix two problems?

   + Lost rc->missed update when try_spin_lock() fails
   + printing up to burst*2 messages in a give interval

It would make the review much easier if you split it into more
patches and fix the problems separately.

Otherwise, it looks promissing...

Best Regards,
Petr

PS: I have vacation the following two weeks. Anyway, please, CC me
if you send any new version.

Best Regards,
Petr
