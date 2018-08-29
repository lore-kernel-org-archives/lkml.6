Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D346CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756242083A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZeAIA0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756242083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeH2Nsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeH2Nsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:48:30 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C12B920645;
        Wed, 29 Aug 2018 09:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535536345;
        bh=eXfkrGNnSa8GlmLTe1iNsL1ROSlGgAN3SvCk4ZO4Usk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FZeAIA0c8ByRVFbt6fFF7pbNbKzk2Cicv5GdG0zIaQpajqg2jGldLyPw3dIKubM85
         Vlk8M1jofMrpt0lNA9mda/0+koGUhr636MuRMhVwetwpU4ZRoe6PIjsL3ebTNZZIQP
         fZebHR/KszKSEmwnHVyjhNb2dRYf2VMj9XnAFDN8=
Date:   Wed, 29 Aug 2018 18:52:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 6/6] x86/alternatives: remove text_poke() return
 value
Message-Id: <20180829185222.e85026ff22638002a1df70e0@kernel.org>
In-Reply-To: <20180829081147.184610-7-namit@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
        <20180829081147.184610-7-namit@vmware.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 01:11:47 -0700
Nadav Amit <namit@vmware.com> wrote:

> The return value of text_poke() is meaningless - it is one of the
> function inputs. One day someone may allow the callers to deal with
> text_poke() failures, if those actually happen.
> 
> In the meanwhile, remove the return value.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/include/asm/text-patching.h | 2 +-
>  arch/x86/kernel/alternative.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index ffe7902cc326..1f73f71b4de2 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -34,7 +34,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>   * On the local CPU you need to be protected again NMI or MCE handlers seeing an
>   * inconsistent instruction while you patch.
>   */
> -extern void *text_poke(void *addr, const void *opcode, size_t len);
> +extern void text_poke(void *addr, const void *opcode, size_t len);
>  extern int poke_int3_handler(struct pt_regs *regs);
>  extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
>  extern int after_bootmem;
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 0feac3dfabe9..45b7fdeaed90 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -795,7 +795,7 @@ static void text_poke_safe(void *addr, const void *opcode, size_t len,
>   *
>   * Note: Must be called under text_mutex.
>   */
> -void *text_poke(void *addr, const void *opcode, size_t len)
> +void text_poke(void *addr, const void *opcode, size_t len)
>  {
>  	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
>  	struct page *pages[2] = {0};

Could you also remove "return addr;" in this patch ?

Thank you,

> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
