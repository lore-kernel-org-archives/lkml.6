Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbeFEFgp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 01:36:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54435 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbeFEFgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 01:36:44 -0400
Subject: Re: [PATCH 6/6] x86/vdso: Move out the CPU number store
To: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1528140269-26205-1-git-send-email-chang.seok.bae@intel.com>
 <1528140269-26205-7-git-send-email-chang.seok.bae@intel.com>
 <8a41304a-3517-003a-badf-1ba8f7ababe4@nextfour.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <51587908-9652-6a8e-0e01-f387e3ae5852@zytor.com>
Date: Mon, 4 Jun 2018 22:36:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8a41304a-3517-003a-badf-1ba8f7ababe4@nextfour.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/18 20:57, Mika Penttilä wrote:
> 
> This won't work on X86-32 because it actually uses the segment limit with fs: access. So there 
> is a reason why the lsl based method is X86-64 only.
> 

<thinks out loud>

Why does that matter in any shape, way, or form?  The LSL instruction
doesn't touch any of the segment registers, it just uses a segment
selector number.

<looks at code>

I see... we have a VERY unfortunate name collision: the x86-64
GDT_ENTRY_PERC_PU and the i386 GDT_ENTRY_PERCPU are in fact two
completely different things, with the latter being the actual percpu
offset used by the kernel.

So yes, this patch is wrong, because the naming of the x86-64 segment is
insane especially in the proximity of the  -- it should be something
like GDT_ENTRY_CPU_NUMBER.

Unfortunately we probably can't use the same GDT entry on x86-32 and
x86-64, because entry 15 (selector 0x7b) is USER_DS, which is something
we really don't want to screw with.  This means i386 programs that
execute LSL directly for whatever reason will have to understand the
difference, but most of the other segment numbers differ as well,
including user space %cs (USER_CS/USER32_CS) and %ds/%es/%ss (USER_DS).
Perhaps we could bump down segments 23-28 by one and put it as 23, that
way the CPU_NUMBER segment would always be at %ss+80 for the default
(flat, initial) user space %ss.  (We want to specify using %ss rather
than %ds, because it is less likely to be changed and because 64 bits,
too, have %ss defined, but not %ds.)

<action item>

Rename the x86-64 segment to CPU_NUMBER, fixing the naming conflict.
Add 1 to GDT entry numbers 23-28 for i386 (all of these are
kernel-internal segments and so have no impact on user space).
Add i386 CPU_NUMBER equivalent to x86-64 at GDT entry 23.
Document the above relationship between segments.

OK, everyone?

	-hpa
