Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE77C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DEF218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbfBFQYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:24:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbfBFQYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:24:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C72892175B;
        Wed,  6 Feb 2019 16:23:57 +0000 (UTC)
Date:   Wed, 6 Feb 2019 11:23:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rusty Russell <rusty@rustcorp.com.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 16/17] Plug in new special vfree flag
Message-ID: <20190206112356.64cc5f0d@gandalf.local.home>
In-Reply-To: <20190117003259.23141-17-rick.p.edgecombe@intel.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
        <20190117003259.23141-17-rick.p.edgecombe@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 16:32:58 -0800
Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:

> Add new flag for handling freeing of special permissioned memory in vmalloc
> and remove places where memory was set RW before freeing which is no longer
> needed.
> 
> In kprobes, bpf and ftrace this just adds the flag, and removes the now
> unneeded set_memory_ calls before calling vfree.
> 
> In modules, the freeing of init sections is moved to a work queue, since
> freeing of RO memory is not supported in an interrupt by vmalloc.
> Instead of call_rcu, it now uses synchronize_rcu() in the work queue.
> 
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Paul E. McKenney <paulmck@linux.ibm.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kernel/ftrace.c       |  6 +--

For the ftrace code.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  arch/x86/kernel/kprobes/core.c |  7 +---
>  include/linux/filter.h         | 16 ++-----
>  kernel/bpf/core.c              |  1 -
>  kernel/module.c                | 77 +++++++++++++++++-----------------
>  5 files changed, 45 insertions(+), 62 deletions(-)
>
