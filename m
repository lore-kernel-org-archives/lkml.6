Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6156C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C07520C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="QHwkaOi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C07520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeINCku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:40:50 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:56759 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeINCkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:40:49 -0400
X-Greylist: delayed 1204 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2018 22:40:47 EDT
Date:   Thu, 13 Sep 2018 20:58:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1536872333;
        bh=2/+yzY/AigedO3JyQu0VEQlEWnCilg6zgOoI+6HuRuQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=QHwkaOi0Ee7Osa9Rbc2Dwg8zpSjMzuHPCb4Q7//Rbip2o+ZhcMsxdiLlnfuZNuyJw
         gumtjhiyqYA0kHEMfeYrgr4NTKz/OwcndCq7A+duFVjNJDytHiT3Fknq9vPC/xlTU9
         WhaCPjvMnElnTjV//v1Bhrqx0ddvYS3YMNKpzhvA=
To:     Paul Moore <paul@paul-moore.com>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "penguin-kernel@i-love.sakura.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "casey.schaufler@intel.com" <casey.schaufler@intel.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
Message-ID: <tb3zfQ7fac9Oth8YArOo84SbMfqV1s0DjOmVy7op90J_o1XOaEjflZloOpj9PIiUQRhKJxhauXzJD3irkSSjOXK94qYlfQ1frIQiH1OTWPQ=@protonmail.ch>
In-Reply-To: <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 13, 2018 9:12 PM, Paul Moore <paul@paul-moore.com> w=
rote:

> On Thu, Sep 13, 2018 at 11:19 AM Kees Cook keescook@chromium.org wrote:
>
> > On Thu, Sep 13, 2018 at 6:16 AM, Paul Moore paul@paul-moore.com wrote:
> >
> > > On Thu, Sep 13, 2018 at 12:19 AM Kees Cook keescook@chromium.org wrot=
e:
> > >
> > > > On Tue, Sep 11, 2018 at 9:42 AM, Casey Schaufler casey@schaufler-ca=
.com wrote:
> > > >
> > > > > Two proposed security modules require the ability to
> > > > > share security blobs with existing "major" security modules.
> > > > > These modules, S.A.R.A and LandLock, provide significantly
> > > > > different services than SELinux, Smack or AppArmor. Using
> > > > > either in conjunction with the existing modules is quite
> > > > > reasonable. S.A.R.A requires access to the cred blob, while
> > > > > LandLock uses the cred, file and inode blobs.
> > > > > The use of the cred, file and inode blobs has been
> > > > > abstracted in preceding patches in the series. This
> > > > > patch teaches the affected security modules how to access
> > > > > the part of the blob set aside for their use in the case
> > > > > where blobs are shared. The configuration option
> > > > > CONFIG_SECURITY_STACKING identifies systems where the
> > > > > blobs may be shared.
> > > > > The mechanism for selecting which security modules are
> > > > > active has been changed to allow non-conflicting "major"
> > > > > security modules to be used together. At this time the
> > > > > TOMOYO module can safely be used with any of the others.
> > > > > The two new modules would be non-conflicting as well.
> > > > >
> > > > > Signed-off-by: Casey Schaufler casey@schaufler-ca.com
> > > > >
> > > > > ------------------------------------------------------
> > > > >
> > > > > Documentation/admin-guide/LSM/index.rst | 14 +++--
> > > > > include/linux/lsm_hooks.h | 2 +-
> > > > > security/Kconfig | 81 +++++++++++++++++++++++++
> > > > > security/apparmor/include/cred.h | 8 +++
> > > > > security/apparmor/include/file.h | 9 ++-
> > > > > security/apparmor/include/lib.h | 4 ++
> > > > > security/apparmor/lsm.c | 8 ++-
> > > > > security/security.c | 30 ++++++++-
> > > > > security/selinux/hooks.c | 3 +-
> > > > > security/selinux/include/objsec.h | 18 +++++-
> > > > > security/smack/smack.h | 19 +++++-
> > > > > security/smack/smack_lsm.c | 17 +++---
> > > > > security/tomoyo/common.h | 12 +++-
> > > > > security/tomoyo/tomoyo.c | 3 +-
> > > > > 14 files changed, 200 insertions(+), 28 deletions(-)
> > >
> > > ...
> > >
> > > > > diff --git a/security/Kconfig b/security/Kconfig
> > > > > index 22f7664c4977..ed48025ae9e0 100644
> > > > > --- a/security/Kconfig
> > > > > +++ b/security/Kconfig
> > > > > @@ -36,6 +36,28 @@ config SECURITY_WRITABLE_HOOKS
> > > > > bool
> > > > > default n
> > > > > +config SECURITY_STACKING
> > > > >
> > > > > -         bool "Security module stacking"
> > > > >
> > > > >
> > > > > -         depends on SECURITY
> > > > >
> > > > >
> > > > > -         help
> > > > >
> > > > >
> > > > > -           Allows multiple major security modules to be stacked.
> > > > >
> > > > >
> > > > > -           Modules are invoked in the order registered with a
> > > > >
> > > > >
> > > > > -           "bail on fail" policy, in which the infrastructure
> > > > >
> > > > >
> > > > > -           will stop processing once a denial is detected. Not
> > > > >
> > > > >
> > > > > -           all modules can be stacked. SELinux, Smack and AppArm=
or are
> > > > >
> > > > >
> > > > > -           known to be incompatible. User space components may
> > > > >
> > > > >
> > > > > -           have trouble identifying the security module providin=
g
> > > > >
> > > > >
> > > > > -           data in some cases.
> > > > >
> > > > >
> > > > > -
> > > > > -           If you select this option you will have to select whi=
ch
> > > > >
> > > > >
> > > > > -           of the stackable modules you wish to be active. The
> > > > >
> > > > >
> > > > > -           "Default security module" will be ignored. The boot l=
ine
> > > > >
> > > > >
> > > > > -           "security=3D" option can be used to specify that one =
of
> > > > >
> > > > >
> > > > > -           the modules identifed for stacking should be used ins=
tead
> > > > >
> > > > >
> > > > > -           of the entire stack.
> > > > >
> > > > >
> > > > > -
> > > > > -           If you are unsure how to answer this question, answer=
 N.
> > > > >
> > > > >
> > > >
> > > > I don't see a good reason to make this a config. Why shouldn't this
> > > > always be enabled?
> > >
> > > I do. From a user perspective it is sometimes difficult to determine
> > > the reason behind a failed operation; its is a DAC based denial, the
> > > LSM, or some other failure? Stacking additional LSMs has the
> > > potential to make this worse. The boot time configuration adds to the
> > > complexity.
> >
> > Let me try to convince you otherwise. :) The reason I think there's no
> > need for this is because the only functional change here is how
> > TOMOYO gets stacked. And in my proposal, we can convert TOMOYO to be
> > enabled/disabled like LoadPin. Given the configs I showed, stacking
> > TOMOYO with the other major LSMs becomes a config (and/or boottime)
> > option.
> > The changes for TOMOYO are still needed even with SECURITY_STACKING,
> > and I argue that the other major LSMs remain the same. It's only
> > infrastructure that has changed. So, I think having SECURITY_STACKING
> > actually makes things more complex internally (all the ifdefs, weird
> > enable logic) and for distros ("what's this stacking option", etc?)
>
> None of the above deals with the user experience or support burden a
> distro would have by forcing stacking on. If we make it an option the
> distros can choose for themselves; picking a kernel build config is
> not something new to distros, and I think Casey's text adequately
> explains CONFIG_SECURITY_STACKING in terms that would be sufficient.

CONFIG_SECURITY_STACKING doesn't make any user visible changes on
itself as it doesn't automatically enable any new LSM. The LSM
specific configs are place where users/distros make decisions. If
there is only one LSM enabled to run then there's nothing to stack.
If someone choose to run two or more LSM in config/boot cmdline
then we can assume having it stacked is what they wanted. As Kees
pointed there is already CONFIG_SECURITY_DEFAULT_XXX. In both cases
CONFIG_SECURITY_STACKING is redundant and only adds burden instead
of removing it.

> I currently have a neutral stance on stacking, making it mandatory
> pushes me more towards a "no".
>

This implies that your real concern is something else than
CONFIG_SECURITY_STACKING which only allows you to ignore the whole
thing. Please reveal it. There are a lot of people waiting for LSM
stacking which is several years late and it would be great to
resolve potential issues earlier  rather later.

> As far as the cpp ifdef's, and other conditionals are concerned, I
> remain unconvinced this is any worse than any other significant
> feature that is a build time option.
>
> paul moore

Jordan
