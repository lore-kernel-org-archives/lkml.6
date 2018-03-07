Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755068AbeCGXnq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:43:46 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:46392 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754998AbeCGXnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:43:45 -0500
X-Google-Smtp-Source: AG47ELuApm9s1YA4gq2h2SaQg49FNbHM4zbp6tVhCDfVZtru6IoyxP9W6WrYSQWs6KbXTwi/s24RCt6JXoj5xV3GpNw=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <CAHC9VhRnM0FKrHvSgf=Pm2BpQSVT2pLWWH8Z7YvG5ExBYb_Ekg@mail.gmail.com>
References: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm>
 <CALCETrWhZ5ermtpfMt6UdLAC0M9mv7L_TsTfErGStPxznz-AWg@mail.gmail.com>
 <nycvar.YFH.7.76.1803071745180.15778@cbobk.fhfr.pm> <CAHC9VhRnM0FKrHvSgf=Pm2BpQSVT2pLWWH8Z7YvG5ExBYb_Ekg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Mar 2018 18:43:42 -0500
Message-ID: <CAHC9VhTipRUv+RB6JPTrHYkVW1vktg5yodD7iZCqgR9Z57Y+zg@mail.gmail.com>
Subject: Re: [PATCH] audit: set TIF_AUDIT_SYSCALL only if audit filter has
 been populated
To: Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 6:41 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Mar 7, 2018 at 11:48 AM, Jiri Kosina <jikos@kernel.org> wrote:
>> On Wed, 7 Mar 2018, Andy Lutomirski wrote:
>>> Wow, this was a long time ago.
>>
>> Oh yeah; but it now resurfaced on our side, as we are of course receiving
>> a lot of requests with respect to making syscall performance great again
>> :)
>
> Ooof.  I'm not sure I can handle making more things "great again" ;)
>
>>> From memory and a bit of email diving, there are two reasons.
>>>
>>> 1. The probably was partially solved (by Oleg, IIRC) by making auditctl
>>>    -a task,never cause newly spawned tasks to not suck.  Yes, it's a
>>>    very partial solution.  After considerable nagging, I got Fedora to
>>>    default to -a task,never.
>>
>> Hm, right; that's a bit inconvenient, because it takes each and every
>> vendor having to realize this option, and put it in. Making kernel do the
>> right thing automatically sounds like a better option to me.
>
> This predates audit falling into my lap, but speaking generally I
> think it would be good if the kernel did The Right Thing, so long as
> it isn't too painful.
>
>>> 2. This patch, as is, may be a bit problematic.  In particular, if one
>>>    task changes the audit rules while another task is in the middle of
>>>    the syscall, then it's too late to audit that syscall correctly.
>>>    This could be seen as a bug or it could be seen as being just fine.
>>
>> I don't think this should be a problem, given the fact that the whole
>> timing/ordering is not predictable anyway due to scheduling.
>>
>> Paul, what do you think?
>
> I'm not overly concerned about the race condition between configuring
> the audit filters and syscalls that are currently in-flight; after all
> we have that now and "fixing" it would be pretty much impractical
> (impossible maybe?).  Most serious audit users configure it during
> boot and let it run, frequent runtime changes are not common as far as
> I can tell.
>
> I just looked quickly at the patch and decided it isn't something I'm
> going to be able to carefully review in the time I've got left today,
> so it's going to have to wait until tomorrow and Friday ... however,
> speaking on general principle I don't have an objection to the ideas
> put forth here.
>
> Andy, if you've got any Reviewed-by/Tested-by/NACK/etc. you want to
> add, that would be good to have.

... and I just realized that linux-audit isn't on the To/CC line,
adding them now.

Link to the patch is below.

* https://marc.info/?t=152041887600003&r=1&w=2

-- 
paul moore
www.paul-moore.com
