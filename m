Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756480AbeBOWvi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 17:51:38 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46082 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756464AbeBOWvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 17:51:37 -0500
X-Google-Smtp-Source: AH8x225rt42X40kovCcPIcGbeQpmZjI7zZorlOEaiHN+L8CIa+vISRwJ1hd8WyOrFY+5g6xDSW7AKRLV2BpfJi3Tyy8=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <CAGXu5jLTEa7sPxOnrWj8SNi-crEPQpTBXtdqdfppOE_vf9GriQ@mail.gmail.com>
References: <cover.1518603831.git.rgb@redhat.com> <3a9542b261d93bc4eaecfaf359affbba152cf965.1518603831.git.rgb@redhat.com>
 <CAGXu5jKtEv-W3R-uakY9S9=OFmjY3ZqxQJFa3YxGd4RWyUEGgQ@mail.gmail.com>
 <20180215023327.tt2s2pbcrblz5a7u@madcap2.tricolour.ca> <CAGXu5jLTEa7sPxOnrWj8SNi-crEPQpTBXtdqdfppOE_vf9GriQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Feb 2018 17:51:34 -0500
Message-ID: <CAHC9VhRiS9rb44m7dTDWU_p4Bo=SM_kSF9bvJw39Wee20zei6w@mail.gmail.com>
Subject: Re: [RFC PATCH ghak21 1/4] audit: make ANOM_LINK obey audit_enabled
 and audit_dummy_context
To: Kees Cook <keescook@chromium.org>
Cc: Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 1:16 AM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Feb 14, 2018 at 6:33 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> On 2018-02-14 09:51, Kees Cook wrote:
>>> On Wed, Feb 14, 2018 at 8:18 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>>> > Audit link denied events emit disjointed records when audit is disabled.
>>> > No records should be emitted when audit is disabled.
>>> >
>>> > See: https://github.com/linux-audit/audit-kernel/issues/21
>>> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>>> > ---
>>> >  kernel/audit.c | 3 +++
>>> >  1 file changed, 3 insertions(+)
>>> >
>>> > diff --git a/kernel/audit.c b/kernel/audit.c
>>> > index 227db99..4c3fd24 100644
>>> > --- a/kernel/audit.c
>>> > +++ b/kernel/audit.c
>>> > @@ -2261,6 +2261,9 @@ void audit_log_link_denied(const char *operation, const struct path *link)
>>> >         struct audit_buffer *ab;
>>> >         struct audit_names *name;
>>> >
>>> > +       if (!audit_enabled || audit_dummy_context())
>>> > +               return;
>>> > +
>>> >         name = kzalloc(sizeof(*name), GFP_NOFS);
>>> >         if (!name)
>>> >                 return;
>>>
>>> Doesn't this means errors here would be silent if audit isn't enabled?
>>> I don't that; sysadmins should see this notification regardless of the
>>> audit state...
>>
>> This is a user error and not a system error, so I would think if system
>> auditing is disabled, they don't care about this kind of error.
>
> It could indicate an attack attempt...

We get beat up by several folks when we emit audit records with audit
disabled, and they have a very valid point.

I'm not arguing that the information isn't useful, I'm arguing that if
you are interested in the sort of information that audit provides you
should enable audit.  :)

-- 
paul moore
www.paul-moore.com
