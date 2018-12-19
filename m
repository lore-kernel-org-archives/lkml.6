Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D59EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE9F218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mQbk5pYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbeLSQ2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:28:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbeLSQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AkglJuc2XIN3wOx1w1H79rDZKUtuy9ZS7QChsA91hUg=; b=mQbk5pYKmg2QJGn9Bz8U/VItV
        MYTH3GTd1kClHHCjHCWgITTDd59h1Hm+8ZTP8jbruUCi7IKi8KgZNurcqyBXPT1wFowflO37hgDVw
        b49zBt75z9wT9jG/9b3wOItoD0cxmdY02R8C5M2EuOU3iXLkV+w1YEevbR75wgG27baukhN/Ll8T6
        Bt2KU/zlvUnhBXDjr9okZ8wDfxgRWdU4TGOPBsK5IkqSv8ohbifTTE9gknXqkcvIrvdS9DAakKAeC
        cNylRl1i0bethdGctyweeUOne7n6cUncwHIId7p6/bCKqWxuwaCMpjr67MaSd+tToLyuM2SeZkl6u
        D9sA3pEtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZei4-0002ji-Mr; Wed, 19 Dec 2018 16:28:36 +0000
Date:   Wed, 19 Dec 2018 08:28:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] irqchip: sifive-plic: More flexible
 plic_irq_toggle()
Message-ID: <20181219162836.GA9224@infradead.org>
References: <20181130080207.20505-1-anup@brainfault.org>
 <20181130080207.20505-4-anup@brainfault.org>
 <20181217182719.GC7086@infradead.org>
 <CAAhSdy3i+ap2J0By3nRqK6yvb8oD4-+2QwUO9PH9GM+0odKqSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy3i+ap2J0By3nRqK6yvb8oD4-+2QwUO9PH9GM+0odKqSA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 02:20:10PM +0530, Anup Patel wrote:
> Actually these functions should not be inline because plic_toggle() uses
> raw_spin_lock() and plic_irq_toggle() uses for-loop.

So?  It still inlines the all of two instances into each caller
for slightly different but related work.  Not sure it is 100% worth
it, but probably more than the one to move the calculations to init
time..
