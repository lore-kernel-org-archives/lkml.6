Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5031C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CED620861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OqKxiKNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CED620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeINESG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 00:18:06 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42242 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeINESF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 00:18:05 -0400
Received: by mail-yb1-f195.google.com with SMTP id j8-v6so4008535ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KZXyikcutpT5p88IsEoShpQCbRxdRRD1SOXBLkD82i8=;
        b=OqKxiKNFhuEOJ1IjKSXSo79mcr7HwQbAGiaNchTb67/X8y1Ocri7//TSx1y3Az4VfI
         9UPjbr2ARywPXF67htBluN+4SMBkyonpdkgubbN5ezEMx2hyB8Lq1MkEKvYYXL300XIY
         fI2BK9ZV2iq4wqtjwWWMNtbtk1aC+Gi/cJfZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KZXyikcutpT5p88IsEoShpQCbRxdRRD1SOXBLkD82i8=;
        b=Gy2PnzDpFvUqzXyh2qkE6Di6lMz8U64vSP68RnkAmkYyMUngIVYyeYvpwDu/Pnkbo/
         TmO0tLZFWOias43X4sYTeaqDtOHOSmD4vAdSYlbwA7cID/nU8vkQMyIuftt8Fb+Ni3GQ
         fxf0cVDfMtIAAJ/sxtQ6ZeCtLvklGESBvVLL95zaGMw9RRMG2r4B4jSTvpoxSGWpRHJ7
         4CiGh17PMZyDChJlO41ZS0uTLYZcVd7w3KVZmCs1GDvOHKEyvIa+QOF5FSa/3tnr7wlw
         IoHJfGX+ttqmg+1dPQsheAncbyMLZAHsyMczqI8Wid9xkApvXlDEDr2jxJ+uo7eUCmwu
         tYWg==
X-Gm-Message-State: APzg51D7TOMquZuuI1TpgiV1Sgpl/q/3xQWYPlbwDOTpO6TfL0QNx2z7
        x7bu3A/sc3sWJPzVWyJEdpiNKmK1VeI=
X-Google-Smtp-Source: ANB0VdZe4cUMsFmsxi6kxGl9KTwLrsMFRs7C7gEfyPYpXBI6QSKPCMI39dPozXf/T+XjWqiyfno6EA==
X-Received: by 2002:a25:db83:: with SMTP id g125-v6mr4658575ybf.412.1536879989038;
        Thu, 13 Sep 2018 16:06:29 -0700 (PDT)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id f5-v6sm2976428ywa.39.2018.09.13.16.06.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 16:06:27 -0700 (PDT)
Received: by mail-yw1-f54.google.com with SMTP id l9-v6so1888854ywc.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 16:06:27 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr4684650ywr.168.1536879986953;
 Thu, 13 Sep 2018 16:06:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 16:06:25
 -0700 (PDT)
In-Reply-To: <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com> <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 16:06:25 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
Message-ID: <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
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

On Thu, Sep 13, 2018 at 2:51 PM, Kees Cook <keescook@chromium.org> wrote:
> At the very least, to avoid stacking now (i.e. TOMOYO being enabled
> with another major LSM), we just do nothing. The existing code already
> makes the existing major LSMs exclusive. Adding a stackable LSM would
> need to just have its own "enable" flag (i.e. ignore
> security_module_enable()), and then either check a runtime "is
> stacking allowed?" flag or have new "depends on SECURITY_STACKING". (I
> think the CONFIG will force distros into enabling it without any
> runtime opt-out.)

Before stacking, we have:

- major LSM, pick one
- all CONFIG minor LSMs, in security.c order

There are two minor LSMs: Yama and LoadPin. If built, Yama is always
on (though it has sysctl knobs). If built, LoadPin is controlled by a
boot param.

Picking the major LSM happens via "security=$LSM" and a per-LSM check
of security_module_enable("$LSM").

Ordering is major, then per security.c for minors.


Under stacking, we have:

The minor LSMs remain unchanged.

We don't have SARA and Landlock yet, but we do have TOMOYO, which we
can use as an example to future "compatible blob-using LSMs".

I see two issues:

- how to determine which set of LSMs are enabled at boot
- how to determine the ORDER of the LSMs


Casey's implementation does this (correct me if I'm wrong):

The minor LSMs remain unchanged.

SECURITY_$lsm_STACKED determines which major is enabled, with
SECURITY_TOMOYO_STACKED allowed in addition. If security= is
specified, all other major LSMs are disabled (i.e. it is not possible
to switch between SELinux/AppArmor/SMACK without also disabling
TOMOYO).

Ordering is per security/Makefile modulo enabled-ness for majors (i.e.
TOMOYO is always _before_ AppArmor if stacked together, otherwise
after SELinux and SMACK), and per security.c for minors.


I don't think this is how we want it to work. For example, Ubuntu
builds in all LSMs, and default-enables AppArmor. If an Ubuntu user
wants TOMOYO, the boot with "security=tomoyo". If Ubuntu wants to make
stacking available to users but off by default, what CONFIGs do they
pick? They could try SECURITY_APPARMOR_STACKED=y and
SECURITY_TOMOYO_STACKED=n, but then how does an end user choose
"apparmor and tomoyo" (or more meaningfully, for the future:
"apparmor, sara, and landlock")? They can still pick
"security=tomoyo", but there isn't a runtime way to opt into stacking.


What about leaving SECURITY_$lsm_DEFAULT as-is, and then...

In the past I'd suggested using "security=" to determine both enabled
and order: "security=tomoyo,smack" would mean stacked LSMs, with
tomoyo going first.

Currently I'm leaning towards "security=" to select ONLY the
incompatible LSM, and per-LSM "enable" flags to determine stacking:

    tomoyo.enabled=1 security=smack

This doesn't explicitly address ordering, though. If we made param
_position_ meaningful, then we could get ordering (i.e. above would
mean "tomoyo first").

Note, ordering matters because call_int_hook() will _stop_ on a
non-zero return value: potentially hiding events from later LSMs. Do
we need to revisit this? I seem to remember if being a very dead
horse, and we needed to quick-abort otherwise we ended up in
nonsensical states.

The reason for the new approach is because I can't find a meaningful
way to provide CONFIGs that make sense. We want to provide a few
things:

- is an LSM built into the kernel at all? (CONFIG_SECURITY_$lsm)
- is an LSM enabled by default? (CONFIG_SECURITY_$lsm_ENABLED?)
- has an LSM been enable for this boot? $lsm.enabled=1 or security=$lsm,$lsm ?
- what order should any stacking happen? Makefile? security=?

And for the incompatible-major, do we stick with CONFIG_SECURITY_$lsm_DEFAULT ?



Anyway, if the concern is with exposed behavior for distros, what do
we want? i.e. what should be done for patch 10. Everything else looks
good.

-Kees

-- 
Kees Cook
Pixel Security
