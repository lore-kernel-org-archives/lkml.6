Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755256AbeDWKwW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:52:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49090 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754808AbeDWKwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:52:19 -0400
Date: Mon, 23 Apr 2018 12:52:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yonghong Song <yhs@fb.com>
Cc: mingo@kernel.org, ast@fb.com, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, x86@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] x86/cpufeature: guard asm_volatile_goto usage with
 NO_BPF_WORKAROUND
Message-ID: <20180423105209.GX4064@hirez.programming.kicks-ass.net>
References: <20180415042738.1788215-1-yhs@fb.com>
 <20180420081936.GD4064@hirez.programming.kicks-ass.net>
 <fd14097e-31c5-0c0e-cbe5-d399299ca489@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd14097e-31c5-0c0e-cbe5-d399299ca489@fb.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 11:06:03AM -0700, Yonghong Song wrote:
> On 4/20/18 1:19 AM, Peter Zijlstra wrote:

> > Hurm, so adding __BPF__ for BPF compiles isn't an option? It seems to me
> > having a CPP flag to identify BPF compile context might be useful in
> > general.
> 
> With "clang -target bpf", we already have __BPF__ defined.
> For tracing, esp. ptrace.h is included, "clang -target <native_arch>" where
> "-target <native_arch>" can be omitted, is typically used.

> The reason is the native architecture header files typically
> include a lot of various asm related stuff where "-target bpf" cannot
> really handle. We relay on native clang to flush out all these
> asm constructs and only bpf program needed stuff survives
> reach to backend compiler.

So because 'clang -target bpf' is 'broken', you do a work-around using
'clang -target <native_arch>'. But because that doesn't set __BPF__ you
want to add NO_BPF_WORKAROUND to the kernel instead of adding __BPF__ to
your build rules to better mimick -target bpf, which you should be
using.

How is that sane? Why not use 'clang -target <native_arch> -D__BPF__'
