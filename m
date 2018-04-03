Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeDCTaC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:30:02 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44737 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeDCT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:29:59 -0400
X-Google-Smtp-Source: AIpwx48V6XlV/o5FpTf+uYfp3Q0kkj6kejUum2jHOMado8JLfSRlybJtwTyns+D5Ox9XnYrssQv0aJ9xlUQdeEkJwdA=
MIME-Version: 1.0
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com> <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
In-Reply-To: <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 03 Apr 2018 19:29:47 +0000
Message-ID: <CACdnJuutJeeaaB2kwma0MMd9uDDbKavoHEk4koDLe1M6gYZWXQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: luto@kernel.org
Cc: David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 9:46 AM Andy Lutomirski <luto@kernel.org> wrote:
> On Tue, Apr 3, 2018 at 9:29 AM, Matthew Garrett <mjg59@google.com> wrote:
> > A kernel that allows users arbitrary access to ring 0 is just an
> > overfeatured bootloader. Why would you want secure boot in that case?

> To get a chain of trust.  I can provision a system with some public
> keys, stored in UEFI authenticated variables, such that the system
> will only boot a signed image.  That signed image, can, in turn, load
> a signed (or hashed or otherwise verfified) kernel and a verified
> initramfs.  The initramfs can run a full system from a verified (using
> dm-verity or similar) filesystem, for example.  Now it's very hard to
> persistently attack this system.  Chromium OS does something very much
> like this, except that it doesn't use UEFI as far as I know.  So does
> iOS, and so do some Android versions.  None of this requires lockdown,
> or even a separation between usermode and kernelmode, to work
> correctly.  One could even do this on an MMU-less system if one really
> cared to.  More usefully, someone probably has done this using a
> unikernel.

That's only viable if you're the only person with the ability to sign stuff
for your machine - the moment there are generic distributions that your
machine trusts, an attacker can use one as a bootloader to compromise your
trust chain. Since most UEFI secure boot systems have to trust generic
distributions (if you don't trust the third party signing key then your GPU
won't post), the ecosystem depends on it not being possible for people to
use generic distributions as bootloaders.
