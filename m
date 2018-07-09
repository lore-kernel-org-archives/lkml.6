Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB89C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6AF2089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oWCiyg3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6AF2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933100AbeGIOtu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:49:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeGIOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EI47blyQ6C2x/F0lwo/yKRI6OXyXmsu53eLx7Fwdk20=; b=oWCiyg3aHzHzg1A1TiKArcpCb
        Cf/4ls1xVf1f1UnmtV8wAOB0VubvCMEec4H/QDAha3Oowl46gRfgbZlYh6yuGGEiLE42Tcsv3KZmN
        d+1vqJrQlsIFKyVAKZ15z435TbkpLMCAN+VQZeLEvy/l194GsD6FwxElRjMdUf3AaB1+8dzR66R+l
        3rvPZ+7JaamzmKHsmo2nEWZ9ba3tQcGICudk7lfxod+/ddvw2bFl/wIyrjI2UzGirXufC/UiV8dQK
        LnqrUVuhgG/RbFz1AdnisoNrp0/zRRVvhoC00Zm3xUVpwnK5S9YytXLvYGR1QieaCnUyIVMHNj4tG
        Gyf6/t8Ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcXTi-0002AL-N3; Mon, 09 Jul 2018 14:49:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7449120289CF4; Mon,  9 Jul 2018 16:49:25 +0200 (CEST)
Date:   Mon, 9 Jul 2018 16:49:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "greg@kroah.com" <greg@kroah.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Message-ID: <20180709144925.GU2476@hirez.programming.kicks-ass.net>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
 <20180709141056.GR2512@hirez.programming.kicks-ass.net>
 <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 02:33:26PM +0000, Alexey Brodkin wrote:
> > In fact, since alloc_dr() uses kmalloc() to allocate the entire thing,
> > it is impossible to guarantee a larger alignment than kmalloc does.
> 
> Well but 4-bytes [which is critical for atomic64_t] should be much less
> than a sane cache line length so above should work.

AFAICT ARCH_KMALLOC_MINALIGN ends up being 4 on x86_32 (it doesn't
define ARCH_DMA_MINALIGN and doesn't seem to otherwise override the
thing).

So unconditionally setting the alignment of devres::data to 8 seems
broken.
