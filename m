Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F43FC677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D72021470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MjNWm/BI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D72021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJLBZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:25:57 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43341 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeJLBZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:25:56 -0400
Received: by mail-yw1-f66.google.com with SMTP id j75-v6so3928795ywj.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7XpdVd9yaWqxN3q4iZjDNpEN2Jt6xA4e1XAH5S9vBsk=;
        b=MjNWm/BIPZIewSM8hnbIw2eE0ORnTDRuXgPmUACDM+YhdYt4Rl+YFD2mcJhqSM/KCw
         3COI3U2T2InyASRyjrLkxy84P82z96V6ipys/qdYZiYDY/QHWEsy0qGcjYH6j45tw5aX
         5T1x3iwQTOZ8IhNkwg1SuhjBGwThjyq/aThiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7XpdVd9yaWqxN3q4iZjDNpEN2Jt6xA4e1XAH5S9vBsk=;
        b=tkooAGYazvH62TSzJEggrBDZl1/uUd7nahjXGlRxvYYdekFejvGhDNmY0lm8ZF4b+N
         UYIguWUSsw5jlc5brFj4HsdP5hCXqeBev4B3IsKzfE2C3zJff50SPo2zA7MdXkjt4OvP
         ZqO1TioXr4keh64jI2hpbL7AGnU6avwBdRxwc3oceJPHe00/9TVb6uMQRJikA9Ti/2o8
         fxR0POf69GpW6TNEVg8tKpRIcZlSEaYXRuaD8h0EryXPEVItkSTiWhJO09SQ5z08t0yE
         f3Ixwr6QpMlPyPScHvaQ5feNf/xnJRw75P5ekcqpohvvcUHkqHWHxMl9NfWf8SUmkiYu
         pvKw==
X-Gm-Message-State: ABuFfohkWUG4g/Czl4CFMuXKCr3yz7P/qv+UErfmycNyHYTWtRbB+3Vm
        8FvvZQYMJ2UnyQUgbVE74vPecze0mMc=
X-Google-Smtp-Source: ACcGV60sWJPUydOXzekCRdvsYnigcXvQjMk7b19KJAFgW3cEFlVS7UIJP9aL8Wj75wWJdP+KuFDTLw==
X-Received: by 2002:a81:450b:: with SMTP id s11-v6mr1529629ywa.148.1539280657646;
        Thu, 11 Oct 2018 10:57:37 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u79-v6sm16889799ywe.110.2018.10.11.10.57.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 10:57:36 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id p74-v6so3940428ybc.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 10:57:35 -0700 (PDT)
X-Received: by 2002:a25:3617:: with SMTP id d23-v6mr1530175yba.141.1539280655226;
 Thu, 11 Oct 2018 10:57:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 10:57:33
 -0700 (PDT)
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Oct 2018 10:57:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
Message-ID: <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 5:18 PM, Kees Cook <keescook@chromium.org> wrote:
> v5:
> - redesigned to use CONFIG_LSM= and lsm= for both ordering and enabling
> - dropped various Reviewed-bys due to rather large refactoring

Here's a tl;dr of the behavioral changes...

Right now, we have:

- hard-coded special LSM: capability which cannot be disabled.
- hard-coded "minor" LSMs: they are enabled in a static order based on
whether they are built into the kernel or not: yama, loadpin.
- a single LSM without a specified order because it only uses the
early-init position: integrity.
- "major" LSMs that are selected via CONFIG_DEFAULT_SECURITY= or
"security=" boot param.
- SELinux and AppArmor each can enable/disable themselves via
CONFIG_..._BOOTPARAM_VALUE= and selinux=/apparmor=.

So, right now, systems will have all the minor LSMs and integrity
initialized if they are built into the kernel without any way to
control their order or disable them at boot time. To select a major
LSM, the pattern is:

selinux=1 security=selinux

Note that both are used here because if you built with
CONFIG_SELINUX_BOOTPARAM_VALUE=0 and CONFIG_DEFAULT_SECURITY=apparmor,
just booting with "security=selinux" just disables AppArmor but
SELinux stays disabled. So the documented way to switch majors is with
"selinux=1 security=selinux". *However* Tomoyo and Smack do not have
separate enable/disable logic. They will work fine with just
"security=smack".

Now, in order to gain arbitrary LSM ordering, this series introduces
CONFIG_LSM= (to replace CONFIG_DEFAULT_SECURITY=) and "lsm=" (to
replace "security="). Note that "security=" has not been removed -- it
will still work. Mixing it with "lsm=" can lead to situations where
"security=" becomes effectively ignored, though.

In the rest of this I'm going to ignore capability: it will always be
first and it will always be enabled.

Assuming that all LSMs are built in (e.g. yama, loadpin, selinux,
smack, tomoyo, apparmor, integrity), here are the changes:

To choose the "default major LSM" of AppArmor before:
CONFIG_DEFAULT_SECURITY=apparmor

To choose the "default major LSM" of AppArmor _without_ extreme stacking now:
CONFIG_LSM=yama,loadpin,integrity,apparmor

To choose the "default major LSM" of AppArmor with future extreme stacking now:
CONFIG_LSM=yama,loadpin,integrity,apparmor,tomoyo,selinux,smack

Whichever exclusive LSM is listed _first_ will be the first to attempt
initialization. Any non-conflicting LSMs following it will initialize
too.

This means a distro can disable the "blob-sharing" behavior by just
providing a CONFIG_LSM= that includes a single major LSM.

To switch to SELinux at boot time with
"CONFIG_LSM=yama,loadpin,integrity,apparmor", the old way continues to
work:

selinux=1 security=selinux

This will work still, since it will enable selinux (selinux=1) and
disable all other major LSMs (security=selinux).

The new way to enable selinux would be using
"lsm=yama,loadpin,integrity,selinux".

To see the behaviors, you can boot with "lsm.debug". (Note that
CONFIG_LSM= and "lsm=" are handled exactly the same, so a boot with
"lsm=" would see the same results as a boot without "lsm=", but with
CONFIG_LSM= set to that string.) An example:

lsm.debug lsm=integrity,cows,loadpin,capability,apparmor,tomoyo
selinux=1 security=selinux

produces:

[    0.292502] LSM: Security Framework initializing
[    0.293109] LSM: security=selinux disabled: smack
[    0.293464] LSM: security=selinux disabled: tomoyo
[    0.294464] LSM: security=selinux disabled: apparmor
[    0.295109] LSM: first ordering: capability (enabled)
[    0.295464] LSM: cmdline ordering: integrity (enabled)
[    0.296464] LSM: cmdline ignored: cows
[    0.296953] LSM: cmdline ordering: loadpin (enabled)
[    0.297464] LSM: cmdline ignored: capability
[    0.298464] LSM: cmdline ordering: apparmor (disabled)
[    0.299136] LSM: cmdline ordering: tomoyo (disabled)
[    0.299464] LSM: security= ordering: selinux (enabled)
[    0.300464] LSM: cmdline disabled: smack
[    0.300979] LSM: cmdline disabled: yama
[    0.301464] LSM: exclusive chosen: selinux
[    0.302008] LSM: initializing capability
[    0.302464] LSM: initializing integrity
[    0.302968] LSM: initializing loadpin
[    0.303464] LoadPin: ready to pin (currently not enforcing)
[    0.304464] LSM: initializing selinux
[    0.304946] SELinux:  Initializing.

With yama left out of lsm=, it is disabled. Invalid,
non-mutable-order, or unbuilt LSMs are ignored (i.e. "cows" and
"capability" above). "security=selinux" disables all the other majors
(their ordering is left alone) and things not mentioned in lsm= and[1]
security= are explicitly disabled (and left out of the ordering).

Another example, without "security="...

lsm.debug lsm=integrity,yama,cows,loadpin,capability,apparmor,tomoyo,selinux,smack

[    0.291697] LSM: Security Framework initializing
[    0.292660] LSM: first ordering: capability (enabled)
[    0.293337] LSM: cmdline ordering: integrity (enabled)
[    0.293659] LSM: cmdline ordering: yama (enabled)
[    0.294659] LSM: cmdline ignored: cows
[    0.295169] LSM: cmdline ordering: loadpin (enabled)
[    0.295659] LSM: cmdline ignored: capability
[    0.296231] LSM: cmdline ordering: apparmor (enabled)
[    0.296659] LSM: cmdline ordering: tomoyo (enabled)
[    0.297659] LSM: cmdline ordering: selinux (enabled)
[    0.298659] LSM: cmdline ordering: smack (enabled)
[    0.299309] LSM: exclusive chosen: apparmor
[    0.299659] LSM: exclusive disabled: tomoyo
[    0.300216] LSM: exclusive disabled: selinux
[    0.300659] LSM: exclusive disabled: smack
[    0.301208] LSM: initializing capability
[    0.301659] LSM: initializing integrity
[    0.302662] LSM: initializing yama
[    0.303124] Yama: becoming mindful.
[    0.303666] LSM: initializing loadpin
[    0.304164] LoadPin: ready to pin (currently not enforcing)
[    0.304660] LSM: initializing apparmor
[    0.305179] AppArmor: AppArmor initialized

Given that apparmor is listed first, its exclusivity disables the
other exclusive LSMs, and initialization proceeds.

So, this should work for all the cases we've got coming, as far as I can see! :)

-Kees

[1] In testing v5, I did discover one glitch in my "security="
handling, which I've fixed locally now for v6.

-- 
Kees Cook
Pixel Security
