Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E247C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20922218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546983726;
	bh=Tt5dLTfoKIPvnQLUC84Ckku7x0LmX6mOXSAysyhimZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j66s62RxcuJyNto/0JVtq//emILlXtgkoo7+2AJTsEq4LpsoxNV6UZAqcsnZFOSNB
	 zUvdi4luMK2Ywsht8qHb5qT0l2qgH+W1CzRkL8140T55B7GK8VBlCys7vxgQ0dmIFf
	 Jm832ea6JrfUQX8qrSDd8o69/xddxZxv6YoDsUrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfAHVmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730077AbfAHVmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:42:02 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E3EB218AE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jan 2019 21:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546983721;
        bh=Tt5dLTfoKIPvnQLUC84Ckku7x0LmX6mOXSAysyhimZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=12YMcK24EZqhbRf1OQQBhrp8hVlVxjS2BuEC3DWf3CZQZDVFBH5rO8FMNvLL/Z83B
         C44nztXYdbz99N/tzRoUQQVMUlc1kTTi9P4FATZKEA08Ixhl+3Z/S5V3/ReoqhRkD/
         Q9xddJS5PheMH8LNIwEdhENmfBxtsBv75mXUTjZ0=
Received: by mail-wr1-f43.google.com with SMTP id q18so5568409wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 13:42:01 -0800 (PST)
X-Gm-Message-State: AJcUuketQg+c8hY50Cnzbq31qldx8avwGzt+WEq1ihLlmBSyKJ3ksKIe
        CBUZ1DmP1fTnmmw/4PrUFRhaPFV6pGkxGmn1XTTi2A==
X-Google-Smtp-Source: ALg8bN61E48Bn5bB2aWvjorke6ZhoDEavbWGw15AeYlpbgLK/qzlkNJuuT69mODMvNsMeVaAPaHj+yfQUz5cToPs4OI=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr2586807wro.77.1546983719572;
 Tue, 08 Jan 2019 13:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20190103143227.9138-1-jlee@suse.com> <20190106181026.GA15256@amd> <20190107173743.GC4210@linux-l9pv.suse>
In-Reply-To: <20190107173743.GC4210@linux-l9pv.suse>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 8 Jan 2019 13:41:48 -0800
X-Gmail-Original-Message-ID: <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
Message-ID: <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
To:     joeyli <jlee@suse.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 7, 2019, at 9:37 AM, joeyli <jlee@suse.com> wrote:
>
> Hi Pavel,
>
> Thanks for your review!
>
>> On Sun, Jan 06, 2019 at 07:10:27PM +0100, Pavel Machek wrote:
>> Hi!
>>
>>> This patchset is the implementation of encryption and authentication
>>> for hibernate snapshot image. The image will be encrypted by AES and
>>> authenticated by HMAC.
>>
>> Ok, so you encrypt.
>
> Yes, encryption and authentication.
>
>>> The hibernate function can be used to snapshot memory pages to an image=
,
>>> then kernel restores the image to memory space in a appropriate time.
>>> There have secrets in snapshot image and cracker may modifies it for
>>> hacking system. Encryption and authentication of snapshot image can pro=
tect
>>> the system.
>>>
>>> Hibernate function requests the master key through key retention servic=
e.
>>> The snapshot master key can be a trusted key or a user defined key. The
>>> name of snapshot master key is fixed to "swsusp-kmk". User should loads
>>> swsusp-kmk to kernel by keyctl tool before the hibernation resume.
>>> e.g. The swsusp-kmk must be loaded before systemd-hibernate-resume
>>
>> But if userspace has a key, encryption is useless against root.
>
> Yes, but this concern is not only for hibernation encryption. This patch
> set does not provide solution against this concern.
>
> The purpose of this patch set is to encrypt and authenticate hibernate
> snapshot image in kernel space. It also requests key through keyring
> mechanism. Which means that we can easy to adapt to new key type from
> keyring in the future.
>
> Currently TPM trusted key or user defined key types are not against
> root. Even using the TPM trusted key, it still can be unsealed by root
> before the PCRs be capped (unless we capped PCRs in kernel).
>
> My solution for keeping the secret by kernel is the EFI secure key type:
>    https://lkml.org/lkml/2018/8/5/31
>
> But the EFI boot variable doesn't design for keeping secret, so Windows
> and OEM/ODM do not use boot variable to keep secret. So this idea can
> not be accepted. We must think other key type against root.
>
>>> The TPM trusted key type is preferred to be the master key. But user
>>> defined key can also be used for testing or when the platform doesn't
>>> have TPM. User must be aware that the security of user key relies on
>>> user space. If the root account be compromised, then the user key will
>>> easy to be grabbed.
>>
>> In the TPM case, does userland have access to the key?
>
> In the TPM case, userland can only touch the sealed key blob. So userland
> doesn't know the real secret. But it has risk that root unseals the key
> before PCRs be capped.
>
>> Please explain your security goals.
>
> My security goals:
>
> - Encrypt and authicate hibernate snapshot image in kernel space. Userspa=
ce
>  can only touch an encrypted and signed snapshot image.

Signed?

I=E2=80=99m not entirely convinced that the keyring mechanism is what you
want. ISTM that there are two goals here:

a) Encryption: it should be as hard as can reasonably be arranged to
extract secrets from a hibernation image.

b) Authentication part 1: it should not be possible for someone in
possession of a turned-off machine to tamper with the hibernation
image such that the image, when booted, will leak its secrets. This
should protect against attackers who don=E2=80=99t know the encryption key.

c) Authentication part 2: it should be to verify, to the extent
practical, that the image came from the same machine and was really
created using hibernation.  Or maybe by the same user.

For (a) and (b), using an AE mode where the key is protected in some
reasonable way.  Joey, why are you using HMAC?  Please tell me you=E2=80=99=
re
at least doing encrypt-then-MAC.  But why not use a real AE mode like
AES-GCM?


I reviewed the code a bit.  Here are some thoughts:

You have some really weird crypto. You=E2=80=99re using an insanely long ke=
y
(512 bits, I think, although you=E2=80=99ve used some bizarre indirection).
You=E2=80=99re explicitly checking that it=E2=80=99s not zero, and I don=E2=
=80=99t see why.

Why are you manually supporting three different key types?  Can=E2=80=99t y=
ou
just somehow support all key types?  And shouldn=E2=80=99t you be verifying
the acceptable usage of trusted keys?

You are using a non-ephemeral key and generating a fresh IV each time.
This is probably okay, but it=E2=80=99s needlessly fragile. Just generate a=
n
entirely fresh key each time, please.  You also seem to be doing
encrypt-and-MAC, which is not generally considered acceptable. And
you=E2=80=99re not authenticating everything =E2=80=94 just the data. This =
seems very
weak.

Can you explain the trampoline?  It looks like you are using it to
tell the resumed kernel that it was tampered with. If so, NAK to that.
Just abort.

You say =E2=80=9CIf the encryption key be guessed then the snapshot master =
key
can also be grabbed from snapshot image.=E2=80=9D  This makes little sense.=
 If
the encryption key is guessed, the game is over. Just remove this
patch =E2=80=94 it seems like pure snake oil.

As far as I can tell, there is only one reason that any of this needs
to be in the kernel: if it=E2=80=99s all in user code, then we lose =E2=80=
=9Clockdown=E2=80=9D
protection against compromised user code on a secure boot system.  Is
that, in fact, true?
