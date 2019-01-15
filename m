Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359DBC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFB920657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XKL7xsKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfAOQM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:12:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfAOQM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OcDt7TWKrclSFkfWyryNYOz6oQ1jOA1snrF0soX+2go=; b=XKL7xsKaAsmZs5Zyks9eqZmtX
        PUvSDfBkK42XtZ0PYviMYzUUl+QPNCUMSMU9Ujiega1l4pKwPhdOSUex2JCSjarXn3erUdxd+5P8f
        UPMt+5ofxIQS1oG6xhxsd5gPg3U0j3Ch6OBKbmABOoQxwwytPltH/nDKFqifIy9r3I8eyy1LVwLFA
        CMCjH1EOrkz5ArqoasgcBs1z/w/cqZKPeibWw74mvXrRNnrZhlXgAsdCzBUR+2QQ6ctY9AVZYq9Ev
        aqRdwaLzlgHfICkZ53eU8pjOb6r+5sABk+P0G1pQvezxt5iBWEISBxxolfaNe/IXKDXjiRu4BHYC3
        qcCX2Ssjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjRKg-00053I-Jy; Tue, 15 Jan 2019 16:12:54 +0000
Date:   Tue, 15 Jan 2019 08:12:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, palmer@sifive.com,
        aou@eecs.berkeley.edu, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>, Mao Han <mao_han@c-sky.com>
Subject: Re: [PATCH] riscv: fixup max_low_pfn with PFN_DOWN.
Message-ID: <20190115161254.GA19081@infradead.org>
References: <1547280987-7630-1-git-send-email-guoren@kernel.org>
 <20190115153613.GC26443@infradead.org>
 <20190115161000.GA22705@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115161000.GA22705@guoren-Inspiron-7460>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:10:00AM +0800, Guo Ren wrote:
> > >  	set_max_mapnr(PFN_DOWN(mem_size));
> > > -	max_low_pfn = memblock_end_of_DRAM();
> > > +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
> > 
> > I know it is used just above, but can we please just switch this
> > code to use >> PAGE_SHIFT instead of PFN_DOWN, which just horribly
> > obsfucates what is going on?
> ???
> #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
> 
> phys_addr_t __init_memblock memblock_end_of_DRAM(void)
> {
> 	int idx = memblock.memory.cnt - 1;
> 
> 	return (memblock.memory.regions[idx].base + memblock.memory.regions[idx].size);
> }
> 
> What's the problem? PFN_DOWN() couldn't be used with function call?

PFN_DOWN gives you the correct result.  But I think it actually
drastically reduces readability over just opencoding it.

> My patch just want to point out that max_low_pfn is PFN not size. In fact
> there is no error for running without my patch :P

No, I think your patch is correct.  I just wonder if we could make
the code easier to read.
