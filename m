Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6C1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C672075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TxtkN1Wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C672075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeIEX1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:27:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIEX1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EFDUXFM7N9blfi2vX04wXNpX3qEo7tdrdnrYx7eYqR8=; b=TxtkN1WbnxdCVUqdCLsbNU2fN
        7xTVFD7TADo7Qf/QyTfGCy30CuekRWKDahnuCIHloLqMhbZ8bOBZ64sUylqgzg/cEw4dyaOH93aVV
        JSjymmrgBPIsgkEYV1gsZ0T2G8+5C92rHzOfIhjRK92QDAeQptMENKwJgsaGrVYXJwMnbIcjhRliD
        kUOok89Xp+KOT2gCdzr5TZD6r3xZwroeNpxS6qrBmSOUEXPTnu46xw5XpfpspNDvpupUSy0TMPSBP
        UlG2N4jqWdDvwZUEwUFwNXTM3IbM6Ed6GLK+ooXsMp0LjzFR5DH/SUBkGo51RZRINV9xTOpXf1RzB
        BBPwaMbzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxcyB-0005Sb-Ke; Wed, 05 Sep 2018 18:56:03 +0000
Date:   Wed, 5 Sep 2018 11:56:03 -0700
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
Subject: Re: [RFC PATCH 1/5] RISC-V: Make IPI triggering flexible
Message-ID: <20180905185603.GA15741@infradead.org>
References: <20180904124514.6290-1-anup@brainfault.org>
 <20180904124514.6290-2-anup@brainfault.org>
 <20180904185001.GA25119@infradead.org>
 <CAAhSdy1iPZ_Y4opsXBE0o09uzgSxV8A9YKHawFB+knXH7FFLsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy1iPZ_Y4opsXBE0o09uzgSxV8A9YKHawFB+knXH7FFLsQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:06:24AM +0530, Anup Patel wrote:
> It's outrageous to call IPI mechanisms using interrupt-controller as "wacky".

I call pluggable IPI whacky, and it's not outragous.  What is outragous
is your bullshit architecture astronaut patches.

There might be a nned to abstract IPI details even more in the future,
but the way to do it is either architectureally in the RISC-V privileged
spec, or in the SBI spec once we actually have one.

Having host OSes go through hoops to provide pluggable IPI
implementations is complete bullshit, and the argument that we already
have this in some architectures is not a good reason to repeat that
mistake.
