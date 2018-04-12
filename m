Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeDLJ6Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:58:25 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58030 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeDLJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:58:24 -0400
Date: Thu, 12 Apr 2018 10:58:11 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-sparc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
Message-ID: <20180412095811.GC16141@n2100.armlinux.org.uk>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412013435.GA21219@altlinux.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 04:34:35AM +0300, Dmitry V. Levin wrote:
> A similar commit v4.16-rc1~159^2~37
> ("signal/arm: Document conflicts with SI_USER and SIGFPE") must have
> introduced a similar ABI regression to compat arm.

So, could you explain how can this change cause a regression?

+#define FPE_FIXME      0
-               vfp_raise_sigfpe(0, regs);
+               vfp_raise_sigfpe(FPE_FIXME, regs);

I think you're talking garbage here - look at the damned change.
It subsitutes a definition for a constant, and vfp_raise_sigfpe()
ends up receiving exactly the same value bother before and after
the change.

The change is rather incomplete though because it should have
also changed:

        int si_code = 0;

as well.

So, the commit log is accurate in this case: it _is_ about
documenting the conflicting cases between SI_USER and SIGFPE and
that bit of the change has no ABI effect.

What does slightly annoy me is the creation of uapi/asm/siginfo.h
to contain a definition that _isn't_ to be exposed as part of the
UAPI.  If it's not part of the UAPI, it doesn't belong in a UAPI
header, period.  In any case, I don't think that is exposed to
userspace.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
