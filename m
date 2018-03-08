Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755247AbeCHBGy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:06:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754741AbeCHBGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:06:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DEF2178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELs+Dg63wXHCZ87V+3+NU2VJaxJqTVuwdEeWwSQbLBeN1g0PsZ9WFmFlWYS22eqbpgOlYbHYiRLylVf4t/k9aF0=
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRnM0FKrHvSgf=Pm2BpQSVT2pLWWH8Z7YvG5ExBYb_Ekg@mail.gmail.com>
References: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm>
 <CALCETrWhZ5ermtpfMt6UdLAC0M9mv7L_TsTfErGStPxznz-AWg@mail.gmail.com>
 <nycvar.YFH.7.76.1803071745180.15778@cbobk.fhfr.pm> <CAHC9VhRnM0FKrHvSgf=Pm2BpQSVT2pLWWH8Z7YvG5ExBYb_Ekg@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 8 Mar 2018 01:06:30 +0000
X-Gmail-Original-Message-ID: <CALCETrVDYxKgdBWFeT4o6tohxGwpkgu8Z4kPmm6wSPJtCLgD0g@mail.gmail.com>
Message-ID: <CALCETrVDYxKgdBWFeT4o6tohxGwpkgu8Z4kPmm6wSPJtCLgD0g@mail.gmail.com>
Subject: Re: [PATCH] audit: set TIF_AUDIT_SYSCALL only if audit filter has
 been populated
To: Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com
Cc: Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 11:41 PM, Paul Moore <paul@paul-moore.com> wrote:
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
>

It's sort of my patch, and I was reasonably happy with it, so
definitely no NACK from me.  The only caveat I have is that I wrote
the original version so long ago that we need to re-audit the code.
In particular, I want to make sure that the following two cases don't
result in warnings, oopses, or other misbehavior:

1. Do a syscall with TIF_AUDIT_SYSCALL clear.  Return with
TIF_AUDIT_SYSCALL set and that syscall enabled for auditing.

2.. Do a VFS syscall with TIF_AUDIT_CLEAR and have TIF_AUDIT_SYSCALL
set before we execute any VFS code.  The VFS code will call into the
audit code to log the paths it touches (IIRC).  Again, this shouldn't
warn or otherwise misbehave.
