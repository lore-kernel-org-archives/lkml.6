Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11CCC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5598B20684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aCGGMk6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5598B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeI1Wp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:45:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbeI1Wp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aYyp5Ze8DtxvO1hAno/KDKwNGvhL82N4jREYVvohcBI=; b=aCGGMk6xy65xepERN1Eoo+Mf7
        xNiN6W29dwmV8iQwz59dFYtiABFPChPjg2+liatERs/tskHi6VaKA+KS4fNlChYIDCvCAx9Ijtdqp
        btShdzamTenUbCk1liaUsPeCPtXxtJTquGSTsnGFpii/VFhKVCDTUow6vba5rwQhfRv6jJHL1F2aR
        kJHdlSuWv73cTxuMLmBmB9HA2NXHyYlLe9RUwYgcAaMDwkyzmEh41iMDKXVSBXkTi1xgRhZu5a3o3
        1O4obBAB0KROe2iTQ+7ZF+AcEEubhTTQ/7GosBvDr0rbiltE716Jx9Ay9Xha4BpN7paivknp6U5ra
        uE3kMMKYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5vW0-0002ez-LM; Fri, 28 Sep 2018 16:21:16 +0000
Date:   Fri, 28 Sep 2018 09:21:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com
Subject: Re: [PATCH V6 20/33] csky/dma: fix up dma_mapping error
Message-ID: <20180928162116.GF19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <378d4064bf29863785f4cc637999e07507e2e926.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <378d4064bf29863785f4cc637999e07507e2e926.1538058840.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 08:51:17AM +0800, Guo Ren wrote:
> The arch_sync_dma_for_cpu()/arch_sync_dma_for_device() implementation is
> broken for some combinations that end up in a BUG() instead of performing
> the necessary flushes.

This should be folded into the original patch adding this code.
