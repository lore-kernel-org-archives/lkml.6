Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD5FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231B42086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231B42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeJKHKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:10:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:10:11 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A1CCB5D;
        Wed, 10 Oct 2018 23:45:42 +0000 (UTC)
Date:   Wed, 10 Oct 2018 16:45:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     <john.hubbard@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
Message-Id: <20181010164541.ec4bf53f5a9e4ba6e5b52a21@linux-foundation.org>
In-Reply-To: <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
        <20181008211623.30796-3-jhubbard@nvidia.com>
        <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
        <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 17:42:09 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> > Also, maintainability.  What happens if someone now uses put_page() by
> > mistake?  Kernel fails in some mysterious fashion?  How can we prevent
> > this from occurring as code evolves?  Is there a cheap way of detecting
> > this bug at runtime?
> > 
> 
> It might be possible to do a few run-time checks, such as "does page that came 
> back to put_user_page() have the correct flags?", but it's harder (without 
> having a dedicated page flag) to detect the other direction: "did someone page 
> in a get_user_pages page, to put_page?"
> 
> As Jan said in his reply, converting get_user_pages (and put_user_page) to 
> work with a new data type that wraps struct pages, would solve it, but that's
> an awfully large change. Still...given how much of a mess this can turn into 
> if it's wrong, I wonder if it's worth it--maybe? 

This is a real worry.  If someone uses a mistaken put_page() then how
will that bug manifest at runtime?  Under what set of circumstances
will the kernel trigger the bug?

(btw, please cc me on all patches, not just [0/n]!)
