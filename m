Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8DFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FCB255B6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uFH03H5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FCB255B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754112AbeFYIRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:17:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45862 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeFYIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9t9vNL/QubuWznFsG0Gdn//alMGVwmo5OdLITKQi3m4=; b=uFH03H5ZJ48dQnXMMLl1XQ+fw
        x9MhOdzF5ox23bhhPt4D6dSaeUzeRUE30QHKj+SfCWWPEdWL+x3ZbXW+fh48rpYCgXNHJlrUUvqbb
        90+FEz7slRP7OV0OEyGCg4BDb93pYu93V+PdcrriD6JearUtFjAVjLLDtzB8foOn4YTFGR6LDFdvo
        Qrm90a/QoKXNEx1Nc7KL8tXLXpPlZREqAgc8DTACSB1+sWTNeP+1/IzNoVRsjzPl+rUeUiqoVvucM
        oG7oD9AkKYSmFnTdz0M7Mynsodkzx5k77anPYgIHF3M6THDKjbdaTsJlTDwDAhnTVRcJJ4gonbbrW
        9/jYrDYQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXMdq-0006Lq-TQ; Mon, 25 Jun 2018 08:14:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62F122029F1DB; Mon, 25 Jun 2018 10:14:29 +0200 (CEST)
Date:   Mon, 25 Jun 2018 10:14:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v12 01/11] x86: text_poke() may access uninitialized
 struct pages
Message-ID: <20180625081429.GS2494@hirez.programming.kicks-ass.net>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621212518.19914-2-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 05:25:08PM -0400, Pavel Tatashin wrote:
> ---
>  arch/x86/include/asm/text-patching.h |  1 +
>  arch/x86/kernel/alternative.c        | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index 2ecd34e2d46c..e85ff65c43c3 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -37,5 +37,6 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>  extern void *text_poke(void *addr, const void *opcode, size_t len);
>  extern int poke_int3_handler(struct pt_regs *regs);
>  extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
> +extern int after_bootmem;
>  
>  #endif /* _ASM_X86_TEXT_PATCHING_H */
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index a481763a3776..0230dbc3c599 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -686,13 +686,21 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
>   *
>   * Note: Must be called under text_mutex.
>   */
> -void *text_poke(void *addr, const void *opcode, size_t len)
> +void __ref *text_poke(void *addr, const void *opcode, size_t len)
>  {
>  	unsigned long flags;
>  	char *vaddr;
>  	struct page *pages[2];
>  	int i;
>  
> +	/* While boot memory allocator is runnig we cannot use struct

Broken comment style..

> +	 * pages as they are not yet initialized. However, we also know
> +	 * that this is early in boot, and it is safe to fallback to
> +	 * text_poke_early.
> +	 */
> +	if (unlikely(!after_bootmem))
> +		return text_poke_early(addr, opcode, len);

I'm not entirely sure this is right.. Because not only do we need the
whole fixmap stuff working, we also need #DB and the IPI handlers set-up
and working.

Also, why do this here and not override @poker in
__jump_label_transform() ?

And I added a sync_core() in text_poke_early(), which I think we need
for this.

>  	if (!core_kernel_text((unsigned long)addr)) {
>  		pages[0] = vmalloc_to_page(addr);
>  		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
> -- 
> 2.17.1
> 
