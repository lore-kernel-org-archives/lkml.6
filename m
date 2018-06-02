Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeFBRzH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 13:55:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750831AbeFBRzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 13:55:06 -0400
Date: Sat, 2 Jun 2018 13:53:58 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Subject: Re: [RFC PATCH ghak86 V1] audit: use audit_enabled as a boolean
 where convenient
Message-ID: <20180602175358.wfdlx6dvnxypspya@madcap2.tricolour.ca>
References: <c390a53d148593016df96e880a35e64f42edcf91.1527726830.git.rgb@redhat.com>
 <CAHC9VhQji1JrZ-QHMJ-965s+a5UJx-wRqpEdb84r=v+t1oH-qw@mail.gmail.com>
 <20180531163811.7m7c3q75duqkicl4@madcap2.tricolour.ca>
 <CAHC9VhTABDT0FKb=vY4G06aY9Ky+NctArCRo8-iUQF6=eWKy1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTABDT0FKb=vY4G06aY9Ky+NctArCRo8-iUQF6=eWKy1g@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-01 18:15, Paul Moore wrote:
> On Thu, May 31, 2018 at 12:38 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-05-31 11:48, Paul Moore wrote:
> >> On Thu, May 31, 2018 at 11:13 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> >> > Most uses of audit_enabled don't care about the distinction between
> >> > AUDIT_ON and AUDIT_LOCKED, so using audit_enabled as a boolean makes
> >> > more sense and is easier to read. Most uses of audit_enabled treat it as
> >> > a boolean, so switch the remaining AUDIT_OFF usage to simply use
> >> > audit_enabled as a boolean where applicable.
> >> >
> >> > See: https://github.com/linux-audit/audit-kernel/issues/86
> >> >
> >> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >> > ---
> >> >  drivers/tty/tty_audit.c      | 2 +-
> >> >  include/net/xfrm.h           | 2 +-
> >> >  kernel/audit.c               | 8 ++++----
> >> >  net/netfilter/xt_AUDIT.c     | 2 +-
> >> >  net/netlabel/netlabel_user.c | 2 +-
> >> >  5 files changed, 8 insertions(+), 8 deletions(-)
> >>
> >> I'm not sure I like this idea.  Yes, technically this change is
> >> functionally equivalent but I worry that this will increase the chance
> >> that non-audit folks will mistake audit_enabled as a true/false value
> >> when it is not.  It might work now, but I worry about some subtle
> >> problem in the future.
> >
> > Would you prefer a patch to change the majority (18) of uses of
> > audit_enabled to be of the form "audit_enabled == AUDIT_OFF" (or
> > "audit_enabled != AUDIT_OFF")?
> >
> > I prefer the approach in this patch because it makes the code smaller
> > and significantly easier to read, but either way, I'd like all uses to
> > be consistent so that it is easier to read all the code similarly.
> >
> >> If you are bothered by the comparison to 0 (magic numbers), you could
> >> move the AUDIT_OFF/AUDIT_ON/AUDIT_LOCKED definitions into
> >> include/linux/audit.h and convert the "audit_enabled == 0" to
> >> "audit_enabled == AUDIT_OFF".
> >
> > I'd be fine doing that if you really dislike this patch's approach.
> 
> Like I said, I'm don't really care for the boolean-like approach of
> this first patch.

That doesn't really address the original issue though.

Without any elaboration, I am not able to guess why you don't like this
or what possible future subtleties would cause a problem.  Is there a
past example somewhere else that brings up this concern?
Can you explain the problem with "non-audit folks will mistake
audit_enabled as a true/false value when it is not"?  Other subsystems
should not care about the distinction between locked and not.

While I realize people change their opinions given a broader context,
and the origninal reply was ambiguous, I went ahead with this patch
based on your "Sounds good." from:
	https://www.redhat.com/archives/linux-audit/2018-April/msg00089.html

Would you accept a patch that defines a function by the same name as the
global variable that returns a boolean (and localizes and renames the
existing global with a "__" prefix?  I'm not willing to offer a patch to
make the existing boolean usage harder to read to bring it all into
similar usage.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
