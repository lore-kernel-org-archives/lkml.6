Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2222FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6989206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MV5PCDTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6989206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeIMU3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:29:07 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36028 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeIMU3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:29:06 -0400
Received: by mail-yb1-f196.google.com with SMTP id d34-v6so3420856yba.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M5Jg/Qhzc0aGKKcGeHxmxtY1xacHr03aCdjtwbbGfeE=;
        b=MV5PCDTNE4agm8NwnAwDMLhyiGitpsaw5RfFHoi0Q3QJczqEkh1OteN2DEk9T1/BdP
         59vDznoYIDPgbMgCyStZe4pLHlSGbZrPJLPRTRpq383rg8tBqT3z5to9sB/ebGSL+3Fy
         Q7Z+H1VqNDmEKD9y9HtQFK17IPAjh3CtVxh00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M5Jg/Qhzc0aGKKcGeHxmxtY1xacHr03aCdjtwbbGfeE=;
        b=I//NofVdhjkkzich33px3J6SVHzujaO0A8bkD7BMIuYiC0+uKkhVnn9s6yJNVHHIVh
         Kg0M1ohLuUAW+4vZJEEyQSK48FQ0L37a3o5TnpU/fKHm8kV1nJqSo+GHqNMmbkUHVLxG
         ILKcjjz2nbG9L4AlZDr5+cPFFNuHYIof9fo95VGjZ7Ja06W9V3HvPRS26L4NIvj2Gu0D
         zrxdt4I/Pe+/TxmItdGr7kN7S3CoQfK8mK5SFRPElbAsyRyXbJ3o8+DhQ4FhAjOwduMO
         uPrxLJDi3b2IpQ6KU37EeFdwQTFchMGHq66c4/CmMZKD9iYS5UwcK2qg0sMs1l5aQ3Va
         cxpg==
X-Gm-Message-State: APzg51C2YF/FNWo2X7BTXzGhKGXM3+3aiIxquS669bSoHOJVF35ZlYs8
        BfsZozrTWgOcS0sCmvnVuyxRCFFpzIU=
X-Google-Smtp-Source: ANB0VdbIEOeZoYwiifdDEHxxtUYXxl+PEF8Xxi9GnfwSfqfgyHAaLvmojMfVKRl/kjYn9NFGmKdIoQ==
X-Received: by 2002:a25:b0d:: with SMTP id 13-v6mr3664802ybl.322.1536851948210;
        Thu, 13 Sep 2018 08:19:08 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id v11-v6sm1429999ywb.13.2018.09.13.08.19.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 08:19:05 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y20-v6so3388904ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 08:19:05 -0700 (PDT)
X-Received: by 2002:a25:f606:: with SMTP id t6-v6mr3786461ybd.141.1536851944587;
 Thu, 13 Sep 2018 08:19:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 08:19:03
 -0700 (PDT)
In-Reply-To: <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 08:19:03 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
Message-ID: <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
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

On Thu, Sep 13, 2018 at 6:16 AM, Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Sep 13, 2018 at 12:19 AM Kees Cook <keescook@chromium.org> wrote:
>> On Tue, Sep 11, 2018 at 9:42 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> > Two proposed security modules require the ability to
>> > share security blobs with existing "major" security modules.
>> > These modules, S.A.R.A and LandLock, provide significantly
>> > different services than SELinux, Smack or AppArmor. Using
>> > either in conjunction with the existing modules is quite
>> > reasonable. S.A.R.A requires access to the cred blob, while
>> > LandLock uses the cred, file and inode blobs.
>> >
>> > The use of the cred, file and inode blobs has been
>> > abstracted in preceding patches in the series. This
>> > patch teaches the affected security modules how to access
>> > the part of the blob set aside for their use in the case
>> > where blobs are shared. The configuration option
>> > CONFIG_SECURITY_STACKING identifies systems where the
>> > blobs may be shared.
>> >
>> > The mechanism for selecting which security modules are
>> > active has been changed to allow non-conflicting "major"
>> > security modules to be used together. At this time the
>> > TOMOYO module can safely be used with any of the others.
>> > The two new modules would be non-conflicting as well.
>> >
>> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> > ---
>> >  Documentation/admin-guide/LSM/index.rst | 14 +++--
>> >  include/linux/lsm_hooks.h               |  2 +-
>> >  security/Kconfig                        | 81 +++++++++++++++++++++++++
>> >  security/apparmor/include/cred.h        |  8 +++
>> >  security/apparmor/include/file.h        |  9 ++-
>> >  security/apparmor/include/lib.h         |  4 ++
>> >  security/apparmor/lsm.c                 |  8 ++-
>> >  security/security.c                     | 30 ++++++++-
>> >  security/selinux/hooks.c                |  3 +-
>> >  security/selinux/include/objsec.h       | 18 +++++-
>> >  security/smack/smack.h                  | 19 +++++-
>> >  security/smack/smack_lsm.c              | 17 +++---
>> >  security/tomoyo/common.h                | 12 +++-
>> >  security/tomoyo/tomoyo.c                |  3 +-
>> >  14 files changed, 200 insertions(+), 28 deletions(-)
>
> ...
>
>> > diff --git a/security/Kconfig b/security/Kconfig
>> > index 22f7664c4977..ed48025ae9e0 100644
>> > --- a/security/Kconfig
>> > +++ b/security/Kconfig
>> > @@ -36,6 +36,28 @@ config SECURITY_WRITABLE_HOOKS
>> >         bool
>> >         default n
>> >
>> > +config SECURITY_STACKING
>> > +       bool "Security module stacking"
>> > +       depends on SECURITY
>> > +       help
>> > +         Allows multiple major security modules to be stacked.
>> > +         Modules are invoked in the order registered with a
>> > +         "bail on fail" policy, in which the infrastructure
>> > +         will stop processing once a denial is detected. Not
>> > +         all modules can be stacked. SELinux, Smack and AppArmor are
>> > +         known to be incompatible. User space components may
>> > +         have trouble identifying the security module providing
>> > +         data in some cases.
>> > +
>> > +         If you select this option you will have to select which
>> > +         of the stackable modules you wish to be active. The
>> > +         "Default security module" will be ignored. The boot line
>> > +         "security=" option can be used to specify that one of
>> > +         the modules identifed for stacking should be used instead
>> > +         of the entire stack.
>> > +
>> > +         If you are unsure how to answer this question, answer N.
>>
>> I don't see a good reason to make this a config. Why shouldn't this
>> always be enabled?
>
> I do.  From a user perspective it is sometimes difficult to determine
> the reason behind a failed operation; its is a DAC based denial, the
> LSM, or some other failure?  Stacking additional LSMs has the
> potential to make this worse.  The boot time configuration adds to the
> complexity.

Let me try to convince you otherwise. :) The reason I think there's no
need for this is because the only functional change here is how
_TOMOYO_ gets stacked. And in my proposal, we can convert TOMOYO to be
enabled/disabled like LoadPin. Given the configs I showed, stacking
TOMOYO with the other major LSMs becomes a config (and/or boottime)
option.

The changes for TOMOYO are still needed even _with_ SECURITY_STACKING,
and I argue that the other major LSMs remain the same. It's only
infrastructure that has changed. So, I think having SECURITY_STACKING
actually makes things more complex internally (all the ifdefs, weird
enable logic) and for distros ("what's this stacking option", etc?)

> I think we should leave this decision to the individual distros so
> that they can make their own decision on LSM stacking based on the
> savviness of their user base and the quality of their support
> infrastructure.

If we reach the "extreme" stacking case, then yes, I want to make sure
we've got something that makes sense. But this first step doesn't get
us there, so I'd prefer we avoid making it overly complex. I think
everything else in this series _reduces_ complexity, except for this
new config.

-Kees

-- 
Kees Cook
Pixel Security
