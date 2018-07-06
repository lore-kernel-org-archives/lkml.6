Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68F6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CDA24001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AVXrlqWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CDA24001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeGFNEN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:04:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932379AbeGFNEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DIy5riyuC6FHTd+mNWhWkHIvvp8JSbIhQcxe1m8l9g0=; b=AVXrlqWKy1GYe3ywKyrxMjaHiY
        86hxPKrdKgOHFVrvsbsppHMBhB0Ov+a6EzjUW9Cl3U7h+MqZQ7ec42R7AUQh+hcqByVlTa305N/B8
        KTZ2UVlfkDp64gHazPbThqXc7s/9B9UwbZpt+UILN5oF2TJCnkp154Ry+UdXDenYxE1XpXiQxG+I2
        PT8NoD6KvD/K3kAfmFHvcUybPJcigRoY9kUHw3G/e33OfFl8Jlsv+flLlE5Ks0hJnWq5lxNdhYT02
        n+UvXRPXDVnhop3piDUz+89eUukoJBv+3oEuFYMgLoYjiWS8wy9pnVkdFHCHlCG062093Nr0afQIq
        rqaUatNQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbQPA-0005DV-3h; Fri, 06 Jul 2018 13:04:08 +0000
Date:   Fri, 6 Jul 2018 06:04:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v14 68/74] dax: Convert dax_lock_page to XArray
Message-ID: <20180706130407.GA18395@bombadil.infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
 <20180617020052.4759-69-willy@infradead.org>
 <20180629173055.GA2973@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180629173055.GA2973@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:30:55AM -0600, Ross Zwisler wrote:
> On Sat, Jun 16, 2018 at 07:00:46PM -0700, Matthew Wilcox wrote:
> > Signed-off-by: Matthew Wilcox <willy@infradead.org>
> > ---
> <>
> > +static void *dax_make_page_entry(struct page *page, void *entry)
> > +{
> > +	pfn_t pfn = page_to_pfn_t(page);
> > +	return dax_make_entry(pfn, dax_is_pmd_entry(entry));
> > +}
> 
> This function is defined and never used, so we get:
> 
> fs/dax.c:106:14: warning: ‘dax_make_page_entry’ defined but not used [-Wunused-function]
>  static void *dax_make_page_entry(struct page *page, void *entry)
>   ^~~~~~~~~~~~~~~~~~~

Yeah, it was used in one of the functions Dan added, then removed.
I understand he's planning on bringing that back before 4.19 and I'm
going to rebase on top of that, so I've left it there for now.

