Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeFEKWi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbeFEKWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:22:37 -0400
X-Google-Smtp-Source: ADUXVKKHwawTxKjP9wl/UW3JbONgSJHUSbFRywvR1lPplWXjrn2+dRFS0xkqkLbRP6sSnZqg9nnftLt+CJSzZsTBXsI=
MIME-Version: 1.0
References: <1528140269-26205-1-git-send-email-chang.seok.bae@intel.com>
 <1528140269-26205-7-git-send-email-chang.seok.bae@intel.com>
 <8a41304a-3517-003a-badf-1ba8f7ababe4@nextfour.com> <51587908-9652-6a8e-0e01-f387e3ae5852@zytor.com>
In-Reply-To: <51587908-9652-6a8e-0e01-f387e3ae5852@zytor.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 5 Jun 2018 03:22:22 -0700
X-Gmail-Original-Message-ID: <CALCETrVP9-H+gJihrU4NGzU151qVPJsK3YYZzJf_BtDLz-Pgsg@mail.gmail.com>
Message-ID: <CALCETrVP9-H+gJihrU4NGzU151qVPJsK3YYZzJf_BtDLz-Pgsg@mail.gmail.com>
Subject: Re: [PATCH 6/6] x86/vdso: Move out the CPU number store
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55AMhrf000372

On Mon, Jun 4, 2018 at 10:36 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 06/04/18 20:57, Mika Penttilä wrote:
> >
> > This won't work on X86-32 because it actually uses the segment limit with fs: access. So there
> > is a reason why the lsl based method is X86-64 only.
> >
>
> <thinks out loud>
>
> Why does that matter in any shape, way, or form?  The LSL instruction
> doesn't touch any of the segment registers, it just uses a segment
> selector number.
>
> <looks at code>
>
> I see... we have a VERY unfortunate name collision: the x86-64
> GDT_ENTRY_PERC_PU and the i386 GDT_ENTRY_PERCPU are in fact two
> completely different things, with the latter being the actual percpu
> offset used by the kernel.
>
> So yes, this patch is wrong, because the naming of the x86-64 segment is
> insane especially in the proximity of the  -- it should be something
> like GDT_ENTRY_CPU_NUMBER.
>
> Unfortunately we probably can't use the same GDT entry on x86-32 and
> x86-64, because entry 15 (selector 0x7b) is USER_DS, which is something
> we really don't want to screw with.  This means i386 programs that
> execute LSL directly for whatever reason will have to understand the
> difference, but most of the other segment numbers differ as well,
> including user space %cs (USER_CS/USER32_CS) and %ds/%es/%ss (USER_DS).
> Perhaps we could bump down segments 23-28 by one and put it as 23, that
> way the CPU_NUMBER segment would always be at %ss+80 for the default
> (flat, initial) user space %ss.  (We want to specify using %ss rather
> than %ds, because it is less likely to be changed and because 64 bits,
> too, have %ss defined, but not %ds.)
>
> <action item>
>
> Rename the x86-64 segment to CPU_NUMBER, fixing the naming conflict.

Yes, agreed.  Probably as its own patch *before* the rest of this cleanup.

> Add 1 to GDT entry numbers 23-28 for i386 (all of these are
> kernel-internal segments and so have no impact on user space).
> Add i386 CPU_NUMBER equivalent to x86-64 at GDT entry 23.
> Document the above relationship between segments.

Sure, but also as a standalone patch, please.

>
> OK, everyone?
>
>         -hpa
