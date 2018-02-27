Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeB0RdX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:33:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39066 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbeB0RdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:33:21 -0500
Date: Tue, 27 Feb 2018 17:33:23 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        yamada.masahiro@socionext.com, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 08/12] arm64: cmpxchg: Include build_bug.h instead
 of bug.h for BUILD_BUG
Message-ID: <20180227173322.GK29123@arm.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
 <1519657500-15094-9-git-send-email-will.deacon@arm.com>
 <20180226154848.ejqxw5lkbiqqxlsf@salmiak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226154848.ejqxw5lkbiqqxlsf@salmiak>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 03:48:49PM +0000, Mark Rutland wrote:
> On Mon, Feb 26, 2018 at 03:04:56PM +0000, Will Deacon wrote:
> > Having asm/cmpxchg.h pull in linux/bug.h is problematic because this
> > ends up pulling in the atomic bitops which themselves may be built on
> > top of atomic.h and cmpxchg.h.
> > 
> > Instead, just include build_bug.h for the definition of BUILD_BUG.
> 
> We also use VM_BUG_ON(), defined in <linux/mmdebug.h>, which includes
> <linux/bug.h>.
> 
> ... so I think we still have some fragility here, albeit no worse than before.
> 
> We also miss includes for:
> 
> * <linux/percpu-defs.h> (raw_cpu_ptr)
> * <linux/preempt.h> (preempt_disable, preempt_enable)

Hmm, we can't include this one because it pulls in linux/bitops.h. I've
moved the percpu cmpxchg stuff into asm/percpu.h, but that too is missing
the linux/preempt.h #include, so I've added that as well.

Generally, I think if we want to clean up our #includes then that's better
done as a separate series rather than as a piecemeal effort, which will
likely fail to identify many of the underlying problems.

Will
