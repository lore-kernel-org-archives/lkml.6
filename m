Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D1CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543CB2080D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AOpXQ13n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfBELq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:46:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBELq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WgHT0dIj2t8a8gjp9bzQ+TocKQzXbiJUfwzI/jgKql4=; b=AOpXQ13nn8fJonUip8IXOf+4B
        yZhXrRk6vTtU42WqMbcOlHFuQ1uTj1YFbtTPDvgP1dMdzlD6tUaxj5rCk7DtnOzBxYzx8c6K0M7Hl
        w+C0xbCl5+RDqovygF0zinjL+h25gc3xAvp4zOu2vTG/lcaj4WdKjLq99p00LwosRg/cbrq2qnY1s
        KaPvfH6j89y9lD7XmEzEI6d3pJwKFt7wjx3ZhQFYKmy2m1vFe767+Z6QhD7L6iKo+lAqXJh2fYlB6
        NoNf6ibBD4dmn47wMn383AuQ43dhSYQaqjJqByOx1bdJfUw4rP0mjGoG1Gckk1B08Ya6XofRjjnOW
        89wc2AYWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqzBC-0007Pw-9H; Tue, 05 Feb 2019 11:46:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB6252029FA06; Tue,  5 Feb 2019 12:46:16 +0100 (CET)
Date:   Tue, 5 Feb 2019 12:46:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH V7 1/5] x86/cpufeature: Add facility to check for min
 microcode revisions
Message-ID: <20190205114616.GQ17528@hirez.programming.kicks-ass.net>
References: <1549319013-4522-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549319013-4522-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 02:23:29PM -0800, kan.liang@linux.intel.com wrote:
>  extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
>  
> +/*
> + * Match specific microcode revisions.
> + *
> + * vendor/family/model/stepping must be all set.
> + *
> + * only checks against the boot CPU.  When mixed-stepping configs are
> + * valid for a CPU model, add a quirk for every valid stepping and
> + * do the fine-tuning in the quirk handler.
> + */
> +
> +struct x86_cpu_desc {
> +	__u8	x86;		/* CPU family */
> +	__u8	x86_vendor;	/* CPU vendor */

So Boris asked me to remove the tail comments (done), but what about I
do: % s/\<x86\>/&_family/g, on the rest of this too? I know we have
cpuinfo_x86::x86 history, but at some point we should rename that too.

> +	__u8	x86_model;
> +	__u8	x86_stepping;
> +	__u32	x86_microcode_rev;
> +};
