Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D327FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E2D20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E2D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJBPYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:24:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:50274 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726508AbeJBPYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:24:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01B41AD7D;
        Tue,  2 Oct 2018 08:42:27 +0000 (UTC)
Date:   Tue, 2 Oct 2018 10:42:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Wang <wonderfly@google.com>
Cc:     rostedt@goodmis.org, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com, akpm@linux-foundation.org,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mathieu.desnoyers@efficios.com, mgorman@suse.de, mhocko@kernel.org,
        pavel@ucw.cz, penguin-kernel@i-love.sakura.ne.jp,
        peterz@infradead.org, tj@kernel.org, torvalds@linux-foundation.org,
        vbabka@suse.cz, xiyou.wangcong@gmail.com,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181002084225.6z2b74qem3mywukx@pathway.suse.cz>
References: <20180927194601.207765-1-wonderfly@google.com>
 <20181001152324.72a20bea@gandalf.local.home>
 <CAJmjG29Jwn_1E5zexcm8eXTG=cTWyEr1gjSfSAS2fueB_V0tfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmjG29Jwn_1E5zexcm8eXTG=cTWyEr1gjSfSAS2fueB_V0tfg@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-10-01 13:37:30, Daniel Wang wrote:
> On Mon, Oct 1, 2018 at 12:23 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > Serial console logs leading up to the deadlock. As can be seen the stack trace
> > > was incomplete because the printing path hit a timeout.
> >
> > I'm fine with having this backported.
> 
> Thanks. I can send the cherrypicks your way. Do you recommend that I
> include the three follow-up fixes though?
> 
> c14376de3a1b printk: Wake klogd when passing console_lock owner
> fd5f7cde1b85 printk: Never set console_may_schedule in console_trylock()
> c162d5b4338d printk: Hide console waiter logic into helpers
> dbdda842fe96 printk: Add console owner and waiter logic to load
> balance console writes

This list looks complete and I am fine with backporting it to 4.14.

Well, I still wonder why it helped and why you do not see it with 4.4.
I have a feeling that the console owner switch helped only by chance.
In fact, you might be affected by a race in
printk_safe_flush_on_panic() that was fixed by the commit:

554755be08fba31c7 printk: drop in_nmi check from printk_safe_flush_on_panic()

The above one commit might be enough. Well, there was one more
NMI-related race that was fixed by:

ba552399954dde1b printk: Split the code for storing a message into the log buffer
a338f84dc196f44b printk: Create helper function to queue deferred console handling
03fc7f9c99c1e7ae printk/nmi: Prevent deadlock when accessing the main log buffer in NMI

Best Regards,
Petr
