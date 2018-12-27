Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FA7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E225E214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fh4ut1vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeL0RmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 12:42:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45177 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbeL0RmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 12:42:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so16808379ota.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 09:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7lkqtX0iPgpYOq225tKwFAugPBM/DCcxKw54tLiU968=;
        b=Fh4ut1vmxSxoqKwsP8hVf3KcBtNtgGCyd3+VBdwDS38YoH64fH3uKWHwc9W6zpqQjy
         wlTTcyLEvvX3eJ4MELWmAm6WOWuZvT9ECJFsRrleXoijkFFtf6ZfVvp6u+J68wwjUfot
         BQqgutGVwSsNoWQCdUFkk0A93jdZsiJTOVRFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7lkqtX0iPgpYOq225tKwFAugPBM/DCcxKw54tLiU968=;
        b=qmEfXR8HC/iTFSTA9UivFKRGZIE6TmsWatvFoPye4uzuD81ngWt9McyD7Kx0aFHpgH
         uTjURkZ2Sgw4LAJNTr/NAccxafwIk+/Bh6udXrFbOeP18lqFKyjtJYSvWVIT71aeTk19
         RwfY1Ka2lWfyc3p+GR5/LZhENeKmaDggSWgh26GochrAYrJ24pbg9ZF4AAi5sKkJOxuk
         AkRfBVo6x+pArE3eYCL+c1pwSsvIZTDsH7aSsp7KCv+XolhUfbnojppeEvOYVX86LW0Q
         q7DqAyWAg8cz3i81NLqkEbLDA+HowAk4+a658NDpzksSgm9HgPBIU3AmNoDv0C4Hv3WV
         iulA==
X-Gm-Message-State: AJcUukcRvHox2K3+1ZYLds7d4G56qhesLG7vakECOsSFym7hhrZkN4wg
        Y1A6T7iW5ejSEsI7rz0e3QXOeFUVqYwY6ZgwPJiRwg==
X-Google-Smtp-Source: ALg8bN6/t6yoYsPGr1iwkgk6WLCzP5ZIrSsEsAN+3jRMz+ghQ5zXyyIuC1UVlkxn5zcqIk/r1eaL4cQ44MD9zQDQJxE=
X-Received: by 2002:a9d:3b77:: with SMTP id z110mr15960008otb.352.1545932529801;
 Thu, 27 Dec 2018 09:42:09 -0800 (PST)
MIME-Version: 1.0
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
In-Reply-To: <87bm56vqg4.fsf@mid.deneb.enyo.de>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Thu, 27 Dec 2018 17:41:58 +0000
Message-ID: <CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, lucho@ionkov.net,
        libc-alpha@sourceware.org, Arnd Bergmann <arnd@arndb.de>,
        ericvh@gmail.com, hpa@zytor.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>, rminnich@sandia.gov,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2018 at 17:19, Florian Weimer <fw@deneb.enyo.de> wrote:
> We have a bit of an interesting problem with respect to the d_off
> field in struct dirent.
>
> When running a 64-bit kernel on certain file systems, notably ext4,
> this field uses the full 63 bits even for small directories (strace -v
> output, wrapped here for readability):
>
> getdents(3, [
>   {d_ino=1494304, d_off=3901177228673045825, d_reclen=40, d_name="authorized_keys", d_type=DT_REG},
>   {d_ino=1494277, d_off=7491915799041650922, d_reclen=24, d_name=".", d_type=DT_DIR},
>   {d_ino=1314655, d_off=9223372036854775807, d_reclen=24, d_name="..", d_type=DT_DIR}
> ], 32768) = 88
>
> When running in 32-bit compat mode, this value is somehow truncated to
> 31 bits, for both the getdents and the getdents64 (!) system call (at
> least on i386).

Yes -- look for hash2pos() and friends in fs/ext4/dir.c.
The ext4 code in the kernel uses a 32 bit hash if (a) the kernel
is 32 bit (b) this is a compat syscall (b) some other bit of
the kernel asked it to via the FMODE_32BITHASH flag (currently only
NFS does that I think).

As you note, this causes breakage for userspace programs which
need to implement an API/ABI with 32-bit offset but which only
have access to the kernel's 64-bit offset API/ABI.

I think the best fix for this would be for the kernel to either
(a) consistently use a 32-bit hash or (b) to provide an API
so that userspace can use the FMODE_32BITHASH flag the way
that kernel-internal users already can.

I couldn't think of or find any existing way for userspace
to get the right results here, which is why
32-bit-guest-on-64-bit-host QEMU doesn't work on these filesystems
(depending on what exactly the guest's libc etc do).

> the 32-bit getdents system call emulation in a 64-bit qemu-user
> process would just silently truncate the d_off field as part of
> the translation, not reporting an error.
> [...]
> This truncation has always been a bug; it breaks telldir/seekdir
> at least in some cases.

Yes; you can't fit a quart into a pint pot, so if the guest
only handles 32-bit offsets then truncation is about all we
can do. This works fine if offsets are offsets, assuming the
directory isn't so enormous it would have broken the guest
anyway. I'm not aware of any issues with this other than the
oddball ext4 offsets-are-hashes situation -- could you expand
on the telldir/seekdir issue? (I suppose we should probably
make QEMU's syscall emulation layer return "no more entries"
rather than entries with truncated hashes.)

thanks
-- PMM
