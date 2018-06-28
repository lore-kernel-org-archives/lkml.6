Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E6DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E032710B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m53clXBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E032710B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbeF1IuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:50:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52458 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeF1IuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VaYagYMjNLi5MbppvTx+jyrVgSqhqS5U8HypcAHit6E=; b=m53clXBP+KMWO6W8lVT/UIkoy
        JZeIZf8XmzffvFUwckJ18HnHV/lQ0Hq4LRZAUCldMJb1lWOgMQ6zOIkKMDzuURNSmYp6QNLwVYIo6
        dLR5speD2kU0ebpCsagjYMDmzUg6YMDVKGjEXvy66mHGvtMJCzXTGotBuyPlN+XMlnLPOr4k0sxMc
        8ikIFXq4vm9sZXtPAAYI0cHBQv5G0tH1k4pcfDlk1XYGCbhUirwN0emC3DHi3ZqDwRkyQH1mXhhC9
        8g+/jOdvUGmqqxTmgei+yZfIoagOUtG4Ekd/dFe0bPru8xH4+3ONKBmICzPkOHth4GyR/italG9qj
        PkrnETh2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYScv-0002gn-07; Thu, 28 Jun 2018 08:50:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B5E320297645; Thu, 28 Jun 2018 10:50:03 +0200 (CEST)
Date:   Thu, 28 Jun 2018 10:50:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/5] kernel/jump_label: implement generic support for
 relative references
Message-ID: <20180628085003.GA2494@hirez.programming.kicks-ass.net>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-3-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627160604.8154-3-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 06:06:01PM +0200, Ard Biesheuvel wrote:
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index 86ec0652d3b1..aa203dffe72c 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -121,6 +121,32 @@ struct static_key {
>  #include <asm/jump_label.h>
>  
>  #ifndef __ASSEMBLY__
> +#ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
> +
> +struct jump_entry {
> +	int code;
> +	int target;
> +	int key;
> +};

I much prefer you use 'u32' there.


> +static void jump_label_swap(void *a, void *b, int size)
> +{
> +	long delta = (unsigned long)a - (unsigned long)b;
> +	struct jump_entry *jea = a;
> +	struct jump_entry *jeb = b;
> +	struct jump_entry tmp = *jea;
> +
> +	jea->code	= jeb->code - delta;
> +	jea->target	= jeb->target - delta;
> +	jea->key	= jeb->key - delta;
> +
> +	jeb->code	= tmp.code + delta;
> +	jeb->target	= tmp.target + delta;
> +	jeb->key	= tmp.key + delta;
> +}
> +
>  static void
>  jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
>  {
> @@ -56,7 +72,9 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
>  
>  	size = (((unsigned long)stop - (unsigned long)start)
>  					/ sizeof(struct jump_entry));
> -	sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
> +	sort(start, size, sizeof(struct jump_entry), jump_label_cmp,
> +	     IS_ENABLED(CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE) ? jump_label_swap
> +							      : NULL);
>  }

That will result in jump_label_swap being an unused symbol for some
compile options.

Would it not be much nicer to write that like:

static void jump_label_swap(void *a, void *b, int size)
{
	struct jump_entry *jea = a, *jeb = b;

#ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
	long delta = a - b;

	jea->code += delta;
	jea->target += delta;
	jea->key += delta;

	jeb->code -= delta;
	jeb->target -= delta;
	jeb->key -= delta;
#else

	swap(*jea, *jeb);
}

And then unconditionally use jump_label_swap().
