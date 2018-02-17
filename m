Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbeBQKiy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:38:54 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:54414 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbeBQKiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:38:52 -0500
X-Google-Smtp-Source: AH8x226XriIB9tMZdxSGV5ddHyubA3uAqJuwEmA2TIM+eSqWNbLnwefJk0npzTYTYjylxNMU8Bur0w==
Date: Sat, 17 Feb 2018 11:38:48 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2 1/2] jump_label: Explicitly disable jump labels in
 __init code
Message-ID: <20180217103848.yiutigxpukxfbtze@gmail.com>
References: <cover.1518798288.git.jpoimboe@redhat.com>
 <eccf3cf668635c9b46acd6a4e3f57c05dbd8aa93.1518798288.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eccf3cf668635c9b46acd6a4e3f57c05dbd8aa93.1518798288.git.jpoimboe@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> +/* Disable any jump label entries in __init code */
> +void __init jump_label_invalidate_init(void)
> +{
> +	struct jump_entry *iter_start = __start___jump_table;
> +	struct jump_entry *iter_stop = __stop___jump_table;
> +	struct jump_entry *iter;
> +
> +	for (iter = iter_start; iter < iter_stop; iter++)
> +		if (iter->code >= (unsigned long)_sinittext &&
> +		    iter->code < (unsigned long)_einittext)
> +			iter->code = 0;
> +}
> +
> +/* Disable any jump label entries in module init code */
>  static void jump_label_invalidate_module_init(struct module *mod)
>  {
>  	struct jump_entry *iter_start = mod->jump_entries;
>  	struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
>  	struct jump_entry *iter;
>  
> -	for (iter = iter_start; iter < iter_stop; iter++) {
> +	for (iter = iter_start; iter < iter_stop; iter++)
>  		if (within_module_init(iter->code, mod))
>  			iter->code = 0;
> -	}

Why did you remove the curly braces? They are canonical kernel style for 
multi-line statements.

The new jump_label_invalidate_init() function has that problem too.

Thanks,

	Ingo
