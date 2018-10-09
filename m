Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8EAC43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779AB214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779AB214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJJGjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:39:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeJJGjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:39:32 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96BCFAC9;
        Tue,  9 Oct 2018 23:20:13 +0000 (UTC)
Date:   Tue, 9 Oct 2018 16:20:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     john.hubbard@gmail.com, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
Message-Id: <20181009162012.c662ef0b041993557e150035@linux-foundation.org>
In-Reply-To: <20181009083025.GE11150@quack2.suse.cz>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
        <20181008211623.30796-3-jhubbard@nvidia.com>
        <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
        <20181009083025.GE11150@quack2.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 10:30:25 +0200 Jan Kara <jack@suse.cz> wrote:

> > Also, maintainability.  What happens if someone now uses put_page() by
> > mistake?  Kernel fails in some mysterious fashion?  How can we prevent
> > this from occurring as code evolves?  Is there a cheap way of detecting
> > this bug at runtime?
> 
> The same will happen as with any other reference counting bug - the special
> user reference will leak. It will be pretty hard to debug I agree. I was
> thinking about whether we could provide some type safety against such bugs
> such as get_user_pages() not returning struct page pointers but rather some
> other special type but it would result in a big amount of additional churn
> as we'd have to propagate this different type e.g. through the IO path so
> that IO completion routines could properly call put_user_pages(). So I'm
> not sure it's really worth it.

I'm not really understanding.  Patch 3/3 changes just one infiniband
driver to use put_user_page().  But the changelogs here imply (to me)
that every user of get_user_pages() needs to be converted to
s/put_page/put_user_page/.

Methinks a bit more explanation is needed in these changelogs?
