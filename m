Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A9AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA22B23DB7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OWGCM+lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA22B23DB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbeGESAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:00:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753405AbeGESAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7fkjtg9sPWTn/G/yziX8+lDXoSKoQKKHXJHNQ4+h17o=; b=OWGCM+lzaQ5tSK15e7vgJYcPt
        V9hePGm7lxiujpSmzmlDeHlQy+rKGH4H3krMN8OST8AwW8r/Wbc7Jrlhlk+p23yxejgJgFzJQhITr
        SpBpkA+4N9TFqsy2GLIHfNgKBxFVe/MN5sdgr4WIikSNwADMOoIxvtJNnX7bSUjEHna68+PPRbTac
        ++5bz0tCaZcGK6bNAn9cfM9TV5SG+pquakLPlpQ9lSU7MrhXjSzZGL+3+4TOTC79QAJDGyRcL4FSj
        0aztqIS52exPLIBD1lIQcsjxiWTorWu+nJV40nGRDz8oGANFbhRjf1BFtfBnu/5rQeXlJCiacjH71
        maPZtLdhw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb8Y6-0002wy-9T; Thu, 05 Jul 2018 18:00:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C764020289CF4; Thu,  5 Jul 2018 20:00:08 +0200 (CEST)
Date:   Thu, 5 Jul 2018 20:00:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180705180008.GG2530@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:
> +#ifdef CONFIG_CPU_HAS_LDSTEX
> +ENTRY(csky_cmpxchg)
> +	USPTOKSP
> +	mfcr	a3, epc
> +	INCTRAP	a3
> +
> +	subi    sp, 8
> +	stw     a3, (sp, 0)
> +	mfcr    a3, epsr
> +	stw     a3, (sp, 4)
> +
> +	psrset	ee
> +1:
> +	ldex	a3, (a2)
> +	cmpne	a0, a3
> +	bt16	2f
> +	mov	a3, a1
> +	stex	a3, (a2)
> +	bez	a3, 1b
> +2:
> +	sync.is
> +	mvc	a0
> +	ldw	a3, (sp, 0)
> +	mtcr	a3, epc
> +	ldw     a3, (sp, 4)
> +	mtcr	a3, epsr
> +	addi	sp, 8
> +	KSPTOUSP
> +	rte
> +END(csky_cmpxchg)
> +#else

Please explain... if the CPU has LDEX/STEX, then _why_ do you need this?
