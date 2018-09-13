Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8507EFC618C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCF4214FE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCF4214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeIMVFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:05:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbeIMVFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:05:52 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9749804E9;
        Thu, 13 Sep 2018 15:55:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 41584308BE75;
        Thu, 13 Sep 2018 15:55:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 13 Sep 2018 17:55:45 +0200 (CEST)
Date:   Thu, 13 Sep 2018 17:55:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] introduce for_each_process_thread_break() and
 for_each_process_thread_continue()
Message-ID: <20180913155543.GA32500@redhat.com>
References: <20180912163312.GA18739@redhat.com>
 <20180912163335.GA18748@redhat.com>
 <20180912122533.459e73df8f512e74b7eb7354@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912122533.459e73df8f512e74b7eb7354@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 13 Sep 2018 15:55:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12, Andrew Morton wrote:
>
> > Usage:
> >
> > 	rcu_read_lock();
> > 	for_each_process_thread(p, t) {
> > 		do_something_slow(p, t);
> >
> > 		if (SPENT_TOO_MUCH_TIME) {
> > 			for_each_process_thread_break(p, t);
> > 			rcu_read_unlock();
> > 			schedule();
> > 			rcu_read_lock();
> > 			for_each_process_thread_continue(&p, &t);
> > 		}
> > 	}
> > 	rcu_read_unlock();

...

> > +static inline void
> > +for_each_process_thread_break(struct task_struct *p, struct task_struct *t)
> > +{
> > +	get_task_struct(p);
> > +	get_task_struct(t);
> > +}
> > +
> > +extern void
> > +for_each_process_thread_continue(struct task_struct **, struct task_struct **);
>
> These things will need some documentation, please.  What they do, why
> they do it, how people should use them, when and why they should use
> them.  Etcetera!  This is tricky stuff.

See "Usage" above, this is as simple as list_for_each_entry_continue_rcu(),
just you need to call _break() first.

OK, I'll try to add some comments and send V2.

> Should these be available to modules, like the rest of these things
> appear to be?  Or we could do that later if a need is shown.

Yes, I think this can be exported on demand,

Oleg.

