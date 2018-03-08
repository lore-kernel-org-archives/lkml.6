Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935664AbeCHJQ7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:16:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755101AbeCHJQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:16:53 -0500
Date: Thu, 8 Mar 2018 04:12:20 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-audit@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: set TIF_AUDIT_SYSCALL only if audit filter has
 been populated
Message-ID: <20180308091220.5hzxjztbiugkxpna@madcap2.tricolour.ca>
References: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm>
 <CALCETrWhZ5ermtpfMt6UdLAC0M9mv7L_TsTfErGStPxznz-AWg@mail.gmail.com>
 <nycvar.YFH.7.76.1803071745180.15778@cbobk.fhfr.pm>
 <CAHC9VhRnM0FKrHvSgf=Pm2BpQSVT2pLWWH8Z7YvG5ExBYb_Ekg@mail.gmail.com>
 <CAHC9VhTipRUv+RB6JPTrHYkVW1vktg5yodD7iZCqgR9Z57Y+zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTipRUv+RB6JPTrHYkVW1vktg5yodD7iZCqgR9Z57Y+zg@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-07 18:43, Paul Moore wrote:
> On Wed, Mar 7, 2018 at 6:41 PM, Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Mar 7, 2018 at 11:48 AM, Jiri Kosina <jikos@kernel.org> wrote:
> >> On Wed, 7 Mar 2018, Andy Lutomirski wrote:
> >>> Wow, this was a long time ago.
> >>
> >> Oh yeah; but it now resurfaced on our side, as we are of course receiving
> >> a lot of requests with respect to making syscall performance great again
> >> :)
> >
> > Ooof.  I'm not sure I can handle making more things "great again" ;)
> >
> >>> From memory and a bit of email diving, there are two reasons.
> >>>
> >>> 1. The probably was partially solved (by Oleg, IIRC) by making auditctl
> >>>    -a task,never cause newly spawned tasks to not suck.  Yes, it's a
> >>>    very partial solution.  After considerable nagging, I got Fedora to
> >>>    default to -a task,never.
> >>
> >> Hm, right; that's a bit inconvenient, because it takes each and every
> >> vendor having to realize this option, and put it in. Making kernel do the
> >> right thing automatically sounds like a better option to me.
> >
> > This predates audit falling into my lap, but speaking generally I
> > think it would be good if the kernel did The Right Thing, so long as
> > it isn't too painful.
> >
> >>> 2. This patch, as is, may be a bit problematic.  In particular, if one
> >>>    task changes the audit rules while another task is in the middle of
> >>>    the syscall, then it's too late to audit that syscall correctly.
> >>>    This could be seen as a bug or it could be seen as being just fine.
> >>
> >> I don't think this should be a problem, given the fact that the whole
> >> timing/ordering is not predictable anyway due to scheduling.
> >>
> >> Paul, what do you think?
> >
> > I'm not overly concerned about the race condition between configuring
> > the audit filters and syscalls that are currently in-flight; after all
> > we have that now and "fixing" it would be pretty much impractical
> > (impossible maybe?).  Most serious audit users configure it during
> > boot and let it run, frequent runtime changes are not common as far as
> > I can tell.

I'd agree the race condition here can't easily be fixed and isn't worth
fixing for the reasons already stated (rules don't change often and may
even be locked once in place relatively early, scheduling uncertainties).

> > I just looked quickly at the patch and decided it isn't something I'm
> > going to be able to carefully review in the time I've got left today,
> > so it's going to have to wait until tomorrow and Friday ... however,
> > speaking on general principle I don't have an objection to the ideas
> > put forth here.

The approach seems a bit draconian since it touches all tasks but only
when adding the first rule or deleting the last.

What we lose is the ability to set or clear individual task auditing and
have it stick to speed up non-audited tasks when there are rules
present, though this isn't currently used, in favour of audit_context
presence.

> > Andy, if you've got any Reviewed-by/Tested-by/NACK/etc. you want to
> > add, that would be good to have.
> 
> ... and I just realized that linux-audit isn't on the To/CC line,
> adding them now.

(and Andy's non-NACK missed too...)  The mailing list *is* in MAINTAINERS.

> Link to the patch is below.
> 
> * https://marc.info/?t=152041887600003&r=1&w=2
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
