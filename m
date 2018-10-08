Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40F7C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3BE2064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tcqAtd4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3BE2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeJHSCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:02:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36569 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeJHSCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:02:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id k5so6356620ote.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 03:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jnx21yYhkaDAgnAPDUHthI2Lxm2pq2fKPQuUILKjyno=;
        b=tcqAtd4L+AIEsFo1daXRekm7DgJfKFNUMezobs3mu5wqCgij+WP7pP9hKeDZMrKb5D
         mev6ypSErX2li7D1URVBFLRCMsMiJZNw5Hq+250+dMduyMiT7FZeHAyZw8xVSwu9bRf2
         4qRb00sCDSizNwlXG6pgjDT7ZmIIVBakqa0P8LfVJeoelV4JBPkGzPtZy1OmoV00gQBT
         e+EdOozWtyPwsRZgUB4Jdc6syBjBxg03feqFBbkoYcFliFmdBlgWBpRDC8Id2GYJP/98
         LEYEHYHrY/lNWJeYQmkPHrfGu11LJxMBmCOOj/wSVaZeRz2Ev52Nv99K20wemtGPVfmQ
         D8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jnx21yYhkaDAgnAPDUHthI2Lxm2pq2fKPQuUILKjyno=;
        b=pEdwO1D1zwtyZ5fomn6VW98LwOR7J/xjvawe1EcaZRz3dyRD5Kdeirv56mz5AZprTt
         ckSmdrpfvwJezstAig+NJKBxBlEANBT48Rzx68soAundDrQ3ld8zbKYjdqlS+4L6vw0P
         htmdw8Qmm9UxoAi6uGWAnUDGxnFHpINeh2wvCq39BrUb2/+8WyuEioiR+3uh6psHK8Be
         By477LdveO6TfB0Lsck0aroucBA0GvEAsJlci17ny0EoZN4vVSMGKBWrmnmEObI3W9g0
         I+H8IVTwiW+40dkzrJKPCRPP2IfTsTx+rSDzdyNt+JsWBji027UPNX30zJfUbT8qqPN/
         /yZg==
X-Gm-Message-State: ABuFfohcskpd6MMSpkaSTHTYWyS2TMV6tfkvFTnThNPRNybhd5MUAmYx
        fPh/bdB9ilcmhW3WOuuiKOQId+N413sf0Xfblu+8jg==
X-Google-Smtp-Source: ACcGV62ntiJXSd/VaXRBG/Em0cTl02LUqa8ra7hVg48cGgxtY378DCK+GeaAJu4mqsJ+JFy+qm5HcS2rHj333mgxmec=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr13617334otf.242.1538995861373;
 Mon, 08 Oct 2018 03:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180929103453.12025-1-cyphar@cyphar.com> <20180929131534.24472-1-cyphar@cyphar.com>
 <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com>
 <20181004162611.vdlujbdguvagalpt@ryuk> <CAG48ez2u--Wac7d9n3idC92Pd-M40QzYtR6FKR8PAYr=VQHUBQ@mail.gmail.com>
 <20181005150728.mgqnpkbukpeu3bsm@ryuk> <CAG48ez3FG0axt92F=+vDe1Q=kj-YngmCgFqDET7E2xCE1mOgeg@mail.gmail.com>
 <20181006021002.6vzsdwd3klddbmji@ryuk>
In-Reply-To: <20181006021002.6vzsdwd3klddbmji@ryuk>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 8 Oct 2018 12:50:34 +0200
Message-ID: <CAG48ez3M84-iL7_9__G81L+16K1eT3j-=QTjL_kVy6BC6sYZzQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path resolution
To:     cyphar@cyphar.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 4:10 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2018-10-05, Jann Horn <jannh@google.com> wrote:
> > > What if we took rename_lock (call it nd->r_seq) at the start of the
> > > resolution, and then only tried the __d_path-style check
> > >
> > >   if (read_seqretry(&rename_lock, nd->r_seq) ||
> > >       read_seqretry(&mount_lock, nd->m_seq))
> > >           /* do the __d_path lookup. */
> > >
> > > That way you would only hit the slow path if there were concurrent
> > > renames or mounts *and* you are doing a path resolution with
> > > AT_THIS_ROOT or AT_BENEATH. I've attached a modified patch that does
> > > this (and after some testing it also appears to work).
> >
> > Yeah, I think that might do the job.
>
> *phew* I was all out of other ideas. :P
>
> > > ---
> > >  fs/namei.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 46 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 6f995e6de6b1..12c9be175cb4 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -493,7 +493,7 @@ struct nameidata {
> > >         struct path     root;
> > >         struct inode    *inode; /* path.dentry.d_inode */
> > >         unsigned int    flags;
> > > -       unsigned        seq, m_seq;
> > > +       unsigned        seq, m_seq, r_seq;
> > >         int             last_type;
> > >         unsigned        depth;
> > >         int             total_link_count;
> > > @@ -1375,6 +1375,27 @@ static int follow_dotdot_rcu(struct nameidata *nd)
> > >                                 return -EXDEV;
> > >                         break;
> > >                 }
> > > +               if (unlikely((nd->flags & (LOOKUP_BENEATH | LOOKUP_CHROOT)) &&
> > > +                            (read_seqretry(&rename_lock, nd->r_seq) ||
> > > +                             read_seqretry(&mount_lock, nd->m_seq)))) {
> > > +                       char *pathbuf, *pathptr;
> > > +
> > > +                       nd->r_seq = read_seqbegin(&rename_lock);
> > > +                       /* Cannot take m_seq here. */
> > > +
> > > +                       pathbuf = kmalloc(PATH_MAX, GFP_ATOMIC);
> > > +                       if (!pathbuf)
> > > +                               return -ECHILD;
> > > +                       pathptr = __d_path(&nd->path, &nd->root, pathbuf, PATH_MAX);
> > > +                       kfree(pathbuf);
> >
> > You're doing this check before actually looking up the parent, right?
> > So as long as I don't trigger the "path_equal(&nd->path, &nd->root)"
> > check that you do for O_BENEATH, escaping up by one level is possible,
> > right? You should probably move this check so that it happens after
> > following "..".
>
> Yup, you're right. I'll do that.
>
> > (Also: I assume that you're going to get rid of that memory allocation
> > in a future version.)
>
> Sure. Would you prefer adding some scratch space in nameidata, or that I
> change __d_path so it accepts NULL as the buffer (and thus it doesn't
> actually do any string operations)?

Well, I think accepting a NULL buffer would be much cleaner; but keep
in mind that I'm just someone making suggestions, Al Viro is the one
who has to like your code. :P

> > >                 if (nd->path.dentry != nd->path.mnt->mnt_root) {
> > >                         int ret = path_parent_directory(&nd->path);
> > >                         if (ret)
> > > @@ -2269,6 +2311,9 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
> > >         nd->last_type = LAST_ROOT; /* if there are only slashes... */
> > >         nd->flags = flags | LOOKUP_JUMPED | LOOKUP_PARENT;
> > >         nd->depth = 0;
> > > +       nd->m_seq = read_seqbegin(&mount_lock);
> > > +       nd->r_seq = read_seqbegin(&rename_lock);
> >
> > This means that now, attempting to perform a lookup while something is
> > holding the rename_lock will spin on the lock. I don't know whether
> > that's a problem in practice though. Does anyone on this thread know
> > whether this is problematic?
>
> I could make it so that we only take &rename_lock
>   if (nd->flags & (FOLLOW_BENEATH | FOLLOW_CHROOT)),
> since it's not used outside of that path.

I think that might be a sensible change; but as I said, I don't
actually know whether it's necessary, and it would be very helpful if
someone who actually knows commented on this.
