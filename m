Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeBHR2U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:28:20 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:51683 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeBHR2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:28:18 -0500
X-Google-Smtp-Source: AH8x227oRCdSm4felJ8DtTH4b4pqD9ley/1OSUvPuwyoaHYtsCImjIVMAc+Q9r7iF3l5n/hL3YjttLu73Xmz0pUbbxQ=
MIME-Version: 1.0
In-Reply-To: <20180208091302.GD25201@hirez.programming.kicks-ass.net>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic> <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net> <20180207192816.GA19536@pd.tnic>
 <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com> <20180208091302.GD25201@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Feb 2018 09:27:56 -0800
X-Google-Sender-Auth: u_3gaf-2iIJQtWgWJQn-9OsJeKY
Message-ID: <CA+55aFySLxYkUQyNf5YcEvitjm2O1whEp4-iKNASPaOpxG1j9w@mail.gmail.com>
Subject: Re: [linus:master] BUILD REGRESSION a2e5790d841658485d642196dbb0927303d6c22f
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 1:13 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> _The_ problem is that new binutils cannot sanely decode any function
> that has a WARN in (this very much includes perf annotate):

Ugh.

Is there any reason why we don't just use UD2 and avoid this whole issue?

Do we even *do* anything different for UD0 vs UD2? I see that
'is_valid_bugaddr()' seems to accept either, I'm not seeing anything
that cares.

Yes, yes, we currently use UD0 for warnings, and UD2 for BUG(), but
the fact is, we don't actually seem to care, because the *real*
differentiator is BUGFLAG_WARNING.

No?

So all the UD0 games seem a bit pointless. Let's not use it at all
because it's so badly documented.

                         Linus
