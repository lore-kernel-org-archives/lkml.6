Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeFEB7J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 21:59:09 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33806 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbeFEB7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 21:59:08 -0400
X-Google-Smtp-Source: ADUXVKI+gfmI/g08w5COJekCIGomQznHJj5ZoQxy19Vgjk9EF4VYNXgihgOw0rcKrxbodriaxAi4oUk99ut0qOa3cww=
MIME-Version: 1.0
References: <20180604122132.GA3337@gmail.com>
In-Reply-To: <20180604122132.GA3337@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Jun 2018 18:58:56 -0700
Message-ID: <CA+55aFx=zLkZx4h4rcWv79OKQSGJAwC3eS8=zSDgKjyrsbLrNA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm changes for v4.18
To: Ingo Molnar <mingo@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 5:21 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>  - __clear_user() micro-optimization (Alexey Dobriyan)

Was this actually tested?

I think one reason people avoided the constant was that on some
microarchitecture it ended up being a separate uop just for the
constant generation, because it wouldn't fit in a single uop.

I'm pretty sure that used to be the case for P4, for example.

Afaik there have also been issues with decoding instructions that have
both an immediate and a memory offset.

I suspect none of this is an issue on modern cores, but there really
at least historically were cases where

   mov %reg,mem

was better than

   mov $imm,mem

if %reg already had the right value, so it's not at all 100% obvious
that the micro-optimization really _optimizes_ anything.

Any time people do this, they should add numbers.

            Linus
