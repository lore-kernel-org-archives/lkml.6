Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86C5C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75A12172F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WKzOsk5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75A12172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeHTUyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:54:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F1exH5Db5+aeTEyDC+TqDtSbmkMvRkI3VFGQ5caxwxk=; b=WKzOsk5nikKhsIveUOgBD6hcm
        SCE794xpA92Iq5RS7sE2/PtF/S9YoTsPNuqV4HzZyPqvOEilRfv3FAAv5rK3KHQjYWqz3k5pQzv/9
        Pc9+R8G204W99AsSagF9J1nAdPnBedsuF8EyLGVjvmW3OLrFlOQRN0fxHHtQUHG93YgKgCemMtytI
        WpQExkhCdwl8u2L9tZbM3C0iRZayw8iHAjDha2kgA5/4cF/FztC0HNMGd3urLpLUDGXqev1IZUpsk
        kTdyjbcFRegctSXsz2cMzBtHGWyA5u8M0AJiwaY7HvqXxzW3X40ILhZZ1xlANs1qd4cK3HS9f8bE2
        b18lzRi4w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fro88-0004Kf-O9; Mon, 20 Aug 2018 17:38:16 +0000
Date:   Mon, 20 Aug 2018 10:38:16 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Li RongQing <lirongqing@baidu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        darrick.wong@oracle.com
Subject: Re: [PATCH] mm: introduce kvvirt_to_page() helper
Message-ID: <20180820173816.GE25153@bombadil.infradead.org>
References: <1534596541-31393-1-git-send-email-lirongqing@baidu.com>
 <20180820144116.GO29735@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820144116.GO29735@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 04:41:16PM +0200, Michal Hocko wrote:
> > +++ b/fs/xfs/xfs_buf.c
> >  	for (i = 0; i < bp->b_page_count; i++) {
> > -		bp->b_pages[i] = mem_to_page((void *)pageaddr);
> > +		bp->b_pages[i] = kvvirt_to_page((void *)pageaddr);
> >  		pageaddr += PAGE_SIZE;

This wants mem_range_to_page_array().

> > +++ b/net/9p/trans_virtio.c
> >  		for (index = 0; index < nr_pages; index++) {
> > -			if (is_vmalloc_addr(p))
> > -				(*pages)[index] = vmalloc_to_page(p);
> > -			else
> > -				(*pages)[index] = kmap_to_page(p);
> > +			(*pages)[index] = kvvirt_to_page(p);

Also mem_range_to_page_array().

> > +++ b/net/ceph/crypto.c
> > @@ -191,11 +191,7 @@ static int setup_sgtable(struct sg_table *sgt, struct scatterlist *prealloc_sg,
> >  		struct page *page;
> >  		unsigned int len = min(chunk_len - off, buf_len);
> >  
> > -		if (is_vmalloc)
> > -			page = vmalloc_to_page(buf);
> > -		else
> > -			page = virt_to_page(buf);
> > -
> > +		page = kvvirt_to_page(buf);
> >  		sg_set_page(sg, page, len, off);
> >  
> >  		off = 0;

This whole function wants to move into the core and be called something like
sg_alloc_table_from_virt().

> > +++ b/net/packet/af_packet.c
> > @@ -374,15 +367,15 @@ static void __packet_set_status(struct packet_sock *po, void *frame, int status)
> >  	switch (po->tp_version) {
> >  	case TPACKET_V1:
> >  		h.h1->tp_status = status;
> > -		flush_dcache_page(pgv_to_page(&h.h1->tp_status));
> > +		flush_dcache_page(kvvirt_to_page(&h.h1->tp_status));

This driver really wants flush_dcache_range(start, len).

