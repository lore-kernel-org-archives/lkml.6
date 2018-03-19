Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967529AbeCSRPl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 13:15:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967805AbeCSRP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 13:15:28 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Paul Moore <paul@paul-moore.com>,
        linux-audit@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: set TIF_AUDIT_SYSCALL only if audit filter has been populated
Date: Mon, 19 Mar 2018 13:15:22 -0400
Message-ID: <1703251.0Aix3r8zCV@x2>
Organization: Red Hat
In-Reply-To: <CALCETrU7diwpacgGPQvt8J-jq0o=nhxb0N6XYUinoQcTaqqd_Q@mail.gmail.com>
References: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm> <nycvar.YFH.7.76.1803140124210.15778@cbobk.fhfr.pm> <CALCETrU7diwpacgGPQvt8J-jq0o=nhxb0N6XYUinoQcTaqqd_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 13, 2018 8:35:44 PM EDT Andy Lutomirski wrote:
> On Wed, Mar 14, 2018 at 12:28 AM, Jiri Kosina <jikos@kernel.org> wrote:
> > On Wed, 14 Mar 2018, Andy Lutomirski wrote:
> >> > Yes...I wished I was in on the beginning of this discussion. Here's
> >> > the
> >> > problem. We need all tasks auditable unless specifically dismissed as
> >> > uninteresting. This would be a task,never rule.
> >> > 
> >> > The way we look at it, is if it boots with audit=1, then we know
> >> > auditd
> >> > is expected to run at some point. So, we need all tasks to stay
> >> > auditable. If they weren't and auditd enabled auditing, then we'd need
> >> > to walk the whole proctable and stab TIF_AUDIT_SYSCALL into every
> >> > process in the system. It was decided that this is too ugly.
> >> 
> >> When was that decided?  That's what this patch does.
> > 
> > I'd like to see some more justification as well.
> > 
> > Namely, if I compare "setting TIF_AUDIT_SYSCALL for every process on a
> > need-to-be-so basis" to "we always go through the slow path and
> > pessimistically assume that audit is enabled and has reasonable ruleset
> > loaded", I have my own (different) opinion of what is too ugly.
> 
> Me too.
> 
> That being said, on re-review of my old code, I think that
> audit_dec_n_rules() may be the wrong approach.  It may be better to
> leave TIF_AUDIT_SYSCALL set but to make the audit code itself clear
> the flag the next time through.  That way we don't end up with a
> partially filled in syscall audit record that never gets consumed if
> we clear TIF_AUDIT_SYSCALL in the middle of a syscall.

So what happened when auditd is being restarted due to system update? Its 
possible to have no auditd, no rules, and audit_enabled == 0. But its getting 
ready to start a new auditd, enable audit, and load rules. In this case, we 
expect tasks already dismissed by task filter to stay dismissed because the 
task filter only runs at fork time.

For example, suppose httpd is not desired to be audited. The admin sets up a 
task rule that sets it to never for httpd. The rule triggers at fork and 
marks it inauditable. Would this patch cause httpd to suddenly become 
auditable again during an auditd restart?

Rather than play run time games which is ultimately racey and prone to 
missing something, what about the approach of controlling this from a boot 
variable and letting user space see an error should auditing try to do its 
normal thing when its not wanted? This way auditd can exit and there aren't 
any races.

-Steve
