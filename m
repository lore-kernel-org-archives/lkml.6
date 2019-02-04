Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58DBC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75775205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IIH8Libj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfBDQMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:12:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfBDQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oFN+KQoRP/AZ1fMH9/ahgnepZfE4l2bgG1MGqmiAXis=; b=IIH8LibjpIBarmSURFAhpGGHO
        6jYB4GH/OrYb9bjQOV28kRqaV6jviv7pI2JsEQkNq5Im+9xjCZSveKgs6GrOHfZzOr1/P43ErwTbY
        qOecBn0wKyQUfSn6ZzCiVF76G4UcuU1P5zYtisBhgJMcHcILQwUuVd54UkZm/uug0wIpRdDcySrbk
        HOARpCDt5dxiOqD7Awl+Y5kwvZwZQhuPkX7NUjT7pNTbk8bzFRA7FJ0KgOFYJIcDoh27sWeHUeuf2
        cmfW6x/FNFlkLG8XNrxLiN1O9frNiXmpaAFsSkg6uf3THD8RCKMPXagf4+CMDyz0bYlS3cel/Crh1
        AjXfAJ9ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqgqn-0003SS-Di; Mon, 04 Feb 2019 16:12:01 +0000
Date:   Mon, 4 Feb 2019 08:12:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/6] RFC v2: mm: gup/dma tracking
Message-ID: <20190204161201.GA6840@infradead.org>
References: <20190204052135.25784-1-jhubbard@nvidia.com>
 <01000168b94439c0-28d5e096-718d-4e39-a7af-20d0a6d7b768-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000168b94439c0-28d5e096-718d-4e39-a7af-20d0a6d7b768-000000@email.amazonses.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 04:08:02PM +0000, Christopher Lameter wrote:
> It may be worth noting a couple of times in this text that this was
> designed for anonymous memory and that such use is/was ok. We are talking
> about a use case here using mmapped access with a regular filesystem that
> was not initially intended. The mmapping of from the hugepages filesystem
> is special in that it is not a device that is actually writing things
> back.
> 
> Any use with a filesystem that actually writes data back to a medium
> is something that is broken.

Saying it was not intended seems rather odd, as it was supported
since day 0 and people made use of it.
