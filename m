Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2859AC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D3021771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D3021771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeHHSoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbeHHSoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:44:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0DB6208D4;
        Wed,  8 Aug 2018 16:24:05 +0000 (UTC)
Date:   Wed, 8 Aug 2018 12:24:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>, will.deacon@arm.com
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180808122404.67bdb77b@gandalf.local.home>
In-Reply-To: <20180808160243.GQ24813@linux.vnet.ibm.com>
References: <20180807222856.3ede96e7@vmware.local.home>
        <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
        <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
        <20180808084629.3290d1d6@gandalf.local.home>
        <20180808130302.GJ24813@linux.vnet.ibm.com>
        <20180808090724.41677176@gandalf.local.home>
        <20180808143310.GL24813@linux.vnet.ibm.com>
        <20180808104910.2ced5e51@gandalf.local.home>
        <20180808150558.GO24813@linux.vnet.ibm.com>
        <20180808112309.6edda174@gandalf.local.home>
        <20180808160243.GQ24813@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2018 09:02:43 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > Which leaves us with sparc, arm, mips, sh and powerpc.
> > 
> > sh is almost dead, and powerpc can be fixed, which I guess leaves us
> > with sparc, arm and mips.  
> 
> If we want to stick with the current srcu_read_lock() and srcu_read_unlock(),
> you mean?  I would like that sort of outcome, at least assuming we are not
> hammering any of the architectures.

I would go with the local_inc approach, and even add a
srcu_read_un/lock_nmi() that does that if you want. Probably should add
lockdep to detect if the _nmi calls is ever used along with non _nmi
calls and complain about that.

But this will be something for the next merge window, not the one
coming up.

-- Steve
