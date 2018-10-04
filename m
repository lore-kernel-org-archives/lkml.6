Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6923DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3728C21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3728C21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeJDOle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:41:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:39398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727319AbeJDOle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:41:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8511AE0B;
        Thu,  4 Oct 2018 07:49:35 +0000 (UTC)
Date:   Thu, 4 Oct 2018 09:49:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Wang <wonderfly@google.com>, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com, akpm@linux-foundation.org,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        tj@kernel.org, torvalds@linux-foundation.org, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181004074933.5pzqnjzl4pwuutoj@pathway.suse.cz>
References: <20180927194601.207765-1-wonderfly@google.com>
 <20181001152324.72a20bea@gandalf.local.home>
 <CAJmjG29Jwn_1E5zexcm8eXTG=cTWyEr1gjSfSAS2fueB_V0tfg@mail.gmail.com>
 <20181002084225.6z2b74qem3mywukx@pathway.suse.cz>
 <CAJmjG2-RrG5XKeW1-+rN3C=F6bZ-L3=YKhCiQ_muENDTzm_Ofg@mail.gmail.com>
 <20181002212327.7aab0b79@vmware.local.home>
 <20181003091400.rgdjpjeaoinnrysx@pathway.suse.cz>
 <CAJmjG2_4JFA=qL-d2Pb9umUEcPt9h13w-g40JQMbdKsZTRSZww@mail.gmail.com>
 <20181003133704.43a58cf5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003133704.43a58cf5@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-10-03 13:37:04, Steven Rostedt wrote:
> On Wed, 3 Oct 2018 10:16:08 -0700
> Daniel Wang <wonderfly@google.com> wrote:
> 
> > On Wed, Oct 3, 2018 at 2:14 AM Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > On Tue 2018-10-02 21:23:27, Steven Rostedt wrote:  
> > > > I don't see the big deal of backporting this. The biggest complaints
> > > > about backports are from fixes that were added to late -rc releases
> > > > where the fixes didn't get much testing. This commit was added in 4.16,
> > > > and hasn't had any issues due to the design. Although a fix has been
> > > > added:
> > > >
> > > > c14376de3a1 ("printk: Wake klogd when passing console_lock owner")  
> > >
> > > As I said, I am fine with backporting the console_lock owner stuff
> > > into the stable release.
> > >
> > > I just wonder (like Sergey) what the real problem is. The console_lock
> > > owner handshake is not fully reliable. It is might be good enough
> 
> I'm not sure what you mean by 'not fully reliable'

I mean that it is not guaranteed that the very first printk() takes over
the console. It will happen only when the other printk() calls
console_trylock_spinning() while the current console owner does
the code between:

   console_lock_spinning_enable();
   console_lock_spinning_disable_and_check();


> > > Just to be sure. Daniel, could you please send a log with
> > > the console_lock owner stuff backported? There we would see
> > > who called the panic() and why it rebooted early.  
> > 
> > Sure. Here is one. It's a bit long but complete. I attached another log
> > snippet below it which is what I got when `softlockup_panic` was turned
> > off. The log was from the IRQ task that was flushing the printk buffer. I
> > will be taking a closer look at it too but in case you'll find it helpful.
> 
> Just so I understand correctly. Does the panic hit with and without the
> suggested backport patch? The only difference is that you get the full
> output with the patch and limited output without it?

Sigh, the other mail suggest that there was a real deadlock. It means
that the console owner logic might help but it would not prevent
the deadlock completely.

Best Regards,
Petr
