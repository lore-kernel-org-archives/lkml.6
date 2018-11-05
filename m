Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DE3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F442081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSXYmuhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F442081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbeKEX30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:29:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbeKEX30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k+PSJZKvzef7tx1jIg7I84kTRsKkr80SBLdaGy+viu0=; b=lSXYmuhFzbzKNCLgswknhj+je
        7aKOqT36/I1X9sqBRDYUfapZ2IbiSpNH3Iassz9qIQrvE4Cu2lWm/sD536ZWyfybXXiUPDTX1lUr7
        xuJlZ2APpVMahuaJNNnurylNkjc+K1Vuu8v3VNTKoakNgqy0O+Y4h2BP/QaYSYpm29ZnXzMKtx40q
        B9+KVo3T+J+O9gyIzMFvIopHYoWHR9tDCWR4Ns+3zqCg8BwwJX1ulGAqeM2CH3oXFLYeboCTNbWcj
        Kz6Gs+ej+3xxGjXketObHMZFs+rpQ/o743lOO2RTDtEMQaHoM32O/g621nWg90GudwAYPetnIBLNv
        6V47MmIdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJfZH-0005Fz-BJ; Mon, 05 Nov 2018 14:09:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32D862029F9FF; Mon,  5 Nov 2018 15:09:25 +0100 (CET)
Date:   Mon, 5 Nov 2018 15:09:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during
 early_init
Message-ID: <20181105140925.GD22467@hirez.programming.kicks-ass.net>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102232946.98461-3-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:29:41PM -0700, Nadav Amit wrote:
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index aac0c1f7e354..367c1d0c20a3 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -52,7 +52,13 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
>  	jmp.offset = jump_entry_target(entry) -
>  		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>  
> -	if (early_boot_irqs_disabled)
> +	/*
> +	 * As long as we are in early boot, we can use text_poke_early(), which
> +	 * is more efficient: the memory was still not marked as read-only (it
> +	 * is only marked after poking_init()). This also prevents us from using
> +	 * text_poke() before poking_init() is called.
> +	 */
> +	if (!early_boot_done)
>  		poker = text_poke_early;
>  
>  	if (type == JUMP_LABEL_JMP) {

It took me a while to untangle init/maze^H^Hin.c... but I think this
is all we need:

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index aac0c1f7e354..ed5fe274a7d8 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -52,7 +52,12 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 	jmp.offset = jump_entry_target(entry) -
 		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
-	if (early_boot_irqs_disabled)
+	/*
+	 * As long as we're UP and not yet marked RO, we can use
+	 * text_poke_early; SYSTEM_BOOTING guarantees both, as we switch to
+	 * SYSTEM_SCHEDULING before going either.
+	 */
+	if (system_state == SYSTEM_BOOTING)
 		poker = text_poke_early;
 
 	if (type == JUMP_LABEL_JMP) {
