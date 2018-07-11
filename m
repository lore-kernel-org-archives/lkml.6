Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B357BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649C120877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649C120877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbeGKMMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:12:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbeGKMMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:12:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C355A7C6CA;
        Wed, 11 Jul 2018 12:08:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0407E2026D6B;
        Wed, 11 Jul 2018 12:08:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 11 Jul 2018 14:08:16 +0200 (CEST)
Date:   Wed, 11 Jul 2018 14:08:15 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Bug 200447] infinite loop in fork syscall
Message-ID: <20180711120815.GC4567@redhat.com>
References: <87h8l9p7bg.fsf@xmission.com>
 <20180709104158.GA23796@redhat.com>
 <87sh4so5jv.fsf@xmission.com>
 <20180709145726.GA26149@redhat.com>
 <877em4nxo0.fsf@xmission.com>
 <CA+55aFwq90_KeRUesktap7L_4Hp3gatKZ28RYw1jXBYeOqUoeA@mail.gmail.com>
 <87lgakm4ol.fsf@xmission.com>
 <CA+55aFz1XFvOgJySKVNQD9VS4hys0J7rozxqd3s5ND0z80tfVw@mail.gmail.com>
 <20180710134639.GA2453@redhat.com>
 <878t6jkrm0.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t6jkrm0.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 12:08:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 12:08:16 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, Eric W. Biederman wrote:
>
> > 2. To simplify, lets suppose we add the new PF_INFORK flag. Yes, this is bad,
> >    we can do better. I think we can simply add "struct hlist_head forking_threads"
> >    into signal_struct, so complete_signal() can just do hlist_for_each_entry()
> >    rather than for_each_thread() + PF_INFORK check. We don't even need a new
> >    member in task_struct.
>
> We still need the distinction between multi-process signals and single
> process signals (which is the hard part).  For good performance of
> signal delivery to multi-threaded tasks we still need a new member in
> signal_struct.  Plus it is a bit more work to update the list or even
> walk the list than a sequence counter.
>
> So I think adding a sequence counter to let us know about multiprocess
> signals is the local optimum.

But we can not rely on on a sequence counter, there are other reasons why
fork() should fail even if fatal_signal_pending() == F and the counter was
not changed (no multi-process signals).

> > 3. copy_process() can simply block/unblock all signals (except KILL/STOP), see
> >    the "patch" below.
>
> All signals are effectively blocked for the duration of the fork for the
> calling task.    Where we get into trouble and where we need a fix for
> correctness is that another thread can dequeue the signal.   Blocking
> signals of the forking task does not change that.

See my reply to Linus. Please look at the change in complete_signal().

> I think that reveals another bug in our current logic.  For blocked
> multi-process signals we don't ensure they get delivered to both the
> parent and the child if the signal logically comes in after the fork.

I thougth thought this too. I simply do not know if this is right or not.

For now I assume that this is correct and by design, iow if fork() is called
with (say) SIGTERM blocked, then we do not care if kill_pgrp(SIGTERM) misses
the new child.

If we want to change this, I think this needs another discussion.

Oleg.

