Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC9F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfBYQLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:11:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfBYQLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:11:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DBEC80F7C;
        Mon, 25 Feb 2019 16:11:32 +0000 (UTC)
Received: from treble (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 929555C21E;
        Mon, 25 Feb 2019 16:11:26 +0000 (UTC)
Date:   Mon, 25 Feb 2019 10:11:24 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] objtool: Replace STACK_FRAME_NON_STANDARD annotation
Message-ID: <20190225161124.cq6c45r3wlwktyuz@treble>
References: <20190225124330.613028745@infradead.org>
 <20190225125232.107098740@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190225125232.107098740@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 25 Feb 2019 16:11:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 01:43:34PM +0100, Peter Zijlstra wrote:
> Replace the existing STACK_FRAME_NON_STANDARD annotation with a
> 'better' scheme.
> 
> The old annotation works by taking the address of a function; this
> is visible to the compiler and might affect code generation (the
> function pointer escapes). The new annotation simply stores the
> function name and has objtool do a symtab lookup.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/frame.h |   19 +++++++++++++---
>  tools/objtool/check.c |   58 +++++++++++++++++++++-----------------------------
>  tools/objtool/check.h |    1 
>  3 files changed, 41 insertions(+), 37 deletions(-)
> 
> --- a/include/linux/frame.h
> +++ b/include/linux/frame.h
> @@ -11,9 +11,22 @@
>   *
>   * For more information, see tools/objtool/Documentation/stack-validation.txt.
>   */
> -#define STACK_FRAME_NON_STANDARD(func) \
> -	static void __used __section(.discard.func_stack_frame_non_standard) \
> -		*__func_stack_frame_non_standard_##func = func
> +#define STACK_FRAME_NON_STANDARD(func)					\
> +	asm (".pushsection .discard.nonstd_frame_strtab, \"S\", @3\n\t"	\
> +	     "999: .ascii \"" #func "\"\n\t"				\
> +	     "     .byte 0\n\t"						\
> +	     ".popsection\n\t"						\
> +	     ".pushsection .discard.nonstd_frame\n\t"			\
> +	     ".long 999b - .\n\t"					\
> +	     ".popsection\n\t")
> +

I don't think this will work in the case where GCC does an IPA
optimization and renames the function (e.g., renames func to
func.isra.1234), right?  That might be a deal breaker...

> +/*
> + * SHT_STRTAB(@3) sections should start with a \0 byte such that the 0 offset
> + * encodes the NULL string.
> + */
> +asm (".pushsection .discard.nonstd_frame_strtab, \"S\", @3\n\t"
> +     ".byte 0\n\t"
> +     ".popsection\n\t");

Including the file creates the section, which is a bit nasty.  Instead
just change STACK_FRAME_NON_STANDARD to prefix every string with a \0?

-- 
Josh
