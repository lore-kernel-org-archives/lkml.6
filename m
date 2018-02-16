Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757359AbeBPDDt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 22:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757345AbeBPDDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 22:03:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87D1217C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x225W+1nrLY5oCurVdkG0XamjSGIaUHqY6ptL/sMW5cdPntkg12QbUBHLeRVSauiumlWpa0m7ZNWFo4Ant940LYQ=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzNcbCxwimCokH2BPihc=vrusbz0NqCnHK3s4aUSLwe-A@mail.gmail.com>
References: <20180215163602.61162-1-namit@vmware.com> <20180215163602.61162-5-namit@vmware.com>
 <CALCETrUY4uZeG2fz=OQWGuyCOcBBNbep6TaJz82CZSP89=g3-A@mail.gmail.com>
 <9EB804CA-0EC9-4CBB-965A-F3C8520201E7@gmail.com> <CALCETrVP3BaOapL3eS8Tf=KFeM8VFPqvMoECGRkFa7WPLq=Asw@mail.gmail.com>
 <CA+55aFypED6i6pESAnk_RPUon_cyvdP3g-QZg2gspEBNAQWvmQ@mail.gmail.com>
 <B723A40E-EFA4-4CCE-80F6-65960213761F@gmail.com> <CA+55aFzNcbCxwimCokH2BPihc=vrusbz0NqCnHK3s4aUSLwe-A@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 16 Feb 2018 03:03:26 +0000
X-Gmail-Original-Message-ID: <CALCETrVF8kjEUhgMQh=BT483dzQ0amfo0ruim4MOSD7DMnEVBw@mail.gmail.com>
Message-ID: <CALCETrVF8kjEUhgMQh=BT483dzQ0amfo0ruim4MOSD7DMnEVBw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/6] x86: Disable PTI on compatibility mode
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <nadav.amit@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@parallels.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 12:42 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Feb 15, 2018 at 4:22 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>>
>> It is not too pretty, I agree, but it should do the work. There is only one
>> problematic descriptor that can be used to switch from compatibility-mode to
>> long-mode in the GDT (LDT descriptors always have the L-bit cleared).
>> Changing the descriptor's present bit on context switch when needed can do
>> the work.
>
> Sure, I can see it working, but it's some really shady stuff, and now
> the scheduler needs to save/restore/check one more subtle bit.
>
> And if you get it wrong, things will happily work, except you've now
> defeated PTI. But you'll never notice, because you won't be testing
> for it, and the only people who will are the black hats.
>
> This is exactly the "security depends on it being in sync" thing that
> makes me go "eww" about the whole model. Get one thing wrong, and
> you'll blow all the PTI code out of the water.
>
> So now you tried to optimize one small case that most people won't
> use, but the downside is that you may make all our PTI work (and all
> the overhead for all the _normal_ cases) pointless.
>

There's also the fact that, if this stuff goes in, we'll be
encouraging people to deploy 32-bit binaries.  Then they'll buy
Meltdown-fixed CPUs (or AMD CPUs!) and they may well continue running
32-bit binaries.  Sigh.  I'm not totally a fan of this.
