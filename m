Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBB4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C012075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C012075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeIGNI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:08:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:42334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeIGNI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:08:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5132AD93;
        Fri,  7 Sep 2018 08:28:35 +0000 (UTC)
Date:   Fri, 7 Sep 2018 10:28:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180907082834.vjycyvt6nddpb4la@pathway.suse.cz>
References: <20180905213334.03375777@vmware.local.home>
 <20180906023151.GA749@jagdpanzerIV>
 <20180907074531.GM24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907074531.GM24106@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-09-07 09:45:31, Peter Zijlstra wrote:
> On Thu, Sep 06, 2018 at 11:31:51AM +0900, Sergey Senozhatsky wrote:
> > An alternative option, thus, could be re-instating back the rule that
> > lockdep_off/on should be the first and the last thing we do in
> > nmi_enter/nmi_exit. E.g.
> > 
> > nmi_enter()
> > 	lockdep_off();
> > 	printk_nmi_enter();
> > 
> > nmi_exit()
> > 	printk_nmi_exit();
> > 	lockdep_on();
> 
> Yes that. Also, those should probably be inline functions.
> 
> ---
> Subject: locking/lockdep: Fix NMI handling
> 
> Someone put code in the NMI handler before lockdep_off(). Since lockdep
> is not NMI safe, this wrecks stuff.

My view is that nmi_enter() has to switch several features into
NMI-safe mode. The code must not trigger the other features when
they are still in the unsafe mode.

It is a chicken&egg problem. And it is hard to completely prevent
regressions caused by future changes.

I though that printk_nmi_enter() should never need any lockdep-related
code. On the other hand, people might want to printk debug messages
when lockdep_off() is called. This is why I put it in the current order.

That said, I am not against this change. Especially the inlining
is a good move. Note that lockdep_off()/lockdep_on() must not
be traced as well.

Best Regards,
Petr
