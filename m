Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeDQWKb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 18:10:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750989AbeDQWKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 18:10:30 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH ghak80 V1] audit: add syscall information to FEATURE_CHANGE records
Date: Tue, 17 Apr 2018 18:10:30 -0400
Message-ID: <2312860.Cha4zeddVm@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhSxjEKNcdE2Mm-Vwef6RvTG2ykGFFmeAtVypAaPRvddmg@mail.gmail.com>
References: <08bd08ee9bc70f6e98b9e298ba6a2c0f4dcadb4b.1523372093.git.rgb@redhat.com> <CAHC9VhSxjEKNcdE2Mm-Vwef6RvTG2ykGFFmeAtVypAaPRvddmg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 17, 2018 6:06:24 PM EDT Paul Moore wrote:
> On Wed, Apr 11, 2018 at 8:46 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Tie syscall information to FEATURE_CHANGE calls since it is a result of
> > user action.
> > 
> > See: https://github.com/linux-audit/audit-kernel/issues/80
> > 
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > 
> >  kernel/audit.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 8da24ef..23f125b 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -1103,10 +1103,9 @@ static void audit_log_feature_change(int which,
> > u32 old_feature, u32 new_feature> 
> >  {
> >  
> >         struct audit_buffer *ab;
> > 
> > -       if (audit_enabled == AUDIT_OFF)
> > +       if (!audit_enabled)
> 
> Sooo, this is an unrelated style change, why?  Looking at the rest of
> kernel/audit.c we seem to use a mix of "(!x)" and "(x == 0/CONST)" so
> why are you adding noise to this patch?
> 
> >                 return;
> > 
> > -
> > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
> > +       ab = audit_log_start(current->audit_context, GFP_KERNEL,
> > AUDIT_FEATURE_CHANGE);
> This is the important part, and the Right Thing To Do.

This is an unexpected change. I have asked questions on the github issue 
tracker but have not gotten a satisfactory answer. Please do not merge this 
until there's agreement on this.

Thanks,
-Steve

> >         if (!ab)
> >         
> >                 return;
> >         
> >         audit_log_task_info(ab, current);
> > 
> > --
> > 1.8.3.1
