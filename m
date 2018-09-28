Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6F7C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51685206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="toKgeUor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51685206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbeI1Wjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:39:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbeI1Wjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=333p9yfI5GRmSYIG0Axly2y8HCgkAoVulKSnmd54I9M=; b=toKgeUorlhAGobxKtH2ZINW7H
        J1RmE6TTMV2kKoF1DnKXU0PdCkd1x3OzUUlD8I55+H2OpjwOUx7vIvCa8LNYyC7giGM9BQdQKnzs1
        G2EnPpypiURbKsf5EVQkqgJL0h5JN5NWsWqUMtZeTjMHjzum2c31ktg5htScPNA0Us1vvDi29N79n
        YAanGYATRvHgThWr/acXAxJ7JfeLqnzGm7CoVI/hKa82tDsZw/KgdbGeOJyF6Udr7B5sZq4B3hIi/
        o+n4Fh7yJNKue3wXolQKQy+pnOda9qGBnq/6ae7733iOpdqpASAQyR3wF/1DFIKq1U1qHpKcvCUnB
        EG9eziGgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5vQ0-0007HM-C9; Fri, 28 Sep 2018 16:15:04 +0000
Date:   Fri, 28 Sep 2018 09:15:03 -0700
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
Subject: Re: [PATCH V6 04/33] csky: Exception handling and mm-fault
Message-ID: <20180928161503.GC19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <a4571e227938b58d8ba5f35e2f8e17b625478607.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4571e227938b58d8ba5f35e2f8e17b625478607.1538058840.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifndef CONFIG_CPU_HAS_TLBI
> +	/*
> +	 * We fault-in kernel-space virtual memory on-demand. The
> +	 * 'reference' page table is init_mm.pgd.
> +	 *
> +	 * NOTE! We MUST NOT take any locks for this case. We may
> +	 * be in an interrupt or a critical region, and should
> +	 * only copy the information from the master page table,
> +	 * nothing more.
> +	 */
> +	if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
> +	{

This doesn't fir the kernel style.  Please run checkpatch.pl over
your code and fix at least all warnings that don't seem clearly bogus.
