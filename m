Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A261C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB38C21916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBHAL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:11:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfBHAL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:11:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77A6521907;
        Fri,  8 Feb 2019 00:11:56 +0000 (UTC)
Date:   Thu, 7 Feb 2019 19:11:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V4 5/9] x86/alternative: Split text_poke_bp() into tree
 steps
Message-ID: <20190207191154.336dea13@gandalf.local.home>
In-Reply-To: <cf7096ad15708be48f3ea62b4e903f6ef29e2838.1549308412.git.bristot@redhat.com>
References: <cover.1549308412.git.bristot@redhat.com>
        <cf7096ad15708be48f3ea62b4e903f6ef29e2838.1549308412.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Feb 2019 20:58:58 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index d458c7973c56..202af29c43c0 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -767,6 +767,29 @@ int poke_int3_handler(struct pt_regs *regs)
>  
>  }
>  
> +static void text_poke_bp_set_handler(void *addr, void *handler,
> +				     unsigned char int3)
> +{
> +	bp_int3_handler = handler;
> +	bp_int3_addr = (u8 *)addr + sizeof(int3);

Why add the above update to the handler in this function? It looks
strange in this patch. Then I thought, "hmm, maybe it has a reason to
be here in other patches". Then I see in patch 7, you *REMOVE* these
awkward lines from this function! Let's not move them here to begin
with.

We then don't even need to pass in "handler". And perhaps rename it to
just "text_poke_bp_add_int3()"?

-- Steve


> +	text_poke(addr, &int3, sizeof(int3));
> +}
> +
> +static void patch_all_but_first_byte(void *addr, const void *opcode,
> +				     size_t len, unsigned char int3)
> +{
> +	/* patch all but the first byte */
> +	text_poke((char *)addr + sizeof(int3),
> +		  (const char *) opcode + sizeof(int3),
> +		  len - sizeof(int3));
> +}
> +
