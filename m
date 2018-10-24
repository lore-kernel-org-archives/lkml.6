Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792CDC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379D12064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379D12064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeJXWUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:20:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeJXWUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:20:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EB5EC029432;
        Wed, 24 Oct 2018 13:52:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 99E095D763;
        Wed, 24 Oct 2018 13:52:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Oct 2018 15:52:20 +0200 (CEST)
Date:   Wed, 24 Oct 2018 15:52:13 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Enke Chen <enkechen@cisco.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>
Subject: Re: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
Message-ID: <20181024135212.GF30128@redhat.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <20181023092348.GA14340@redhat.com>
 <1e68a3ce-32cd-b058-3d1d-36455ceca848@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e68a3ce-32cd-b058-3d1d-36455ceca848@cisco.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 24 Oct 2018 13:52:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23, Enke Chen wrote:
>
> >> +	/*
> >> +	 * Send the pre-coredump signal to the parent if requested.
> >> +	 */
> >> +	read_lock(&tasklist_lock);
> >> +	notify = do_notify_parent_predump(current);
> >> +	read_unlock(&tasklist_lock);
> >> +	if (notify)
> >> +		cond_resched();
> >
> > Hmm. I do not understand why do we need cond_resched(). And even if we need it,
> > why we can't call it unconditionally?
>
> Remember the goal is to allow the parent (e.g., a process manager) to take early
> action. The "yield" before doing coredump will help.

I don't see how can it actually help...

cond_resched() is nop if CONFIG_PREEMPT or should_resched() == 0.

and the coredumping thread will certainly need to sleep/wait anyway.

> > And once again, SIGCHLD/SIGUSR do not queue, this means that PR_SET_PREDUMP_SIG
> > is pointless if you have 2 or more children.
>
> Hmm, could you point me to the code where SIGCHLD/SIGUSR is treated differently
> w.r.t. queuing?  That does not sound right to me.

see the legacy_queue() check. Any signal < SIGRTMIN do not queue. IOW, if SIGCHLD
is already pending, then next SIGCHLD is simply ignored.

Oleg.

