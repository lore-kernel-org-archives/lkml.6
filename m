Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04D0C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A371F20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b2WivrWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A371F20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeFTNGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:06:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57376 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeFTNGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TJEh0uTDOlXwZQeHzFDMF3QbEXH8AiztTc3Y8g2InN4=; b=b2WivrWZGkiR4DrV5qjWRQ0Cj
        h9JkVnRXnRtxPBHANu/gOoZ9yH9XU7AKeUcPhSCbmg5iPL+2UyToOC0y2DR1rcSAwazTApkFm/NTj
        3YBU+2ga3Vw2m/rLtC/x5O2jqGYXRbD+o4jV1oampgOLAgMAfqlVmGB8IPJCkBjCTb//84VAbPbgu
        24TDtFxWaIuCyLTB70Le++dIKtSATqk/zcqPi2futjXWfrRaJtSWwUKyaHlfnMD0vBV08hve54acl
        laiplkrcjPPnYNIvbwchM48SISug4zX0v/DYhKOxeudIvb4FYp7QnuJBOBP94u7mJ72ueKaOC0mfM
        IMx/nPE5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVcod-00053l-CC; Wed, 20 Jun 2018 13:06:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFDDC2029FA0A; Wed, 20 Jun 2018 15:06:24 +0200 (CEST)
Date:   Wed, 20 Jun 2018 15:06:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v5 9/9] x86: jump-labels: use macros instead of inline
 assembly
Message-ID: <20180620130624.GC2530@hirez.programming.kicks-ass.net>
References: <20180619194854.69486-1-namit@vmware.com>
 <20180619194854.69486-10-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619194854.69486-10-namit@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 12:48:54PM -0700, Nadav Amit wrote:
> diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
> index 8c0de4282659..f321a50e6727 100644
> --- a/arch/x86/include/asm/jump_label.h
> +++ b/arch/x86/include/asm/jump_label.h
> @@ -108,6 +99,26 @@ struct jump_entry {
>  	.popsection
>  .endm
>  
> +.macro STATIC_BRANCH_NOP l_yes:req key:req branch:req
> +1:
> +	.byte STATIC_KEY_INIT_NOP
> +	.pushsection __jump_table, "aw"
> +	_ASM_ALIGN
> +	_ASM_PTR 1b, \l_yes, \key + \branch
> +	.popsection
> +.endm
> +
> +.macro STATIC_BRANCH_JMP l_yes:req key:req branch:req
> +1:
> +	.byte 0xe9
> +	.long \l_yes - 2f
> +2:
> +	.pushsection __jump_table, "aw"
> +	_ASM_ALIGN
> +	_ASM_PTR 1b, \l_yes, \key + \branch
> +	.popsection
> +.endm
> +
>  #endif	/* __ASSEMBLY__ */
>  
>  #endif


This also allows the below, the old macros were slightly easier to
understand, but not in wide use, in fact, only a single user, so I see
no point in preserving them.

---
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -67,38 +67,6 @@ struct jump_entry {
 
 #else	/* __ASSEMBLY__ */
 
-.macro STATIC_JUMP_IF_TRUE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.else
-	.byte		STATIC_KEY_INIT_NOP
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key
-	.popsection
-.endm
-
-.macro STATIC_JUMP_IF_FALSE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	.byte		STATIC_KEY_INIT_NOP
-	.else
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key + 1
-	.popsection
-.endm
-
 .macro STATIC_BRANCH_NOP l_yes:req key:req branch:req
 1:
 	.byte STATIC_KEY_INIT_NOP
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 352e70cd33e8..7c0d2ace8839 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -338,7 +338,7 @@ For 32-bit we have the following conventions - kernel is built with
 .macro CALL_enter_from_user_mode
 #ifdef CONFIG_CONTEXT_TRACKING
 #ifdef HAVE_JUMP_LABEL
-	STATIC_JUMP_IF_FALSE .Lafter_call_\@, context_tracking_enabled, def=0
+	STATIC_BRANCH_JMP .Lafter_call_\@, context_tracking_enabled, 1
 #endif
 	call enter_from_user_mode
 .Lafter_call_\@:
