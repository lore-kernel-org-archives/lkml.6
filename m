Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbeA3GaI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 01:30:08 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35941 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752501AbeA3GaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 01:30:06 -0500
X-Google-Smtp-Source: AH8x226KGgNgi3GKwYO4ASEF/shygjWGZIQ71yJxwyKub/lswo2TxW4XXzl6Q4fpvCa0CNihPnuDUA==
Date: Tue, 30 Jan 2018 07:30:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [GIT pull] Timer core updates for 4.16
Message-ID: <20180130063002.gxmruvxcqsfp5hv4@gmail.com>
References: <alpine.DEB.2.20.1801290935160.1849@nanos>
 <CA+55aFy6FX6Ewg9exGH12PWnzSNKBfmc--v6H6UYpcSAEWUR8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFy6FX6Ewg9exGH12PWnzSNKBfmc--v6H6UYpcSAEWUR8A@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Jan 29, 2018 at 12:48 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >   - A rather large rework of the hrtimer infrastructure which introduces
> >     softirq based hrtimers to replace the spread of hrtimer/tasklet combos
> >     which force the actual callback execution into softirq context.
> 
> I really would have liked to see more of the rationale for this - now
> I'm left with just two example drivers, and a "you'll see the cleanups
> this allows in future driver pulls".
> 
> But pulled, since the code doesn't look disgusting.

Sorry, this is my fault: from Anna-Maria's original, full softirq-hrtimers series 
I didn't apply many of the usecases, because we didn't get any review feedback 
from the networking folks:

 can/bcm: Replace hrtimer_tasklet with softirq based hrtimer

   net/can/bcm.c | 156 ++++++++++++++++++++--------------------------------------
   1 file changed, 52 insertions(+), 104 deletions(-)

 mac80211_hwsim: Replace hrtimer tasklet with softirq hrtimer

   drivers/net/wireless/mac80211_hwsim.c | 44 ++++++++++++++++-------------------
   1 file changed, 20 insertions(+), 24 deletions(-)

 xfrm: Replace hrtimer tasklet with softirq hrtimer

   include/net/xfrm.h    |  2 +-
   net/xfrm/xfrm_state.c | 30 ++++++++++++++++++------------
   2 files changed, 19 insertions(+), 13 deletions(-)

 net/mvpp2: Replace tasklet with softirq hrtimer

   drivers/net/ethernet/marvell/mvpp2.c | 62 +++++++++++++++---------------------
   1 file changed, 25 insertions(+), 37 deletions(-)

And I felt uneasy about applying this in one go, so we decided to apply it in two 
phases.

These are in cases significant driver simplifications, but they also enable the 
real deal, the elimination of the hrtimer tasklet:

 softirq: Remove tasklet_hrtimer

   include/linux/interrupt.h | 25 -----------------------
   kernel/softirq.c          | 51 -----------------------------------------------
   2 files changed, 76 deletions(-)

... which is a pretty nice thing in itself even without the driver 
simplifications!

Plus the _real_ secret motivation behind it all is the -rt kernel and 
CONFIG_PREEMPT_RT=y and the ability to push most of the hrtimer processing into 
softirq context - while it still keeps the main hrtimer machinery capable to run 
in hard-RT hardirq domain. Turns out it was possible to implement this duality via 
the softirq-hrtimers, with a good chunk of benefits to non-rt upstream as well.

Thanks,

	Ingo
