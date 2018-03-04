Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeCDO1s (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 09:27:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:47756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752485AbeCDO1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 09:27:47 -0500
Date: Sun, 4 Mar 2018 15:27:36 +0100
From: Borislav Petkov <bp@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        r.marek@assembler.cz, ricardo.neri-calderon@linux.intel.com,
        rkrcmar@redhat.com, Janakarajan.Natarajan@amd.com, x86@kernel.org,
        hpa@zytor.com, mingo@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] clarify how insecure CPU is
Message-ID: <20180304142736.GC1142@pd.tnic>
References: <20180108201017.GA20588@amd>
 <alpine.DEB.2.20.1801082125530.2253@nanos>
 <20180108230355.GA25349@amd>
 <alpine.DEB.2.20.1801090043160.2253@nanos>
 <20180303210653.GB22392@amd>
 <alpine.DEB.2.21.1803040825130.1654@nanos.tec.linutronix.de>
 <20180304085159.GB7931@amd>
 <20180304092918.GA1142@pd.tnic>
 <20180304140147.GA7276@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180304140147.GA7276@amd>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 03:01:48PM +0100, Pavel Machek wrote:
> > Not "might be needed" - "X86_BUG_AMD_APIC_C1E will be set if platform is
> > affected".
> 
> That's not what Thomas was explaining to me.

It is in the comment he pasted:

         * Check whether the machine is affected by erratum 400. This is
         * used to select the proper idle routine and to enable the check
         * whether the machine is affected in arch_post_acpi_init(), which
         * sets the X86_BUG_AMD_APIC_C1E bug depending on the MSR check.

> So.. what's magical about it, why do we need two bits, and why is that
> not explained in the header file?

Lemme enable line numbers so that you can find it:

arch/x86/include/asm/cpufeatures.h:
 19 /*
 20  * Note: If the comment begins with a quoted string, that string is used
 21  * in /proc/cpuinfo instead of the macro name.  If the string is "",
 22  * this feature bit is not displayed in /proc/cpuinfo at all.

> Please go through the email thread,

No, you read Thomas' mail again.

> I'm trying to understand what is going on here,

Nothing's going on, it works as designed.

X86_BUG_AMD_E400 marks all CPUs which could be affected by erratum 400
and X86_BUG_AMD_APIC_C1E is the bit we set when we detect that the CPU
is *actually* affected because we need to do the detection late, after
ACPI has been initialized.

A CPU might be affected by the erratum - bit X86_BUG_AMD_E400 - but if
the BIOS doesn't enter C1E, then the erratum doesn't come to manifest
itself, i.e., we don't set X86_BUG_AMD_APIC_C1E.

If it is still not clear, read the erratum 400 description in the
revision guide.

The code works perfectly fine.

Unless you're experiencing a problem with it. Then I'm all ears.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
