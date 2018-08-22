Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BAAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2209214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZGXejm+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2209214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeHVJ1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:27:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeHVJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yAmFxMvN3BD3bGlN5RcjnMnxoN1cKW/y/zvv9jkwmxE=; b=ZGXejm+VdZEAUiwQ7qXDhQcqK
        Xx5zqT4KD+wsH3w3O4y1KgZaqx9wgzJ+XYJGDCphnhf3ZYtJ7QUoFo2UukS85xlkWOhVDges0RT9A
        jYaKrlcTEHrtlzPvDz9CP1wFwSPhk/HPvELdGNlMOSdS174xN+uuuTePLBah4zkd+RvBIa1xstdWm
        fJE3rMT8tg6oxXcSt/5J9Atv/NTxlTSbDtyE/ExmTBWlyoR+LiKRExXJ66f4uhb/7W0WkjirvMnt8
        vt2FJ9BCTp7zfpuxUhepjgPzcPO7/cSaMBxh0I9AVlctC53RsfKGWMn4dZ0dSKA3N3jXJE1T6pjwd
        6emFGT02A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsMFF-0007RA-Mx; Wed, 22 Aug 2018 06:03:53 +0000
Date:   Tue, 21 Aug 2018 23:03:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 3/5] RISC-V: Add cpu_operatios structure
Message-ID: <20180822060353.GA27106@infradead.org>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-4-git-send-email-atish.patra@wdc.com>
 <CAAhSdy2TeNfjdzWPHtCwrorBu8c9v-u9Ro-eGMbzSwzapfwdjw@mail.gmail.com>
 <ce39a215-3bb1-d866-0d84-76642acb70bc@wdc.com>
 <CAAhSdy30Fz0Ki5zMws6hspgn=xwcFLj3VVixH88UWGU+oehBQg@mail.gmail.com>
 <20180821074826.GA28079@infradead.org>
 <CAAhSdy2NP4raXXPVvEJyAO127=J9jR3NNEHLF=vigBz=v-Qqkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2NP4raXXPVvEJyAO127=J9jR3NNEHLF=vigBz=v-Qqkw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 10:34:38PM +0530, Anup Patel wrote:
> The cpu_operations is certainly required because SOC vendors will add
> vendor-specific mechanism to selectively bringing-up CPUs/HARTs instead
> of all CPUs entering Linux kernel simultaneously. In fact, we might also end-up
> having CPU ON/OFF operations in SBI.

Your forgot an essential part in your analysis:  Right now we only have
one single way to deal with cpu on/offlining, and that is the dummy WFI
kind.  Once other ways show up we can build proper infrastructure, but
until then this is just a white elephant as we have no idea how these
abstractions will look like.

And my hope is that we'll just see new SBI calls, in which case we'll
just need SBI and dummy version and can avoid all the indirect calls.
