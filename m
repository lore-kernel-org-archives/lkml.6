Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755189AbeDTNw4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:52:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754958AbeDTNwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:52:54 -0400
Date: Fri, 20 Apr 2018 09:46:51 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH ghak80 V1] audit: add syscall information to
 FEATURE_CHANGE records
Message-ID: <20180420134651.3badjswsokqs7hex@madcap2.tricolour.ca>
References: <08bd08ee9bc70f6e98b9e298ba6a2c0f4dcadb4b.1523372093.git.rgb@redhat.com>
 <CAHC9VhSxjEKNcdE2Mm-Vwef6RvTG2ykGFFmeAtVypAaPRvddmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSxjEKNcdE2Mm-Vwef6RvTG2ykGFFmeAtVypAaPRvddmg@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-17 18:06, Paul Moore wrote:
> On Wed, Apr 11, 2018 at 8:46 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Tie syscall information to FEATURE_CHANGE calls since it is a result of
> > user action.
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/80
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/audit.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 8da24ef..23f125b 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -1103,10 +1103,9 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
> >  {
> >         struct audit_buffer *ab;
> >
> > -       if (audit_enabled == AUDIT_OFF)
> > +       if (!audit_enabled)
> 
> Sooo, this is an unrelated style change, why?  Looking at the rest of
> kernel/audit.c we seem to use a mix of "(!x)" and "(x == 0/CONST)" so
> why are you adding noise to this patch?

Ok, survey sez 25 instances of audit_enabled used as a boolean vs 7
instances where it could be used as a boolean where the expression is
made harder to read (in my opinion).  I thought it was worth changing to
read the same way most of the other instances I've been reviewing are
written.  There are only two where the non-boolean distiction with
AUDIT_LOCKED is required.

> >                 return;
> > -
> > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
> > +       ab = audit_log_start(current->audit_context, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
> 
> This is the important part, and the Right Thing To Do.
> 
> >         if (!ab)
> >                 return;
> >         audit_log_task_info(ab, current);
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
