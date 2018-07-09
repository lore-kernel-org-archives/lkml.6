Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4085C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BC020881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RUJyyk6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BC020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeGIOHo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:07:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54476 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbeGIOHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aE9WJpS5O1x/cSk9XTY786CLi5Y5ap/CZIHO+NmgzKs=; b=RUJyyk6iZhGwODp1mbCJZmGWp
        2hEi2w7Kw+xj6SGedira9qPWX8a6EiE7Mz3nkuHahdDGI+soP6ZrhH/c2Wc3+ugV72SLjdPNgGj9o
        9sZqZGMzSpW8YLtA2k9KWwhp3Opyh97+G/0p5f9GvIc2mcB24rs2s47oM9aOK3BIjtEjooCMoyNrW
        l1HoXxcVZPHfD2LT1pdYhJUn9Uh4Xreu+JLHhbNUR8CXuH8MHp04kYlXHtlrPGRPoQyY4NwncE8FJ
        J0QUecCdqDE1w0wK3NSPrFdt0gxaRBl4/YvKsrQ3NSNzUmu4m85Hr/BdLvBuOxOyLcHT3sD/w5b42
        7hIsVuOiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcWox-0001Gh-Ko; Mon, 09 Jul 2018 14:07:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08C6120289CE4; Mon,  9 Jul 2018 16:07:18 +0200 (CEST)
Date:   Mon, 9 Jul 2018 16:07:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Message-ID: <20180709140717.GR2476@hirez.programming.kicks-ass.net>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709134550.29541-1-abrodkin@synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:45:50PM +0300, Alexey Brodkin wrote:
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -24,8 +24,12 @@ struct devres_node {
>  
>  struct devres {
>  	struct devres_node		node;
> -	/* -- 3 pointers */
> -	unsigned long long		data[];	/* guarantee ull alignment */
> +	/*
> +	 * data[] must be 64 bit aligned even on 32 bit architectures
> +	 * because it might be accessed by instructions that require
> +	 * aligned memory arguments such as atomic64_t.
> +	 */
> +	u8 __aligned(8)			data[];
>  };

Seeing that this ends up in a semi generic allocation thing, I don't
feel this should be different from ARCH_KMALLOC_MINALIGN.
