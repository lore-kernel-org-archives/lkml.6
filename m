Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E0DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5D1214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jtN1bQJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5D1214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeIQTmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:42:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbeIQTmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/ogqbR+H7CN/XFP0qv3r31Xp/vhh0gqnEvgUYywAQ7w=; b=jtN1bQJp0AYus5w9tSVTq6LIx
        PkOwkxWh+ba1Yv/TCSEYvwall1j6UYv/pKk9+4MRV1+McnDZp9o5R4j/cfufqg8gzgtAN/4XRCn8P
        nedtYi99JCpyfY640N/omS+8nWqiXxDjhCtoP5SPhhcZ7Ue79j+q/CnmqZxoLRkcylTeHhC6TF8ux
        I4bAYxnHPWdKk2fVc8Mw039xT6iGJXnt8KBsNEdmAgy7gPaXQb/m89gxQrIuvqAs93WstATKGcti5
        sZFXFXjDj0s6GksohCxmMWp0bxyHqLBeDzlou3Mzp2pzpoGTuAyUnsqtQET4GIgnlTMiXWUz1QNWS
        W0lAShnrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1uIP-0001vR-41; Mon, 17 Sep 2018 14:14:37 +0000
Date:   Mon, 17 Sep 2018 07:14:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
Message-ID: <20180917141436.GB2821@infradead.org>
References: <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
 <20180910133902.GB21593@infradead.org>
 <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org>
 <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
 <20180910161328.GA13171@infradead.org>
 <CAAhSdy2Y-XTZ12i5aV+SzraMZP1YQBhAArpER-YssPcBJNOPOA@mail.gmail.com>
 <20180910163543.GA13052@infradead.org>
 <CAAhSdy2PSLjrtmSbkJ4w-v-zWm2hjii3XL6HE5Pe7u3wz4BmZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2PSLjrtmSbkJ4w-v-zWm2hjii3XL6HE5Pe7u3wz4BmZA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:08:58PM +0530, Anup Patel wrote:
> > They could in theory IFF someone actually get the use case through
> > the riscv privileged spec working group.
> 
> Their is no point in having each and every possible local interrupts
> defined by RISC-V spec because some of these will be CPU
> implementation specific in which case these local interrupts will
> be described in platform specific DT passed to Linux.

Again, to legally have implementation specific local interrupt types
you'll first need to convice the spec to change the status for those
fields from reserved to implementation specific.
