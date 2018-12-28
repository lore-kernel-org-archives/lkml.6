Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F33C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92832184E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546010777;
	bh=MktodN6LfpP5c2RyxKeHRrnNbEE1p/4Fth/u500O+Js=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FkW50wd35uZyk6LA0VqAP117+kVK4IUnITHXG3r8zMi5715sMrf1Eh01ROMhX5+V1
	 3O8hX6wZXSKLp7my38TjVtPE9hh5KIqX0cNccqu5T6V1s37IlP6HIog4u46kB6RZP2
	 TCXUurMewzaE4cZdh+iStHKftMDmr6Exat6LLoJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbeL1P0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:26:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729314AbeL1P0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:26:15 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2739721872
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 15:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546010774;
        bh=MktodN6LfpP5c2RyxKeHRrnNbEE1p/4Fth/u500O+Js=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l80q3zRr0qeic4eLjPtjQtwU4ib1MCFC/HM4YmSauzbNug5dsoZOo2z+TcDhQVpkb
         8fQF4e6CI4l2Vx3uVTDQ8ikB4Jo9/B2ZNJKzQYk3LJz0CG2Q0BGKdqucNp8ZfontN1
         qYTwwTfrclOwyyNqCOR4pjAx7RhzDHkQKMn0Wh1M=
Received: by mail-wm1-f49.google.com with SMTP id m22so20061102wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 07:26:14 -0800 (PST)
X-Gm-Message-State: AA+aEWbEZnSxawX30/vpoe48FGA9Rwg0vabRg+eDQAzxBM90aB63nvYS
        4u2API73s5Qzhpsdj1unwashsXlN8oXLtq6oyINJfQ==
X-Google-Smtp-Source: ALg8bN4swd80npVpmRuIXV5t3BHONvGMBzzcVX0qc0qYyAEOjo6kJqsaEJQrszX0D0r3g/6o5tiYvTzEQBZicy6jewo=
X-Received: by 2002:a1c:f112:: with SMTP id p18mr23342434wmh.83.1546010772484;
 Fri, 28 Dec 2018 07:26:12 -0800 (PST)
MIME-Version: 1.0
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
In-Reply-To: <87bm56vqg4.fsf@mid.deneb.enyo.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 28 Dec 2018 07:26:00 -0800
X-Gmail-Original-Message-ID: <CALCETrUBfVK1yUtuVn-pGzgrq8GQ7_E0sjPBXPaSiPU+Q-C_aA@mail.gmail.com>
Message-ID: <CALCETrUBfVK1yUtuVn-pGzgrq8GQ7_E0sjPBXPaSiPU+Q-C_aA@mail.gmail.com>
Subject: Re: d_off field in struct dirent and 32-on-64 emulation
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        libc-alpha <libc-alpha@sourceware.org>,
        "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[sending again, slightly edited, due to email client issues]

On Thu, Dec 27, 2018 at 9:25 AM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> We have a bit of an interesting problem with respect to the d_off
> field in struct dirent.
>
> When running a 64-bit kernel on certain file systems, notably ext4,
> this field uses the full 63 bits even for small directories (strace -v
> output, wrapped here for readability):
>
> getdents(3, [
>   {d_ino=3D1494304, d_off=3D3901177228673045825, d_reclen=3D40, d_name=3D=
"authorized_keys", d_type=3DDT_REG},
>   {d_ino=3D1494277, d_off=3D7491915799041650922, d_reclen=3D24, d_name=3D=
".", d_type=3DDT_DIR},
>   {d_ino=3D1314655, d_off=3D9223372036854775807, d_reclen=3D24, d_name=3D=
"..", d_type=3DDT_DIR}
> ], 32768) =3D 88
>
> When running in 32-bit compat mode, this value is somehow truncated to
> 31 bits, for both the getdents and the getdents64 (!) system call (at
> least on i386).
>

...

>
> However, both qemu-user and the 9p file system can run in such a way
> that the kernel is entered from a 64-bit process, but the actual usage
> is from a 32-bit process:


I imagine that at least some of the problems you're seeing are due to this =
bug:

https://lkml.org/lkml/2018/10/18/859

Presumably the right fix involves modifying the relevant VFS file
operations to indicate the relevant ABI to the implementations.  I
would guess that 9p is triggering the =E2=80=9Cnot really in the syscall yo=
u
think you=E2=80=99re in=E2=80=9D issue.
