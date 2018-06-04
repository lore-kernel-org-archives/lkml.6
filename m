Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeFDX5V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:57:21 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40609 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeFDX5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:57:20 -0400
X-Google-Smtp-Source: ADUXVKKPJbYKyOklpeFe7QegQXHHgOGas1DC4hEaBHBJPLPrgmCqaB3DWHudsm7zrvLc4YLv0J0wbC8VFnPQxgrwtVE=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180602175358.wfdlx6dvnxypspya@madcap2.tricolour.ca>
References: <c390a53d148593016df96e880a35e64f42edcf91.1527726830.git.rgb@redhat.com>
 <CAHC9VhQji1JrZ-QHMJ-965s+a5UJx-wRqpEdb84r=v+t1oH-qw@mail.gmail.com>
 <20180531163811.7m7c3q75duqkicl4@madcap2.tricolour.ca> <CAHC9VhTABDT0FKb=vY4G06aY9Ky+NctArCRo8-iUQF6=eWKy1g@mail.gmail.com>
 <20180602175358.wfdlx6dvnxypspya@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 Jun 2018 19:57:17 -0400
Message-ID: <CAHC9VhR-TaSDbowz6FGGSvdxLTJG9so92C9wXyE04uygBazkhQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak86 V1] audit: use audit_enabled as a boolean where convenient
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 2, 2018 at 1:53 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-06-01 18:15, Paul Moore wrote:
>> On Thu, May 31, 2018 at 12:38 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > On 2018-05-31 11:48, Paul Moore wrote:
>> >> On Thu, May 31, 2018 at 11:13 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> >> > Most uses of audit_enabled don't care about the distinction between
>> >> > AUDIT_ON and AUDIT_LOCKED, so using audit_enabled as a boolean makes
>> >> > more sense and is easier to read. Most uses of audit_enabled treat it as
>> >> > a boolean, so switch the remaining AUDIT_OFF usage to simply use
>> >> > audit_enabled as a boolean where applicable.
>> >> >
>> >> > See: https://github.com/linux-audit/audit-kernel/issues/86
>> >> >
>> >> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> >> > ---
>> >> >  drivers/tty/tty_audit.c      | 2 +-
>> >> >  include/net/xfrm.h           | 2 +-
>> >> >  kernel/audit.c               | 8 ++++----
>> >> >  net/netfilter/xt_AUDIT.c     | 2 +-
>> >> >  net/netlabel/netlabel_user.c | 2 +-
>> >> >  5 files changed, 8 insertions(+), 8 deletions(-)
>> >>
>> >> I'm not sure I like this idea.  Yes, technically this change is
>> >> functionally equivalent but I worry that this will increase the chance
>> >> that non-audit folks will mistake audit_enabled as a true/false value
>> >> when it is not.  It might work now, but I worry about some subtle
>> >> problem in the future.
>> >
>> > Would you prefer a patch to change the majority (18) of uses of
>> > audit_enabled to be of the form "audit_enabled == AUDIT_OFF" (or
>> > "audit_enabled != AUDIT_OFF")?
>> >
>> > I prefer the approach in this patch because it makes the code smaller
>> > and significantly easier to read, but either way, I'd like all uses to
>> > be consistent so that it is easier to read all the code similarly.
>> >
>> >> If you are bothered by the comparison to 0 (magic numbers), you could
>> >> move the AUDIT_OFF/AUDIT_ON/AUDIT_LOCKED definitions into
>> >> include/linux/audit.h and convert the "audit_enabled == 0" to
>> >> "audit_enabled == AUDIT_OFF".
>> >
>> > I'd be fine doing that if you really dislike this patch's approach.
>>
>> Like I said, I'm don't really care for the boolean-like approach of
>> this first patch.
>
> That doesn't really address the original issue though.

To be honest, there really isn't an issue to begin with, at least not
in my mind.  Sure, I understand you think all non-audit users of
audit_enabled should treat audit_enabled as a boolean; at this point
in time, I don't think that is necessary or desirable.

> Without any elaboration, I am not able to guess why you don't like this
> or what possible future subtleties would cause a problem.

As I said previously: "I worry that this will increase the chance that
non-audit folks will mistake audit_enabled as a true/false value when
it is not.  It might work now, but I worry about some subtle problem
in the future.".

> Can you explain the problem with "non-audit folks will mistake
> audit_enabled as a true/false value when it is not"?

See the "it might work but ..." part above.

> While I realize people change their opinions given a broader context,
> and the origninal reply was ambiguous, I went ahead with this patch
> based on your "Sounds good." from:
>         https://www.redhat.com/archives/linux-audit/2018-April/msg00089.html

I think the confusion comes from what was meant by "clean them all
up".  We obviously have different understandings of what "cleaning"
meant.

> Would you accept a patch that defines a function by the same name as the
> global variable that returns a boolean (and localizes and renames the
> existing global with a "__" prefix?

At this point I think I've been clear that I don't like treating it as
a boolean, regardless of if it is wrapped in a function or not.  Why?
Well, it's not a boolean for starters.

If you wanted to submit a patch that would swap out 0 for AUDIT_OFF I
would accept that.

> I'm not willing to offer a patch to make the existing boolean usage harder to read to bring it all into similar usage.

Okay ... ?  Patch submission has always been voluntary as far as I can
tell; if you aren't willing to submit a patch, that's fine.

-- 
paul moore
www.paul-moore.com
