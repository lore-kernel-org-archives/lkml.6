Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2DAC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300D9222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qw7ortlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbfBMGoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:44:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfBMGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PWbL/4SM/FCpa2kpx0HFkhtSLmcFMEfuKZ+eKMOIyw0=; b=Qw7ortlk+26yXlOSEFiN8o6oG
        ptj2G6yzSeaWW5H3csqikFRZ61vK5L0ddsPgErQvuyuouQZnUsCdeMt6SIchawf057qU/7QaqyfEh
        SRURhFe5DuVSukM3WnIc9cxyFieTNrD0CZ4tQ2lFquq3HoW2arPazu+L/1MKKkJwcWq7uwhPQlTjv
        uNOgtN/PsvkUP3L5vi/RX8hfOhwuas0uYuIkzdi5xScXdJqFUvl2V9mkRwYNSJDDhXQtC9Zw98FSd
        QhkQZDvjHw0HGRo424isfSUN6lhIS+hpdeFZKY5FgMemuoEAGVf2xv1xiXynGKBhB4WCJWrzumBro
        bq5XBnhzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoHL-0001uh-Ak; Wed, 13 Feb 2019 06:44:19 +0000
Date:   Tue, 12 Feb 2019 22:44:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] RISC-V: Free-up initrd in free_initrd_mem()
Message-ID: <20190213064419.GA27012@infradead.org>
References: <20190213063127.28703-1-anup.patel@wdc.com>
 <20190213063127.28703-7-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213063127.28703-7-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 06:32:24AM +0000, Anup Patel wrote:
> index 9cd583b6d1cd..c22b873de856 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -97,8 +97,9 @@ static void __init setup_initrd(void)
>  	initrd_end = 0;
>  }
>  
> -void free_initrd_mem(unsigned long start, unsigned long end)
> +void __init free_initrd_mem(unsigned long start, unsigned long end)
>  {
> +	memblock_free(__pa(start), end - start);

I'm pretty sure this should be a call to free_reserved_area instead.

All regions reserved using memblock_reserved and not freed before
initializing the MM are marked reserved and don't have valid page
counts, etc.

So we need the actions in free_reserved_area to actually make the
memory useful.  Now every other architecture except for arm64
seems to do fine without a memblock_free.  I'm not an expert on
memblock (but I've CCed one), but I guess the reason is that once
the kernel has booted we don't really care about freeing memblock
area.
