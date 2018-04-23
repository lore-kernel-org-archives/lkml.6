Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755245AbeDWMup (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:50:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36618 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754857AbeDWMum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:50:42 -0400
Date: Mon, 23 Apr 2018 14:50:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [PATCH] x86/entry/64/compat: Preserve r8-r11 in int $0x80
Message-ID: <20180423125013.GC22238@pd.tnic>
References: <d4c4d9985fbe64f8c9e19291886453914b48caee.1523975710.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4c4d9985fbe64f8c9e19291886453914b48caee.1523975710.git.luto@kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 07:36:36AM -0700, Andy Lutomirski wrote:
> 32-bit user code that uses int $80 doesn't care about r8-r11.  There is,
> however, some 64-bit user code that intentionally uses int $0x80 to
> invoke 32-bit system calls.  From what I've seen, basically all such
> code assumes that r8-r15 are all preserved, but the kernel clobbers
> r8-r11.  Since I doubt that there's any code that depends on int $0x80
> zeroing r8-r11, change the kernel to preserve them.
> 
> I suspect that very little user code is broken by the old clobber,
> since r8-r11 are only rarely allocated by gcc, and they're clobbered
> by function calls, so they only way we'd see a problem is if the
> same function that invokes int $0x80 also spills something important
> to one of these registers.
> 
> The current behavior seems to date back to the historical commit
> "[PATCH] x86-64 merge for 2.6.4".  Before that, all regs were
> preserved.  I can't find any explanation of why this change was made.

Probably because r8-r11 are callee-clobbered, according to ABI so
someone decided to whack them so that code which doesn't adhere to the
ABI would fall on its face...

Also, looking at PUSH_AND_CLEAR_REGS and how we call it on the 64-bit
entry path, we probably should keep clearing those regs to avoid
speculation crap.

Methinks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
