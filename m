Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34030ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0135520832
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MpvEJuN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0135520832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJYKnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:43:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeJYKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oU5/CK9xGDIgltwfC3V0IqOYEgJuBBis/7+8VPbSTvQ=; b=MpvEJuN11TH+rsgGY6vyr99kk
        aEK5Ee76J1j9PyKkPlhqks3GARhDZjJzsWixZxAUxtFCGjskx8kvwcc3kSnsrMgSsg8NpuDLYj+EA
        yX92413ZHV/360q8L/Kjii/G+EgFtQX024dSozwXmVTUqaBYYohBepEfhGTL3/IKB47E8oZ0y9GRf
        udFSpCIyni+w7i0iy+PN0ngZi2jLK6qSvaH6AgdS77MBHRS0wOUAWz903Cxcg2A9RYBy/h7LPei1d
        N5Vss13mSAUo9YhYSlQMbLTTdhLTI18xvl0wBKPuRJVyomVykNaFNYBIRgcImn3B7zYzTcob+4ErF
        zJO0hqxLA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFV91-0001vU-PP; Thu, 25 Oct 2018 02:13:07 +0000
Date:   Wed, 24 Oct 2018 19:13:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] prmem: struct page: track vmap_area
Message-ID: <20181025021307.GH25444@bombadil.infradead.org>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-9-igor.stoppa@huawei.com>
 <20181024031200.GC25444@bombadil.infradead.org>
 <ffb887e1-2029-42d5-3a97-54546e4d28d8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffb887e1-2029-42d5-3a97-54546e4d28d8@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 02:01:02AM +0300, Igor Stoppa wrote:
> > > @@ -1747,6 +1750,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> > >   	if (!addr)
> > >   		return NULL;
> > > +	va = __find_vmap_area((unsigned long)addr);
> > > +	for (i = 0; i < va->vm->nr_pages; i++)
> > > +		va->vm->pages[i]->area = va;
> > 
> > I don't like it that you're calling this for _every_ vmalloc() caller
> > when most of them will never use this.  Perhaps have page->va be initially
> > NULL and then cache the lookup in it when it's accessed for the first time.
> > 
> 
> If __find_vmap_area() was part of the API, this loop could be left out from
> __vmalloc_node_range() and the user of the allocation could initialize the
> field, if needed.
> 
> What is the reason for keeping __find_vmap_area() private?

Well, for one, you're walking the rbtree without holding the spinlock,
so you're going to get crashes.  I don't see why we shouldn't export
find_vmap_area() though.

Another way we could approach this is to embed the vmap_area in the
vm_struct.  It'd require a bit of juggling of the alloc/free paths in
vmalloc, but it might be worthwhile.
