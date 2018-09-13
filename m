Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55581C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76842083A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="p9RuFnKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76842083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeINDP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:15:58 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:22107 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeINDP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:15:58 -0400
Date:   Thu, 13 Sep 2018 22:04:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1536876270;
        bh=aIyewBJ4JzI6xf/1pAdmGjC4qH8QtDuMPSwd+5P/vYg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=p9RuFnKMr5ZzNOzQ2UpO1Mf09ZBdHUnRSRi/dcnaDyG7W+UwWeAY54RY7t4d08/8t
         B29KDpft0Mz7qG8n1BsMrfk26b6M9dAKVnTbllVHk/WbMnzBJYi2zGgYLOD+acjVdZ
         kskv5ex7CFJQ2Z28GviwTQdX7r9JjdI0lUbZ18H0=
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
Message-ID: <REFI4ukAP8BSR0O11mS48hqeVoRMcx5EV3w-qUTXdanAqKjBQUvo6ygSjRkWkgY7EdAFfAJRUFpY61MdAOdjq4vLxdDDUGKfeiMrxnOuTIU=@protonmail.ch>
In-Reply-To: <CAHC9VhR0qfTn3qwVGpBV=LcM8O1jz-dmqxTW0OqJ-xfO+1k6ew@mail.gmail.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <tb3zfQ7fac9Oth8YArOo84SbMfqV1s0DjOmVy7op90J_o1XOaEjflZloOpj9PIiUQRhKJxhauXzJD3irkSSjOXK94qYlfQ1frIQiH1OTWPQ=@protonmail.ch>
 <CAHC9VhR0qfTn3qwVGpBV=LcM8O1jz-dmqxTW0OqJ-xfO+1k6ew@mail.gmail.com>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 13, 2018 11:50 PM, Paul Moore <paul@paul-moore.com> =
wrote:

> On Thu, Sep 13, 2018 at 4:58 PM Jordan Glover
> Golden_Miller83@protonmail.ch wrote:
>
> > On Thursday, September 13, 2018 9:12 PM, Paul Moore paul@paul-moore.com=
 wrote:
> >
> > > On Thu, Sep 13, 2018 at 11:19 AM Kees Cook keescook@chromium.org wrot=
e:
> > >
> > > > On Thu, Sep 13, 2018 at 6:16 AM, Paul Moore paul@paul-moore.com wro=
te:
> > > >
> > > > > On Thu, Sep 13, 2018 at 12:19 AM Kees Cook keescook@chromium.org =
wrote:
>
> ...
>
> > > > > > I don't see a good reason to make this a config. Why shouldn't =
this
> > > > > > always be enabled?
> > > > >
> > > > > I do. From a user perspective it is sometimes difficult to determ=
ine
> > > > > the reason behind a failed operation; its is a DAC based denial, =
the
> > > > > LSM, or some other failure? Stacking additional LSMs has the
> > > > > potential to make this worse. The boot time configuration adds to=
 the
> > > > > complexity.
> > > >
> > > > Let me try to convince you otherwise. :) The reason I think there's=
 no
> > > > need for this is because the only functional change here is how
> > > > TOMOYO gets stacked. And in my proposal, we can convert TOMOYO to b=
e
> > > > enabled/disabled like LoadPin. Given the configs I showed, stacking
> > > > TOMOYO with the other major LSMs becomes a config (and/or boottime)
> > > > option.
> > > > The changes for TOMOYO are still needed even with SECURITY_STACKING=
,
> > > > and I argue that the other major LSMs remain the same. It's only
> > > > infrastructure that has changed. So, I think having SECURITY_STACKI=
NG
> > > > actually makes things more complex internally (all the ifdefs, weir=
d
> > > > enable logic) and for distros ("what's this stacking option", etc?)
> > >
> > > None of the above deals with the user experience or support burden a
> > > distro would have by forcing stacking on. If we make it an option the
> > > distros can choose for themselves; picking a kernel build config is
> > > not something new to distros, and I think Casey's text adequately
> > > explains CONFIG_SECURITY_STACKING in terms that would be sufficient.
> >
> > CONFIG_SECURITY_STACKING doesn't make any user visible changes on
> > itself as it doesn't automatically enable any new LSM. The LSM
> > specific configs are place where users/distros make decisions. If
> > there is only one LSM enabled to run then there's nothing to stack.
> > If someone choose to run two or more LSM in config/boot cmdline
> > then we can assume having it stacked is what they wanted. As Kees
> > pointed there is already CONFIG_SECURITY_DEFAULT_XXX. In both cases
> > CONFIG_SECURITY_STACKING is redundant and only adds burden instead
> > of removing it.
>
> See my last response to Kees.
>
> > > I currently have a neutral stance on stacking, making it mandatory
> > > pushes me more towards a "no".
> >
> > This implies that your real concern is something else than
> > CONFIG_SECURITY_STACKING which only allows you to ignore the whole
> > thing. Please reveal it. There are a lot of people waiting for LSM
> > stacking which is several years late and it would be great to
> > resolve potential issues earlier rather later.
>
> What? I resent the implication that I'm hiding anything; there are a
> lot of fair criticisms you could level at me, but I take offense at
> the idea that I'm not being honest here. I've been speaking with
> Casey, John, and others about stacking for years, both on-list and
> in-person at conferences, and my
> neutral-opinion-just-make-it-work-for-everything-and-make-it-optional
> stance has been pretty consistent and isn't new.
>
> Also, let's be really clear here: I'm only asking that stacking be
> made a build time option (as it is in Casey's patchset). That seems
> like a pretty modest ask for something so significant and "several
> years late" as you put it.
>
> paul moore

Fair enough. I apologize then.

Jordan
