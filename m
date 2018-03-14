Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbeCNAgH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 20:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932590AbeCNAgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 20:36:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A62D2178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELupUoW1iFjZuiAIrXK2Z8N0L0pttJIxdmepFVPqE6XTxyGUtsLjgy0KCYNT0ff/GrTkiQpxh3o87zxU34VX+3U=
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1803140124210.15778@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm>
 <CALCETrWhZ5ermtpfMt6UdLAC0M9mv7L_TsTfErGStPxznz-AWg@mail.gmail.com>
 <nycvar.YFH.7.76.1803071745180.15778@cbobk.fhfr.pm> <CAHC9VhRnM0FKrHvSgf=Pm2BpQSVT2pLWWH8Z7YvG5ExBYb_Ekg@mail.gmail.com>
 <CAHC9VhTipRUv+RB6JPTrHYkVW1vktg5yodD7iZCqgR9Z57Y+zg@mail.gmail.com>
 <20180310111535.2e3202bc@ivy-bridge> <CALCETrUV9Q8o2TkydO7NNjHAQNsZM-m9nEV8n_XnoaE+RmGoXw@mail.gmail.com>
 <nycvar.YFH.7.76.1803140124210.15778@cbobk.fhfr.pm>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 14 Mar 2018 00:35:44 +0000
X-Gmail-Original-Message-ID: <CALCETrU7diwpacgGPQvt8J-jq0o=nhxb0N6XYUinoQcTaqqd_Q@mail.gmail.com>
Message-ID: <CALCETrU7diwpacgGPQvt8J-jq0o=nhxb0N6XYUinoQcTaqqd_Q@mail.gmail.com>
Subject: Re: [PATCH] audit: set TIF_AUDIT_SYSCALL only if audit filter has
 been populated
To: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 12:28 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 14 Mar 2018, Andy Lutomirski wrote:
>
>> > Yes...I wished I was in on the beginning of this discussion. Here's the
>> > problem. We need all tasks auditable unless specifically dismissed as
>> > uninteresting. This would be a task,never rule.
>> >
>> > The way we look at it, is if it boots with audit=1, then we know auditd
>> > is expected to run at some point. So, we need all tasks to stay
>> > auditable. If they weren't and auditd enabled auditing, then we'd need
>> > to walk the whole proctable and stab TIF_AUDIT_SYSCALL into every
>> > process in the system. It was decided that this is too ugly.
>>
>> When was that decided?  That's what this patch does.
>
> I'd like to see some more justification as well.
>
> Namely, if I compare "setting TIF_AUDIT_SYSCALL for every process on a
> need-to-be-so basis" to "we always go through the slow path and
> pessimistically assume that audit is enabled and has reasonable ruleset
> loaded", I have my own (different) opinion of what is too ugly.

Me too.

That being said, on re-review of my old code, I think that
audit_dec_n_rules() may be the wrong approach.  It may be better to
leave TIF_AUDIT_SYSCALL set but to make the audit code itself clear
the flag the next time through.  That way we don't end up with a
partially filled in syscall audit record that never gets consumed if
we clear TIF_AUDIT_SYSCALL in the middle of a syscall.
