Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF94C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B6D2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qQeJVtaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B6D2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933506AbeGIPem (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:34:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932699AbeGIPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kVjWbuv+0D/7swPO1PiH5b8EBZJLujqFRuZquM2Qusg=; b=qQeJVtaV1+HLue0I7Z4Y8msbB
        v9NI+ZWYic6Bqa0PQYqEEXy4RZFqSjya0teJDvFbX9VipQQ9S0Wucehp1cWnzWokPagy7RiT6r7cW
        aKaEMbSMbrxV/5gJFVp+Bi8Jr70v1srv8nvm7uptRXy6PZldBX8mhh+3qPshWTcJE2EGrucqxfDXo
        dN3kGpsI8qetcl7CtGArjX8MM26kG/SFAPTqZuWnAQy+mW3syrhwT3gHnAX6jNCUwH5Nk1lQDK3+k
        MnECPrAvF/Qu8in5K0lsMZ4m0W4F5iyfBbyD4WpopwN6A3MUJH9iav2Kkl5Y/4UGYTlhkk3Rn4mRi
        jJUw4Z+dQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcYBJ-0005X0-Ec; Mon, 09 Jul 2018 15:34:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFC4A20289CF4; Mon,  9 Jul 2018 17:34:27 +0200 (CEST)
Date:   Mon, 9 Jul 2018 17:34:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-ID: <20180709153427.GY2476@hirez.programming.kicks-ass.net>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
 <20180709141056.GR2512@hirez.programming.kicks-ass.net>
 <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
 <20180709144925.GU2476@hirez.programming.kicks-ass.net>
 <20180709152958.565weccfaktqauef@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709152958.565weccfaktqauef@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:29:58PM +0100, Mark Rutland wrote:
> Shouldn't that be 8? AFAICT, __alignof__(unsigned long long) is 8 on
> x86_32:

Curious, I wonder why we put that align in atomic64_32 then.
