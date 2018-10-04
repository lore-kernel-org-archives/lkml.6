Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444F4C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126772083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126772083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJEAoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:44:25 -0400
Received: from namei.org ([65.99.196.166]:35682 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbeJEAoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:44:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w94HnEtf015791;
        Thu, 4 Oct 2018 17:49:14 GMT
Date:   Fri, 5 Oct 2018 03:49:14 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     John Johansen <john.johansen@canonical.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
In-Reply-To: <CAGXu5jJDBhFrdCBHH4MZVDmG88mMxSaSx0w9anCcyx24YHLO5w@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1810050338470.14095@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com> <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com> <alpine.LRH.2.21.1810030758460.23596@namei.org>
 <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com> <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org> <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com> <alpine.LRH.2.21.1810040723320.16168@namei.org> <CAGXu5jJDBhFrdCBHH4MZVDmG88mMxSaSx0w9anCcyx24YHLO5w@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018, Kees Cook wrote:

> On Wed, Oct 3, 2018 at 2:34 PM, James Morris <jmorris@namei.org> wrote:
> > On Wed, 3 Oct 2018, Kees Cook wrote:
> >
> >   - All LSMs which are built are NOT enabled by default
> >
> >   - You specify enablement and order via a Kconfig:
> >
> >         CONFIG_LSM="selinux,yama"
> >
> >   - This can be entirely overridden by a boot param:
> >
> >         lsm="apparmor,landlock"
> 
> This doesn't work with how SELinux and AppArmor do their bootparams,
> unfortunately. (And Paul and Stephen have expressed that the
> documented selinux on/off must continue to work.) For example, let's
> say you've built an Ubuntu kernel with:
> 
> CONFIG_SELINUX=y
> ...
> CONFIG_LSM="yama,apparmor"
> 
> (i.e. you want SELinux available, but not enabled, so it's left out of
> CONFIG_LSM)
> 
> Then someone boots the system with:
> 
> selinux=1 security=selinux
> 
> In what order does selinux get initialized relative to yama?
> (apparmor, flagged as a "legacy major", would have been disabled by
> the "security=" not matching it.)

It doesn't, it needs to be specified in one place.

Distros will need to update boot parameter handling for this kernel 
onwards.  Otherwise, we will need to carry this confusing mess forward 
forever.

> The LSM order needs to be defined externally to enablement because 
> something may become enabled when not listed in the order.
> 
> Now, maybe I misunderstood your earlier suggestion, and what you meant
> was to do something like:
> 
> CONFIG_LSM="yama,apparmor,!selinux"
> 
> to mean "put selinux here in the order, but don't enable it". Then the
> problem becomes what happens to an LSM that has been built in but not
> listed in CONFIG_LSM?

In my most recent suggestion, there is no '!' disablement, just 
enablement.  If an LSM is not listed in CONFIG_LSM="", it's not enabled.

> Related to that, this means that when new LSMs are added, they will
> need to be added to any custom CONFIG_LSM= or lsm= parameters. If
> that's really how we have to go, I'll accept it, but I think it's a
> bit unfriendly. :P

If you want to enable them, yes.  How is this different to adding new 
mount options as new fs features become available?


> Another reason I don't like it is because it requires users to know
> about all the LSMs to make changes. One LSM can't be added/removed
> without specifying ALL of the LSMs. (i.e. there is no trivial way to
> enable/disable a single LSM without it growing its own enable/disable
> code as in SELinux/AppArmor. I'd hoped to make that easier for both
> users and developers.) Again, I can live with it, but I think it's
> unfriendly.

This is only done via boot params or KConfig.

-- 
James Morris
<jmorris@namei.org>

