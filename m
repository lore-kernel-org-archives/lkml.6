Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01238C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4AF20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t4eL2a5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4AF20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeIJVGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:06:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeIJVGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3hDQjZ4chlgNvSWClBLfOa+koMXO48DzpgV9qQ2hY5U=; b=t4eL2a5CuhbU23xiv95Zs7syo
        CPfUuHk7io3fZ+8B+zQGIeQOd20T51oEZnPN2T+1vtzaxg3YsZOAVGafBq8GvL9XKepPHJ+xScOsf
        FmqpgyT3kwB2h13E/fA5BKzfY+jPI7gLtzRGVu1tnXvtROdqb5TkHphL7bq9SVUQpaIR8j8jHD99e
        dvWYgED1OT1OPH2ESe8+4zT9HcQJ8qkt4c8N5qvHlqU+W1z11w2C5sTIxnvLdqOKy4r4/EGxkiHDl
        dMkrBRmftad9m6gXFBlkPomSxiHyL7HYoucvA+duF+tLIJc2dyMHPmoUXnib2mJzS+GC+9F3k1L+w
        4MJR1nmhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzOmu-0003PP-2K; Mon, 10 Sep 2018 16:11:44 +0000
Date:   Mon, 10 Sep 2018 09:11:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
Message-ID: <20180910161143.GA1053@infradead.org>
References: <20180906140628.GA10580@infradead.org>
 <alpine.DEB.2.21.1809081241310.1402@nanos.tec.linutronix.de>
 <20180910132924.GA6987@infradead.org>
 <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
 <20180910133902.GB21593@infradead.org>
 <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org>
 <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
 <alpine.DEB.2.21.1809101805110.1419@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809101805110.1419@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 06:07:12PM +0200, Thomas Gleixner wrote:
> > Considering above, it is better to have a distinct irqchip and
> > irq_domain for all local interrupts (just like this patch).
> 
> If that's the future usage

It's not, at least there has been no proposal for that so far, and I
don't really think it is how the architecture was intended.

> and that's what my impression was, under which I
> changed my mind, yes, then having a domain model is certainly of advantage
> especially when those things end up being different per SoC.

And even if we went down the way of using the other bits it would
be architectureal in the RISC-V spec - these are not available for
vendor specific uses.
