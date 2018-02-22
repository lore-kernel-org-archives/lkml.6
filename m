Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbeBVA7y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:59:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751423AbeBVA7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:59:53 -0500
Date: Wed, 21 Feb 2018 19:55:49 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH] audit: return on memory error to avoid null pointer
 dereference
Message-ID: <20180222005549.m45nkj5n6wbshbdl@madcap2.tricolour.ca>
References: <2000f6951431b4f19947d7aa41bb8efd2fe3f15b.1519196084.git.rgb@redhat.com>
 <CAHC9VhQnVHgX99k2wTWyyxdaep-6k1WBnJ7t-AZmMNZJc_SN0A@mail.gmail.com>
 <CAHC9VhQ0QEJ9Gt=0em_u=sSHze-Af2AVbf72ARoAAoHf33_-Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQ0QEJ9Gt=0em_u=sSHze-Af2AVbf72ARoAAoHf33_-Og@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-21 19:02, Paul Moore wrote:
> On Wed, Feb 21, 2018 at 6:49 PM, Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Feb 21, 2018 at 4:30 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> >> If there is a memory allocation error when trying to change an audit
> >> kernel feature value, the ignored allocation error will trigger a NULL
> >> pointer dereference oops on subsequent use of that pointer.  Return
> >> instead.
> >>
> >> Passes audit-testsuite.
> >> See: https://github.com/linux-audit/audit-kernel/issues/76
> >> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >> ---
> >>  kernel/audit.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> > Thanks, merged.
> >
> > In the future a "[PATCH v2]" prefix would be appreciated for patches
> > like this, it makes things a little easier in my inbox.

(Sorry, forgot in haste to get that fixed one out...)

> After merging this I went through all the other callers to see if they
> suffered the same mistake and everyone except for IMA was checking the
> returned pointer for NULL.  Upon looking at the IMA code, and the
> audit code which is called, I realized we are actually "ok" as
> audit_log_task_info(), audit_log_format(), audit_log_end(), and others
> all check for a NULL audit_buffer at the very top of the functions.
> I'm going to leave this patch merged, it's a good practice after all,
> but I don't believe that unpatched systems are in any danger of
> oops'ing here.

On review, agreed.  My ctags/cscope DBs need regeneration, so I hadn't
noticed that the functions to which I was led weren't the ones I was
seeking, and while these three do check, not all functions that
accept a struct audit_buffer pointer parameter don't check for NULL.
Now that I check, I only find audit_expand (whose callers are all
protected) and audit_log_d_path (whose callers all appear to be
protected), the latter of which I've spent a bit of time staring at of
late (ghak8, ghak21...).

We're ok.

> >> diff --git a/kernel/audit.c b/kernel/audit.c
> >> index 5c25449..2de74be 100644
> >> --- a/kernel/audit.c
> >> +++ b/kernel/audit.c
> >> @@ -1059,6 +1059,8 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
> >>                 return;
> >>
> >>         ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
> >> +       if (!ab)
> >> +               return;
> >>         audit_log_task_info(ab, current);
> >>         audit_log_format(ab, " feature=%s old=%u new=%u old_lock=%u new_lock=%u res=%d",
> >>                          audit_feature_names[which], !!old_feature, !!new_feature,
> >> --
> >> 1.8.3.1
> 
> -- 
> paul moore
> www.paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
