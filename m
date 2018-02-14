Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966926AbeBNJip (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:38:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966693AbeBNJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:38:43 -0500
Date: Wed, 14 Feb 2018 10:38:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Dave Hansen <dave@sr71.net>,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] watchdog: hpwdt: Remove spinlock acquire and BIOS calls
 from NMI context
Message-ID: <20180214093835.GW25181@hirez.programming.kicks-ass.net>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
 <20180212165835.GO25181@hirez.programming.kicks-ass.net>
 <20180213075540.3lkikkpgjoe6ocjk@gmail.com>
 <5c3ba123-abbe-f153-7b75-a89d31d25c72@linux.intel.com>
 <20180214093159.mdzfupne547bi5qx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214093159.mdzfupne547bi5qx@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:31:59AM +0100, Ingo Molnar wrote:
> Because in this particular case it does not appear to be so: the reason for the 
> BIOS/firmware call appears to be to determine how we nmi_panic() after receiving 
> an NMI that no other NMI handler handled: with a passive-aggressive "I don't know" 
> panic message or with a slightly more informative panic message.

However much I like just ripping all that out, I think the ROM call
actually does that logging, or that is how I read things.

If you look at the original Changelog for that driver:

    Hp is providing a Hardware WatchDog Timer driver that will only work with the
    specific HW Timer located in the HP ProLiant iLO 2 ASIC. The iLO 2 HW Timer
    will generate a Non-maskable Interrupt (NMI) 9 seconds before physically
    resetting the server, by removing power, so that the event can be logged to
    the HP Integrated Management Log (IML), a Non-Volatile Random Access Memory
    (NVRAM). The logging of the event is performed using the HP ProLiant ROM via
    an Industry Standard access known as a BIOS Service Directory Entry.
