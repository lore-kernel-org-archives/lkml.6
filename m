Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932167AbeCJKPN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 05:15:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750884AbeCJKPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 05:15:11 -0500
Date: Sat, 10 Mar 2018 11:15:35 +0100
From: Steve Grubb <sgrubb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-audit@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: set  TIF_AUDIT_SYSCALL only if audit filter has
 been populated
Message-ID: <20180310111535.2e3202bc@ivy-bridge>
In-Reply-To: <CAHC9VhTipRUv+RB6JPTrHYkVW1vktg5yodD7iZCqgR9Z57Y+zg@mail.gmail.com>
References: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm>
        <CALCETrWhZ5ermtpfMt6UdLAC0M9mv7L_TsTfErGStPxznz-AWg@mail.gmail.com>
        <nycvar.YFH.7.76.1803071745180.15778@cbobk.fhfr.pm>
        <CAHC9VhRnM0FKrHvSgf=Pm2BpQSVT2pLWWH8Z7YvG5ExBYb_Ekg@mail.gmail.com>
        <CAHC9VhTipRUv+RB6JPTrHYkVW1vktg5yodD7iZCqgR9Z57Y+zg@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2018 18:43:42 -0500
Paul Moore <paul@paul-moore.com> wrote:
> ... and I just realized that linux-audit isn't on the To/CC line,
> adding them now.
> 
> Link to the patch is below.
> 
> * https://marc.info/?t=152041887600003&r=1&w=2

Yes...I wished I was in on the beginning of this discussion. Here's the
problem. We need all tasks auditable unless specifically dismissed as
uninteresting. This would be a task,never rule.

The way we look at it, is if it boots with audit=1, then we know auditd
is expected to run at some point. So, we need all tasks to stay
auditable. If they weren't and auditd enabled auditing, then we'd need
to walk the whole proctable and stab TIF_AUDIT_SYSCALL into every
process in the system. It was decided that this is too ugly.

So, we need them all to be auditable if there is any intent to audit.
It doesn't matter if there are rules loaded or not. All processes have
to stay within reach.

What might be acceptable is to add one more state to audit boot variable
to indicate that auditing is never expected. We currently have:
disabled - which means we'll decide later, enabled, and immutable (no
changes allowed). Then have calls to audit_enable or loading rules
fail on that flag state so that user space can log that there is a
conflict (boot vs daemon) that has to be resolved. As long as we can
fail in a discoverable way, I think it would be OK to do something like
this. Also, I don't think we want that to be the default state at the
moment because the current default is keep all processes auditable.

-Steve
