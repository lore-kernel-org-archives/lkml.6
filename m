Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033220AbeBNRBR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032907AbeBNRBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:01:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99E22177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 14 Feb 2018 12:01:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/3] jump_label: Warn on failed jump_label patch
Message-ID: <20180214120112.43821b5e@gandalf.local.home>
In-Reply-To: <b8f1b55f17c346fba39d3f59a01251185e09e151.1518626149.git.jpoimboe@redhat.com>
References: <cover.1518626149.git.jpoimboe@redhat.com>
        <b8f1b55f17c346fba39d3f59a01251185e09e151.1518626149.git.jpoimboe@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018 10:40:41 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> When the jump label code encounters an address which isn't recognized by
> kernel_text_address(), it just silently fails.
> 
> This can be dangerous because jump labels are used in a variety of
> places, and are generally expected to work.  Convert the silent failure
> to a warning.

I made ftrace function tracing work on init code, can we do the same
with tracepoints (aka jump labels)?

But I have to say that this goes with my argument that there exists
tracepoints in the kernel that nobody cares about ;-)

-- Steve

> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  kernel/jump_label.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index b4517095db6a..c71fb7cdfc41 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -370,8 +370,12 @@ static void __jump_label_update(struct static_key *key,
>  		 * kernel_text_address() verifies we are not in core kernel
>  		 * init code, see jump_label_invalidate_module_init().
>  		 */
> -		if (entry->code && kernel_text_address(entry->code))
> -			arch_jump_label_transform(entry, jump_label_type(entry));
> +		if (entry->code) {
> +			if (kernel_text_address(entry->code))
> +				arch_jump_label_transform(entry, jump_label_type(entry));
> +			else
> +				WARN_ONCE(1, "can't patch jump_label at %pS", (void *)entry->code);
> +		}
>  	}
>  }
>  
