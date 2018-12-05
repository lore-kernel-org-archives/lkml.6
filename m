Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A48C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B912082D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QHCI2yVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B912082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeLET1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:27:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41830 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLET1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LFJn1UEgu7qruDBYY7f07dl0/ndfGC7Ev9Idmq2934Q=; b=QHCI2yVL9fFKnAMHLbLj5pD1N4
        tX6wczw5yScz1gDbv2JjSABo0hoyabsgZWxemz4dm5NF+nVjS3x4Kc5DPi7sNHPpejBYtCfRyK1xx
        0Dxzi1SXKhcroOuAnEvbnL28jG1zFOBJBqJ94mraeuAETFk8moDaGWEpXrZE0DiMGzBjDnz8Af6Th
        Y7VYlT5OK3yW+onb7MZMlTwLCESeCwqjBpEFDQPJUW4Q8lV5CXNxu2+pkCEODP9SvQs5y2htkCPUD
        wlfvYtS03tlANQxGg8SJ2aSsMCQz4JhKlhje3sF1KXKkuMtlEJZrZ5GxMi5S3oCU64Z//TiYU3JLg
        3LmmZu8g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUcpH-0007eE-Tk; Wed, 05 Dec 2018 19:27:16 +0000
Subject: Re: [PATCH] x86/fault: Print "SUPERVISOR" and "READ" when decoding
 #PF oops
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
References: <20181205163624.1842-1-sean.j.christopherson@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fcffaedd-5057-19ca-52fc-76d35cae7535@infradead.org>
Date:   Wed, 5 Dec 2018 11:27:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205163624.1842-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 8:36 AM, Sean Christopherson wrote:
> ...instead of manually handling the case where error_code=0, e.g. to
> display "[SUPERVISOR] [READ]" instead of "normal kernel read fault".
> 
> This makes the zero case consistent with all other messages and also
> provides additional information for other error code combinations,
> e.g. error_code==1 will display "[PROT] [SUPERVISOR] [READ]" instead
> of simply "[PROT]".
> 
> Print unique names for the negative cases as opposed to e.g. "[!USER]"
> to avoid mixups due to users missing a single "!" character, and to be
> more concise for the !INSTR && !WRITE case.
> 
> Print "SUPERVISOR" in favor of "KERNEL" to reduce the likelihood that
> the message is misinterpreted as a generic kernel/software error and
> to be consistent with the SDM's nomenclature.
> 
> An alternative to passing a negated error code to err_str_append() would
> be to expand err_str_append() to take a second string for the negative
> test, but that approach complicates handling the "[READ]" case, which
> looks for !INSTR && !WRITE, e.g. it would require an extra call to
> err_str_append() and logic in err_str_append() to allow null messages
> for both the positive and negative tests.  Printing "[INSTR] [READ]"
> wouldn't be the end of the world, but a little bit of trickery in the
> kernel is a relatively small price to pay in exchange for the ability
> to unequivocally know the access type by reading a single word.
> 
> Now that all components of the message use the [<code>] format,
> explicitly state that it's the error *code* that's being printed and
> group the err_str_append() calls by type so that the resulting print
> messages are consistent, e.g. the deciphered codes will always be:
> 
>     [PROT] [USER|SUPERVISOR] [WRITE|INSTR|READ] [RSDV] [PK]

                                                   RSVD
but it's correct in the patch.
BTW, what does PK mean?

thanks.

> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/mm/fault.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 2ff25ad33233..0b4ce5d2b461 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -609,7 +609,7 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
>   */
>  static void err_str_append(unsigned long error_code, char *buf, unsigned long mask, const char *txt)
>  {
> -	if (error_code & mask) {
> +	if ((error_code & mask) == mask) {
>  		if (buf[0])
>  			strcat(buf, " ");
>  		strcat(buf, txt);
> @@ -655,13 +655,16 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
>  	 * zero delimiter must fit into err_txt[].
>  	 */
>  	err_str_append(error_code, err_txt, X86_PF_PROT,  "[PROT]" );
> -	err_str_append(error_code, err_txt, X86_PF_WRITE, "[WRITE]");
>  	err_str_append(error_code, err_txt, X86_PF_USER,  "[USER]" );
> -	err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
> +	err_str_append(~error_code, err_txt, X86_PF_USER, "[SUPERVISOR]");
> +	err_str_append(error_code, err_txt, X86_PF_WRITE, "[WRITE]");
>  	err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
> +	err_str_append(~error_code, err_txt, X86_PF_WRITE | X86_PF_INSTR,
> +							  "[READ]");
> +	err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
>  	err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
>  
> -	pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
> +	pr_alert("#PF error code: %s\n", err_txt);
>  
>  	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
>  		struct desc_ptr idt, gdt;
> 


-- 
~Randy
