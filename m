Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933652AbeBVSEz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:04:55 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36535 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933516AbeBVSEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:04:53 -0500
X-Google-Smtp-Source: AH8x224kMt+FSnpmvkBL7mwd+CnTQtTPG52HsgLBb2ndu1wZnDO+riGLE7DaCIUrJqZg8U79HTHoJPoCraJPf25WVaY=
MIME-Version: 1.0
In-Reply-To: <20180222174140.GA3154@beast>
References: <20180222174140.GA3154@beast>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2018 10:04:52 -0800
X-Google-Sender-Auth: Pwuz0dsKas8WpvE0c3hri21dMAQ
Message-ID: <CA+55aFxDh-69p0Lr52icct6-3PGcsHaZmMqHwks8HptdmdxvTg@mail.gmail.com>
Subject: Re: [PATCH v3] kconfig.h: Include compiler types to avoid missed
 struct attributes
To: Kees Cook <keescook@chromium.org>
Cc: Patrick McLean <chutzpah@gentoo.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 9:41 AM, Kees Cook <keescook@chromium.org> wrote:
>
> Updated to include Tested-by. Linus, this looks ready to go.

Ok, applied.

I'm a bit worried that this ends up bypassing our automatic dependency
generation.

Lookie here (in a fully built tree):

    find . -name '*.o.cmd' |
        xargs grep -L linux/compiler_types.h |
        xargs grep -l linux/kconfig.h |
        while read i; do
            j=$(echo $i | sed 's/\.o.cmd$/\.c/' | sed 's:/\.:/:');
            test -f $j && echo $j;
        done

shows that a number of files don't end up depending on that header
file, even though it's included (that "grep -l linux/kconfig,h"
triggers on the command itself having that "-include linux/kconfig.h"
line).

It looks like "gcc -M" just doesn't list any files that get included
on the command line with "-include".

Now, there are very *few* files that don't end up eventually including
linux/compiler_types.h _some_ way, and I checked them all, and they
really are so trivial that this doesn't matter.

But it worries me a bit regardless.

              Linus
