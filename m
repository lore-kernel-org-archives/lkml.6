Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D31BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAD1213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c0Ff/dGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAD1213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeJDAQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:16:02 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33618 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDAQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:16:01 -0400
Received: by mail-yw1-f68.google.com with SMTP id m127-v6so2624993ywb.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pgagTJS+/zh6aAZZxcRs0vqo7FGylJqShjBmA4Pw+9E=;
        b=c0Ff/dGUIIowPk+JxYLnn8oOKC+ep2diKty9/lSpYwvFzBDsyvOyvcAsDcnhzxAHQe
         1uKIl+v22OAy605FeiVBZ+AK3ZMFheACzKYtRM/hyHEuZ01LX9WPOHCfigfAz0FOmRZV
         rPTu84GMskeVHyGvuIuSmnOJ+peco3/YpbVlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pgagTJS+/zh6aAZZxcRs0vqo7FGylJqShjBmA4Pw+9E=;
        b=O/JFi6YaMy/yiUAo5E7yMwLF4EzfHFmBNfAd65wecY0u1D6x9CuOFGsnsjCYZZ3FR9
         Y/89rzRrZCAzNhPM68ZZDmg9qc07rHt6OxX8jIVP8/5TSVGTgu9Rx2yHJBT+SwmhEnZv
         PRLSjaF0Muwb15sEKQ5+UlgcHOIo5Exe9N4IaY6A3glJXpkAVpP5Oh9Hb/nLAsCOjINb
         EYrJ+tI4mJYZ3xO1cPpF+vpl2pcpGgA68I45Qm44vIKsX0e11kAPr+EVsZIPUDCnBFPd
         tzWJoH5ya7BhfJkb/wWKGIzB2LKVBvz52KoFvF8PRCYZUoc8GKxcXQjb8Wm1K1EsS4q2
         TUmA==
X-Gm-Message-State: ABuFfoh2mggmyCWJTJxaiTByzlHpJi+UrKA2S9EP3CN9owA5QQKOs+uU
        rTeMoShhCXCOJJxoxvLuIgZNn7e1yBw=
X-Google-Smtp-Source: ACcGV60wFKl4033k7g0RMMNATvy4hXMYYYbHRXlKeHNcmq6bNcqjdMEnEhpMLCNcWJp8piM5Lj1wJw==
X-Received: by 2002:a81:4b17:: with SMTP id y23-v6mr1565724ywa.198.1538587600564;
        Wed, 03 Oct 2018 10:26:40 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id o128-v6sm637349ywe.110.2018.10.03.10.26.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:26:38 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id v198-v6so2601873ywg.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:26:37 -0700 (PDT)
X-Received: by 2002:a81:2908:: with SMTP id p8-v6mr1539629ywp.407.1538587597054;
 Wed, 03 Oct 2018 10:26:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 3 Oct 2018 10:26:36 -0700 (PDT)
In-Reply-To: <583a703e-18af-a1b2-dfc9-62a2a3384825@tycho.nsa.gov>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <CAGXu5jKqSZ5LhQ_HwbA9-_DAg3efNzWfLjpxO_rurBgUZ-nnAA@mail.gmail.com>
 <583a703e-18af-a1b2-dfc9-62a2a3384825@tycho.nsa.gov>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 3 Oct 2018 10:26:36 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLmQQd4e=B3YsiEoRVih2m889ia2tnzu5r8bqcms2sOqQ@mail.gmail.com>
Message-ID: <CAGXu5jLmQQd4e=B3YsiEoRVih2m889ia2tnzu5r8bqcms2sOqQ@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 6:39 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/02/2018 07:54 PM, Kees Cook wrote:
>>
>> On Tue, Oct 2, 2018 at 4:46 PM, John Johansen
>> <john.johansen@canonical.com> wrote:
>>>
>>> On 10/02/2018 04:06 PM, Kees Cook wrote:
>>>>
>>>> I think the current proposal (in the other thread) is likely the
>>>> sanest approach:
>>>>
>>>> - Drop CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE
>>>> - Drop CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE
>>>> - All enabled LSMs are listed at build-time in CONFIG_LSM_ENABLE
>>>
>>>
>>> Hrrmmm isn't this a Kconfig selectable list, with each built-in LSM
>>> available to be enabled by default at boot.
>>
>>
>> That's not how I have it currently. It's a comma-separated a string,
>> including the reserved name "all". The default would just be
>> "CONFIG_LSM_ENABLE=all". Casey and I wanted this to have a way to
>> capture new LSMs by default at build-time.
>>
>>>> - Boot time enabling for selinux= and apparmor= remain
>>>> - lsm.enable= is explicit: overrides above and omissions are disabled
>>>
>>> wfm
>>
>>
>> Okay, this is closer to v3 than v4. Paul or Stephen, how do you feel
>> about losing the SELinux bootparam CONFIG? (i.e. CONFIG_LSM_ENABLE
>> would be replacing its functionality.)
>
>
> I'd like to know how distro kernel maintainers feel about it. They would
> need to understand that if they were previously setting
> CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE to 0 and want to preserve that
> behavior, then they must set CONFIG_LSM_ENABLE explicitly to a list of
> security modules (that does not include selinux, of course).  In practice,

That's not how it would be done. See below...

> this means that even the distros that choose to build all security modules
> into their kernels must explicitly set CONFIG_LSM_ENABLE to a specific list
> of security modules.  So no one would use "all" in practice.

This is why I had originally wanted to do CONFIG_LSM_DISABLE. Right
now, distro kernel maintainers have two ways to trigger enablement:
via the SELinux and AppArmor BOOTPARAM_VALUE _and_ DEFAULT_SECURITY
(which is an implicit "enable" for Smack or TOMOYO). All the minors
are on-if-built. So, really, the BOOTPARAM_VALUEs were only used for
disabling. Distros would build what they wanted, then use
DEFAULT_SECURITY for their desired major, and if their
DEFAULT_SECURITY wasn't SELinux or AppArmor, they'd _also_ have to set
those BOOTPARAM_VALUEs to 0.

The goal of the series is to split this more cleanly between "enable"
and "order": the way to handle the LSMs is to enable _everything_ and
then set the desired init order: the first exclusive "wins". So I *do*
think the default would be CONFIG_LSM_ENALBE=all, since it's
CONFIG_LSM_ORDER= that effectively replaces CONFIG_DEFAULT_SECURITY.

Either a distro builds a very specific subset of LSMs, or they build
in all LSMs (for the user to choose from). In both cases, they set an
explicit order, which defines which exclusive LSM get selected.

AppArmor wants to drop BOOTPARAM_VALUE, which make sense, since it's
even now redundant to CONFIG_DEFAULT_SECURITY. I think it makes sense
to drop SELinux's BOOTPARAM_VALUE too. The current way to "enable" a
major LSM is via CONFIG_DEFAULT_SECURITY. No sane distro kernel is
going to set CONFIG_DEFAULT_SECURITY=selinux and
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0. If you wanted no major LSM
(but still build them all in), you'd set CONFIG_DEFAULT_SECURITY="".

-Kees

-- 
Kees Cook
Pixel Security
