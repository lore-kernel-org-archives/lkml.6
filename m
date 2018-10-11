Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F6AC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4155A2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="JePUwiNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4155A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJLG1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:27:53 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:55408 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbeJLG1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:27:53 -0400
Date:   Thu, 11 Oct 2018 22:58:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1539298704;
        bh=U7vuDGTuuk6QB8i/MHG2kvDaaLJRTJOLm+wp1OfFL+M=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=JePUwiNaUoigfu0R+NY1YSP39lkZOyqlIY3fuYbf+z1htt+48ZqV9cEeX1rdFUpp0
         KWls9jg7vTRLEThkkKn+zkc5dKkSRyjOSc/YXsFUJ3QK+tCfqI7xH//xmuNWHaJ9W9
         OrkGhX2e0iw2pf04igOGGtGca+OfzrBphk2a1xJo=
To:     Kees Cook <keescook@chromium.org>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
Message-ID: <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
In-Reply-To: <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
References: <20181011001846.30964-1-keescook@chromium.org>
 <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, October 11, 2018 7:57 PM, Kees Cook <keescook@chromium.org> wr=
ote:

> On Wed, Oct 10, 2018 at 5:18 PM, Kees Cook keescook@chromium.org wrote:
>
> > v5:
> >
> > -   redesigned to use CONFIG_LSM=3D and lsm=3D for both ordering and en=
abling
> > -   dropped various Reviewed-bys due to rather large refactoring
>
> Here's a tl;dr of the behavioral changes...
>
> Right now, we have:
>
> -   hard-coded special LSM: capability which cannot be disabled.
> -   hard-coded "minor" LSMs: they are enabled in a static order based on
>     whether they are built into the kernel or not: yama, loadpin.
>
> -   a single LSM without a specified order because it only uses the
>     early-init position: integrity.
>
> -   "major" LSMs that are selected via CONFIG_DEFAULT_SECURITY=3D or
>     "security=3D" boot param.
>
> -   SELinux and AppArmor each can enable/disable themselves via
>     CONFIG_..._BOOTPARAM_VALUE=3D and selinux=3D/apparmor=3D.
>
>     So, right now, systems will have all the minor LSMs and integrity
>     initialized if they are built into the kernel without any way to
>     control their order or disable them at boot time. To select a major
>     LSM, the pattern is:
>
>     selinux=3D1 security=3Dselinux
>
>     Note that both are used here because if you built with
>     CONFIG_SELINUX_BOOTPARAM_VALUE=3D0 and CONFIG_DEFAULT_SECURITY=3Dappa=
rmor,
>     just booting with "security=3Dselinux" just disables AppArmor but
>     SELinux stays disabled. So the documented way to switch majors is wit=
h
>     "selinux=3D1 security=3Dselinux". However Tomoyo and Smack do not hav=
e
>     separate enable/disable logic. They will work fine with just
>     "security=3Dsmack".
>
>     Now, in order to gain arbitrary LSM ordering, this series introduces
>     CONFIG_LSM=3D (to replace CONFIG_DEFAULT_SECURITY=3D) and "lsm=3D" (t=
o
>     replace "security=3D"). Note that "security=3D" has not been removed =
-- it
>     will still work. Mixing it with "lsm=3D" can lead to situations where
>     "security=3D" becomes effectively ignored, though.
>
>     In the rest of this I'm going to ignore capability: it will always be
>     first and it will always be enabled.
>
>     Assuming that all LSMs are built in (e.g. yama, loadpin, selinux,
>     smack, tomoyo, apparmor, integrity), here are the changes:
>
>     To choose the "default major LSM" of AppArmor before:
>     CONFIG_DEFAULT_SECURITY=3Dapparmor
>
>     To choose the "default major LSM" of AppArmor without extreme stackin=
g now:
>     CONFIG_LSM=3Dyama,loadpin,integrity,apparmor
>
>     To choose the "default major LSM" of AppArmor with future extreme sta=
cking now:
>     CONFIG_LSM=3Dyama,loadpin,integrity,apparmor,tomoyo,selinux,smack
>
>     Whichever exclusive LSM is listed first will be the first to attempt
>     initialization. Any non-conflicting LSMs following it will initialize
>     too.
>
>     This means a distro can disable the "blob-sharing" behavior by just
>     providing a CONFIG_LSM=3D that includes a single major LSM.
>
>     To switch to SELinux at boot time with
>     "CONFIG_LSM=3Dyama,loadpin,integrity,apparmor", the old way continues=
 to
>     work:
>
>     selinux=3D1 security=3Dselinux
>
>     This will work still, since it will enable selinux (selinux=3D1) and
>     disable all other major LSMs (security=3Dselinux).
>
>     The new way to enable selinux would be using
>     "lsm=3Dyama,loadpin,integrity,selinux".
>

It seems to me that legacy way is more user friendly than the new one.
AppArmor and SElinux are households names but the rest may be enigmatic
for most users and the need for explicit passing them all may be
troublesome. Especially when the new ones like sara,landlock or cows :)
will be incoming. Moreover to knew what you have to pass there, you need
to look at CONFIG_LSM in kernel config (which will vary across distros
and also mean copy-paste from the web source may won't work as expected)
which again most users don't do.

I think there is risk that users will end up with "lsm=3Dselinux" without
realizing that they may disable something along the way.

I would prefer for "lsm=3D" to work as override to "CONFIG_LSM=3D" with
below assumptions:

I. lsm=3D"$lsm" will append "$lsm" at the end of string. Before extreme
stacking it will also remove the other major (explicit) lsm from it.

II. lsm=3D"!$lsm" will remove "$lsm" from the string.

III. If "$lsm" already exist in the string, it's moved at the end of it
(this will cover ordering).

Examples:

1. Without extreme stacking.

a) Enable selinux, disable apparmor and leave the rest untouched.

CONFIG_LSM=3Dyama,loadpin,integrity,apparmor && lsm=3Dselinux =3D yama,load=
pin,integrity,selinux

b) Enable selinux, disable apparmor and disable loadpin.

CONFIG_LSM=3Dyama,loadpin,integrity,apparmor && lsm=3Dselinux,!loadpin =3D =
yama,integrity,selinux


2. With extreme stacking.

a) Enable selinux, disable apparmor and leave the rest untouched.

CONFIG_LSM=3Dyama,loadpin,integrity,apparmor && lsm=3Dselinux,!apparmor =3D=
 yama,loadpin,integrity,selinux

b) Enable selinux, disable apparmor and disable loadpin.

CONFIG_LSM=3Dyama,loadpin,integrity,apparmor && lsm=3Dselinux,!apparmor,!lo=
adpin =3D yama,integrity,selinux

c) Enable selinux and order it after apparmor.

CONFIG_LSM=3Dyama,loadpin,integrity,apparmor && lsm=3Dselinux =3D yama,load=
pin,integrity,apparmor,selinux

d) Enable selinux and order it before apparmor.

CONFIG_LSM=3Dyama,loadpin,integrity,apparmor && lsm=3Dselinux,apparmor =3D =
yama,loadpin,integrity,selinux,apparmor


IMO above will be easier to handle for users. At worst case with
full ordering all existing lsm's it will look the same as what
Kees proposes but I assume that ordering is rather for more
advanced people.

It's possible that something lime this was discussed already
but without full examples it was hard to me for tracking things.

Jordan
