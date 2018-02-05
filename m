Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeBER5c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:57:32 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:39742 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeBER5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:57:24 -0500
X-Google-Smtp-Source: AH8x225Cd6ZPAWbseBFxG9Sv/LHjDVC8hoEDQIOLvvt+fw4vt9ch9z8TiJ1kKVps7DzuzUOvnI8/OQYt25krbJIk2GM=
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxi4KrCYAVFbWE=4ptSgpVdPEaDDHPVFvFuHvrhsQ69uTA@mail.gmail.com>
References: <1517851938-5892-1-git-send-email-amir73il@gmail.com>
 <CA+55aFzyqjGXBjVmb+A7EUJr35a3BdZgYN29dD-KZXzY7k4e6Q@mail.gmail.com> <CAOQ4uxi4KrCYAVFbWE=4ptSgpVdPEaDDHPVFvFuHvrhsQ69uTA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Feb 2018 09:57:23 -0800
X-Google-Sender-Auth: brFdQbLAHCsT_diFvp5G9h4DQno
Message-ID: <CA+55aFz=4jx5f0NVes02rtKY9rW+bdEMUdRh0ukK4UPW3UkFeg@mail.gmail.com>
Subject: Re: [RFC][PATCH] <linux/stringhash.h>: fix end_name_hash() for 64bit long
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 9:51 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>
> and hash_32_generic() is just __hash_32() with zero shift.

Right. But that __hash_32() is very expensive and doesn't help.

So the patch as-is doesn't seem to buy anything, and only adds cost.

Note that the dentry code is a bit unusual, in that the final shift is
done later, in d_hash(). And that takes the _high_ bits of the hash,
so unlike a lot of other hash functions, the name hashing doesn't need
to try to spread the bits down to the low bits. The intermediate hash
value should be fine without any extra spreading.

Anyway, we did have numbers at one point. That's what really matters:
how good the actual hashing ends up being. So for me to take the
patch, I would need to see that it actually improves the hash bucket
spreading enough to be worth the cost.

            Linus
