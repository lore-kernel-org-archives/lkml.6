Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66923C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B23B223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmP5lA2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B23B223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbeKNEWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeKNEWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:22:49 -0500
Received: from devnote (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4401206BB;
        Tue, 13 Nov 2018 18:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542133413;
        bh=l6VGobAswRrMZlN6IKWBWaezIpPx4k9brX5u5TtFf8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RmP5lA2jziI8SbKDXnNsOavARyNi67q8FvsGwG0BX69ELlefR0Fb4IPTonAilGH3C
         ae81FC0b2dO4wYLD+FEI4X+fqft50p0AtiWop6nRtWdUC50i7fTt02KIZl8N3F4Yt3
         MMDvBJd//OOX7eHumEmB0+BTw+pylBAP96S3i278=
Date:   Tue, 13 Nov 2018 10:23:32 -0800
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] stackleak: Disable function tracing and kprobes for
 stackleak_erase()
Message-Id: <20181113102332.00a97f983a2b361328fab9af@kernel.org>
In-Reply-To: <1542056928-10917-1-git-send-email-alex.popov@linux.com>
References: <1542056928-10917-1-git-send-email-alex.popov@linux.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 00:08:48 +0300
Alexander Popov <alex.popov@linux.com> wrote:

> The stackleak_erase() function is called on the trampoline stack at the end
> of syscall. This stack is not big enough for ftrace and kprobes operations,
> e.g. it can be exhausted if we use kprobe_events for stackleak_erase().
> 
> So let's disable function tracing and kprobes for stackleak_erase().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/stackleak.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index e428929..08cb57e 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/stackleak.h>
> +#include <linux/kprobes.h>
>  
>  #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
>  #include <linux/jump_label.h>
> @@ -47,7 +48,7 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
>  #define skip_erasing()	false
>  #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
>  
> -asmlinkage void stackleak_erase(void)
> +asmlinkage void notrace stackleak_erase(void)
>  {
>  	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
>  	unsigned long kstack_ptr = current->lowest_stack;
> @@ -101,6 +102,7 @@ asmlinkage void stackleak_erase(void)
>  	/* Reset the 'lowest_stack' value for the next syscall */
>  	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
>  }
> +NOKPROBE_SYMBOL(stackleak_erase);
>  
>  void __used stackleak_track_stack(void)
>  {
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
