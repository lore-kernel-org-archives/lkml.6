Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C04EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C627C208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAMiCyTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C627C208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeH1MkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbeH1MkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:40:20 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 809A32089E;
        Tue, 28 Aug 2018 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535446182;
        bh=QkOLfG7p/RGfwfZeVYJ7z2ujo9/HzY9KQ0IPoMQITJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PAMiCyTEKvWYW4nKOBgTWegrqZhCGKDAfQ5ZpdG7FD9y9KBwS495aCsZKfKye7zk9
         uHOxmF9VLkPh2u+BKHyDHj0hEYlWkQt6wYgYa9PAvdKwMn+EVFjVgZqRI1bFA0uu9W
         bdhScW2Fqg2vCiTHuo/SnGDy/knY9dRBYMHb7ejk=
Date:   Tue, 28 Aug 2018 17:49:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: lockdep-enforce text_mutex in
 text_poke*()
Message-Id: <20180828174939.a2f81bd978067a0f93dc5c4a@kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1808280853520.25787@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1808280853520.25787@cbobk.fhfr.pm>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 08:55:14 +0200 (CEST)
Jiri Kosina <jikos@kernel.org> wrote:

> From: Jiri Kosina <jkosina@suse.cz>
> 
> text_poke() and text_poke_bp() must be called with text_mutex held.
> Let's put proper lockdep anotation in place instead of just mentioning
> the requirement in comment.

Thank you!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> 
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>  arch/x86/kernel/alternative.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 014f214da581..b9d5e7c9ef43 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -684,8 +684,6 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
>   * It means the size must be writable atomically and the address must be aligned
>   * in a way that permits an atomic write. It also makes sure we fit on a single
>   * page.
> - *
> - * Note: Must be called under text_mutex.
>   */
>  void *text_poke(void *addr, const void *opcode, size_t len)
>  {
> @@ -700,6 +698,8 @@ void *text_poke(void *addr, const void *opcode, size_t len)
>  	 */
>  	BUG_ON(!after_bootmem);
>  
> +	lockdep_assert_held(&text_mutex);
> +
>  	if (!core_kernel_text((unsigned long)addr)) {
>  		pages[0] = vmalloc_to_page(addr);
>  		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
> @@ -782,8 +782,6 @@ int poke_int3_handler(struct pt_regs *regs)
>   *	- replace the first byte (int3) by the first byte of
>   *	  replacing opcode
>   *	- sync cores
> - *
> - * Note: must be called under text_mutex.
>   */
>  void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
>  {
> @@ -792,6 +790,9 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
>  	bp_int3_handler = handler;
>  	bp_int3_addr = (u8 *)addr + sizeof(int3);
>  	bp_patching_in_progress = true;
> +
> +	lockdep_assert_held(&text_mutex);
> +
>  	/*
>  	 * Corresponding read barrier in int3 notifier for making sure the
>  	 * in_progress and handler are correctly ordered wrt. patching.
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
