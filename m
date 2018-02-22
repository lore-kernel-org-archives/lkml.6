Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeBVAeQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:34:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751270AbeBVAeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:34:15 -0500
Message-ID: <1519259648.3171.43.camel@redhat.com>
Subject: Re: [PATCH] audit: return on memory error to avoid null pointer
 dereference
From: Eric Paris <eparis@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Steve Grubb <sgrubb@redhat.com>
Date: Wed, 21 Feb 2018 16:34:08 -0800
In-Reply-To: <CAHC9VhQ0QEJ9Gt=0em_u=sSHze-Af2AVbf72ARoAAoHf33_-Og@mail.gmail.com>
References: <2000f6951431b4f19947d7aa41bb8efd2fe3f15b.1519196084.git.rgb@redhat.com>
         <CAHC9VhQnVHgX99k2wTWyyxdaep-6k1WBnJ7t-AZmMNZJc_SN0A@mail.gmail.com>
         <CAHC9VhQ0QEJ9Gt=0em_u=sSHze-Af2AVbf72ARoAAoHf33_-Og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think if we went back and looked at history we'd see that all of the
code originally had none of the if(!ab) checks after allocation and
they just sorta slowly crept in over time. I prefer this pattern, but
it used to be the opposite everywhere.


On Wed, 2018-02-21 at 19:02 -0500, Paul Moore wrote:
> On Wed, Feb 21, 2018 at 6:49 PM, Paul Moore <paul@paul-moore.com>
> wrote:
> > On Wed, Feb 21, 2018 at 4:30 AM, Richard Guy Briggs <rgb@redhat.com
> > > wrote:
> > > If there is a memory allocation error when trying to change an
> > > audit
> > > kernel feature value, the ignored allocation error will trigger a
> > > NULL
> > > pointer dereference oops on subsequent use of that
> > > pointer.  Return
> > > instead.
> > > 
> > > Passes audit-testsuite.
> > > See: https://github.com/linux-audit/audit-kernel/issues/76
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  kernel/audit.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > 
> > Thanks, merged.
> > 
> > In the future a "[PATCH v2]" prefix would be appreciated for
> > patches
> > like this, it makes things a little easier in my inbox.
> 
> After merging this I went through all the other callers to see if
> they
> suffered the same mistake and everyone except for IMA was checking
> the
> returned pointer for NULL.  Upon looking at the IMA code, and the
> audit code which is called, I realized we are actually "ok" as
> audit_log_task_info(), audit_log_format(), audit_log_end(), and
> others
> all check for a NULL audit_buffer at the very top of the functions.
> I'm going to leave this patch merged, it's a good practice after all,
> but I don't believe that unpatched systems are in any danger of
> oops'ing here.
> 
> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index 5c25449..2de74be 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -1059,6 +1059,8 @@ static void audit_log_feature_change(int
> > > which, u32 old_feature, u32 new_feature
> > >                 return;
> > > 
> > >         ab = audit_log_start(NULL, GFP_KERNEL,
> > > AUDIT_FEATURE_CHANGE);
> > > +       if (!ab)
> > > +               return;
> > >         audit_log_task_info(ab, current);
> > >         audit_log_format(ab, " feature=%s old=%u new=%u
> > > old_lock=%u new_lock=%u res=%d",
> > >                          audit_feature_names[which],
> > > !!old_feature, !!new_feature,
> > > --
> > > 1.8.3.1
> 
> 
