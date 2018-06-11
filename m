Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0F744C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A3120660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="swlnFVN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A3120660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934157AbeFKRUB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:20:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934079AbeFKRT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mDm6xOUZBchL3cb4cnWgR1zMwHQo3xdVUPXYZUQ6YUs=; b=swlnFVN+iIb54TP4EuEQziGu1
        hWYjzm7Dmi4qFfBeLNDo8i0NEvJEuo43oJMdw56Tzak3lyd1FsvpwBR1srE8YFr5wW396S+BwiXVD
        WS7I2Ez3NaobTUTx9/gE1cBaoOEk+FH9Nw5bW/gaKa1904Ief5HFq76kgIJ3vDLcC5Xwbx91uDwU7
        AUCWn1qH7Vc3yzuRgoPuk5DZWQHMS9Ilb2o+FK9QIngH13HGu0UoG4wB0SHFml7kuI7DPYkfQxQmC
        MCHN7Rgt0c/NOYSqPcn8qWLbh6a4/1UAK+XCVOgpYbZGEDR7PZ/BOQZoTABnGS214adfVXYy0ff+J
        uzMzz/zQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSQTj-0000h8-3b; Mon, 11 Jun 2018 17:19:39 +0000
Date:   Mon, 11 Jun 2018 10:19:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 08/30] block: introduce chunk_last_segment()
Message-ID: <20180611171938.GA5101@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-9-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609123014.8861-9-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think both callers would be just as easy to understand by using
nth_page() instead of these magic helpers.  E.g. for guard_bio_eod:

		unsigned offset = (bv.bv_offset + bv.bv_len);
		struct page *page = nth_page(bv.bv_page, offset);

		zero_user(page, offset & PAGE_MASK, truncated_bytes);

