Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753191AbeBIWj2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:39:28 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:38472 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeBIWj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:39:27 -0500
X-Google-Smtp-Source: AH8x224uyo63E6O/9M6zmcU6NZhM6LDu2IIZsZAR0c0SBSE2XeLZoyXYSg6GGliDWF/B4YIT6wY7pIvzSBZ9hFy3kyA=
MIME-Version: 1.0
In-Reply-To: <56d0376c-dc1f-334b-d392-a8c5cd85f4aa@infradead.org>
References: <56d0376c-dc1f-334b-d392-a8c5cd85f4aa@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2018 14:39:26 -0800
X-Google-Sender-Auth: -iD7TLG0Vx-DFQE7EAHZoRoPwRE
Message-ID: <CA+55aFymknkNH2mP1vX5ZLEqQwA3BgxQhZF-SUbbJMwTDL6hAA@mail.gmail.com>
Subject: Re: [PATCH] x86: try to simplify NR_CPUS config
To: Randy Dunlap <rdunlap@infradead.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 2:01 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> This is a rather literal interpretation of Linus's suggestion.

I think it can be simplified a bit more.

If you move the definition of RANGE_END_CPUS up to before
RANGE_BEGIN_CPUS, you can then make the RANGE_BEGIN_CPUS just be
something like

   default 1 if !SMP
   default RANGE_END_CPUS if MAXSMP
   default 2

which makes a whole lot more sense.

and if you split that RANGE_END_CPUS so that the x86-32 and x86-64
cases are separate, that makes *those* more understandable. It also
makes sense to separate since X86_BIGSMP is 32-bit only.

But yes, this looks like it's in the right direction, where we can
make each step be fairly obvious, instead of the current NR_CPUS mess
that is entirely impossible to parse for mere humans.

               Linus
