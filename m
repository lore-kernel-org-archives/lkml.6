Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936060AbeCST3Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:29:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935986AbeCST3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:29:11 -0400
Date: Mon, 19 Mar 2018 14:29:10 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de
Subject: Re: [PATCH 2/2] x86/unwind: Make CONFIG_UNWINDER_ORC=y the default
 in kconfig for 64-bit
Message-ID: <20180319192910.wfbi656bxkrlurgf@treble>
References: <20171013052544.euk7yawni47lhmdq@gmail.com>
 <9b1237bbe7244ed9cdf8db2dcb1253e37e1c341e.1507924831.git.jpoimboe@redhat.com>
 <20180319185732.GD37438@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180319185732.GD37438@google.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 11:57:32AM -0700, Matthias Kaehlcke wrote:
> Hi Josh,
> 
> El Fri, Oct 13, 2017 at 03:02:01PM -0500 Josh Poimboeuf ha dit:
> 
> > The ORC unwinder has been stable in testing so far.  Give it much wider
> > testing by making it the default in kconfig for x86_64.  It's not yet
> > supported for 32-bit, so leave frame pointers as the default there.
> > 
> > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> 
> Building an upstream kernel with clang results in plenty of objtool
> warnings like these:
> 
> drivers/gpu/drm/i915/dvo_ch7017.o: warning: objtool: ch7017_get_hw_state()+0x80: return with modified stack frame
>   CC      drivers/gpu/drm/i915/i915_oa_cflgt2.o
> ...
>   CC      drivers/gpu/drm/i915/intel_lpe_audio.o
> drivers/gpu/drm/i915/i915_gpu_error.o: warning: objtool: i915_error_printf()+0x6c: return with modified stack frame
> drivers/gpu/drm/i915/intel_display.o: warning: objtool: pipe_config_err()+0xa6: return with modified stack frame
> 
> Bisecting shows that the warnings are generated since the ORC unwinder
> was made the default. Not sure if the issue is on the unwinder side
> or clang.
> 
> Any ideas on what could be the problems?

Hi Matthias,

The ORC unwinder relies on objtool, which reverse engineers the compiled
code.  This is objtool's first exposure to clang, so I'm not at all
surprised if it's getting confused.

Send me one of the .o files and I can take a quick look to see how bad
it is, but I'm guessing it's going to be a lot of work to make objtool
compatible with clang (and unfortunately I won't have the bandwidth to
work on that in the near term.)

In the meantime I'd recommend that you use frame pointers (and
CONFIG_STACK_VALIDATION=n) for clang-compiled kernels.

-- 
Josh
