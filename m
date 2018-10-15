Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F412C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED3C2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="aog6ggTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED3C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJOQy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:54:26 -0400
Received: from 8bytes.org ([81.169.241.247]:40254 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOQyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:54:25 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D45F22DF; Mon, 15 Oct 2018 11:10:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1539594600; bh=6YZA1WFNwAxNdRfyyePlBap+fBSdXZLhSy/IVLc1kbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aog6ggTp0/j57+7oJWnz8gEcWQJsTiHBGUlMJ2siBIqHSnsLLaQyINRmaVhsyk/wt
         Ouk8KLQQHdu+8I4q/kVHzzT+AzETisvbOyq6Dfu4+Ur+6kQck59I+RTsQs9Sy5AvuX
         WAQc/Crt9TZPdYPgKsvGgj/faueZ1YdpR1eQmBH41aJEre2qK3lQ1TMAml+Zck1EgJ
         wBHY8GwN21/3+QzChVJBpg71R6OM6iyGHCdr+sP8uZIIS94J1aIHUSI85p17ETrABi
         SYImgNkNid9xDP1g/Z7iHfSN4qfp/ITPm9mbciQDx2yCTnTsvF7dQPxgTidyBqcZU5
         W53Ao6qj8ZcUg==
Date:   Mon, 15 Oct 2018 11:10:00 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jan Kiszka <jan.kiszka@web.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] x86/entry/32: Fix setup of CS high bits
Message-ID: <20181015091000.GE3630@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
 <1531906876-13451-11-git-send-email-joro@8bytes.org>
 <97421241-2bc4-c3f1-4128-95b3e8a230d1@siemens.com>
 <35a24feb-5970-aa03-acbf-53428a159ace@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35a24feb-5970-aa03-acbf-53428a159ace@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jan,

thanks for tracking this down and sending the fix! So your hardware
probably doesn't zero out the CS high bits, so that the code wrongly
detects that it came from the entry stack on return. Clearing the bits
earlier before the entry-stack check makes sense.

Acked-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>

On Sat, Oct 13, 2018 at 11:54:54AM +0200, Jan Kiszka wrote:
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index 2767c625a52c..95c94d48ecd2 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -389,6 +389,12 @@
>  	 * that register for the time this macro runs
>  	 */
>  
> +	/*
> +	 * Clear unused upper bits of the dword containing the word-sized CS
> +	 * slot in pt_regs in case hardware didn't clear it for us.
> +	 */
> +	andl	$(0x0000ffff), PT_CS(%esp)
> +
>  	/* Are we on the entry stack? Bail out if not! */
>  	movl	PER_CPU_VAR(cpu_entry_area), %ecx
>  	addl	$CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
> @@ -407,12 +413,6 @@
>  	/* Load top of task-stack into %edi */
>  	movl	TSS_entry2task_stack(%edi), %edi
>  
> -	/*
> -	 * Clear unused upper bits of the dword containing the word-sized CS
> -	 * slot in pt_regs in case hardware didn't clear it for us.
> -	 */
> -	andl	$(0x0000ffff), PT_CS(%esp)
> -
>  	/* Special case - entry from kernel mode via entry stack */
>  #ifdef CONFIG_VM86
>  	movl	PT_EFLAGS(%esp), %ecx		# mix EFLAGS and CS
> -- 
> 2.16.4
