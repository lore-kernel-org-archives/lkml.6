Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753383AbeCYONf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 10:13:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753229AbeCYONe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 10:13:34 -0400
Date: Sun, 25 Mar 2018 16:12:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Eric Dumazet <edumazet@google.com>,
        x86 <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v3 1/2] x86, msr: allow rdmsr_safe_on_cpu() to schedule
Message-ID: <20180325141242.GC21878@pd.tnic>
References: <20180323215818.127774-1-edumazet@google.com>
 <20180324080946.3db4xdkl5i6jx2rc@gmail.com>
 <336355a3-c11d-44fc-0642-671670980ac0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <336355a3-c11d-44fc-0642-671670980ac0@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 07:29:48AM -0700, Eric Dumazet wrote:
> It is named gsysd, "Google System Tool", a daemon+cli that is run 
> on all machines in production to provide a generic interface
> for interacting with the system hardware.

So I'm wondering if poking at the hardware like that is a really optimal
design. Maybe it would be cleaner if the OS would provide properly
abstracted sysfs interfaces instead of raw MSRs. For a couple of
reasons:

* different vendors have different MSR ranges giving the same info so
instead of differentiating that in your daemon, we can do that nicely in
the kernel.

* exposing raw MSRs instead of having clearly defined sysfs files is
always a pain when a new CPU decides to change those MSRs. Hiding that
change in the OS is always easier.

* periodically polling MSRs which don't change that often is, of course,
wasting power and so reading a cached result is leaner.

* <another reason which I'll think of after hitting send... :\ >

In general, we should've never have had exposed that raw MSR access but
it is too late now - that ship has sailed. We can still try to design
new interfaces more cleanly, though.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
