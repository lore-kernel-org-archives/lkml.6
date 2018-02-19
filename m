Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeBSM5N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:57:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752657AbeBSM5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:57:12 -0500
Date: Mon, 19 Feb 2018 06:57:11 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 1/3] jump_label: Explicitly disable jump labels in
 __init code
Message-ID: <20180219125711.x5bhj7veuu77fizk@treble>
References: <cover.1519002843.git.jpoimboe@redhat.com>
 <969b2305cce1b9ce94aa3b678c36fbd6abd94a5d.1519002843.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <969b2305cce1b9ce94aa3b678c36fbd6abd94a5d.1519002843.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 07:17:19PM -0600, Josh Poimboeuf wrote:
> After initmem has been freed, any jump labels in __init code are
> prevented from being written to by the kernel_text_address() check in
> __jump_label_update().  However, this check is quite broad.  If
> kernel_text_address() were to return false for any other reason, the
> jump label write would fail silently with no warning.
> 
> For jump labels in module init code, entry->code is set to zero to
> indicate that the entry is disabled.  Do the same thing for core kernel
> init code.  This makes the behavior more consistent, and will also make
> it more straightforward to detect non-init jump label write failures in
> the next patch.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

NACK

0-day reports this doesn't build with CONFIG_MODULES=n:

   init/main.o: In function `kernel_init':
>> main.c:(.ref.text+0x98): undefined reference to `jump_label_invalidate_init'

-- 
Josh
