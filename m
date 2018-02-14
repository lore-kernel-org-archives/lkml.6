Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033233AbeBNRBk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:01:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:46721 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032907AbeBNRBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:01:39 -0500
Date: Wed, 14 Feb 2018 18:01:33 +0100
From: Borislav Petkov <bp@suse.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH 1/3] jump_label: Warn on failed jump_label patch
Message-ID: <20180214170133.GA19502@pd.tnic>
References: <cover.1518626149.git.jpoimboe@redhat.com>
 <b8f1b55f17c346fba39d3f59a01251185e09e151.1518626149.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8f1b55f17c346fba39d3f59a01251185e09e151.1518626149.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:40:41AM -0600, Josh Poimboeuf wrote:
> When the jump label code encounters an address which isn't recognized by
> kernel_text_address(), it just silently fails.
> 
> This can be dangerous because jump labels are used in a variety of
> places, and are generally expected to work.  Convert the silent failure
> to a warning.
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
> -- 
> 2.14.3

Good idea.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
