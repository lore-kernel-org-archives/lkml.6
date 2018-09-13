Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6396BC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27652147C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n3ect4Dh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27652147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeINCNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:13:04 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36084 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeINCNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:13:04 -0400
Received: by mail-yb1-f195.google.com with SMTP id d34-v6so3898465yba.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V93sSpgUrom8pF7o+5J1HdUbIMKj2Y26fPjs3mm8DsA=;
        b=n3ect4DhMwJYK3sqHzHBBG2MS+PPGYlA2oN/hwg9Lc16xALqtpB//mW+ZCYbUyhL8I
         PxxoVyJJ/c5S4Fk5O+3eMgZCGSiP//00y4vlMes93sFXmTZQtV9wMqhD2zFXxlcBT56Y
         pQF2KjJ7rM/94nVpNUSppfp90VXGRzijIR8rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V93sSpgUrom8pF7o+5J1HdUbIMKj2Y26fPjs3mm8DsA=;
        b=ayH+Mqf96OGsiQBy8IU3vXuOIaFBCBskcy/IruzHQCEENDB1bMNr/iAGKTXOWdq41m
         XipoD5JdS0csUup/1O3Sz78Zp1Sk3CAEtpZlB2zae83K1PwsbVGObFVQF8e5JBhlWU34
         +qUDgdcRo/bBvOZViHihA64eFtpQuF56VKwl3nVW98nC8mDxAIMgp+ZmzxUTpUhAvCOC
         k+Lb9yUumITvnPK3t18rW2itG6sLSPc9J2yjkoeenSU/ZPnev4Fa67jqNb/gEST9FOjT
         vvD1SNM/MbBGQUH7uNIHW1uUBs6wDAL+TXpGlGC07eJDmjOtiUnPwnPNdhFFzt6PSp4I
         1M3w==
X-Gm-Message-State: APzg51CcJbN+/ivHXy/TSAJb7xPgbnb+wUlxChUbcEAqX7rDnbrkhj5g
        KmSLGUGpWzOa2MOo7F4tzQIJmZQmE/c=
X-Google-Smtp-Source: ANB0VdYVai5t3x2vVdKv5evMBmnn9PUO1dJTjMwwfj9RDHOCiuj45+UpdRbxq/bZsbki21S0n5t43g==
X-Received: by 2002:a25:1207:: with SMTP id 7-v6mr4311843ybs.470.1536872511245;
        Thu, 13 Sep 2018 14:01:51 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id i123-v6sm6396390ywe.14.2018.09.13.14.01.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 14:01:49 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id w184-v6so1469240ybe.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:01:49 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr4386801ybz.410.1536872509237;
 Thu, 13 Sep 2018 14:01:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 14:01:48
 -0700 (PDT)
In-Reply-To: <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com> <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 14:01:48 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
Message-ID: <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 12:12 PM, Paul Moore <paul@paul-moore.com> wrote:
> None of the above deals with the user experience or support burden a
> distro would have by forcing stacking on.  If we make it an option the

Just to make sure we're clear here: this series does not provide
"extreme" stacking: SELinux, AppArmor, and SMACK remain boot-exclusive
no matter what the CONFIGs.

> distros can choose for themselves; picking a kernel build config is
> not something new to distros, and I think Casey's text adequately
> explains CONFIG_SECURITY_STACKING in terms that would be sufficient.

I absolutely want stacking to be configurable, but I want to point out
that there is no operational difference between
CONFIG_SECURITY_STACKING=n and CONFIG_SECURITY_STACKING=y in the code
here:

- all the new accessor and allocation code is exercised in both cases

- with stacking enabled: selinux, apparmor, and smack have an offset
of 0 into blobs (and only one can be enabled at a time)

- with stacking disabled: selinux, apparmor, and smack have an offset
of 0 into blobs (and only one can be enabled at a time)

The only behavioral difference is TOMOYO:

1- with stacking disabled and TOMOYO as the only major LSM, it will
have a 0 offset into blobs (like above)

2- with stacking enabled and TOMOYO as the only major LSM, it will
have a 0 offset into blobs (like above)

3- with stacking disabled and another major LSM is enabled, TOMOYO
will be disabled (like always)

4- with stacking enabled and another major LSM is enabled, TOMOYO will
have a non-0 offset into blobs and will run after selinux or smack or
run before apparmor (based on link ordering defined by the Makefile).

Note that cases 1, 2, and 3 are identical in behavior to before this
series. Only case 4 is different, which is why I'm saying that instead
of creating a redundant and needlessly complex config, or reinventing
the "enable" wheel, we should simply drop the no-op
CONFIG_SECURITY_STACKING config and provide TOMOYO with an "enable"
parameter (and CONFIG). And it should be _separate_ from the
"security=" line.

This will be the SAME outcome for distros: if they want stacking, they
choose the "enable TOMOYO by default" CONFIG. If they don't want
stacking, they don't.

> I currently have a neutral stance on stacking, making it mandatory
> pushes me more towards a "no".

This is why I'm trying to explain myself: the infrastructure proposed
here is always exercised, no matter the CONFIG. From that sense it is
"mandatory" no matter what the config is. There isn't a reality where
you could "turn off stacking", because it's not stacking until you
actually stack something, and that will be disabled by default as I've
proposed it.

Let me put this another way: if we simply leave off patch 10, we can
take the other 9 patches (modulo feedback), and we only have to decide
how to expose "stacking"; all the infrastructure work for supporting
it is done.

I'm arguing that "security=" is likely insufficient to describe what
we want, and instead we should focus on individual LSM enablement via
parameters ("tomoyo.enabled=1"). If _ordering_ becomes an issue, we
could either use parameter order, or use "security=" again maybe, but
for now, ordering is already defined by the Makefile (and
security/security.c).

"Stacking" only exists if you try to enable one of [selinux, apparmor,
or smack] AND tomoyo. CONFIG_SECURITY_STACKING is redundant: if you
want to disable stacking, you just disable tomoyo if you have another
LSM (which we can already enforce in the Kconfig).

If you want something more explicit than per-LSM config, then a simple
"security.lsm_stack=1/0" with a CONFIG for the default would be fine.
I'm trying to argue against what appears to be needless complexity
around CONFIG_SECURITY_STACK as it was proposed, since it doesn't
provide a meaningful operational change, since exclusivity of major
LSMs is already handled.

> As far as the cpp ifdef's, and other conditionals are concerned, I
> remain unconvinced this is any worse than any other significant
> feature that is a build time option.

That's fine. That's just a code style issue. What I'm trying to show
is that by lifting the allocation logic up out of the LSMs, we've
actually simplified the logic. The "stacking" part will only become a
distro-choice once they knowingly enable TOMOYO or build in SARA
and/or Landlock in the future.

-Kees

-- 
Kees Cook
Pixel Security
