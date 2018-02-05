Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbeBERvS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:51:18 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33228 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbeBERvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:51:05 -0500
X-Google-Smtp-Source: AH8x225eme9q2t7/Zdl3+AuC/HQGbFaRIIZuTCnfJ4oRXReVBM+tJ7zcGNOOZiMxCXCI9hDcrl4ew8q2SowhKPrmiKY=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzyqjGXBjVmb+A7EUJr35a3BdZgYN29dD-KZXzY7k4e6Q@mail.gmail.com>
References: <1517851938-5892-1-git-send-email-amir73il@gmail.com> <CA+55aFzyqjGXBjVmb+A7EUJr35a3BdZgYN29dD-KZXzY7k4e6Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 5 Feb 2018 19:51:03 +0200
Message-ID: <CAOQ4uxi4KrCYAVFbWE=4ptSgpVdPEaDDHPVFvFuHvrhsQ69uTA@mail.gmail.com>
Subject: Re: [RFC][PATCH] <linux/stringhash.h>: fix end_name_hash() for 64bit long
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 7:36 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Feb 5, 2018 at 9:32 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> Assuming the fix is not moronic, I wouldn't even know where to begin testing
>> its affects, or how to prove if there really is a problem.
>> Any suggestions?
>
> So I *think* that this was on purpose, but it's a long time ago, and
> we've changed some of the hashing since.
>
> And I think you're wrong that it's a no-op on 32-bit. It's a very
> expensive and pointless multiplication there too, even if the *shift*
> ends up being a nop-op.
>

I did not mean this is no-op on 32-bit, what I meant is that the patch
changes nothing for 32-bit long, besides the zero shift, because:

#if BITS_PER_LONG == 32
#define hash_long(val, bits) hash_32(val, bits)

and hash_32_generic() is just __hash_32() with zero shift.

I guess I cannot make that claim for platforms that HAVE_ARCH_HASH_32.

> The name hashing is pretty performance-sensitive.
>

I realize that, that's why I am asking.
BTW, I think this shouldn't affect dcache on x86_64 and arm64, because they
use the CONFIG_DCACHE_WORD_ACCESS variant of full_name_hash().

Anyway, my work does not depend on this fix, so I am fine with leaving it be.
I just wanted to point it out is case you knew what the original intention was.

Thanks,
Amir.
