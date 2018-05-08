Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbeEHOuQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:50:16 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:45518 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932452AbeEHOuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:50:14 -0400
X-Google-Smtp-Source: AB8JxZpVSmaGejEu13jI7yxLBGRhC/32MGZtmmCcw17ZdaegCte1iT+VEZwg+pd5MOyPYyhLvUastbipbbVXWkZZ42M=
MIME-Version: 1.0
References: <20180508121638.174022-1-glider@google.com> <1f69bdb6-df5e-d709-064a-4f6fdd6e11a7@linux.intel.com>
In-Reply-To: <1f69bdb6-df5e-d709-064a-4f6fdd6e11a7@linux.intel.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 08 May 2018 14:50:02 +0000
Message-ID: <CAG_fn=Xv74c80swzFjKyybQpRj7Qj9K1NVH-D6gcxcYEoUJ1xA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/64/clang: Use fixup_pointer() to access '__supported_pte_mask'
To: dave.hansen@linux.intel.com
Cc: Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Dmitriy Vyukov <dvyukov@google.com>, Michael Davidson <md@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48EoJ4b022996

On Tue, May 8, 2018 at 4:30 PM Dave Hansen <dave.hansen@linux.intel.com>
wrote:

> On 05/08/2018 05:16 AM, Alexander Potapenko wrote:
> > Similarly to commit 187e91fe5e91
> > ("x86/boot/64/clang: Use fixup_pointer() to access 'next_early_pgt'"),
> > '__supported_pte_mask' must be also accessed using fixup_pointer() to
> > avoid position-dependent relocations.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Fixes: fb43d6cb91ef ("x86/mm: Do not auto-massage page protections")

> In the interests of standalone changelogs, I'd really appreciate an
> actual explanation of what's going on here.  Your patch makes the code
> uglier and doesn't fix anything functional from what I can see.
You're right, sure. I'll send a patch with an updated description.

> The other commit has some explanation, so it seems like the rules for
> accessing globals in head64.c are different than other files because...
> something.
The problem as far as I understand it is that the code in __startup_64()
can be relocated during execution, but the compiler doesn't have to
generate PC-relative relocations when accessing globals from that function.

> The functional problem here is that it causes insta-reboots?
True.

> Do we have anything we can do to keep us from recreating these kinds of
> regressions all the time?
I'm not really aware of the possible options in the kernel land. Looks like
a task for some objtool-like utility?
As long as these regressions are caught with Clang, setting up a 0day Clang
builder might help.
At least I should've added a comment regarding this to __startup_64() last
time.



-- 
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Straße, 33
80636 München

Geschäftsführer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
