Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeBPS4d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:56:33 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39870 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeBPS4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:56:30 -0500
X-Google-Smtp-Source: AH8x225uT6xJLj810WuDZwtc4L5X5Pdgn7F4VAzA36KEahff0+YCLdjTOTx7PI+3+jPbAYVJNHiBeJefvkBTz8s8VhU=
MIME-Version: 1.0
X-Originating-IP: [70.88.214.193]
In-Reply-To: <20180216025922.fmqxidvwk7qpq6gv@madcap2.tricolour.ca>
References: <cover.1518603831.git.rgb@redhat.com> <1c5184985e422774329484153b0147c2861e91a7.1518603831.git.rgb@redhat.com>
 <CAHC9VhR3u0n9ZSLHYcf0aJR=X=PLkSFPnYffz+=5v669QyasHg@mail.gmail.com> <20180216025922.fmqxidvwk7qpq6gv@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 16 Feb 2018 13:56:28 -0500
Message-ID: <CAHC9VhQ886QKrz8xgyhsZdsbzfVzYDNG6EVgZ5DpFfKAFVdWew@mail.gmail.com>
Subject: Re: [RFC PATCH ghak21 4/4] audit: add parent of refused symlink to audit_names
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 9:59 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-02-15 18:34, Paul Moore wrote:
>> On Wed, Feb 14, 2018 at 11:18 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > Audit link denied events for symlinks were missing the parent PATH
>> > record.  Add it.  Since the full pathname may not be available,
>> > reconstruct it from the path in the nameidata supplied.
>> >
>> > See: https://github.com/linux-audit/audit-kernel/issues/21
>> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> > ---
>> >  fs/namei.c | 9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > diff --git a/fs/namei.c b/fs/namei.c
>> > index 0edf133..bf1c046b 100644
>> > --- a/fs/namei.c
>> > +++ b/fs/namei.c
>> > @@ -923,6 +923,7 @@ static inline int may_follow_link(struct nameidata *nd)
>> >         const struct inode *inode;
>> >         const struct inode *parent;
>> >         kuid_t puid;
>> > +       char *pathname;
>> >
>> >         if (!sysctl_protected_symlinks)
>> >                 return 0;
>> > @@ -945,6 +946,14 @@ static inline int may_follow_link(struct nameidata *nd)
>> >         if (nd->flags & LOOKUP_RCU)
>> >                 return -ECHILD;
>> >
>> > +       pathname = kmalloc(PATH_MAX + 1, GFP_KERNEL);
>> > +       if (!pathname)
>> > +               return -ENOMEM;
>> > +       audit_inode(getname_kernel(d_absolute_path(&nd->stack[0].link, pathname,
>> > +                                                  PATH_MAX + 1)),
>> > +                   nd->stack[0].link.dentry, 0);
>>
>> Hmm, it's been a while since I've looked at the audit vfs/inode code,
>> but isn't the audit_inode() call directly above effectively a
>> duplicate of the audit_inode(nd->name, nd->stack[0].link.dentry, 0)
>> call you added in patch 3/4?
>
> It gets the full pathname string of the link, then converts it to a
> struct filename*, and then below, we feed it that struct filename* with
> the parent's dentry and the LOOKUP_PARENT flag to drop the last part of
> the pathname and set the filetype to PARENT.

I think that last bit is what I was forgetting, thanks.

> I didn't try, it, but I expect if I feed it parent's dentry above, I'd
> get only the parent pathname and when I feed it to audit_inode() below
> it would again drop the last part of the pathname when the LOOKUP_PARENT
> flag is included, or not label it as a filetype PARENT if we don't
> include the flag to get the full parent pathname.
>
>> > +       audit_inode(nd->name, nd->stack[0].link.dentry->d_parent, LOOKUP_PARENT);
>> > +
>> >         audit_inode(nd->name, nd->stack[0].link.dentry, 0);
>> >         audit_log_link_denied("follow_link", &nd->stack[0].link);
>> >         return -EACCES;
>> > --
>> > 1.8.3.1

-- 
paul moore
www.paul-moore.com
