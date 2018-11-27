Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936A2C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65234208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65234208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeK1Atm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:49:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41792 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeK1Atm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:49:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so20128813otk.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 05:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hi9iX299DQInLmJAtW0O641VhL4ev2inw/6dRwxQFJs=;
        b=AWSZPcZyaHBaNGwILCBSWAV6yYNPc2udlvGdHIWJEyeaKSXJE2nJtll5bgBi7NGrrN
         j7f0kYQ9UnWyqd1EkLkSZ2YNsP6kNa2RuZ0FiyJQco94smCqdOgAkUjrY110UbVyid+n
         trqCePPpW9UuUAgHu2TJeEcE1EljFakrLyDsIUVpfSq3bKaOF3/IacSThv4NoyDg4IQM
         Z7VceINl8GTeHOsPR0KUWN259PbI+nVOij3VLC2ytvBS+oloIWe3E1+trpTkL9YJJdDU
         tLTX0pTQBg0/MZCcX4hLq/J9/E36XMFqs1m/QX8Ob4Kize5XgCRZEtVOEJ99FHkBUhZ2
         0+Jg==
X-Gm-Message-State: AA+aEWawIiGwoqKowOKVj5QNl9UH+x4O4/g/U7DZLKKiXnGTts5GTvJt
        F46jorbCvrh6H74WOqGLpjUtQhlAB/uhvoOnQUkjDw==
X-Google-Smtp-Source: AFSGD/UDcoixmjnUyxh5EzfsBxtQ71PdZ8mHdE7/ClPe90U6fIFnE6upOU7KnluvdE5WW5BhrW/bDS1IUOKpe3OgPdM=
X-Received: by 2002:a9d:32c7:: with SMTP id u65mr17415964otb.236.1543326702007;
 Tue, 27 Nov 2018 05:51:42 -0800 (PST)
MIME-Version: 1.0
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
 <ecb10f5c-7bbd-fb2e-4148-63290bc9a7ff@schaufler-ca.com> <CAGXu5jJxjJoQmdsjy18z6N0fcSfpNTx60YnRESbOToHQG_2mdQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJxjJoQmdsjy18z6N0fcSfpNTx60YnRESbOToHQG_2mdQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 27 Nov 2018 14:51:30 +0100
Message-ID: <CAFqZXNvcYWNh2fmgY7wF8QOmRBfhaqqYAKG1kYFDcn496ah26Q@mail.gmail.com>
Subject: Re: [PATCH v5 01/38] LSM: Introduce LSM_FLAG_LEGACY_MAJOR
To:     keescook@chromium.org
Cc:     casey@schaufler-ca.com, s.mesoraca16@gmail.com,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        mic@digikod.net,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 2:27 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Nov 26, 2018 at 3:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Hmmm... the "From: Kees..." in the body is missing. Are you using "git
> send-email"?

Not to mention that you are sending (only) to the old SELinux mailing
list. The new list is at selinux@vger.kernel.org, see:

https://lore.kernel.org/selinux/8263f9fa-16f1-1d0a-e391-61d609e50d7d@tycho.nsa.gov/

>
> >
> > This adds a flag for the current "major" LSMs to distinguish them when
> > we have a universal method for ordering all LSMs. It's called "legacy"
> > since the distinction of "major" will go away in the blob-sharing world.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > ---
> >  include/linux/lsm_hooks.h  | 3 +++
> >  security/apparmor/lsm.c    | 1 +
> >  security/selinux/hooks.c   | 1 +
> >  security/smack/smack_lsm.c | 1 +
> >  security/tomoyo/tomoyo.c   | 1 +
> >  5 files changed, 7 insertions(+)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index aaeb7fa24dc4..63c0e102de20 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -2039,8 +2039,11 @@ extern char *lsm_names;
> >  extern void security_add_hooks(struct security_hook_list *hooks, int count,
> >                                 char *lsm);
> >
> > +#define LSM_FLAG_LEGACY_MAJOR  BIT(0)
> > +
> >  struct lsm_info {
> >         const char *name;       /* Required. */
> > +       unsigned long flags;    /* Optional: flags describing LSM */
> >         int (*init)(void);      /* Required. */
> >  };
> >
> > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > index 42446a216f3b..2edd35ca5044 100644
> > --- a/security/apparmor/lsm.c
> > +++ b/security/apparmor/lsm.c
> > @@ -1728,5 +1728,6 @@ static int __init apparmor_init(void)
> >
> >  DEFINE_LSM(apparmor) = {
> >         .name = "apparmor",
> > +       .flags = LSM_FLAG_LEGACY_MAJOR,
> >         .init = apparmor_init,
> >  };
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7ce683259357..56c6f1849c80 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -7209,6 +7209,7 @@ void selinux_complete_init(void)
> >     all processes and objects when they are created. */
> >  DEFINE_LSM(selinux) = {
> >         .name = "selinux",
> > +       .flags = LSM_FLAG_LEGACY_MAJOR,
> >         .init = selinux_init,
> >  };
> >
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index 81fb4c1631e9..3639e55b1f4b 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -4891,5 +4891,6 @@ static __init int smack_init(void)
> >   */
> >  DEFINE_LSM(smack) = {
> >         .name = "smack",
> > +       .flags = LSM_FLAG_LEGACY_MAJOR,
> >         .init = smack_init,
> >  };
> > diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> > index 1b5b5097efd7..09f7af130d3a 100644
> > --- a/security/tomoyo/tomoyo.c
> > +++ b/security/tomoyo/tomoyo.c
> > @@ -552,5 +552,6 @@ static int __init tomoyo_init(void)
> >
> >  DEFINE_LSM(tomoyo) = {
> >         .name = "tomoyo",
> > +       .flags = LSM_FLAG_LEGACY_MAJOR,
> >         .init = tomoyo_init,
> >  };
> > --
> > 2.14.5
> >
> >
>
>
> --
> Kees Cook
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
